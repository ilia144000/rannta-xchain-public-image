# RANNTA X-Chain Public Architecture

This document describes the non-sensitive public architecture boundary of RANNTA X-Chain. It does not disclose production source code, consensus internals, validator orchestration, signing material, or deployment secrets.

## 1. Network identity layer

Public identity and compatibility parameters:

- Network: RANNTA X-Chain
- Chain ID: 13113
- Hex chain ID: 0x3339
- Native asset: RANNTA Core X
- Symbol: RNTX
- Decimals: 18
- RPC: https://rpc.rannta.com
- Explorer: https://explorer.rannta.com

## 2. Public ledger interface

Supported public interfaces expose appropriate read and transaction-submission capabilities for compatible wallets and applications, including public concepts such as:

- Chain identity
- Blocks and block references
- Transactions and receipts
- Accounts and balances
- Nonces and gas-related data
- Contract code and public state where supported

Exact runtime behavior and currently available methods must be verified against the live endpoint.

## 3. Private node and consensus boundary

The following remain private and are not represented by this repository:

- Production node implementation
- Validator keys and validator topology
- Consensus internals
- Mempool and execution internals
- Peer-management controls
- Signing infrastructure
- Administrative RPC surfaces
- Deployment and recovery automation
- Monitoring, alerting, and incident-response configuration

## 4. Explorer and verification layer

The official explorer provides a public verification surface for blocks, transactions, addresses, and network activity:

https://explorer.rannta.com

Explorer presentation is informative; canonical transaction and state validity remain properties of the live blockchain network.

## 5. Application and ecosystem layer

Compatible applications may connect through the public network boundary. RANNTA ecosystem integrations include:

- RANNTA X-Change
- RouteX-connected infrastructure
- Compatible wallets
- Public blockchain inspection tools
- Future developer and ecosystem applications

The public existence of an application integration does not expose or license its private implementation.

## 6. Controlled release and evidence layer

RANNTA separates:

- Live public network identity
- Publicly verifiable chain state
- Non-sensitive architecture documentation
- Redacted examples and evidence
- Private operator and implementation material

Performance, capacity, validator, bridge, and production-security claims should only be published when supported by appropriate evidence and disclosure review.

## Trust boundary

A public GitHub repository is not the production node package. Users and developers should verify current network state using the official RPC and explorer and should not treat redacted samples as production configuration.