---
title: Repository Context Template
document_id: AGENT-CONTEXT-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-10
scope:
  - repository-level AI orientation
  - repository authority mapping
  - delivery-state orientation
  - scoped-context routing
authority_note: This file is supporting, refreshable repository context. It does not replace authoritative business, product, requirement, architecture, implementation, test, version-control, CI, or release artifacts.
---

# Repository Context

This file is the repository-level context entrypoint for AI-assisted software delivery.

It provides a verified orientation map of the repository, identifies where authoritative information lives, summarizes the current delivery state, and routes agents to additional scoped context when needed.

It is not a replacement for authoritative repository artifacts.

Keep this file concise enough to serve as an orientation layer. Prefer references to authoritative documents over duplicating their full contents.

## Repository identity

**Name:**  
`<repository-name>`

**Repository type:**  
`<application | service | library | monorepo | data pipeline | documentation repository | internal tool | other>`

**Primary responsibility:**  
`<short description of the outcome or system responsibility owned by this repository>`

## Purpose

Describe why this repository exists and what outcome it is responsible for.

Focus on repository-level purpose rather than implementation details.

`<repository-purpose>`

## Current repository state

Describe the repository's current delivery condition.

Examples include:

- greenfield;
- early implementation;
- active development;
- mature;
- legacy;
- migration or modernization;
- maintenance;
- another repository-specific state.

Record only information that materially affects planning, execution, review, or release decisions.

**Current state:**  
`<state>`

**Relevant summary:**  
`<verified summary of the current repository condition>`

Existing repositories MUST reuse valid artifacts and implementation evidence rather than recreating workflow artifacts solely to conform to this template.

## Authority map

Map the logical responsibilities defined by `.agents/software-workflow.md` to the actual authoritative sources used by this repository.

Physical file locations and artifact structure are repository-defined.

### Business sources and decisions

- `<path, URL reference, issue, decision record, contract, policy, or other approved source>`

### Product / PRD authority

- `<authoritative product or PRD source>`

### Requirements and matrices

- `<requirement registry, specification, traceability source, dependency source, or equivalent>`

### Architecture and repository policy

- `<architecture specification, ADR location, repository instructions, policy, or equivalent>`

### Delivery planning

- `<implementation plan, roadmap, Work Package plan, MVP plan, gap register, or equivalent>`

### Release policy

- `<release procedure, deployment policy, operational gate, or equivalent>`

### Other authority

- `<additional repository-specific authoritative sources>`

Do not duplicate authoritative artifacts when references are sufficient.

If an authority-bearing artifact does not yet exist, record that absence rather than silently substituting agent-generated assumptions.

## Top-level architecture and boundaries

Summarize only the repository-wide boundaries that an agent should understand before loading more detailed context.

Relevant topics MAY include:

- deployable boundaries;
- module, service, domain, or package boundaries;
- data ownership and source-of-truth boundaries;
- trust and security boundaries;
- major external systems;
- major runtime topology;
- repository-to-repository boundaries;
- materially important architectural constraints.

`<concise repository-wide architecture and boundary summary>`

Detailed architecture SHOULD remain in its authoritative repository location when one exists.

## Scoped context

Additional context MAY exist below `.agents/context/` for repository-defined scopes such as:

- modules;
- services;
- domains;
- packages;
- integrations;
- applications;
- infrastructure areas;
- other meaningful repository boundaries.

Load only the scoped context materially relevant to the current work.

### Available scoped context

- `<scope>` → `<relative-context-path>`
- `<scope>` → `<relative-context-path>`

Examples:

```text
Member module       → modules/member/project.md
Image Gateway       → modules/image-gateway/project.md
Billing service     → services/billing/project.md
External PACS       → integrations/pacs/project.md
```

The hierarchy under `.agents/context/` is repository-defined.

A deeper scoped context file does not implicitly override repository-level context or authoritative repository sources.

Material contradictions MUST be verified against repository authority before use.

## Delivery state

Record the currently verified software-delivery state.

This section is an orientation summary, not a replacement for authoritative delivery-planning artifacts.

### Current delivery objective

`<MVP-oriented objective | Work-Package-oriented objective | maintenance objective | other>`

### Current Work Package / MVP / delivery slice

`<identifier or description, if applicable>`

### Quality-gate state

Record only gates that have been verified from repository evidence.

| Gate | Status | Evidence / authority |
|---|---|---|
| B0 — Business Framing | `<passed | in-review | blocked | not-applicable | unknown>` | `<reference>` |
| P1 — Product Definition | `<status>` | `<reference>` |
| R2 — Requirements | `<status>` | `<reference>` |
| A3 — Architecture | `<status>` | `<reference>` |
| D4 — Delivery Planning | `<status>` | `<reference>` |
| T5 — Task Readiness | `<status>` | `<reference>` |
| E6 — Execution Verification | `<status>` | `<reference>` |
| V7 — Review | `<status>` | `<reference>` |
| R8 — Remediation | `<status>` | `<reference>` |
| A9 — Acceptance | `<status>` | `<reference>` |
| G10 — Release | `<status>` | `<reference>` |

**Earliest unmet or materially unreliable gate:**  
`<gate-id and reason>`

### Active task(s)

- `<task path and, when available, immutable task revision>`

### Blocking items

- `<blocking dependency, decision, approval, or gap>`

Non-blocking items should remain visible only when they materially affect downstream planning or execution.

## Accepted baseline

Record the current accepted immutable repository revision.

For Git repositories, prefer the full commit SHA.

**Accepted baseline:**  
`<immutable repository revision>`

**Accepted scope:**  
`<short description of what this baseline is known to satisfy>`

**Evidence reference:**  
`<review, CI, acceptance record, or other supporting evidence>`

Branch names, tags, or labels MAY be recorded for convenience but MUST NOT replace the immutable revision used for execution and review.

## Known gaps and open decisions

Record only unresolved items that materially affect repository orientation or delivery.

Detailed gap registers, ADRs, requirement matrices, or decision logs SHOULD remain in their authoritative repository locations when they already exist.

### Blocking

- `<item>`
  - owner: `<owner>`
  - impact: `<impact>`
  - resolution trigger: `<trigger>`

### Non-blocking

- `<item>`
  - owner: `<owner>`
  - impact: `<impact>`
  - resolution trigger: `<trigger or latest stage by which it must be resolved>`

Do not convert unresolved decisions into implementation assumptions.

## Repository conventions

Record repository-specific conventions and constraints that materially affect planning, execution, review, or release.

Examples MAY include:

- repository structure conventions;
- module ownership rules;
- testing expectations;
- migration constraints;
- generated-code boundaries;
- dependency policies;
- API compatibility constraints;
- deployment restrictions;
- security or privacy constraints;
- prohibited operational practices.

`<repository-specific conventions>`

Do not reproduce generic software-engineering methodology here.

## Context verification

This context is supporting, refreshable repository knowledge.

Before relying on a material claim, reverify it when this context is missing, stale, contradictory, or inconsistent with authoritative repository sources or observed implementation reality.

**Last verified:**  
`<date-time or date>`

**Verified against repository revision:**  
`<immutable revision when applicable>`

**Verified sources:**  

- `<source>`
- `<source>`

**Known verification limitations:**  

- `<limitation or "None known">`
