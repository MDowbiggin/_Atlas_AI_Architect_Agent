---
name: production-grade-engineering-skills
description: "Production-grade software and IaC engineering lifecycle skills. Use when: writing or reviewing IaC code (Terraform, Bicep, Ansible, CloudFormation); designing CI/CD pipelines; conducting security hardening reviews; gathering and refining requirements for a demand or design; producing Architecture Decision Records; breaking down architecture work into implementation tasks; debugging BAU incidents; planning or reviewing migrations and deprecations; or ensuring any code or automation deliverable meets production quality standards."
---

# Production-Grade Engineering Skills

## When to Use (Atlas Context)

These skills apply whenever Atlas_Architect produces, reviews, or plans code or automation artefacts. They encode the engineering discipline that ensures infrastructure deliverables are production-quality — not just architecturally sound, but implementable, testable, secure, and maintainable.

| Atlas Activity | Primary Skill(s) | Supporting Skills |
|----------------|-----------------|-------------------|
| Scoping a new demand or unclear requirement | `interview-me`, `idea-refine` | `spec-driven-development` |
| Writing an IaC specification or design brief | `spec-driven-development` | `planning-and-task-breakdown` |
| Breaking architecture work into delivery tasks | `planning-and-task-breakdown` | `incremental-implementation` |
| Writing Terraform / Bicep / Ansible / CloudFormation | `incremental-implementation` | `test-driven-development`, `git-workflow-and-versioning` |
| Reviewing IaC code quality | `code-review-and-quality` | `code-simplification` |
| Security hardening review of IaC or design | `security-and-hardening` | `security-compliance` skill |
| Designing or reviewing ADO / GitHub Actions pipelines | `ci-cd-and-automation` | `git-workflow-and-versioning` |
| Producing Architecture Decision Records | `documentation-and-adrs` | `decision-making` skill |
| Debugging a BAU incident or failed deployment | `debugging-and-error-recovery` | `doubt-driven-development` |
| Planning a migration or platform deprecation | `deprecation-and-migration` | `incremental-implementation` |
| Pre-deployment readiness check | `shipping-and-launch` | `ci-cd-and-automation` |
| IaC refactoring or simplification | `code-simplification` | `code-review-and-quality` |
| Performance review of infrastructure or pipelines | `performance-optimization` | — |
| Designing API or integration boundaries | `api-and-interface-design` | `security-and-hardening` |
| High-stakes or irreversible architecture decision | `doubt-driven-development` | `decision-making` skill |

## Skill Index

### Discovery
- [`using-agent-skills`](skills/using-agent-skills/SKILL.md) — Maps any task to the right skill; start here if unsure

### Define — Clarify what to build
- [`interview-me`](skills/interview-me/SKILL.md) — One-question-at-a-time requirements extraction; use when a demand is underspecified
- [`idea-refine`](skills/idea-refine/SKILL.md) — Structured divergent/convergent thinking for vague concepts
- [`spec-driven-development`](skills/spec-driven-development/SKILL.md) — Write a structured specification before any code or design; gated four-phase workflow

### Plan — Break it down
- [`planning-and-task-breakdown`](skills/planning-and-task-breakdown/SKILL.md) — Decompose specs into small, verifiable tasks with acceptance criteria and dependency order

### Build — Write the code
- [`incremental-implementation`](skills/incremental-implementation/SKILL.md) — Thin vertical slices: implement → test → verify → commit; applies to IaC modules and automation scripts
- [`test-driven-development`](skills/test-driven-development/SKILL.md) — Red-Green-Refactor, test pyramid; applies to Terratest, policy tests (OPA/Checkov), and pipeline unit tests
- [`context-engineering`](skills/context-engineering/SKILL.md) — Feed agents the right information at the right time; manage context windows and rules files
- [`source-driven-development`](skills/source-driven-development/SKILL.md) — Ground every framework and provider decision in official documentation; verify and cite sources
- [`doubt-driven-development`](skills/doubt-driven-development/SKILL.md) — Adversarial review of high-stakes decisions; mandatory for production, security, or irreversible changes
- [`api-and-interface-design`](skills/api-and-interface-design/SKILL.md) — Contract-first design, Hyrum's Law, error semantics; applies to API gateway designs and module interfaces

### Verify — Prove it works
- [`debugging-and-error-recovery`](skills/debugging-and-error-recovery/SKILL.md) — Five-step triage: reproduce → localise → reduce → fix → guard; applies to BAU incident response and failed deployments
- [`browser-testing-with-devtools`](skills/browser-testing-with-devtools/SKILL.md) — Chrome DevTools MCP for live runtime data; applies when reviewing web-facing portal or console behaviour

### Review — Quality gates before merge
- [`code-review-and-quality`](skills/code-review-and-quality/SKILL.md) — Five-axis review framework; change sizing; applies to IaC PR reviews and automation script reviews
- [`code-simplification`](skills/code-simplification/SKILL.md) — Chesterton's Fence, Rule of 500; reduce IaC complexity without changing behaviour
- [`security-and-hardening`](skills/security-and-hardening/SKILL.md) — OWASP Top 10, STRIDE threat model, three-tier boundary system; complements the `/security-compliance` skill for code-level controls
- [`performance-optimization`](skills/performance-optimization/SKILL.md) — Measure-first; applies to pipeline execution time, Terraform plan time, and infrastructure throughput

### Ship — Deploy with confidence
- [`git-workflow-and-versioning`](skills/git-workflow-and-versioning/SKILL.md) — Trunk-based development, atomic commits, change sizing; applies to all IaC repository work
- [`ci-cd-and-automation`](skills/ci-cd-and-automation/SKILL.md) — Shift Left, quality gate pipelines, feature flags; applies to ADO and GitHub Actions pipeline design and review
- [`deprecation-and-migration`](skills/deprecation-and-migration/SKILL.md) — Code-as-liability mindset, compulsory vs advisory deprecation, migration patterns; applies to re-platforming and technology retirement
- [`documentation-and-adrs`](skills/documentation-and-adrs/SKILL.md) — Architecture Decision Records, API docs, inline documentation standards; complements the `/decision-making` skill
- [`shipping-and-launch`](skills/shipping-and-launch/SKILL.md) — Pre-launch checklists, staged rollouts, rollback procedures; applies to infrastructure deployment readiness gates

## Specialist Personas

Three specialist review personas are included. Invoke when you need a focused deep-dive:

| Persona | File | Use When |
|---------|------|----------|
| **Code Reviewer** | [`agents/code-reviewer.md`](agents/code-reviewer.md) | IaC PR review, automation script review; "would a staff engineer approve this?" |
| **Security Auditor** | [`agents/security-auditor.md`](agents/security-auditor.md) | Security-focused IaC review, threat modelling, OWASP/STRIDE assessment |
| **Test Engineer** | [`agents/test-engineer.md`](agents/test-engineer.md) | Test strategy for IaC (Terratest, Checkov, OPA), pipeline test coverage |

## Reference Checklists

| Reference | Covers | Atlas Relevance |
|-----------|--------|----------------|
| [`security-checklist.md`](references/security-checklist.md) | Pre-commit checks, auth, input validation, OWASP Top 10 | IaC security gates, pipeline secrets handling |
| [`testing-patterns.md`](references/testing-patterns.md) | Test structure, naming, mocking, anti-patterns | Policy tests, Terratest patterns, pipeline test design |
| [`performance-checklist.md`](references/performance-checklist.md) | Core Web Vitals targets, profiling, bundle analysis | Infrastructure throughput, pipeline efficiency |
| [`accessibility-checklist.md`](references/accessibility-checklist.md) | Keyboard nav, screen readers, ARIA, WCAG 2.1 AA | Portal/web UI components in managed services |

## Atlas-Specific Usage Notes

### IaC Code Quality
When writing or reviewing Terraform, Bicep, Ansible, or CloudFormation, treat the IaC module as production code — not a configuration file. Apply `incremental-implementation` (one resource type at a time), `test-driven-development` (Checkov/OPA policy tests before applying), and `code-review-and-quality` (PR review before merge to main) to every IaC change.

### Security Hardening of IaC
The `security-and-hardening` skill's STRIDE threat model and three-tier boundary system apply directly to IaC: treat provider credentials as secrets (never hardcode), treat variable inputs as untrusted at module boundaries, and apply least-privilege IAM/RBAC in every resource definition. Cross-reference with the `/security-compliance` skill for HIPAA/NIST/CIS controls.

### ADR Production
`documentation-and-adrs` provides the ADR template and decision workflow. It complements the `/decision-making` skill — use `documentation-and-adrs` for the *format and writing discipline*, and `/decision-making` for the *EMIS/Optum-specific scoring framework and ARB routing*.

### Demand Scoping
`interview-me` and `idea-refine` are the engineering equivalents of the Architecture Assessment demand triage. Use them when a demand brief is underspecified — gather requirements one question at a time before committing to an HLD or LLD scope.

### CI/CD Pipeline Design
`ci-cd-and-automation` covers the quality gate pipeline pattern (lint → type check → unit test → build → integration → security audit). For ADO pipelines, combine this with the `/technology-roadmap` skill for approved ADO task extensions and agent pool standards.
