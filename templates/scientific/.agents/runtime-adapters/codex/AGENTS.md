---
title: Codex Runtime Adapter for Scientific Research
document_id: SCI-RUNTIME-CODEX-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-31
runtime: Codex
materialization_target: ./AGENTS.md
scope:
  - Codex adapter bootstrap for scientific research
  - instruction integration with .agents/
  - methodology and specialist capability boundaries
authority_note: This file is a runtime bootstrap and execution-methodology adapter. It MUST NOT override .agents/AGENTS.md, .agents/research-governance.md, approved study protocol, the governing task revision, or observed scientific evidence.
---

# Codex Runtime Adapter for Scientific Research

This file is the root Codex instruction entrypoint for repositories using the canonical `.agents/` Scientific Research Governance framework.

Its purpose is to connect Codex instruction discovery to the repository-local research delivery contract.

When materialized at repository root as `AGENTS.md`, Codex automatically discovers it.

## Canonical routing

The canonical repository contract is:

- [`.agents/AGENTS.md`](.agents/AGENTS.md)

When applicable, follow its role-aware progressive-loading rules for:
- authority versus observed scientific evidence;
- Planner, Reviewer, and Executor responsibilities;
- study protocol and frozen analysis plan conformance;
- execution baselines and provenance tracking;
- side-effect and dissemination boundaries.

`.agents/research-governance.md` remains the normative scientific research protocol.

This root adapter MUST NOT override either canonical file.

## Planner and Reviewer procedure

When acting as Planner or Reviewer, load the required canonical context and use:

- [`.agents/prompts/plan-create-task.md`](.agents/prompts/plan-create-task.md)

as the delivery-orchestration procedure.

## Methodology and specialist capability boundaries

External methodologies (such as `K-Dense-AI/science-superpowers`) and specialist capability libraries (such as `K-Dense-AI/scientific-agent-skills`) are execution aids.

Runtime execution methodology remains subordinate to:
1. applicable human and study authority;
2. `.agents/research-governance.md`;
3. `.agents/AGENTS.md`;
4. the exact governing validated task when executing;
5. applicable approval, permission, privacy, and side-effect boundaries.
