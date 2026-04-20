# Security Architecture

> **Source**: Confluence — Architecture Space (ARCH)
> **Classification**: Internal

## Overview

This document gives an overview of the security requirements for developing our software. This does not only apply to new developments but also provides a security baseline for our current applications either to be working towards or comply with.

---

## Why Do We Need Security?

The data contained within the applications we build is sensitive and any breach of our solutions could lead to data being either lost or compromised. We need to ensure the solutions we produce are as secure as we can make them. This can be achieved by ensuring we assess the security risks of our solution — we should always take a pessimistic view of these risks and ensure reasonable mitigations are put in place to counter them.

---

## Security by Design

All solutions should be designed with a **security first** approach. If this is not the case, then applying security after the main application is built may require significant rework.

At a high level, for all applications, we must **assume that any operating environment applications are deployed to are insecure**, adopting a **Zero Trust Model**.

### Mandatory Requirements — All Applications

We **MUST**:

1. **Encrypt data in transit** — both external to the solution and between solution components
2. **Authenticate** solution users — ensure they are known
3. **Authorise** solution users — ensure they are permitted to undertake the requested activity
4. **Enforce good password maintenance and security**
5. **Implement protection against known attack vectors** — for example the [OWASP Top 10](https://owasp.org/www-project-top-ten/)
6. **Implement the principle of least privilege** across the solution — review regularly to prevent privilege creep
7. **Ensure no sensitive strings are stored in plain text** — not in configuration files, code, or data stores
8. **Audit all activities centrally** within the deployed solution

### Additional Requirements — New Applications

For new applications we **MUST** also ensure that:

1. **Data is encrypted at rest** within whatever storage mechanism is being used
2. **Bot protection** is in place to prevent DDoS and brute force attacks
3. **Cloud-hosted solutions run with private networks and endpoints by default**
4. **Security is enforced at all layers of the solution** (Defence in Depth)

---

## Security Architecture Child Pages

The following sub-topics provide detailed guidance on each security area:

| Topic | Confluence Page | Description |
|-------|----------------|-------------|
| **Security Defence in Depth** | ARCH/Security+Defence+in+Depth | Layered security approach across all solution tiers |
| **Encrypt Data In Transit** | ARCH/Encrypt+Data+In+Transit | TLS/mTLS requirements for data in motion |
| **Authentication & Authorisation** | ARCH/Authentication+Authorisation | Identity verification and access control |
| **Threat Modelling** | ARCH/Threat+Modelling | Identifying and mitigating security threats |
| **Principle of Least Privilege** | ARCH/Principle+of+least+privilege | Minimum necessary access controls |
| **Protect Against Known Attack Vectors** | ARCH/Protect+against+known+attack+vectors | OWASP and common vulnerability mitigations |
| **Encrypt Data at Rest** | ARCH/Encrypt+Data+at+Rest | Encryption requirements for stored data |
| **Central Auditing of Actions** | ARCH/Central+Auditing+of+actions | Audit trail and logging requirements |
| **Bot Protection** | ARCH/Bot+Protection | DDoS and brute force attack prevention |
| **Secret Management** | ARCH/Secret+Management | Secrets, credentials, and key management |
| **Session Management** | ARCH/Session+Management | Secure session handling |
| **Password Requirements** | ARCH/Password+Requirements | Password policy and enforcement |
| **SQL Injection** | ARCH/SQL+Injection | SQL injection prevention |
| **WAF Rule Sets** | ARCH/WAF+Rule+Sets | Web Application Firewall configuration |
| **AWS Confused Deputy** | ARCH/AWS+Confused+Deputy | AWS cross-account access security |
