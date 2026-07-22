# Security Policy

## Repository status

This repository is a public, redacted, documentation-oriented image of RANNTA X-Chain. It is not the production node source repository, a validator distribution, or a deployable mainnet package.

## Never publish here

Do not commit or disclose:

- Private keys or seed phrases
- Validator keys or validator topology
- Signing material
- RPC administrator credentials
- API keys or access tokens
- Production environment files
- Internal IP addresses or restricted endpoints
- Deployment, recovery, or incident-response secrets
- Unredacted production logs
- Treasury or exchange signing configuration
- Private RANNTA X-Change or RouteX implementation

## Official public endpoints

- RPC: https://rpc.rannta.com
- Explorer: https://explorer.rannta.com
- RANNTA website: https://rannta.com
- RANNTA X-Change: https://ranntaexchange.com

Users should verify domains before submitting transactions or connecting compatible wallets.

## Wallet and transaction safety

- Never provide a seed phrase or private key to a website, repository issue, support account, or contributor.
- Verify Chain ID `13113` / `0x3339` before signing.
- Verify the RPC and explorer domains against this repository.
- Review transaction destination, value, gas, contract address, and requested permissions inside the wallet.
- Use the official explorer to inspect transaction results.

## Reporting a vulnerability

Do not publish exploitable security findings as public GitHub issues.

Send security reports privately to:

security@rannta.com

Include, when safe:

- Affected public component or endpoint
- Technical description
- Reproduction conditions
- Potential impact
- Transaction hashes or public block references
- Suggested mitigation

Never include private keys, seed phrases, validator credentials, or sensitive production secrets in a report.

## Disclosure boundary

Security-sensitive implementation details are intentionally excluded from this repository. The absence of private implementation details is a deliberate security boundary and does not indicate that the live network lacks a production implementation.