---
title: Scientific Study Context Template
document_id: SCI-CONTEXT-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-31
scope:
  - study-level scientific orientation
  - research authority mapping
  - experimental and analysis evidence mapping
  - research state, mode, and accepted baseline tracking
  - scoped research context router
authority_note: This file is supporting, refreshable repository context. Approved study protocols govern intended behavior; observed scientific evidence governs claims about findings.
---

# Scientific Study Context

This file is the study-level context entrypoint for AI-assisted scientific research and computational analysis when adopted into a target repository.

In this template package, angle-bracket values (e.g. `<study-name>`) are intentional placeholders that must be replaced with verified repository facts during adoption.

## Study identity

- **Study name / Project:** `<study-name>`
- **Research domain:** `<computational-biology | machine-learning | physics | social-science | other>`
- **Primary investigation goal:** `<concise summary of research objective>`
- **Current research mode:** `<confirmatory | exploratory | feasibility>`
- **Preregistration / plan freeze:** `<none | frozen plan commit SHA | public registry DOI>`

## Research questions and hypotheses

| ID | Type | Description | Evaluation metric / criterion |
|---|---|---|---|
| `RQ-01` | `<Question | Hypothesis>` | `<description>` | `<significance threshold / success criterion>` |

## Intended study authority map

Map governing study decisions to repository sources:

| Responsibility | Repository source / Location | Status |
|---|---|---|
| Study proposal / Grant | `<path or URL>` | `<approved | draft>` |
| Analysis protocol / Plan | `<path or URL>` | `<frozen | iterative>` |
| Institutional / Ethics approval | `<path or URL>` | `<approved | N/A>` |
| Research governance protocol | [`.agents/research-governance.md`](.agents/research-governance.md) | `approved-reference` |
| Active research contract | [`.agents/tasks/_template.md`](.agents/tasks/_template.md) | `approved-template` |

## Observed scientific evidence map

| Asset | Location / Pointer | Provenance / Hash / Version |
|---|---|---|
| Raw data | `<data/raw/ or external URI>` | `<checksum / acquisition date>` |
| Preprocessing pipelines | `<src/preprocessing/ or scripts/>` | `<commit revision>` |
| Analysis notebooks / code | `<src/analysis/ or notebooks/>` | `<commit revision>` |
| Output artifacts / figures | `<results/ or models/>` | `<artifact checksum>` |
| Computational environment | `<environment.yml or Dockerfile>` | `<lockfile hash>` |

## Current research state

- **Current accepted baseline:** `<commit-SHA / initial-baseline>`
- **Active research task:** `<none | .agents/tasks/active-task.md>`
- **Pending review items:** `<none | list of items>`
- **Blocking questions / deviations:** `<none | documented deviations>`

## Scoped context router

Load deeper scoped context only when relevant:

```text
.agents/context/
├── project.md
├── datasets/
├── models/
├── pipelines/
└── protocols/
```

Context is supporting and refreshable. It does not override approved study authority or observed experimental evidence.
