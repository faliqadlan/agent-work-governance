# Two-Template Agent Work Governance Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace the transitional universal/profile-based product with two independently adoptable, self-contained Software and Scientific `.agents` packages while preserving accepted Software governance and validating shared invariants.

**Architecture:** `templates/software/.agents/` and `templates/scientific/.agents/` are separate product roots. Each owns its governance documents, inventory, checker, prompts/tasks/context, and thin runtime adapters. Root files remain documentation or transition-only mechanics. Deterministic PowerShell tests validate each package independently and compare explicit shared-invariant markers.

**Tech Stack:** Markdown governance artifacts, JSON manifests, PowerShell consistency checkers, Pester-style PowerShell regression tests, Git.

**Spec:** `docs/superpowers/specs/2026-08-31-two-template-agent-work-governance-design.md`

## Global Constraints

- Preserve governing task revision `8d88cc7de580e3d1f320cd7670f96fa5712a0877`.
- Preserve accepted Software behavior from `7c4f648207bd6f65f4afdf917547635feef2c56d`.
- Treat WIP `43e53bde5774ce5d4e3fbf4a447c3ae2f2b3e183` as evidence, not an acceptance baseline.
- Keep each nested package adoptable as one target `.agents/` directory with no source-path dependency.
- Do not retain a universal distributable `.agents`, runtime profile selector, composition mechanism, or mandatory physical shared core.
- Do not copy/vendor `obra/superpowers`, `K-Dense-AI/science-superpowers`, or `K-Dense-AI/scientific-agent-skills`.
- Do not modify `main`, rewrite history, force-push, rename the repository, create a PR, merge, release, publish, or write issues.
- Keep one portable root `Planner-Reviewer Contract.md`.
- Use truthful identities, versions, and `last_updated` dates.

### Task 1: Establish the validation contract

**Files:** Create `tests/two-template-governance.Tests.ps1`; modify `tests/check-agents-consistency.Tests.ps1`.

**Interfaces:** The tests consume the current repository layout and produce deterministic checks for both nested package roots, package-local checkers/manifests, standalone copies, invariant drift, forbidden profile/core architecture, and version drift.

- [ ] Write failing tests asserting each package has `AGENTS.md`, a manifest, checker, governance entry, context, prompts/tasks, and runtime adapters.
- [ ] Write failing standalone-copy tests that copy each package to a temporary `.agents` directory and run its checker there without the source `templates` tree.
- [ ] Replace the stale hard-coded README version fixture with a test that reads the current declared version, changes it to `0.0.0-invalid` in a temporary copy, and asserts checker failure.
- [ ] Add assertions rejecting source-relative `templates/...` references, profile selectors, mandatory shared-core dependencies, and copied external methodology/skill content.
- [ ] Run `Invoke-Pester -Path tests/two-template-governance.Tests.ps1 -Output Detailed`; confirm failures are missing-architecture failures, not syntax errors.
- [ ] Commit with `git add tests; git commit -m "test: define two-template governance validation"`.

### Task 2: Materialize the standalone Software package

**Files:** Create `templates/software/.agents/` with `AGENTS.md`, `manifest.json`, `check-consistency.ps1`, `software-workflow.md`, `context/project.md`, `prompts/plan-create-task.md`, `tasks/_template.md`, applicable package-local task material, and Codex/Claude/Antigravity adapters.

**Interfaces:** Consume accepted Software artifacts from baseline `7c4f648...`; produce a checker-valid package usable from its own root or after copying to a target `.agents` directory.

- [ ] Copy/adapt accepted Software behavior, preserving authority versus evidence, B0–G10 readiness/lifecycle semantics, bounded task identity, governing-task versus implementation-baseline identity, same-task remediation versus replanning, review/accepted-baseline semantics, release separation, provenance, side-effect authorization, progressive context, runtime neutrality, and adapter materialization rules.
- [ ] Make every link and manifest path package-relative; do not reference root `.agents`, `templates/...`, Scientific files, or a universal profile.
- [ ] Make `manifest.json` enumerate package-relative artifacts, versions, identities, and adapter mappings. Make `check-consistency.ps1` resolve from `$PSScriptRoot` and reject missing paths, duplicate identities, version drift, broken links, source-tree references, selectors, and vendored external content.
- [ ] Run `& templates/software/.agents/check-consistency.ps1` and the focused Pester tests; verify Software passes before committing.
- [ ] Commit with `git add templates/software/.agents; git commit -m "feat: add standalone software governance template"`.

### Task 3: Materialize the standalone Scientific package

**Files:** Create `templates/scientific/.agents/` with `AGENTS.md`, `manifest.json`, `check-consistency.ps1`, `research-governance.md`, `context/project.md`, `prompts/plan-create-task.md`, `tasks/_template.md`, and thin Codex/Claude/Antigravity adapters.

**Interfaces:** Consume Scientific requirements from the approved spec and current profile as evidence; produce a package with distinct identities and no Software/core dependency.

- [ ] Write scientific governance covering research intent; question/hypothesis identity; authority versus observed evidence; confirmatory/exploratory/feasibility classification; frozen/preregistered plans; execution/analysis baseline; provenance; deviations; reproducibility; claim-evidence traceability; scientific review; bounded remediation/replanning; accepted result identity; and separately authorized dissemination/publication.
- [ ] State that exploratory work cannot become preregistered confirmatory evidence silently, absent preregistration cannot be claimed, and deviations require interpretation-impact recording.
- [ ] Use distinct Scientific document IDs and package-relative links. Reference `K-Dense-AI/science-superpowers` and `K-Dense-AI/scientific-agent-skills` only as external sources; do not copy or require them.
- [ ] Implement the package-local manifest/checker using the same deterministic checks as Software, with Scientific-specific required artifacts and invariant markers.
- [ ] Run `& templates/scientific/.agents/check-consistency.ps1` and the focused Pester tests; verify standalone-copy success before committing.
- [ ] Commit with `git add templates/scientific/.agents; git commit -m "feat: add standalone scientific governance template"`.

### Task 4: Migrate documentation and remove obsolete product coupling

**Files:** Modify `README.md` and repository-level tests; remove or relocate only transitional product files whose sole purpose is universal/profile logic; preserve governing task mechanics until verification is complete.

**Interfaces:** Consume both package-local products; produce adoption documentation and repository checks that describe exactly one selected package per target.

- [ ] Rewrite README to show `templates/software/.agents/ -> <software-repository>/.agents/` and `templates/scientific/.agents/ -> <scientific-repository>/.agents/`, explain manual/lightweight scripted copying, and remove claims that both domains are loaded.
- [ ] Remove root references requiring `.agents/core-governance.md`, `.agents/profiles/`, or a universal selector. Keep `Planner-Reviewer Contract.md` portable and unchanged except for concrete scientific-compatibility fixes.
- [ ] Classify every WIP change as reusable, Software-relocated, Scientific-adapted, repository tooling, or superseded root profile/core logic; record the disposition in the final handoff.
- [ ] Run `& .agents/check-consistency.ps1`, `Invoke-Pester -Path tests -Output Detailed`, and `git diff --check`; fix failures without reintroducing shared product coupling.
- [ ] Commit with `git add -A; git commit -m "refactor: migrate governance to standalone templates"` after reviewing the staged file list.

### Task 5: Complete external review and verification

**Files:** Modify package artifacts only for concrete verification defects; add no unrelated functionality.

**Interfaces:** Consume the migrated repository; produce evidence for Planner/Reviewer review, not self-acceptance.

- [ ] Recheck current primary sources for `obra/superpowers`, `K-Dense-AI/science-superpowers`, `K-Dense-AI/scientific-agent-skills`, GitHub template documentation, and GitHub rename documentation where materially relied upon. Record links and boundaries; copy nothing.
- [ ] Run `& .agents/check-consistency.ps1`, `& templates/software/.agents/check-consistency.ps1`, `& templates/scientific/.agents/check-consistency.ps1`, `Invoke-Pester -Path tests -Output Detailed`, and `git diff --check`; all must exit zero.
- [ ] Verify each package in a fresh temporary target `.agents` directory with the source repository absent; remove only those temporary directories.
- [ ] Verify `git rev-parse HEAD`, branch name, clean status, `git rev-parse refs/remotes/origin/main`, published WIP reachability, no repository rename, and no unauthorized side effect.
- [ ] Report exact command outputs, changed files, architecture, Software preservation mapping, Scientific mapping, WIP disposition, invariant strategy, external-reference strategy, version/date decisions, final/pushed SHAs, limitations, and runtime-testing scope. Stop with `CORRECTED TWO-TEMPLATE AGENT WORK GOVERNANCE IMPLEMENTATION READY FOR PLANNER/REVIEWER REVIEW` without declaring acceptance or a new baseline.
