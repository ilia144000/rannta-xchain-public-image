# RANNTA X-Chain Native Asset Specification

## Canonical native asset

The official native asset of RANNTA X-Chain is **RANNTA Core X (RNTX)**.

| Field | Canonical value |
|---|---|
| Display name | RNTX — RANNTA Core X |
| Full name | RANNTA Core X |
| Symbol | RNTX |
| Smallest unit | NANTA |
| Decimals | 18 |
| Maximum supply | 330,000,000 RNTX |
| Supply schedule | Mining issuance halves approximately every 5.35 years |
| Native network | RANNTA X-Chain |
| Chain ID | 13113 |
| Hex chain ID | 0x3339 |
| Official RPC | https://rpc.rannta.com |
| Official explorer | https://explorer.rannta.com |

## Functional role

RNTX is the native network asset used for native value accounting and gas on RANNTA X-Chain.

It is not an ERC-20 token contract on its native chain. Wallets and applications should treat it as the chain-native currency identified by Chain ID `13113`.

## Unit conversion

Because RNTX uses 18 decimals:

```text
1 RNTX = 1,000,000,000,000,000,000 NANTA
```

Applications must use integer base units for transaction values and only convert to decimal RNTX for display.

## Required naming rule

Use the following official identity:

```text
RNTX — RANNTA Core X
```

Do not rename the asset to "RANNTA X-Chain Native Coin" as an official name. That phrase may only be used as a generic descriptive label.

## Verification

The current network state, balances, gas use, blocks, and transactions should be verified through:

- RPC: https://rpc.rannta.com
- Explorer: https://explorer.rannta.com

Static supply and identity documentation does not replace live on-chain verification.