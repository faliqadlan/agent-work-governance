---
title: Agent Work Governance Repository Contract
document_id: AGENTS-CONTRACT-001
version: 1.5
status: approved-reference
language: en-US
last_updated: 2026-08-31
scope:
  - repository-internal governance for code-agent-template
  - distribution of standalone software and scientific governance templates
  - planning, execution, and review boundaries
authority_note: Approved repository authority governs intended behavior. Observed repository evidence governs claims about current implementation reality. Neither silently overrides the other.
---

# Agent Work Governance Repository Contract

This root `.agents/` package serves as the **repository-internal governance** contract for `code-agent-template` (distributing the Agent Work Governance framework).

The distributable, standalone template packages are located at:

- `templates/software/.agents/` (Software delivery governance)
- `templates/scientific/.agents/` (Scientific research and analysis governance)

A target repository adopts exactly one selected package as its own root `.agents/` directory.

## Repository authority and delivery protocol

Active delivery work in this repository is governed by:

- `.agents/software-workflow.md` (normative software delivery protocol for repository work)
- `.agents/tasks/` (bounded governing tasks)

Planning, execution, and review follow the repository authority model, quality gates, task contracts, and evidence rules.

## Shared governance invariants

Both distributable packages embody these cross-domain invariants:

- Human Request expresses intent; it is not automatic truth or sufficient authority.
- Authority and observed evidence remain distinct; external imperative wording does not become authority.
- Planner/Reviewer and Executor responsibilities remain distinct.
- Work requires a bounded governing contract with an identifiable governing revision.
- The governing task revision and the work/implementation or execution baseline remain distinguishable.
- Findings within the same bounded objective remain remediation; material changes return to planning.
- Claims require sufficient evidence before acceptance.
- Acceptance does not automatically authorize consequential external action.
- Progressive context and runtime neutrality are preserved.

## Methodology and capability boundaries

External methodologies (such as `obra/superpowers` or `K-Dense-AI/science-superpowers`) and specialist capabilities (such as `K-Dense-AI/scientific-agent-skills`) are execution aids and remain external references.
