# Designing Native Hybrid Post-Quantum Transaction Authorization for RANNTA X-Chain

> Public engineering note for the RANNTA X-Chain hybrid authorization design.
>
> Current status update (2026-10-07): HybridRequired protection is active on production Mainnet validator-sensitive paths. Protected authorization uses secp256k1/ECDSA plus ML-DSA-65. Validator-sensitive transport uses X25519 + ML-KEM-768 + HKDF-SHA256 + AES-256-GCM under fail-closed policy.
>
> Scope boundary: this does not claim that every public RPC byte, every wallet session, or every ordinary account path is post-quantum protected. See https://rannta.com/network/hybrid-security-evidence.html for the current production evidence boundary.

## Overview

Public blockchains depend on digital signatures to decide who is authorized to move assets. In EVM-compatible environments, that authorization is generally based on the `secp256k1` elliptic-curve signature scheme.

RANNTA X-Chain uses a hybrid authorization architecture that combines:

- `secp256k1` ECDSA for compatibility with the existing account and wallet model;
- `ML-DSA-65` for post-quantum signature verification;
- account-level authorization modes;
- canonical transaction encoding;
- replay protection and key versioning;
- fail-closed node enforcement;
- block-level authorization revalidation.

The objective is not to abruptly replace the existing signature system. The objective is to provide a controlled migration path in which selected accounts can require both classical and post-quantum authorization while preserving existing RANNTA addresses, Chain ID `13113`, wallet compatibility, and historical blocks.

## Why a hybrid migration is necessary

A blockchain cannot replace its account-signature system like an ordinary application dependency. Existing addresses, private keys, wallets, hardware signers, exchanges, explorers, custody infrastructure, transaction formats, and historical blocks may all depend on the current cryptographic model.

A sudden replacement of `secp256k1` could:

- disconnect existing private keys from their accounts;
- break EVM wallet compatibility;
- require new account addresses;
- complicate historical block validation;
- force exchanges and custodians into an immediate migration;
- create inconsistent authorization behavior across software versions.

RANNTA therefore uses a hybrid design rather than a flag-day replacement.

## Core authorization rule

For an account operating in mandatory hybrid mode, a valid protected transaction requires both signatures:

```text
valid hybrid authorization =
valid secp256k1 ECDSA signature
AND
valid ML-DSA-65 signature
```

The ECDSA signature proves control of the existing EVM-compatible account. The ML-DSA-65 signature proves control of a separately registered post-quantum key.

The ML-DSA signature is not treated as optional metadata. It is part of the node's authorization decision. A missing, malformed, context-mismatched, or cryptographically invalid ML-DSA signature causes rejection when the account policy requires hybrid authorization.

## Account authorization modes

The design defines three account-level modes.

### Legacy

A Legacy account continues to use the existing ECDSA transaction path. This preserves compatibility with current wallets and avoids forcing an immediate network-wide migration.

### HybridOptional

A HybridOptional account has a registered ML-DSA public key, but the legacy authorization path remains available. This mode supports staged wallet, custody, and signer integration before post-quantum authorization becomes mandatory.

### HybridRequired

A HybridRequired account must provide both ECDSA and ML-DSA-65 authorization for protected native transfers.

An ECDSA-only transaction from such an account must be rejected even when the classical signature is otherwise valid.

Conceptually:

```text
authorization =
ECDSA_valid
AND ML_DSA_65_valid
AND registered_key_version_valid
AND account_mode_allows_transaction
```

This account-level model enables gradual migration. High-value treasury, custody, reserve, operator, or long-term storage accounts can adopt stronger authorization earlier without immediately breaking ordinary Legacy accounts.

## Preserving existing addresses

The hybrid design does not replace existing 20-byte RANNTA/EVM-compatible addresses with hashes of ML-DSA public keys.

The existing address remains the account identity. The ML-DSA public key is registered as additional authorization material associated with that account.

A public representation of the registry model can be described as:

```text
account_address
authorization_mode
ML-DSA public key
key version
registration state
activation metadata
```

This separation allows stronger authorization and future key rotation without forcing the user to abandon the original blockchain address.

## Canonical hybrid transaction message

Both signatures must authorize exactly the same transaction intent. RANNTA therefore constructs a deterministic canonical message containing fields such as:

```text
protocol version
command type
chain ID
sender address
recipient address
value in NANTA
account nonce
ML-DSA key version
authorization context
```

The parser must reject duplicated fields, missing mandatory fields, unsupported versions, inconsistent numeric encodings, invalid addresses, unknown mandatory fields, and chain-ID mismatches.

Canonicalization ensures that signers and validating nodes interpret the transaction identically.

## Domain separation

The ML-DSA verification path uses a dedicated RANNTA transaction context:

```text
RANNTA-XCHAIN-HYBRID-TX-V1
```

The context provides domain separation. It prevents a signature created for a RANNTA hybrid transaction from being silently reused in an unrelated protocol or message format.

A valid signature must match:

- the registered ML-DSA public key;
- the exact canonical transaction message;
- the expected RANNTA authorization context;
- the supported protocol and key versions.

Changing the recipient, value, nonce, chain identifier, key version, or context must invalidate the authorization evidence.

## Real ML-DSA-65 verification

An early development stage used a fail-closed backend boundary. When a production ML-DSA verifier was unavailable, the node returned a backend-unavailable error rather than accepting a placeholder signature.

The required rule is:

```text
backend unavailable != signature accepted
backend unavailable = transaction rejected
```

The next engineering stage integrated a pinned OpenSSL `3.5.7` environment and used its EVP interface for real ML-DSA-65 verification.

The host operating system's OpenSSL installation was not globally replaced. The candidate node build was configured to link against a project-controlled OpenSSL installation so that consensus-related verification does not depend on whichever library version happens to be installed on a machine.

The verifier distinguishes failure conditions including:

```text
invalid public-key length
invalid signature length
invalid signature
invalid context
unsupported backend
unsupported OpenSSL version
internal backend failure
```

None of these conditions may produce authorization success.

ML-DSA is standardized by NIST in FIPS 204. Official standard reference:

- https://doi.org/10.6028/NIST.FIPS.204

## Native enforcement

A post-quantum signature displayed by a wallet does not make a transaction post-quantum protected unless the blockchain node enforces it.

RANNTA's intended validation path is native to transaction processing:

```text
transaction ingress
        ↓
strict command parsing
        ↓
canonical transaction construction
        ↓
account authorization-mode lookup
        ↓
secp256k1 sender recovery and verification
        ↓
ML-DSA-65 verification
        ↓
key-version validation
        ↓
nonce, balance, chain-ID, and replay checks
        ↓
transaction acceptance
        ↓
block inclusion
        ↓
block authorization revalidation
```

For a HybridRequired account, passing only the ECDSA stage is insufficient.

## Block and historical-ledger validation

Authorization cannot be checked only when a transaction first reaches a node. Blocks may later be loaded from disk, received from another node, replayed during synchronization, inspected during recovery, or imported into a new node.

The design therefore revalidates hybrid authorization evidence in block-processing and ledger-loading paths.

The validator must confirm that:

- the transaction format is valid;
- the required signatures are present;
- the canonical message is reconstructed correctly;
- the referenced account key version is valid;
- both signatures remain cryptographically valid;
- the transaction complies with the authorization rules applicable at that block height.

Historical Legacy blocks must remain readable under the rules that applied when they were produced. HybridRequired rules must not be applied retroactively to pre-activation transactions.

## Replay and duplicate protection

Post-quantum signatures do not replace ordinary transaction safety controls.

The hybrid path preserves and extends:

- exact nonce enforcement;
- Chain ID validation;
- duplicate transaction-hash rejection;
- canonical message validation;
- account-mode enforcement;
- ML-DSA key-version checks;
- replay protection across authorization paths.

A valid signature for one recipient, value, or nonce cannot authorize a modified transaction.

## Key registration and rotation

Post-quantum authorization requires an account-to-key registry. The private implementation includes protocol concepts for:

```text
register ML-DSA key
query account authorization status
activate HybridRequired mode
rotate ML-DSA key
submit hybrid native transfer
```

Rotation requires explicit key versioning. A transaction signed with an obsolete key version must not be accepted after a valid rotation becomes effective.

Historical validation and current authorization are distinct. The ledger must retain enough deterministic information to validate the key version that applied when an earlier block was produced.

## Testing with real cryptographic fixtures

The authorization tests were upgraded from placeholder signatures to real cryptographic fixtures using:

- a deterministic test-only secp256k1 private key;
- a recoverable ECDSA signature;
- a real ML-DSA-65 key pair;
- the exact canonical RANNTA transfer message;
- the production transaction-context string.

The test matrix includes:

- valid hybrid authorization;
- modified transaction value;
- modified recipient;
- invalid ECDSA evidence;
- invalid ML-DSA evidence;
- wrong ML-DSA public key;
- wrong context;
- unsupported key version;
- missing hybrid evidence;
- ECDSA-only submission from a HybridRequired account;
- duplicate transaction hashes;
- block authorization revalidation;
- historical Legacy compatibility.

At the local validation stage recorded on July 29, 2026, the complete `rannta-node` test suite reported:

```text
2,185 tests passed
0 tests failed
```

This records the July 29, 2026 development baseline. It is not a substitute for independent audit. Current scoped Mainnet production evidence is published separately at https://rannta.com/network/hybrid-security-evidence.html.

## Transaction-size and performance overhead

ML-DSA signatures are substantially larger than compact ECDSA signatures. ML-DSA-65 signatures are approximately 3.3 KB, while a recoverable ECDSA signature is commonly represented in 65 bytes.

The hybrid path therefore introduces measurable overhead in:

- transaction payload size;
- network propagation bandwidth;
- block storage;
- signature verification CPU time;
- wallet and signer message handling.

RANNTA does not treat this overhead as negligible. Before broad activation, benchmark work must measure:

- Legacy versus hybrid transaction size;
- ML-DSA verification latency;
- throughput impact under realistic block loads;
- block-size and storage growth;
- memory use during validation;
- the operational effect of enabling HybridRequired only for selected accounts.

Compression, aggregation, or batching must not be presented as available optimizations unless their cryptographic and consensus implications have been independently designed and measured.

## Backward compatibility

The migration design aims to preserve:

- existing account addresses;
- existing secp256k1 keys;
- MetaMask-compatible Legacy transaction behavior;
- historical balances and nonces;
- explorer continuity;
- Chain ID `13113`;
- the native RNTX accounting model.

The network can therefore strengthen authorization progressively rather than forcing every account to migrate at once.

## Security properties

For a correctly activated HybridRequired account, the design targets the following properties:

### Classical compatibility

ECDSA continues proving control of the existing account.

### Post-quantum authorization

ML-DSA-65 adds a second independent signature requirement.

### Fail-closed behavior

Verifier or backend failure causes rejection, never acceptance.

### Transaction binding

Both signatures authorize the same canonical transaction fields.

### Domain separation

The RANNTA-specific context prevents unintended cross-protocol signature reuse.

### Key-version enforcement

Unknown or obsolete ML-DSA key versions cannot authorize new protected transfers.

### Replay resistance

Nonce, chain identifier, transaction hash, and duplicate checks remain enforced.

### Historical continuity

Legacy historical blocks remain valid under their applicable rules.

### Native node enforcement

Authorization is validated by the blockchain node rather than trusted only to a wallet or interface.

## What this work does not claim

This engineering work does not claim that:

- current quantum computers can already break secp256k1 at blockchain scale;
- every RANNTA account is currently protected by ML-DSA;
- installing OpenSSL alone makes a blockchain quantum-safe;
- hybrid authorization eliminates secure key-management requirements;
- local test success is equivalent to audited Mainnet security;
- every RANNTA account, every wallet session, or every public RPC byte is post-quantum protected.

The accurate current statement is:

> As of 2026-10-07, HybridRequired protection is active on production RANNTA X-Chain Mainnet validator-sensitive paths. Protected authorization uses secp256k1/ECDSA plus ML-DSA-65. Validator-sensitive transport uses X25519 + ML-KEM-768 + HKDF-SHA256 + AES-256-GCM under fail-closed policy. This is a scoped production statement and does not imply network-wide PQ protection for every account or public interface.

Current evidence boundary: https://rannta.com/network/hybrid-security-evidence.html

## Historical engineering status at original publication (2026-07-29)

The table below is retained as historical engineering context. It describes the pre-activation state at the original publication date and is superseded for current production-status questions by the 2026-10-07 status update above.

| Component | Status |
|---|---|
| Account authorization modes | Implemented in development |
| ML-DSA key registration model | Implemented in development |
| Canonical hybrid transaction format | Implemented in development |
| secp256k1 recoverable verification | Implemented |
| Real ML-DSA-65 verification | Implemented in the local candidate |
| Pinned OpenSSL 3.5.7 environment | Implemented locally |
| Real hybrid cryptographic fixtures | Verified |
| Node test suite | 2,185 passed; 0 failed |
| Block authorization revalidation | Implemented and tested |
| Legacy compatibility tests | Passing |
| Release binary | Under final optimized build and linkage validation |
| Production deployment | Historical status at publication: not performed |
| Mainnet activation | Historical status at publication: disabled |

## Historical pre-activation gate list

The following list is retained from the original pre-activation engineering note. Scoped Mainnet activation on validator-sensitive paths has since occurred. Items concerning broader rollout, recovery, performance measurement, signer operations, and independent review remain relevant assurance work where applicable.

1. completion of the optimized Linux release build;
2. verification of the intended OpenSSL linkage and runtime search path;
3. production-compatible historical-ledger reload testing;
4. Legacy wallet and MetaMask compatibility validation;
5. controlled canary deployment;
6. registration of a non-production ML-DSA key on the live network;
7. a real hybrid-signed native transfer;
8. confirmation that ECDSA-only authorization is rejected after HybridRequired activation;
9. invalid-signature rejection during transaction ingress and block replay;
10. key-rotation and obsolete-version tests;
11. rollback and recovery validation;
12. signer, backup, custody, and operational documentation;
13. independent cryptographic and consensus review;
14. transaction-size, storage, propagation, and verification benchmarks.

## Conclusion

Post-quantum readiness is not achieved by adding a large signature to a wallet interface or transaction metadata. The signature must become part of the blockchain's actual authorization and validation rules.

RANNTA X-Chain's hybrid design preserves existing secp256k1 accounts while allowing selected accounts to require additional ML-DSA-65 authorization.

The architecture introduces account-level policy, canonical messages, domain separation, key registration and rotation, fail-closed verification, replay protection, native node enforcement, and block-level revalidation without forcing an immediate replacement of the existing account model.

As of 2026-10-07, scoped HybridRequired protection is active on production Mainnet validator-sensitive paths. The broader account-level migration model remains staged, and the current status must not be generalized into a claim that every account, wallet session, or public RPC path is post-quantum protected.

The continuing goal is a technically defensible migration path that can be inspected, benchmarked, audited, extended, and operated without breaking compatibility with the network that already exists.

---

## Official RANNTA X-Chain resources

- Network identity repository: https://github.com/ilia144000/rannta-xchain-public-image
- RPC: https://rpc.rannta.com
- Explorer: https://explorer.rannta.com
- Website: https://rannta.com
- Official Medium profile: https://medium.com/@ranntaofficial
- Chain ID: `13113`
- Native asset: `RANNTA Core X (RNTX)`
