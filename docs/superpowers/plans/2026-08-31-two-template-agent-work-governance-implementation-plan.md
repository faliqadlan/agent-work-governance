# Two-Template Agent Work Governance Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the transitional universal/profile product with two independently adoptable `.agents` packages while preserving accepted Software governance and validating shared invariants.

**Architecture:** Build two complete package roots, `templates/software/.agents/` and `templates/scientific/.agents/`. Each package owns its entry contract, normative workflow, context, Planner/Reviewer procedure, task/research-contract template, manifest, checker, and thin runtime adapters. The root `.agents/` is transition-only and is removed as a product package after its governing task is preserved in history and final validation no longer depends on it.

**Tech Stack:** Markdown, JSON, dependency-free PowerShell scripts executed with the current supported PowerShell host (e.g., `pwsh` or current PowerShell session), and Git. No Pester installation or test-framework migration is introduced.

**Spec:** `docs/superpowers/specs/2026-08-31-two-template-agent-work-governance-design.md`

## Global Constraints

- Governing task: `8d88cc7de580e3d1f320cd7670f96fa5712a0877`.
- Accepted Software baseline: `7c4f648207bd6f65f4afdf917547635feef2c56d`.
- Superseded WIP: `43e53bde5774ce5d4e3fbf4a447c3ae2f2b3e183`.
- Keep one selected package per target repository: copy one nested `.agents` directory to `<target>/.agents/`.
- No runtime profile selector, composition mechanism, mandatory physical shared core, installer, dependency, or vendored external skill.
- Preserve `Planner-Reviewer Contract.md` as one portable root contract.
- Do not mutate `main`, rewrite history, force-push, rename the repository, create a PR, merge, release, deploy, publish, write issues, or install unrelated dependencies.

### Task 1: Convert validation to direct PowerShell and define concrete red fixtures

**Files:** Modify `tests/check-agents-consistency.Tests.ps1`; create `tests/check-two-template-governance.ps1`.

**Interfaces:** Existing regression script remains directly executable. The new script returns exit code 0 only when both package roots and all shared invariants pass. Host invocation uses the current PowerShell host (e.g. `& ./<script>.ps1` in a PowerShell session, or `<supported-pwsh-host> -NoProfile -File <script>.ps1` when invoked externally without assuming `powershell.exe`).

- [ ] Replace the stale fixture with helper `Get-ExactReadmeVersion`: read `README.md`, match ``| `prompts/plan-create-task.md` | <version> |`` exactly once, and throw if the match count is not one.
- [ ] Derive an invalid value from the found source (for example `"$sourceVersion-invalid"`), replace the exact full row once, assert replacement count is one, run the checker, and assert exit code 1 plus the diagnostic beginning `README version for 'prompts/plan-create-task.md'`.
- [ ] Add direct checks for Software paths: `AGENTS.md`, `software-workflow.md`, `context/project.md`, `prompts/plan-create-task.md`, `tasks/_template.md`, `manifest.json`, `check-consistency.ps1`, and all six Codex/Claude/Antigravity adapter files. Throw a named diagnostic per missing path.
- [ ] Add `Copy-And-Check`: copy one package to a GUID temporary directory as `.agents`, invoke the copied checker with no source-repository arguments, capture output and `$LASTEXITCODE`, and delete only that directory in `finally`.
- [ ] Add equivalent Scientific required-path and standalone checks; fail on `templates/software`, `templates/scientific`, `../`, `profile_selection`, or `profiles/` references inside either package.
- [ ] Define shared marker names: `authority-vs-evidence`, `external-imperative-not-authority`, `planner-reviewer-executor`, `bounded-contract`, `governing-revision`, `implementation-or-execution-baseline`, `remediation-vs-replanning`, `evidence-before-acceptance`, `acceptance-not-consequential-authorization`, and `progressive-context-runtime-neutrality`. Compare marker presence, not full text.
- [ ] Add a forbidden-content check for copied Superpowers, Science Superpowers, or Scientific Agent Skills files and mandatory root-core paths.
- [ ] Run `& ./tests/check-two-template-governance.ps1`; observe missing-package diagnostics and exit code 1. Run `& ./tests/check-agents-consistency.Tests.ps1`; observe the existing suite executes without Pester.
- [ ] Stage exactly the two test files and commit `test: define direct two-template governance validation`.

### Task 2: Materialize Software from the accepted baseline

**Destination:** `templates/software/.agents/`.

**Source-to-destination mapping and provenance:**

Start from exact accepted artifacts at `7c4f648207bd6f65f4afdf917547635feef2c56d`. Distinguish accepted baseline identities and versions from unaccepted, optional WIP improvements from `43e53bde5774ce5d4e3fbf4a447c3ae2f2b3e183`. Do not inherit WIP versions merely because they exist on the branch; assign new versions only if substantive changes are made under repository versioning conventions.

| Accepted source (`7c4f648...`) | Accepted ID / Version | Software destination | Optional reusable WIP improvement (`43e53bde...`) | Implementation treatment & versioning |
|---|---|---|---|---|
| `.agents/AGENTS.md` | `AGENTS-CONTRACT-001` v1.3 | `templates/software/.agents/AGENTS.md` | Imperative-as-evidence wording; methodology/capability boundary clarification. (Reject root core / profile selector). | Relocate with package-local paths; preserve `AGENTS-CONTRACT-001`. Evaluate WIP wording improvements independently; bump to `1.4` only if substantive changes are adopted. |
| `.agents/software-workflow.md` | `SD-PROTOCOL-001` v2.3 | `templates/software/.agents/software-workflow.md` | None (WIP preserved v2.3). | Relocate with package-local link updates; preserve `SD-PROTOCOL-001` version `2.3` and full B0–G10 lifecycle semantics. |
| `.agents/context/project.md` | `AGENT-CONTEXT-001` v1.1 | `templates/software/.agents/context/project.md` | Minor context-guidance phrasing. (Reject profile selector references). | Relocate with package-local paths; preserve `AGENT-CONTEXT-001`. Evaluate WIP improvements; bump to `1.2` only if substantive changes are made, otherwise retain `1.1`. |
| `.agents/prompts/plan-create-task.md` | `AGENT-PROMPT-PLAN-001` v2.4 | `templates/software/.agents/prompts/plan-create-task.md` | Orchestration checklist clarity. (Reject core/profile loading). | Relocate with package-local references; preserve `AGENT-PROMPT-PLAN-001`. Evaluate WIP improvements; bump to `2.5` only if substantive changes are made, otherwise retain `2.4`. |
| `.agents/tasks/_template.md` | `AGENT-TASK-001` v1.2 | `templates/software/.agents/tasks/_template.md` | Minor contract phrasing. (Reject domain-neutral generalization). | Relocate with package-local references; preserve `AGENT-TASK-001`. Evaluate WIP improvements; bump to `1.3` only if substantive changes are made, otherwise retain `1.2`. |
| `.agents/manifest.json` | Manifest schema v3 (software baseline inventory) | `templates/software/.agents/manifest.json` | Invariant markers array, structured checks. (Reject universal profile inventory). | Create Software-only inventory reflecting exact Software package artifacts and continuous versions; define shared invariant marker names. |
| `.agents/check-consistency.ps1` | Baseline consistency checker | `templates/software/.agents/check-consistency.ps1` | Enhanced adapter, mirror, and invariant checks adapted for standalone execution. | Relocate; execute standalone relative to `$PSScriptRoot`; preserve version/link/adapter/materialization checks without source-tree coupling. |
| `.agents/runtime-adapters/codex/{AGENTS.md,README.md}` | Codex adapter v1.2 (`AGENT-RUNTIME-CODEX-001` v1.2, `AGENT-RUNTIME-CODEX-README-001` v1.2) | `templates/software/.agents/runtime-adapters/codex/{AGENTS.md,README.md}` | Methodology subordination clarity. (Reject profile selector references). | Relocate below Software destination; preserve document IDs; bump to `1.3` only if substantive changes are made; preserve source/materialization distinctions and package-local links. |
| `.agents/runtime-adapters/claude/{CLAUDE.md,README.md}` | Claude adapter v1.2 (`AGENT-RUNTIME-CLAUDE-README-001` v1.2, CLAUDE.md v1.2) | `templates/software/.agents/runtime-adapters/claude/{CLAUDE.md,README.md}` | Methodology subordination clarity. (Reject profile selector references). | Relocate below Software destination; preserve document IDs; bump to `1.3` only if substantive changes are made; preserve `@` materialization rewrite. |
| `.agents/runtime-adapters/antigravity/{README.md,rules/antigravity-code-agent-workflow.md}` | Antigravity adapter v1.2 (`AGENT-RUNTIME-ANTIGRAVITY-README-001` v1.2, rule v1.2) | `templates/software/.agents/runtime-adapters/antigravity/{README.md,rules/antigravity-code-agent-workflow.md}` | Methodology subordination clarity. (Reject profile selector references). | Relocate below Software destination; preserve document IDs; bump to `1.3` only if substantive changes are made; preserve source filename versus materialized `code-agent-workflow.md`. |
| `.agents/tasks/audit-improve-agents-framework.md` | Historic task artifact | Transition-only (root `.agents/tasks/`) | N/A | Retain in repository root during transition if needed; do not copy into adopted Software package. |
| Existing regression semantics | `tests/check-agents-consistency.Tests.ps1` | Repository-level `tests/` | Stale-fixture refactoring | Preserve existing behavior in repository-level tests; do not copy tests into adopted package. |

- [ ] Create the destination tree and use `git show 7c4f648...:<path>` as content reference. Do not copy `core-governance.md` or the Scientific profile.
- [ ] Edit links and adapter materialization text to resolve from an adopted package root. Preserve Business/Product/Requirements/Architecture, E6/V7/R8/A9, review, baseline, integration, release, provenance, and side-effect semantics.
- [ ] Re-evaluate WIP wording changes from `43e53bde...` independently; apply only compatible improvements and set versions/dates strictly based on substantive changes according to repository conventions.
- [ ] Define manifest canonical artifacts, continuous IDs/versions, adapter mappings, and the shared marker names from Task 1.
- [ ] Implement the checker with stable diagnostics for missing artifacts, duplicate IDs, version/mirror drift, broken paths, stale Antigravity source depiction, selectors, source-tree dependencies, and vendored external methodology.
- [ ] Run `& ./templates/software/.agents/check-consistency.ps1`; expect exit code 0. Run `& ./tests/check-two-template-governance.ps1`; expect only Scientific/root-migration failures.
- [ ] Stage exactly `templates/software/.agents`; commit `feat: add standalone software governance template`.

### Task 3: Create the Scientific package with explicit canonical artifacts

**Destination:** `templates/scientific/.agents/`.

| Destination | Document ID | Responsibility |
|---|---|---|
| `AGENTS.md` | `SCI-AGENTS-CONTRACT-001` | Entry router, authority/evidence boundary, progressive loading, role separation, package-local links. |
| `research-governance.md` | `SCI-RESEARCH-PROTOCOL-001` | Intent, question/hypothesis, mode, plan, provenance, deviations, reproducibility, claims, review, acceptance, dissemination. |
| `context/project.md` | `SCI-CONTEXT-001` | Study/repository context, authority map, evidence map, mode, execution baseline, scoped router. |
| `prompts/plan-create-task.md` | `SCI-PROMPT-PLAN-001` | Planner/Reviewer procedure for bounded research contracts, plan freeze/preregistration, review, remediation, replanning. |
| `tasks/_template.md` | `SCI-TASK-001` | Research-contract template with question, mode, plan, provenance, deviations, claims, evidence, acceptance, dissemination. |
| `manifest.json` | `SCI-MANIFEST-001` | Package-relative inventory, versions, IDs, markers, external references, adapter mappings. |
| `check-consistency.ps1` | `SCI-CHECKER-001` | Direct checks for paths, IDs, versions, links, markers, safeguards, external-only boundaries. |

- [ ] Write `AGENTS.md` to load the workflow, context, contract template, scoped evidence, and external methodology only when relevant; never load a Software profile or root core.
- [ ] Write `research-governance.md` with research intent, stable question/hypothesis identity, confirmatory/exploratory/feasibility classification, frozen/preregistered plan identity when applicable, execution/analysis baseline, raw/derived data and code provenance, deviations, reproducibility, claim-evidence traceability, scientific review, bounded remediation, material replanning, accepted result identity, and separately authorized dissemination/publication.
- [ ] State exactly: exploratory/feasibility output cannot become confirmatory evidence; absent preregistration cannot be claimed; deviations record reason, affected analysis, and interpretation impact.
- [ ] Write context, Planner/Reviewer procedure, and Scientific task template using the IDs above and package-relative links. Separate research-contract revision, execution/analysis baseline, and result identity.
- [ ] Implement manifest/checker with required paths, unique IDs, versions, markers, only the external URLs `K-Dense-AI/science-superpowers` and `K-Dense-AI/scientific-agent-skills`, and diagnostics for missing Scientific safeguards.
- [ ] Adapt `.agents/profiles/scientific-governance.md` into `research-governance.md`; classify the old profile path as superseded, never as a selector.
- [ ] Run `& ./templates/scientific/.agents/check-consistency.ps1`; expect exit code 0. Run `& ./tests/check-two-template-governance.ps1`; expect both standalone package checks to pass before cleanup.
- [ ] Stage exactly `templates/scientific/.agents`; commit `feat: add standalone scientific governance template`.

### Task 4: Sequence root cleanup and update adoption documentation

**Files:** Modify `README.md` and repository tests; remove/neutralize obsolete root product files only after Tasks 2–3 pass.

- [ ] Keep root `.agents/AGENTS.md`, `.agents/tasks/agent-work-governance-generalization.md`, and task/review evidence needed for the active governing task until the final review handoff. Label these repository-internal transition governance, not product templates.
- [ ] Remove/neutralize `.agents/core-governance.md`, `.agents/profiles/README.md`, `.agents/profiles/scientific-governance.md`, and root universal `.agents/manifest.json` profile-selection assumptions after package checkers pass. Neither package may reference them.
- [ ] Remove root `.agents/check-consistency.ps1` only after package checkers and `tests/check-two-template-governance.ps1` replace its product checks. If retained for transition inspection, rename/document it as internal-only and never use it as an adopted-package checker.
- [ ] Rewrite README tables and links to show only `templates/software/.agents/ -> <software-repository>/.agents/` and `templates/scientific/.agents/ -> <scientific-repository>/.agents/`; explain manual/lightweight copying and why GitHub native templates cannot select nested packages.
- [ ] Remove claims that both domains load; retain external URLs only as references; keep `Planner-Reviewer Contract.md` one portable contract.
- [ ] Run `& ./tests/check-two-template-governance.ps1`; if the internal root checker remains, also run `& ./tests/check-agents-consistency.Tests.ps1`; all must exit 0 with no root coupling diagnostics.
- [ ] Review `git diff --cached --name-status`, stage only selected README/tests/root changes, and commit `refactor: migrate governance to standalone templates`.

### Task 5: External review and final verification

**Files:** Modify only concrete defects in package artifacts, tests, or adoption docs.

- [ ] Recheck primary sources for `obra/superpowers`, `K-Dense-AI/science-superpowers`, `K-Dense-AI/scientific-agent-skills`, GitHub template documentation, and GitHub rename documentation. Record URLs and boundaries; add no source content.
- [ ] Run directly: `& ./tests/check-two-template-governance.ps1`, `& ./templates/software/.agents/check-consistency.ps1`, `& ./templates/scientific/.agents/check-consistency.ps1` (or via supported PowerShell host), and `git diff --check`; all must exit 0.
- [ ] Copy each package alone to a fresh temporary target `.agents` directory, run its checker with the source repository unavailable, and remove only that temporary directory.
- [ ] Run `git rev-parse HEAD`, `git branch --show-current`, `git status --short --branch`, `git rev-parse refs/remotes/origin/main`, `git merge-base --is-ancestor 43e53bde5774ce5d4e3fbf4a447c3ae2f2b3e183 HEAD`, and `git diff --name-status 7c4f648207bd6f65f4afdf917547635feef2c56d HEAD`. Confirm task branch, reachable WIP, unchanged `main`, and no unauthorized side effect.
- [ ] Report exact outputs, changed files, mappings, root disposition, marker strategy, external-reference strategy, version/date decisions, stale-fixture correction, final/pushed SHAs, limitations, and runtime-testing scope. End with `CORRECTED TWO-TEMPLATE AGENT WORK GOVERNANCE IMPLEMENTATION READY FOR PLANNER/REVIEWER REVIEW`; do not declare acceptance or a new baseline.
