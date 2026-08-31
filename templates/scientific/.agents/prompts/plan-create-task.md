---
title: Plan, Review, and Create Validated Research Task
document_id: SCI-PROMPT-PLAN-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-31
role:
  - Planner
  - Reviewer
scope:
  - research state assessment
  - scientific evidence review
  - plan freeze and preregistration verification
  - research objective selection
  - validated research task creation
authority_note: This prompt is a reusable Planner/Reviewer orchestration procedure. It is not repository authority and MUST NOT override .agents/AGENTS.md, .agents/research-governance.md, approved study authority, the governing task revision, or observed scientific evidence.
---

# Plan, Review, and Create Validated Research Task

Use this canonical procedure to assess study readiness, review completed computational analysis or experiments, evaluate reproducibility evidence, perform bounded remediation, or publish the next validated research task.

## 1. Role loading

Before material Planner/Reviewer work, load:

1. `.agents/AGENTS.md`;
2. `.agents/research-governance.md`;
3. `.agents/context/project.md`;
4. only the scoped context materially relevant to the current investigation;
5. applicable study protocol, hypothesis definitions, and authority artifacts;
6. active or recently completed research task files and their exact governing revisions;
7. current experimental evidence, data provenance, run logs, and repository state;
8. available reproducibility evidence and verification outputs.

Do not load unnecessary scoped context files.

## 2. Evidence review and acceptance check

If an execution attempt has completed under a governing research task:

1. **Verify mode integrity:** Ensure exploratory analysis is not presented as confirmatory testing.
2. **Verify protocol conformance:** Check adherence to the frozen plan; verify all deviations document reason, affected analysis, and interpretation impact.
3. **Verify reproducibility:** Confirm pipeline executed successfully from baseline with specified random seeds and environment parameters.
4. **Determine outcome:**
   - **Acceptance:** Observed evidence fully satisfies task criteria; record accepted result identity (commit SHA, artifact hashes).
   - **Bounded Remediation (Same Task):** Update the same task for minor code fixes, re-runs, or missing documentation.
   - **Replanning (New Contract):** Material change in hypothesis, protocol, or data requires stopping and publishing a new validated task.

## 3. Research readiness assessment

Before creating a new task, confirm:
- [ ] Research question or hypothesis is explicitly stated and approved.
- [ ] Research mode (confirmatory, exploratory, feasibility) is explicitly classified.
- [ ] For confirmatory work, the analysis plan is frozen at an immutable revision.
- [ ] Execution baseline and input data provenance are identified.
- [ ] Scope, acceptance criteria, and reproducibility requirements are bounded.
- [ ] Dissemination/publication remains separate from technical acceptance.

## 4. Publish validated research task

When readiness is satisfied, author the task file under `.agents/tasks/` using `.agents/tasks/_template.md`.

Set contract state to `Validated/Published` only when the immutable governing revision is resolvable.
