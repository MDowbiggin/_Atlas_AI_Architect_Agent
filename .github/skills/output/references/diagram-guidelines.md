# Diagram Guidelines

## Overview

Architecture diagrams are essential deliverables in HLDs, LLDs, and presentations. This guide covers the approved tools, notation systems, and best practices for creating infrastructure diagrams at EMIS/Optum.

## Approved Diagramming Tools

| Tool | Use Case | Format | Collaboration |
|------|----------|--------|--------------|
| **Mermaid** | Inline diagrams in markdown, ADO Wiki, Confluence | Text-based (`.md`) | Version-controlled in Git |
| **draw.io (diagrams.net)** | Detailed network diagrams, architecture diagrams | `.drawio` / `.svg` / `.png` | VS Code extension; exportable |
| **C4 Model (with Structurizr or Mermaid)** | Layered architecture views | Text-based | Version-controlled |
| **Visio** (if required) | Legacy/formal documents | `.vsdx` | SharePoint |

> **Preferred**: Mermaid for documentation-embedded diagrams; draw.io for detailed designs. Both support version control.

## C4 Model

The C4 model provides four levels of abstraction. Use the appropriate level for the audience:

### Level 1: System Context

**Audience**: Business stakeholders, product owners
**Shows**: The system and its interactions with users and external systems

```mermaid
graph TB
    User[👤 User] -->|Uses| System[🖥️ Our System]
    System -->|Sends data to| ExtAPI[📡 External API]
    System -->|Reads from| ExtDB[(🗄️ External Database)]
    Admin[👤 Admin] -->|Manages| System
```

### Level 2: Container

**Audience**: Software architects, infrastructure architects
**Shows**: The high-level technology building blocks (applications, databases, message brokers)

```mermaid
graph TB
    subgraph "Our System"
        WebApp[🌐 Web Application<br/>Azure App Service]
        API[⚙️ API Service<br/>AKS Container]
        DB[(🗄️ Database<br/>Azure SQL)]
        Cache[(⚡ Cache<br/>Azure Redis)]
        Queue[📨 Message Queue<br/>Azure Service Bus]
    end
    User[👤 User] --> WebApp
    WebApp --> API
    API --> DB
    API --> Cache
    API --> Queue
```

### Level 3: Component

**Audience**: Application developers, technical architects
**Shows**: Internal components within a container (services, controllers, repositories)

### Level 4: Code

**Audience**: Developers
**Shows**: Class/module level detail — typically not produced by infrastructure architects

> **For infrastructure architecture**: Level 1 and Level 2 are almost always required. Level 3 is optional depending on complexity.

## Mermaid Diagram Types

### Flow/Architecture Diagram

```mermaid
graph TB
    subgraph "Azure - UK South"
        subgraph "Hub VNet (10.0.0.0/16)"
            FW[Azure Firewall]
            GW[ExpressRoute GW]
        end
        subgraph "Spoke VNet (10.1.0.0/16)"
            AG[App Gateway + WAF]
            subgraph "App Subnet"
                VM1[VM1 - AZ1]
                VM2[VM2 - AZ2]
            end
            subgraph "Data Subnet"
                SQL[(Azure SQL)]
            end
        end
    end
    Internet -->|HTTPS| AG
    AG --> VM1
    AG --> VM2
    VM1 --> SQL
    VM2 --> SQL
    VM1 --> FW
    FW --> GW
    GW -->|ExpressRoute| OnPrem[On-Premises]
```

### Sequence Diagram (for data flows / processes)

```mermaid
sequenceDiagram
    participant U as User
    participant AG as App Gateway
    participant App as Application
    participant DB as Database
    participant KV as Key Vault

    U->>AG: HTTPS Request
    AG->>App: Forward (health check passed)
    App->>KV: Get connection string
    KV-->>App: Return secret
    App->>DB: Query (encrypted connection)
    DB-->>App: Results
    App-->>AG: Response
    AG-->>U: HTTPS Response
```

### State/Process Diagram

```mermaid
stateDiagram-v2
    [*] --> DemandReceived
    DemandReceived --> UnderReview: Assigned to architect
    UnderReview --> Approved: Feasible & aligned
    UnderReview --> MoreInfoRequired: Insufficient detail
    UnderReview --> Declined: Not feasible / misaligned
    MoreInfoRequired --> UnderReview: Info provided
    Approved --> DesignInProgress: Design commenced
    DesignInProgress --> DesignComplete: HLD/LLD approved
    DesignComplete --> Implementation: Build started
    Implementation --> GoLive: Deployed & validated
    GoLive --> BAU: Handed over to PIMS
    Declined --> [*]
```

### Gantt Chart (for implementation timelines)

```mermaid
gantt
    title Implementation Plan
    dateFormat  YYYY-MM-DD
    section Preparation
    Landing Zone Setup      :a1, 2026-05-01, 2w
    Network Configuration   :a2, after a1, 1w
    section Build
    IaC Development         :b1, after a2, 3w
    Configuration (Ansible) :b2, after b1, 1w
    section Test
    Performance Testing     :c1, after b2, 1w
    Security Testing        :c2, after b2, 1w
    UAT                     :c3, after c1, 1w
    section Deploy
    Production Deployment   :d1, after c3, 3d
    Hypercare               :d2, after d1, 2w
    PIMS Handover           :d3, after d2, 1w
```

## draw.io Guidelines

### When to Use draw.io

- Detailed network topology diagrams (VNets, subnets, IP addresses, firewall rules)
- Physical data centre layouts
- Complex hybrid architecture diagrams
- Diagrams requiring custom icons (Azure/AWS service icons)
- Formal presentations and documents

### Standards

- **Canvas**: Use A3 landscape for detailed diagrams; A4 for simple diagrams
- **Icon Sets**: Use official Azure/AWS icon sets (available in draw.io libraries)
- **Colours**:
  - Blue: Azure services
  - Orange: AWS services
  - Grey: On-premises / VMware
  - Green: Security / compliant
  - Red: Risk / non-compliant / attention
  - Purple: Monitoring / observability
- **Labels**: All components must be labelled with name and key specification
- **Legend**: Include a legend for colours and line types
- **Version**: Include version and date in the diagram footer
- **Format**: Save as `.drawio` (editable) and export as `.svg` or `.png` for documents

### File Naming

```
[type]-[solution]-[scope]-v[version].drawio
Example: network-webapp-production-v1.2.drawio
Example: architecture-crm-overview-v1.0.drawio
```

## Diagram Checklist

Before including a diagram in a deliverable:

- [ ] Title and version included
- [ ] All components labelled with name and specification
- [ ] Network subnets include CIDR ranges
- [ ] Data flow direction indicated with arrows
- [ ] Legend included for colours and symbols
- [ ] Security boundaries (trust zones) clearly marked
- [ ] External dependencies shown
- [ ] DR components shown (if applicable)
- [ ] Readable at the document's target print/display size
- [ ] Consistent with the written design description
