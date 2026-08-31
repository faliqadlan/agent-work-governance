---
title: Scientific Research Task Template
document_id: SCI-TASK-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-31
scope:
  - validated scientific research contracts
  - bounded computational analysis and experiment contracts
  - research mode, hypothesis, and provenance tracking
  - reproducibility, claim review, and acceptance boundaries
authority_note: A published validated task authorizes only the bounded research execution described below. Observed scientific evidence informs results but does not replace intended authority.
---

# Scientific Research Task

This file defines a bounded research and computational analysis contract for execution.

A validated task MUST provide enough protocol, mode, provenance, acceptance, reproducibility, and stop-condition information for an Executor to proceed without inventing material hypotheses, analysis choices, or approval decisions.

## Task identity

- **Task title:** `<concise human-readable research task title>`
- **Task path:** `.agents/tasks/<task-file>.md`
- **Task contract state:** `Draft | Validated/Published`
- **Delivery objective / Work package:** `<objective-id>`
- **Owner / designated planning authority:** `<designated-authority>`

## Research context

- **Research question / Hypothesis ID:** `<e.g., RQ-01 / H-01>`
- **Research mode:** `Confirmatory | Exploratory | Feasibility`
- **Frozen plan / Preregistration identity:** `<commit-SHA | DOI | N/A (Exploratory)>`
- **Execution baseline:** `<commit SHA of starting repository state>`
- **Governing task revision:** `.agents/tasks/<task-file>.md @ <resolvable immutable revision>`

> [!IMPORTANT]
> Exploratory or feasibility work cannot be silently represented as confirmatory evidence. Absent preregistration cannot be claimed.

## Data and code inputs (Provenance)

- **Input datasets:** `<dataset names, versions, checksums, and paths>`
- **Pipelines / scripts:** `<source code files under src/ or notebooks/>`
- **Environment requirements:** `<environment file, container image, random seed>`

## Objective and scope

### In scope
- `<explicitly authorized computational experiments, data transformations, or model runs>`

### Out of scope
- `<unauthorized data modifications, unapproved hypothesis shifts, or external mutations>`

## Protocol rules and deviation tracking

If unexpected data issues or software bugs require departing from the planned analysis:
1. Do not silently rewrite the protocol.
2. Record the **reason**, **affected analyses**, and **interpretation impact**.
3. If the deviation materially changes the research objective, stop and return to planning.

## Acceptance criteria

- [ ] Pipeline executes to completion from the specified baseline and seed.
- [ ] Primary statistical or computational outputs match expected schemas and thresholds.
- [ ] All claims are traceable to observed data outputs and execution logs.
- [ ] Known limitations and numerical tolerances are documented.

## Reproducibility and verification

- Run command: `<e.g. pytest tests/ or python src/run_analysis.py --seed 42>`
- Environment log: `<capture of package versions and system info>`
- Output verification: `<comparison of generated artifacts against expected checksums/bounds>`

## Stop conditions

The Executor MUST stop and return to Planner/Reviewer if:
- data corruption or missing required inputs prevent valid execution;
- execution reveals a need to change primary hypotheses or study protocol;
- an unapproved deviation materially alters the research scope;
- execution requires unauthorized external mutations or data release.

## Side-effect authorization

Execution authorization is limited to repository-local computation and analysis artifact generation.
It does NOT authorize public dissemination, preprint submission, or external data publishing.
