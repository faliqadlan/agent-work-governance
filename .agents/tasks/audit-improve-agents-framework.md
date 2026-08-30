---
title: Audit and Improve the Repository Agents Framework
document_id: AGENT-TASK-AUDIT-001
version: 1.0
status: draft
language: en-US
last_updated: 2026-08-30
scope:
  - .agents framework integrity
  - directly related published package documentation
  - bounded consistency and regression verification
authority_note: This Draft is a candidate delivery contract awaiting Planner/Reviewer inspection. It does not authorize implementation until it is approved and published as Validated/Published with an immutable governing revision.
---

# Executable Task

## Task identity

**Task title:**  Audit and Improve the Repository Agents Framework

**Task path:**  `.agents/tasks/audit-improve-agents-framework.md`

**Task contract state:**  `Draft`

**Delivery objective / Work Package / MVP:**  `.agents framework integrity and verifiability`

**Owner / designated planning authority:**  `Planner/Reviewer under .agents/prompts/plan-create-task.md; designated repository authority for any unresolved context or governance decision`

## Delivery context

Audit and improve the internal correctness, consistency, maintainability, runtime accuracy, and verifiability of the reusable `.agents` delivery framework and directly related root package documentation. The outcome must preserve the runtime-neutral architecture, Planner/Executor/Reviewer boundaries, validated-task execution model, authority/evidence separation, side-effect boundaries, progressive context loading, bounded Executor discretion, and unrelated repository behavior.

The task exists because the audited baseline contains confirmed metadata and path drift and no dedicated consistency mechanism was observed to catch those classes of errors. Normal Executor discovery may identify additional affected `.agents` files or directly related README references within this same integrity objective without requiring a new top-level task.

## Baseline and task revision

**Implementation baseline:**  `b5c82736701e009bc2e90f30d13a88f28bbcbed5` (`main` audited baseline; execution must verify the actual applicable baseline before implementation)

**Task revision:**  `resolved when published`

This task remains Draft. It MUST NOT be treated as Validated/Published or executed until Planner/Reviewer establishes the exact immutable governing revision containing the approved task.

## Objective

**Objective:**  Produce one coherent, reviewable integrity improvement to the repository-local `.agents` package and the minimum directly related root README material, correcting verified drift, clarifying source-versus-materialized runtime semantics and reusable-template context semantics, and adding proportionate reproducible checks for path/version/reference consistency without redesigning the delivery framework.

## Authoritative inputs

### Governing authority

- `.agents/AGENTS.md` — approved repository AI delivery contract and runtime-neutral boundaries.
- `.agents/software-workflow.md` — approved normative delivery protocol, task, review, baseline, and release semantics.
- `.agents/prompts/plan-create-task.md` — approved Planner/Reviewer procedure for task readiness, publication, review, and escalation.
- `.agents/tasks/_template.md` — approved structure and constraints for executable delivery contracts.
- `.agents/manifest.json`, `.agents/context/project.md`, runtime-adapter sources/READMEs, and `README.md` — observed repository evidence and descriptive package material to reconcile, not authority over the canonical contract.

### Requirement traceability

- `AFI-01` → `.agents/AGENTS.md` runtime neutrality, authority/evidence separation, runtime-adapter thinness, reuse, and preservation rules.
- `AFI-02` → `.agents/software-workflow.md` validated-task, exact-revision, verification, stop-condition, and acceptance-versus-release requirements.
- `AFI-03` → `.agents/prompts/plan-create-task.md` planning/review procedure and task-readiness expectations.
- `AFI-04` → confirmed baseline evidence recorded below and any additional directly verified evidence discovered during execution.

External runtime documentation is supporting evidence only. Where material runtime claims are changed or retained, consult current primary documentation, including the official OpenAI Codex repository-instruction documentation/source, official Google Antigravity workspace-rule documentation, and official Anthropic Claude Code memory/import documentation as relevant. Examples available at execution time include:

- https://github.com/openai/codex/blob/main/docs/agents_md.md
- https://github.com/openai/codex/blob/main/codex-rs/core/src/agents_md.rs
- https://codelabs.developers.google.com/getting-started-agy-ide
- https://docs.anthropic.com/en/docs/claude-code/memory

## Problem and confirmed evidence

The audited baseline at `b5c82736701e009bc2e90f30d13a88f28bbcbed5` contains these verified integrity findings:

1. `.agents/prompts/plan-create-task.md` declares version `2.3`, while `.agents/manifest.json` records it as `2.2`.
2. Root `README.md` also reports `prompts/plan-create-task.md` as version `2.2`.
3. `.agents/manifest.json` identifies the Antigravity source as `.agents/runtime-adapters/antigravity/rules/code-agent-workflow.md`, but the retained audited source is `.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md`.
4. Root `README.md` and `.agents/runtime-adapters/antigravity/README.md` contain source-path descriptions using the nonexistent `code-agent-workflow.md` form.
5. The retained Antigravity source intentionally describes its materialized runtime target as `.agents/rules/code-agent-workflow.md`. Retained adapter source identity and materialized runtime target identity are different concepts and must not be conflated.
6. `.agents/context/project.md` is an approved generic template containing placeholders, although the Planner/Reviewer loading rules identify it as the repository-level context entrypoint. Because this repository is itself a reusable template, execution must determine whether this is intentional packaging, documentation ambiguity, or a genuine self-hosting/context defect. A structural or authority decision must not be silently invented.
7. No dedicated repository consistency validation mechanism was observed that would automatically catch the confirmed version/path drift.

## Scope

### In scope

- Audit all relevant `.agents` metadata, canonical documentation, task/prompt/template references, runtime-adapter source and README references, and directly related root README content.
- Correct factual version, path, link, structural-example, and source-versus-materialized-target inconsistencies supported by verified evidence.
- Make the Antigravity retained source path and materialized target path explicit wherever both concepts are discussed.
- Clarify the role of the reusable `context/project.md` template and explicitly resolve or escalate any actual ambiguity affecting self-hosting or Planner/Reviewer loading.
- Add or adapt a lightweight, reproducible consistency/regression check that detects the confirmed classes of version, path, link, and reference drift while allowing intentional approved template placeholders.
- Update directly related documentation and verification artifacts required to keep the published `.agents` package internally consistent and runtime claims current.
- Preserve thin runtime adapters, canonical runtime-neutral governance, progressive loading, bounded Executor discretion, and existing delivery lifecycle semantics.

### Out of scope

- Redesigning the delivery lifecycle for stylistic preference.
- Removing or weakening the validated-task requirement, review gates, baseline identity, authority/evidence separation, or acceptance-versus-release separation.
- Making canonical governance depend on Codex, Claude, Antigravity, a particular IDE, vendor terminology, or a model.
- Materializing adapters into root or runtime-native locations merely because retained adapter sources exist.
- Unrelated repository content, speculative frameworks/infrastructure, deployment, release, or remote Git operations.
- Changes to `main`, destructive Git operations, pushes, pull requests, merges, issue writes, or external-system mutation.

### Preserved behavior

- `.agents/AGENTS.md` and `.agents/software-workflow.md` remain the canonical governance and normative protocol.
- Planner, Executor, and Reviewer remain logical responsibilities with their existing boundaries.
- Implementation-changing work still requires an exact published validated task revision.
- Authority remains distinct from observed implementation evidence; runtime adapters remain supporting integration material.
- Progressive context loading, repository reuse discipline, side-effect/approval boundaries, security/privacy boundaries, and release separation remain intact.
- The repository remains a reusable template; approved placeholders are not falsely reported as instantiated repository facts.
- Unrelated files and behavior remain unchanged unless verified evidence demonstrates a necessary integrity correction within this objective.

## Dependencies and assumptions

### Dependencies

- The execution baseline and exact governing task revision must be known before implementation.
- Current primary runtime documentation must be available when material runtime claims are evaluated.
- Any validation mechanism must run in the repository's available local tooling without requiring speculative infrastructure or unrelated dependency replacement.

### Approved assumptions

- The audited starting revision is `b5c82736701e009bc2e90f30d13a88f28bbcbed5`; any material drift must be reported and returned to Planner/Reviewer.
- Additional affected files discovered under `.agents` or directly related package README references remain in scope when they serve the same integrity objective.
- The exact validation technique is left to the Executor within repository conventions and this contract.

### Remaining approval requirements

- Planner/Reviewer must inspect and publish this Draft before execution.
- Any decision to instantiate `context/project.md` for this template repository, redesign canonical governance, change lifecycle semantics, or materially expand scope requires the applicable authority decision and Planner/Reviewer republishing.
- No release, deployment, remote publication, or other external side effect is authorized by this task.

## Required capabilities

- Repository read/write and local Git inspection.
- Local command execution sufficient to run the selected consistency checks.
- Browser or equivalent access to current primary runtime documentation when runtime behavior materially affects a change.

## Execution constraints

### Constraints

- Work only from a verified non-main branch and do not modify `main`.
- Prefer the smallest sufficient edits and established repository mechanisms.
- Do not treat the manifest, README, prompt, context, or runtime documentation as authority that silently overrides `.agents/AGENTS.md` or `.agents/software-workflow.md`.
- Do not normalize intentionally different retained-source and materialized-target identities into one path.
- Validation must be deterministic/reproducible and must not falsely fail on approved reusable-template placeholders.
- Runtime-specific claims must remain limited to behavior supported by current primary documentation; vendor terminology must not leak into canonical runtime-neutral semantics.

## Acceptance criteria

- [ ] Canonical and descriptive version metadata agree with the actual governed artifacts wherever mirroring is intended, including the prompt version currently declared as `2.3`.
- [ ] Every manifest source path refers to the intended existing retained source, including the actual Antigravity source `.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md`.
- [ ] Antigravity retained source identity is explicitly distinguished from materialized target identity `.agents/rules/code-agent-workflow.md` in relevant manifest, README, and source descriptions.
- [ ] Relevant README links, path references, and structural examples resolve to intended repository files and no longer materially contradict the manifest or retained sources.
- [ ] Material runtime-adapter claims are consistent with current primary Codex, Antigravity, and Claude Code documentation where those claims are in scope, while canonical governance remains runtime-neutral.
- [ ] Duplicated metadata and references no longer materially contradict one another.
- [ ] The reusable `context/project.md` template is accurately described as a template/entrypoint, and any actual repository-context ambiguity is explicitly resolved or escalated rather than hidden.
- [ ] A proportionate reproducible check detects the confirmed path/version/reference drift classes and reports actionable failures.
- [ ] The check does not falsely fail merely because an approved reusable template intentionally contains placeholders.
- [ ] Verification demonstrates preservation of unrelated repository content and the existing delivery-governance boundaries.

## Verification requirements

### Required checks

- Inspect the complete changed-file set and compare it with the task scope.
- Verify every manifest-listed path exists and every corrected README/reference path resolves to the intended file.
- Verify version metadata against the governed artifact front matter or other established source of truth.
- Run the added or selected consistency/regression check from a clean or precisely identified repository state.
- Review relevant runtime-adapter source/README claims against current primary runtime documentation and report any limitation where live runtime behavior cannot be exercised.
- Run any existing repository checks that materially cover the changed artifacts; do not invent CI evidence.
- Verify no changes occurred on `main`, no unrelated files were altered, and no root/runtime-native materialization was introduced.

### Required evidence

The Executor MUST report:

- exact execution-start baseline and whether it matched this task's declared baseline;
- resulting revision or exact reviewable working-tree state;
- complete changed-file set;
- manifest/path/reference checks and observed results;
- metadata/version consistency checks and observed results;
- relevant documentation and runtime-adapter validation, including primary sources consulted;
- automated consistency/regression checks added or run and their actual output/result;
- tests/checks actually run, known limitations, deviations, blockers, and evidence that unrelated behavior/content was preserved.

## Stop conditions

In addition to the standard task stop conditions, stop and return to Planner/Reviewer if:

- deciding the intended role of `context/project.md` requires choosing between reusable-template packaging and instantiated active context without an existing authority decision;
- a proposed correction would change canonical lifecycle, authority, evidence, task, review, baseline, security, privacy, approval, or release semantics;
- current runtime behavior is incompatible with the existing architecture in a way that requires more than a bounded adapter/documentation correction;
- acceptance cannot be met without weakening an existing boundary or adding materially expanded scope;
- material baseline drift, a new side-effect boundary, or an external publication/deployment need is discovered.

Ordinary discovery of additional affected `.agents` files, references, tests, or directly related documentation within this integrity objective is not itself a stop condition or reason for a new top-level task.

## Side-effect authorization

### Explicitly authorized side effects

- Modify files within the bounded scope of this task on a non-main local branch.
- Run non-destructive local checks and tests.

Git commits, pushes, pull requests, merges, deployment, release, destructive operations, dependency installation/replacement, issue writes, external-system mutation, and runtime-native materialization are not authorized unless separately approved by applicable authority.

## Expected terminal outcome

### Review Required

Use when the bounded integrity changes are reviewable and the required evidence is available. Report the exact task revision, implementation baseline, resulting implementation state/revision, complete changed-file set, checks/results, runtime documentation evidence, limitations, and deviations.

### Planning Required

Use when a stop condition prevents safe completion. Report the specific authority, architecture, scope, runtime-compatibility, baseline, dependency, or approval issue and the repository evidence supporting escalation.

The Executor does not self-declare final acceptance.
