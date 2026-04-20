# Well-Architected Framework

> **Source**: Confluence — Architecture Space (ARCH)
> **Classification**: Internal
> **External Reference**: [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/)

## EMIS Adoption Context

We want to adopt the AWS Well-Architected Framework for all of our solutions going forwards. However, much of the framework is not within the remit of the Architecture Team at EMIS. If we are to fully adopt the framework, we need to work collaboratively with teams and leaders to ensure ownership (responsibility & accountability) is agreed across the business. Further, many of the questions in the AWS Well-Architected Framework are covered by processes we already have in place at EMIS and so many of the questions can be answered once instead of for every project.

---

## Overview

The [AWS Well-Architected Framework](https://aws.amazon.com/architecture/well-architected/) documents a set of foundational questions that allow you to understand if a specific architecture aligns well with cloud best practices. The framework provides a consistent approach to evaluating systems against the qualities you expect from modern cloud-based systems, and the remediation that would be required to achieve those qualities.

The AWS Well-Architected Framework is based on **six pillars** — operational excellence, security, reliability, performance efficiency, cost optimisation, and sustainability.

### The Pillars of the AWS Well-Architected Framework

| Pillar | Description |
|--------|-------------|
| **Operational Excellence** | The ability to support development and run workloads effectively, gain insight into their operations, and to continuously improve supporting processes and procedures to deliver business value. |
| **Security** | The security pillar describes how to take advantage of cloud technologies to protect data, systems, and assets in a way that can improve your security posture. |
| **Reliability** | The reliability pillar encompasses the ability of a workload to perform its intended function correctly and consistently when it's expected to. This includes the ability to operate and test the workload through its total lifecycle. |
| **Performance Efficiency** | The ability to use computing resources efficiently to meet system requirements, and to maintain that efficiency as demand changes and technologies evolve. |
| **Cost Optimisation** | The ability to run systems to deliver business value at the lowest price point. |
| **Sustainability** | The ability to continually improve sustainability impacts by reducing energy consumption and increasing efficiency across all components of a workload by maximising the benefits from the provisioned resources and minimising the total resources required. |

---

## General Design Principles

The Well-Architected Framework identifies a set of general design principles to facilitate good design in the cloud:

- **Stop guessing your capacity needs**: Use as much or as little capacity as you need, and scale up and down automatically.
- **Test systems at production scale**: Create a production-scale test environment on demand, complete testing, and then decommission the resources.
- **Automate to make architectural experimentation easier**: Create and replicate workloads at low cost, track changes, audit impact, and revert when necessary.
- **Allow for evolutionary architectures**: In the cloud, the capability to automate and test on demand lowers the risk of impact from design changes, allowing systems to evolve over time.
- **Drive architectures using data**: Collect data on how architectural choices affect workload behaviour to make fact-based decisions.
- **Improve through game days**: Regularly schedule game days to simulate events in production, understand improvements, and build organisational experience.

---

## The 6 Pillars

### 1. Operational Excellence

The [Operational Excellence pillar](https://docs.aws.amazon.com/wellarchitected/latest/operational-excellence-pillar/welcome.html) includes the ability to support development and run workloads effectively, gain insight into their operation, and continuously improve supporting processes and procedures to deliver business value.

**Design Principles:**

- Perform operations as code
- Make frequent, small, reversible changes
- Refine operations procedures frequently
- Anticipate failure
- Learn from all operational failures

**Best Practices:** Operations teams need to understand their business and customer needs so they can support business outcomes. Ops creates and uses procedures to respond to operational events, and validates their effectiveness. It's important to design operations to support evolution over time in response to change, and to incorporate lessons learned.

---

### 2. Security

The [Security pillar](https://docs.aws.amazon.com/wellarchitected/latest/security-pillar/welcome.html) includes the ability to protect data, systems, and assets to take advantage of cloud technologies to improve your security.

**Design Principles:**

- Implement a strong identity foundation
- Enable traceability
- Apply security at all layers
- Automate security best practices
- Protect data in transit and at rest
- Keep people away from data
- Prepare for security events

**Best Practices:** Before you architect any workload, you need to put in place practices that influence security. Control who can do what, identify security incidents, protect systems and services, and maintain the confidentiality and integrity of data. Have a well-defined process for responding to security incidents.

---

### 3. Reliability

The [Reliability pillar](https://docs.aws.amazon.com/wellarchitected/latest/reliability-pillar/welcome.html) encompasses the ability of a workload to perform its intended function correctly and consistently when it's expected to, including the ability to operate and test the workload through its total lifecycle.

**Design Principles:**

- Automatically recover from failure
- Test recovery procedures
- Scale horizontally to increase aggregate workload availability
- Stop guessing capacity
- Manage change in automation

**Best Practices:** Foundational requirements that influence reliability should be in place before building any system. A reliable workload starts with upfront design decisions for both software and infrastructure. Follow specific patterns such as loosely coupled dependencies, graceful degradation, and limiting retries. Implement resiliency through fault isolation, automated failover, and a disaster recovery strategy.

---

### 4. Performance Efficiency

The [Performance Efficiency pillar](https://docs.aws.amazon.com/wellarchitected/latest/performance-efficiency-pillar/welcome.html) includes the ability to use computing resources efficiently to meet system requirements, and to maintain that efficiency as demand changes and technologies evolve.

**Design Principles:**

- Democratise advanced technologies
- Go global in minutes
- Use serverless architectures
- Experiment more often
- Consider [mechanical sympathy](https://wa.aws.amazon.com/wellarchitected/2020-07-02T19-33-23/wat.concept.mechanical-sympathy.en.html)

**Best Practices:** Take a data-driven approach to building a high-performance architecture. Review choices on a regular basis to take advantage of the evolving AWS Cloud. Make trade-offs such as using compression or caching, or relaxing consistency requirements. Combine multiple solutions and enable different features to improve performance.

---

### 5. Cost Optimisation

The [Cost Optimisation pillar](https://docs.aws.amazon.com/wellarchitected/latest/cost-optimization-pillar/welcome.html) includes the ability to run systems to deliver business value at the lowest price point.

**Design Principles:**

- Implement cloud financial management
- Adopt a consumption model
- Measure overall efficiency
- Stop spending money on undifferentiated heavy lifting
- Analyse and attribute expenditure

**Best Practices:** Consider trade-offs between speed to market and cost. Avoid over-provisioned and under-optimised deployments driven by haste rather than data. Use the appropriate services, resources, and configurations for your workloads.

---

### 6. Sustainability

The [discipline of sustainability](https://docs.aws.amazon.com/wellarchitected/latest/sustainability-pillar/sustainability-pillar.html) addresses the long-term environmental, economic, and societal impact of your business activities.

**Design Principles:**

- Understand your impact
- Establish sustainability goals
- Maximise utilisation
- Anticipate and adopt new, more efficient hardware and software offerings
- Use managed services
- Reduce the downstream impact of your cloud workloads

**Best Practices:** Choose AWS Regions based on business requirements and sustainability goals. Scale infrastructure down when not needed, position resources to limit the network required, and remove unused assets. Implement load smoothing and maintain consistent high utilisation. Analyse data patterns to reduce provisioned storage. Select the most efficient hardware for your workload. Use automation to manage the lifecycle of development and test environments.
