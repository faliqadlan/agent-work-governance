# Two-Template Agent Work Governance Design

**Status:** Approved design; implementation planning authorized
**Date:** 2026-08-31  
**Repository:** `faliqadlan/code-agent-template`  
**Execution branch:** `task/agent-work-governance-generalization`

## Goal

Distribute two independently adoptable Agent Work Governance packages: a Software package and a Scientific package. A target repository copies exactly one package into its own `.agents/` directory; neither package depends on the source repository's `templates/` path or on a runtime profile selector.

## Constraints and authority

The governing task revision is `8d88cc7de580e3d1f320cd7670f96fa5712a0877`. The accepted Software behavior baseline is `7c4f648207bd6f65f4afdf917547635feef2c56d`; the superseded WIP `43e53bde5774ce5d4e3fbf4a447c3ae2f2b3e183` is evidence and reusable work, not an acceptance baseline. The corrected architecture is represented by `269b0c1171d8b028d9f0e42ea0f11fbefd2c8fa3`.

This design specification is supporting implementation-design evidence subordinate to governing task revision `8d88cc7de580e3d1f320cd7670f96fa5712a0877`. If this specification conflicts materially with the governing task, implementation planning must stop and reconcile the conflict rather than silently following the specification.

The implementation must preserve published history, avoid force-pushes and history rewrites, leave `main` unchanged, and make no release, publication, issue, PR, merge, or repository-rename change.

## Architecture

The source repository will contain:

```text
templates/software/.agents/
templates/scientific/.agents/
Planner-Reviewer Contract.md
tests/                         # repository-level validation
```

The root `.agents/` used during transition may remain only as long as needed to keep the governing task and local review mechanics inspectable. It must not be a required product source, must not contain a universal Software/Scientific profile architecture, and must not be referenced by either adopted package.

Each nested package is a complete unit with its own governance documents, task/prompt material, manifest or inventory, consistency checker where applicable, and thin runtime adapters. Shared invariant wording may be duplicated. No generator, installer, package manager, mandatory shared core, or local external-skills installation is introduced.

## Software package

`templates/software/.agents/` is materially equivalent to the accepted Software baseline. It preserves repository authority versus observed implementation evidence; Business/Product/Requirements/Architecture readiness; bounded validated tasks; governing-task and implementation-baseline identities; same-task continuation/remediation versus replanning; E6/V7/R8/A9 lifecycle semantics; implementation review and accepted baseline; release/integration separation; provenance; side-effect authorization; progressive context; runtime neutrality; adapter source/materialization distinctions; and consistency/regression protections.

Useful Software terminology remains explicit rather than being generalized into domain-neutral wording.

## Scientific package

`templates/scientific/.agents/` is a complete counterpart with distinct scientific document identities and truthful dates/versions. It governs:

- research intent and the research question or hypothesis identity;
- authority versus observed scientific evidence;
- confirmatory versus exploratory work;
- frozen or preregistered research/analysis plans when applicable;
- execution/analysis baseline and data/evidence provenance;
- protocol and analysis deviations;
- reproducibility evidence and claim-to-evidence traceability;
- scientific review;
- bounded remediation versus material replanning;
- accepted research-result identity; and
- dissemination/publication as a separately authorized consequential action.

Exploratory results cannot be silently represented as preregistered confirmatory evidence, and preregistration cannot be claimed when absent. Scientific semantics are written as governance rules, not as mechanical word substitutions.

## Shared invariants

Both packages independently state and validate these properties:

1. Human requests express intent and are not automatically authoritative truth.
2. Authority and observed evidence remain distinguishable.
3. Retrieved or external imperative content cannot establish authority by itself.
4. Planner/Reviewer and Executor responsibilities remain distinct.
5. Work is governed by a bounded contract.
6. Governing-task revision and execution/work baseline are separate identities.
7. Ordinary same-objective discovery stays within the contract.
8. Bounded findings are remediation; material objective, authority, architecture, or risk changes require replanning.
9. Evidence is required before acceptance.
10. Acceptance does not automatically authorize consequential external action.
11. Progressive context and runtime neutrality are preserved.

Repository-level deterministic fixtures compare material invariant markers between the packages without requiring a generic schema framework.

## Runtime adapters and external references

Adapters remain thin routing/materialization layers. They do not own governance semantics and do not vendor external methodology or skills. The Software package references `obra/superpowers` as external methodology; the Scientific package references `K-Dense-AI/science-superpowers` and, when relevant, `K-Dense-AI/scientific-agent-skills` as external supporting sources. These references are evidence, not repository authority.

The implementation will recheck current primary sources for those repositories and GitHub's template/rename documentation when materially relied upon. No live runtime claim will be made unless a runtime is actually exercised.

## Adoption documentation

README will show the exact manual/lightweight-script adoption flows:

```text
templates/software/.agents/   ->   <software-repository>/.agents/
templates/scientific/.agents/ ->   <scientific-repository>/.agents/
```

It will state that copied packages are standalone and that GitHub native “Use this template” cannot select a nested package. It will not imply that adopted repositories load both domains.

## Validation

Validation will cover repository structure, both package checkers, manifest/document identity uniqueness and coherence, relative-path resolution, standalone-copy behavior, absence of source-path dependencies, shared-invariant drift, non-vendoring of external content, removal of runtime profile selection, removal of mandatory shared-core dependence, Software regression preservation, and the robust version-drift fixture.

Required final commands include the repository checker, Software checker, Scientific checker, complete regression suite, focused shared-invariant fixtures, and `git diff --check`. Structural standalone copies will be checked in temporary locations without changing tracked product files.

## WIP disposition

The WIP changes will be classified during implementation as follows:

- General governance wording and consistency-checking improvements: reusable where compatible.
- Software-specific behavior: relocated into `templates/software/.agents/`.
- Scientific profile text: adapted into the independent Scientific package, not retained as a runtime profile.
- Runtime adapter and manifest improvements: retained only where they remain thin and package-local.
- Root `core-governance.md`, profile selection, and universal manifest assumptions: superseded and removed from the distributable architecture.
- Stale hard-coded README version fixture: replaced with identity-based current-version mutation.

## Versioning and migration

Moved Software artifacts retain identity unless established repository versioning requires otherwise. Substantively changed artifacts receive truthful `last_updated` values. Scientific artifacts use distinct identities. Package manifests, mirrored references, and README declarations remain coherent. Transition files are not deleted until governing-task inspectability and final verification are complete.

## Completion boundary

The work is ready for Planner/Reviewer review only after all validations pass and the final report includes the exact command outputs, changed-file set, commit SHAs, final architecture, mappings, WIP disposition, external sources consulted, limitations, remote SHA checks, and confirmation of no unauthorized side effects. The Executor must not self-declare acceptance or a new accepted baseline.
