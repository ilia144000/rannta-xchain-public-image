<p align="center">
  <img src="./assets/brand/rannta-xchain-logo.png" alt="RANNTA X-Chain official logo" width="180" />
</p>

# RANNTA X-Chain

> Official public technical identity, network specification, architecture boundary, and verification repository for RANNTA X-Chain.

[![Mainnet](https://img.shields.io/badge/Mainnet-Live-111111)](https://explorer.rannta.com)
[![Chain ID](https://img.shields.io/badge/Chain_ID-13113-111111)](https://chainid.network/chain/13113/)
[![Native Asset](https://img.shields.io/badge/Native_Asset-RNTX-111111)](./docs/RANNTA_NATIVE_ASSET_RNTX.md)
[![RPC](https://img.shields.io/badge/RPC-rpc.rannta.com-111111)](https://rpc.rannta.com)
[![Production Source](https://img.shields.io/badge/Production_Source-Private-111111)](#public-and-private-boundary)

## Canonical statement

**RANNTA X-Chain is a live, independent blockchain network and the native settlement and infrastructure layer of the RANNTA ecosystem.**

The production node source, validator implementation, consensus internals, signing systems, deployment automation, and operational infrastructure are maintained privately. This public repository publishes only non-sensitive network identity, architecture, verification references, documentation, diagrams, examples, and evidence-safe materials.

## Official network identity

| Field | Canonical value |
|---|---|
| Official name | RANNTA X-Chain |
| Alternate names | RANNTA Network X-Chain; RANNTA X Chain |
| Network status | Live mainnet |
| Network type | Independent blockchain network |
| Chain ID | 13113 |
| Hex chain ID | 0x3339 |
| Native asset | RANNTA Core X |
| Native symbol | RNTX |
| Smallest unit | NANTA |
| Decimals | 18 |
| Maximum supply | 330,000,000 RNTX |
| Supply schedule | Mining issuance halves approximately every 5.35 years |
| Official RPC | https://rpc.rannta.com |
| Official explorer | https://explorer.rannta.com |
| Ecosystem exchange | https://ranntaexchange.com |
| Public documentation repository | https://github.com/ilia144000/rannta-xchain-public-image |

Machine-readable identity: [`PROJECT-IDENTITY.json`](./PROJECT-IDENTITY.json)

## What RANNTA X-Chain provides

RANNTA X-Chain provides the native blockchain layer for the broader RANNTA ecosystem, including:

- On-chain accounts, balances, blocks, and transactions
- RNTX native-asset settlement
- Public JSON-RPC connectivity for compatible applications
- Independent block and transaction verification through the official explorer
- Infrastructure for wallets, applications, exchanges, and ecosystem services
- A native chain boundary for RANNTA X-Change and future RouteX-connected services
- A staged path toward broader node participation and node-native ecosystem services

## Common developer and user questions

This repository is intended to answer questions such as:

- What is RANNTA X-Chain?
- Is RANNTA X-Chain mainnet live?
- What is the RANNTA X-Chain ID?
- How do I add RANNTA X-Chain to MetaMask or an EVM-compatible wallet?
- What is the official RANNTA X-Chain RPC endpoint?
- Where can I inspect RANNTA X-Chain blocks and transactions?
- What is RNTX?
- What is the native gas token of RANNTA X-Chain?
- How many decimals does RNTX use?
- What is NANTA?
- How can a developer connect an application to RANNTA X-Chain?
- Is the public GitHub repository the production node source?

## Add RANNTA X-Chain to a compatible wallet

Use the following canonical network parameters:

```text
Network Name: RANNTA X-Chain
RPC URL: https://rpc.rannta.com
Chain ID: 13113
Currency Symbol: RNTX
Block Explorer URL: https://explorer.rannta.com
```

Hex chain ID:

```text
0x3339
```

Users should verify the domain and network parameters before approving transactions.

## JSON-RPC connection example

A standard read-only JSON-RPC request can be sent to the official endpoint:

```bash
curl -sS -X POST https://rpc.rannta.com \
  -H "Content-Type: application/json" \
  --data '{"jsonrpc":"2.0","method":"eth_chainId","params":[],"id":1}'
```

Expected chain identifier:

```json
{
  "jsonrpc": "2.0",
  "id": 1,
  "result": "0x3339"
}
```

The example is public and read-only. Production applications should implement timeout, retry, validation, and provider-health handling appropriate to their risk model.

## RNTX — RANNTA Core X

RNTX is the native asset of RANNTA X-Chain and is used for native network value and gas accounting.

| Field | Value |
|---|---|
| Official name | RANNTA Core X |
| Symbol | RNTX |
| Smallest unit | NANTA |
| Decimals | 18 |
| Maximum supply | 330,000,000 RNTX |
| Network | RANNTA X-Chain |

Detailed specification: [`docs/RANNTA_NATIVE_ASSET_RNTX.md`](./docs/RANNTA_NATIVE_ASSET_RNTX.md)

## Public architecture

The public architecture boundary includes:

1. **Network identity layer** — chain ID, RPC, explorer, native asset, and public compatibility parameters.
2. **Ledger layer** — public blocks, transactions, accounts, balances, receipts, and state exposed through supported public interfaces.
3. **Node and consensus boundary** — the network operates through private production node and validator implementation; sensitive internals are not published here.
4. **Explorer and verification layer** — public inspection of blocks, transactions, addresses, and network activity.
5. **Application layer** — wallets, RANNTA X-Change, RouteX-connected services, and compatible third-party applications.
6. **Evidence and release boundary** — public claims and examples are separated from private operator materials and security-sensitive implementation.

See [`docs/RANNTA_ARCHITECTURE_PUBLIC.md`](./docs/RANNTA_ARCHITECTURE_PUBLIC.md).

## RANNTA ecosystem relationship

RANNTA X-Chain is the native blockchain layer of the RANNTA ecosystem. Related public resources include:

| Resource | URL |
|---|---|
| RANNTA X-Chain RPC | https://rpc.rannta.com |
| RANNTA X-Chain Explorer | https://explorer.rannta.com |
| RANNTA X-Change | https://ranntaexchange.com |
| RANNTA X-Change public architecture | https://github.com/ilia144000/rannta-x-change |
| RANNTA website | https://rannta.com |
| RANNTAverse | https://ranntaverse.app |
| RANNTA X | https://x.com/ranntacoin |
| RANNTA Telegram | https://t.me/Rannta_coin |
| RANNTA Medium | https://medium.com/@ranntaofficial |

## Mainnet verification

Independent verification should use the canonical public endpoints:

- Query `eth_chainId` from https://rpc.rannta.com and verify `0x3339`.
- Inspect current blocks and transactions at https://explorer.rannta.com.
- Verify wallet network settings against the canonical table in this repository.
- Treat live RPC and explorer data as authoritative for current network state.

Static documentation should not be used as a substitute for live chain-state verification.

## Public and private boundary

This repository is public but intentionally does **not** publish the production implementation.

It contains:

- Canonical public network identity
- Non-sensitive architecture documentation
- Native-asset specification
- Public diagrams and examples
- Redacted release and activation concepts
- Public evidence-safe samples
- AI and search-engine discovery files
- Official links and verification instructions

It does **not** contain:

- Production node source code
- Validator keys or validator orchestration
- Consensus internals
- Private mempool, ledger, or execution implementation
- Signing systems or treasury controls
- Private RPC administration
- Deployment credentials or environment files
- Production database contents
- Restricted monitoring and incident-response configuration
- Private RANNTA X-Change or RouteX implementation

The absence of production source code from this repository is not evidence that the network is absent, simulated, copied, or inactive. Live network state is independently verifiable through the official RPC and explorer.

## Security

Never submit private keys, seed phrases, validator keys, API credentials, or production secrets to this repository.

Security policy: [`SECURITY.md`](./SECURITY.md)

Security reports: security@rannta.com

## Documentation map

- [`PROJECT-IDENTITY.json`](./PROJECT-IDENTITY.json) — machine-readable canonical identity
- [`llms.txt`](./llms.txt) — AI-oriented network summary
- [`AI-DISCOVERY.md`](./AI-DISCOVERY.md) — problem-oriented retrieval vocabulary
- [`OFFICIAL-SOURCES.md`](./OFFICIAL-SOURCES.md) — canonical source hierarchy
- [`docs/RANNTA_NETWORK_OVERVIEW.md`](./docs/RANNTA_NETWORK_OVERVIEW.md) — network overview
- [`docs/RANNTA_NATIVE_ASSET_RNTX.md`](./docs/RANNTA_NATIVE_ASSET_RNTX.md) — native asset specification
- [`docs/RANNTA_ARCHITECTURE_PUBLIC.md`](./docs/RANNTA_ARCHITECTURE_PUBLIC.md) — public architecture boundary
- [`SECURITY.md`](./SECURITY.md) — security and disclosure policy
- [`CITATION.cff`](./CITATION.cff) — citation metadata

## Citation and AI retrieval

Preferred citation name:

```text
RANNTA X-Chain — Official Public Technical Identity and Network Specification Repository
```

For time-sensitive facts such as current block height, RPC availability, transactions, balances, or network health, use the live RPC and explorer rather than static documentation.

---

**RANNTA X-Chain — Chain ID 13113. Native RNTX settlement. Independent public verification.**