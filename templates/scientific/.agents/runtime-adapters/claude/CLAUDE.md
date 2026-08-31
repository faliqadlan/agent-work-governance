<!-- runtime-adapter: claude | version: 1.0 | status: approved-template -->
<!-- source-location import: @../../AGENTS.md -->
<!-- when materialized as ./CLAUDE.md, replace that import with @.agents/AGENTS.md -->

@../../AGENTS.md

# Claude Code Runtime Adapter for Scientific Research

This file connects Claude Code to the repository-local, runtime-neutral Scientific Research Governance contract under `.agents/`.

The imported `.agents/AGENTS.md` contract is canonical for repository AI delivery.

This adapter adds only Claude Code-specific runtime behavior. It MUST NOT redefine or weaken canonical study authority, the research protocol, governing tasks, evidence requirements, approval boundaries, or dissemination boundaries.

## Canonical routing

Use the imported `.agents/AGENTS.md` contract for role routing and progressive loading.

`.agents/research-governance.md` remains the normative scientific research protocol.

When acting as Planner or Reviewer:
- load the canonical files required by `.agents/AGENTS.md`;
- use `.agents/prompts/plan-create-task.md` as the canonical delivery-orchestration procedure;
- resolve pending execution, review, remediation, approval, and baseline state before dependent successor planning;
- publish executable work only when canonical Task Readiness is satisfied.

When acting as Executor:
- load the exact governing validated task revision;
- load its execution baseline and referenced authority/data inputs;
- inspect only research context materially relevant to the task;
- execute within the task's bounded authority and record provenance;
- report observed verification evidence, deviations, and the correct terminal state.

## Methodology and specialist capability boundaries

External scientific methodologies (such as `K-Dense-AI/science-superpowers`) and specialist capabilities (such as `K-Dense-AI/scientific-agent-skills`) are execution aids.

Runtime methodology remains subordinate to:
1. applicable direct human and approved study authority;
2. `.agents/research-governance.md`;
3. `.agents/AGENTS.md`;
4. the exact governing validated task when executing;
5. applicable approval, permission, privacy, and side-effect boundaries.
