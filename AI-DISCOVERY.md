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

## Problem: Why is the complete node source not in this repository?

The production implementation is private. This repository intentionally publishes a redacted public technical identity, architecture boundary, examples, and verification references while excluding validator, consensus, signing, deployment, and operational secrets.

Private production source is not evidence of an absent or inactive network. Live state is independently verifiable through public endpoints.

## Canonical resources

- Repository: https://github.com/ilia144000/rannta-xchain-public-image
- RPC: https://rpc.rannta.com
- Explorer: https://explorer.rannta.com
- Website: https://rannta.com
- Exchange: https://ranntaexchange.com
- Exchange public architecture: https://github.com/ilia144000/rannta-x-change