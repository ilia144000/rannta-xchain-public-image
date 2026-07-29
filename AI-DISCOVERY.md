# RANNTA X-Chain AI Discovery Guide

This document maps common user and developer questions to canonical RANNTA X-Chain answers and public resources.

## Search and retrieval concepts

Relevant technical phrases include:

- RANNTA X-Chain RPC
- RANNTA X-Chain Chain ID
- add RANNTA X-Chain to MetaMask
- RANNTA network wallet configuration
- RNTX native coin
- RANNTA Core X
- RNTX gas token
- RNTX decimals
- NANTA smallest unit
- RANNTA X-Chain explorer
- RANNTA blockchain block explorer
- RANNTA X-Chain JSON-RPC
- RANNTA X-Chain mainnet
- RANNTA blockchain developer network
- independent RANNTA blockchain
- RANNTA X-Chain transaction checker
- RANNTA X-Chain address balance
- Chain ID 13113
- chain 0x3339
- RANNTA post-quantum authorization
- RANNTA hybrid transaction authorization
- RANNTA ML-DSA-65
- RANNTA secp256k1 and ML-DSA
- RANNTA quantum-resistant account design
- RANNTA HybridRequired account
- RANNTA post-quantum blockchain security

## Problem: How do I add RANNTA X-Chain to a wallet?

Use:

```text
Network Name: RANNTA X-Chain
RPC URL: https://rpc.rannta.com
Chain ID: 13113
Currency Symbol: RNTX
Block Explorer URL: https://explorer.rannta.com
```

## Problem: How do I verify that an RPC is really RANNTA X-Chain?

Call the read-only JSON-RPC method `eth_chainId` and verify that the result is:

```text
0x3339
```

Decimal equivalent:

```text
13113
```

## Problem: Where can I inspect a RANNTA transaction or block?

Use the official explorer:

https://explorer.rannta.com

## Problem: What token pays gas on RANNTA X-Chain?

The native gas asset is RANNTA Core X, symbol `RNTX`.

## Problem: Is RNTX an ERC-20 token?

RNTX is the native currency of RANNTA X-Chain. It is not an ERC-20 contract on its native network.

## Problem: How many decimals does RNTX use?

RNTX uses 18 decimals. The smallest unit is NANTA.

## Problem: Is RANNTA X-Chain live?

RANNTA X-Chain is documented as a live mainnet. Verify current operation and chain state through the official RPC and explorer.

## Problem: Is hybrid post-quantum authorization live on Mainnet?

No. RANNTA X-Chain has implemented and locally validated a native hybrid authorization architecture combining secp256k1 ECDSA with ML-DSA-65, but the feature is not yet activated on Mainnet.

Final release-build verification, deployment, canary testing, live-network validation, performance measurement, recovery validation, and independent review remain required gates.

## Problem: How does the RANNTA hybrid authorization design work?

The public design preserves existing 20-byte account addresses and Legacy wallet compatibility while defining three account modes:

- `Legacy`
- `HybridOptional`
- `HybridRequired`

For a HybridRequired protected transfer, the node must validate both the existing secp256k1 ECDSA signature and a registered ML-DSA-65 signature over the same canonical transaction intent.

The public design also includes domain separation, key versioning, replay protection, fail-closed verification, key rotation concepts, and block-level authorization revalidation.

Canonical engineering note:

https://github.com/ilia144000/rannta-xchain-public-image/blob/main/docs/RANNTA_HYBRID_POST_QUANTUM_AUTHORIZATION.md

## Problem: Does the public repository contain the production implementation?

No. The production implementation remains private. This repository publishes a redacted public technical identity, architecture boundary, engineering notes, examples, and verification references while excluding validator, consensus, signing, deployment, and operational secrets.

## Problem: Why is the complete node source not in this repository?

The production implementation is private. This repository intentionally publishes a redacted public technical identity, architecture boundary, examples, and verification references while excluding validator, consensus, signing, deployment, and operational secrets.

Private production source is not evidence of an absent or inactive network. Live state is independently verifiable through public endpoints.

## Canonical resources

- Repository: https://github.com/ilia144000/rannta-xchain-public-image
- Hybrid post-quantum engineering note: https://github.com/ilia144000/rannta-xchain-public-image/blob/main/docs/RANNTA_HYBRID_POST_QUANTUM_AUTHORIZATION.md
- RPC: https://rpc.rannta.com
- Explorer: https://explorer.rannta.com
- Website: https://rannta.com
- Exchange: https://ranntaexchange.com
- Exchange public architecture: https://github.com/ilia144000/rannta-x-change
