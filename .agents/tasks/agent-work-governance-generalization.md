---
title: Generalize the Repository into Agent Work Governance
document_id: AGENT-TASK-WORK-GOV-001
version: 1.0
status: Validated/Published
language: en-US
last_updated: 2026-08-31
scope:
  - cross-domain agent-work governance core
  - Software and Scientific governance profiles
  - adoption, composition, and verification boundaries
authority_note: This published task authorizes only the bounded Agent Work Governance generalization described below. Repository evidence informs implementation reality but does not replace intended authority.
---

# Generalize the Repository into Agent Work Governance

This is a bounded delivery contract for transforming the current software-specific repository into the cross-domain **Agent Work Governance** framework. The framework governs human/AI work independently from the domain methodology used to perform that work.

## Task identity

**Task title:**  
`Generalize the Repository into Agent Work Governance`

**Task path:**  
`.agents/tasks/agent-work-governance-generalization.md`

**Task contract state:**  
`Validated/Published`

**Delivery objective / Work Package / MVP:**  
`AGENT-TASK-WORK-GOV-001`

**Owner / designated planning authority:**  
`Planner/Reviewer under the repository's accepted authority model`

## Delivery context

The repository currently provides a software-delivery governance framework. This task establishes a domain-neutral governance core, preserves accepted Software behavior through a Software profile, introduces an initial Scientific profile, and documents how external methodologies and specialist capabilities compose with one coherent adopted `.agents/` control plane.

The intended future product identity is `agent-work-governance`. The GitHub repository rename is deliberately deferred.

## Baseline and task revision

**Implementation baseline:**  
`7c4f648207bd6f65f4afdf917547635feef2c56d`

**Task revision:**  
`.agents/tasks/agent-work-governance-generalization.md @ resolved by the full Git commit SHA containing this published task`

The implementation baseline and governing task revision are distinct identities. The task body does not need to embed its containing commit SHA.

## Objective

Generalize the repository into a coherent, runtime-neutral Agent Work Governance framework with a domain-neutral core, Software and Scientific profiles, explicit external methodology/capability boundaries, one adoptable `.agents/` control plane, progressive profile loading, migration guidance, and regression protection.

## Authoritative inputs

### Governing authority

- Human Request: `TASK AUTHORING / PUBLICATION HANDOFF`, supplied for this task.
- Existing repository governance, `.agents/` control plane, accepted Software behavior, and `Planner-Reviewer Contract.md` at the implementation baseline.
- Open Agent Skills specification: `https://agentskills.io/specification`.
- Primary external methodology/capability references listed under Dependencies.

### Requirement traceability

- `CORE` → cross-domain invariants: authority/evidence separation, bounded contracts, distinct task and implementation identities, review, verification, remediation/replanning, acceptance, side-effect boundaries, and progressive context.
- `PROFILE` → Software preservation and Scientific research governance semantics.
- `METHODOLOGY` → external Superpowers and Science Superpowers references, without duplication.
- `CAPABILITY / SKILL` → external Scientific Agent Skills references, without governance authority.
- `RUNTIME ADAPTER` → runtime-specific entry and deterministic enforcement only; governance remains repository-owned.
- `RENAME` → future preparation only; no remote rename in this task.

## Scope

### In scope

- Define and materialize a domain-neutral governance core for human intent, authority, evidence, work-contract identity, bounded scope, planning/review, execution authorization, immutable revisions/baselines, side effects, verification, remediation/replanning, acceptance, and integration/publication boundaries.
- Establish maintainable Software and Scientific profiles under one coherent adopted `.agents/` control plane, with explicit selection/composition, precedence, ownership, and progressive loading behavior.
- Preserve accepted Software semantics, including intended authority versus observed reality, readiness gates where applicable, validated executable tasks, immutable implementation baselines, Executor lifecycle semantics (E6/V7/R8/A9 or an equivalent accepted mapping), bounded remediation, implementation acceptance, and release/integration separation.
- Add Scientific semantics for research intent versus scientific claims; protocol/design authority versus observed data/results; research-question or hypothesis identity; confirmatory versus exploratory classification; preregistered or frozen research-plan identity where applicable; execution baselines; raw-data/evidence provenance; reproducibility; deviations; claim-evidence traceability; scientific review; accepted results; and separate dissemination/publication authorization.
- Document external integration by reference to `obra/superpowers`, `K-Dense-AI/science-superpowers`, and `K-Dense-AI/scientific-agent-skills`, and document adoption/migration from a software-only installation.
- Update identity, architecture, manifests/inventory/schema/version metadata, relevant task templates, checks, regression tests, and only those runtime-adapter references directly required by the generalized architecture.
- Prepare verified rename-sensitive guidance for `faliqadlan/code-agent-template` → `faliqadlan/agent-work-governance`, including links, remotes, GitHub Pages, and Action/dependency implications.

### Out of scope

- Vendoring, copying, forking, or reimplementing Superpowers, Science Superpowers, Scientific Agent Skills, or the Open Agent Skills specification.
- Creating competing `.agents-software/` or `.agents-scientific/` control planes, a general plugin/package system, a replacement skill format, or unrelated profiles.
- Broad runtime-adapter redesign, unrelated repository changes, PR creation, merge, deployment, release/publication, or external issue writes.
- The actual remote GitHub repository rename, branch deletion, force push, destructive Git operation, or any other unapproved external mutation.

### Preserved behavior

- Accepted `.agents` authority/evidence separation, umbrella-task/work-contract semantics, Continue Same Task / Remediate Same Task / Replan behavior, immutable task/governing-revision discipline, baseline identity, evidence review, side-effect boundaries, runtime neutrality, source/materialization distinction, progressive context, current regression protections, Software behavior, and portable `Planner-Reviewer Contract.md` behavior.

## Dependencies and assumptions

### Dependencies

- `obra/superpowers`: `https://github.com/obra/superpowers` — external software-development methodology and composable skills.
- `K-Dense-AI/science-superpowers`: `https://github.com/K-Dense-AI/science-superpowers` — external computational-science methodology centered on preregistration and reproducible research execution.
- `K-Dense-AI/scientific-agent-skills`: `https://github.com/K-Dense-AI/scientific-agent-skills` — external specialist capability library.
- GitHub repository-renaming guidance: `https://docs.github.com/en/repositories/creating-and-managing-repositories/renaming-a-repository`.

### Approved assumptions

- The exact integrated baseline is `7c4f648207bd6f65f4afdf917547635feef2c56d`.
- One adopted repository has one coherent `.agents/` control plane; irrelevant profiles are not loaded into context.
- External methodologies and capabilities remain separately maintained and are integrated by stable references, documented interfaces, and applicable local authority.
- Exploratory scientific work is permitted when explicitly classified; exploratory findings cannot silently become confirmatory/preregistered evidence.

### Remaining approval requirements

- Planner/Reviewer acceptance is required before implementation begins and before any material authority, architecture, scope, or precedence change is adopted.
- Separate designated authorization is required for repository rename, PR/merge, deployment, release/publication, or other consequential external side effects.

## Required capabilities

- Repository read/write and Git branch/commit operations.
- Local shell and repository consistency/regression checks.
- Current primary-source inspection for the external references and GitHub rename guidance above.
- No runtime vendor or model-specific capability is required.

## Execution constraints

### Constraints

- Define each invariant once and reference it from profiles and adapters; keep safety-critical reminders concise.
- Keep core terminology domain-neutral where practical, while retaining scientifically meaningful terms such as hypothesis, preregistration, deviation, provenance, and confirmatory/exploratory classification.
- Do not weaken validated-task, review, evidence, baseline, acceptance, or side-effect integrity for cosmetic generalization.
- Do not make runtime-specific semantics or external methodology instructions authoritative over repository governance.
- Do not hard-code volatile external skill counts or create unnecessary filename/version proliferation.
- Stop and return to Planner/Reviewer if core/profile authority cannot coexist, precedence is unresolved, a new plugin system is required, licensing/compatibility is materially unresolved, or another consequential boundary or domain becomes necessary.

## Acceptance criteria

- [ ] Repository identity and architecture clearly describe Agent Work Governance.
- [ ] Core governance is meaningfully domain-neutral and explicitly distinguishes Core, Profile, Methodology, Capability/Skill, and Runtime Adapter ownership.
- [ ] Existing Software governance is preserved through a Software profile, including lifecycle, baseline, remediation, review, and release/integration boundaries.
- [ ] Superpowers remains an external methodology and is not duplicated or vendored.
- [ ] A coherent Scientific profile represents authority/evidence, research identity, confirmatory/exploratory status, frozen plans, deviations, provenance, reproducibility, claim traceability, review, accepted results, and dissemination boundaries.
- [ ] Science Superpowers remains an external methodology and Scientific Agent Skills remains an external specialist capability library.
- [ ] Scientific exploratory findings cannot be silently represented as preregistered confirmatory evidence.
- [ ] Adoption yields one `.agents/` control plane with explicit profile selection/composition, precedence, and progressive loading; target repositories need not load irrelevant profiles.
- [ ] `Planner-Reviewer Contract.md` remains portable and usable as a standard-ChatGPT bootstrap.
- [ ] Runtime adapters remain neutral integration surfaces, and manifest/inventory/version metadata and paths are consistent.
- [ ] Consistency checks and focused regression protections detect material core/profile drift, while existing protections remain green unless intentionally superseded by an equivalent or stronger check.
- [ ] Migration/adoption guidance maps an existing software-only installation to the generalized framework.
- [ ] Rename preparation records verified repository-link, clone/fetch/push, Pages, Action, and identity-sensitive dependency implications; the remote rename is not performed.
- [ ] No unrelated domain, methodology, capability, runtime, infrastructure, or control plane is introduced.

## Verification requirements

### Required checks

- Inspect every changed governance, profile, task, manifest, README, test, and adapter artifact.
- Run the repository consistency checker, all consistency regression tests, focused new invariant checks, and `git diff --check`.
- Compare Software profile semantics against the accepted integrated baseline.
- Check core for unjustified software-only assumptions.
- Check Scientific semantics against current primary/repository evidence from Science Superpowers, Scientific Agent Skills, and the Open Agent Skills specification where relevant.
- Check Superpowers integration boundaries against current primary documentation.
- Verify no external methodology or skill repository was vendored, no duplicate `.agents` control plane was introduced, and profile loading/adoption is progressive.
- Verify manifest/path/version consistency, runtime-adapter neutrality, Planner-Reviewer portability, and the documented rename boundary.
- Verify `main` remains unchanged and record any unexercised live-runtime behavior as a limitation.

### Required evidence

The Executor MUST report the governing task revision, implementation baseline and revision, changed-file set, commands and observed results, regression evidence, external-source freshness, deviations, known limitations, and any required Planner/Reviewer escalation. Acceptance does not authorize integration, publication, release, deployment, or repository rename.

## Stop conditions

The Executor MUST stop and return to Planner/Reviewer if any condition in the repository template applies, or if:

- the core/profile split materially redefines the accepted authority model;
- Software preservation is incompatible with domain-neutral semantics;
- Scientific trust/authority cannot coherently coexist with the core;
- profile composition produces unresolved conflict or precedence;
- a new plugin/package system or third profile becomes necessary;
- external methodology licensing or compatibility is materially unresolved;
- implementation requires the remote rename or another unapproved consequential side effect;
- acceptance cannot be satisfied within this objective.

## Side-effect authorization

Implementation authorization is limited to the repository changes, checks, and documentation needed to satisfy this task. It does not authorize remote repository rename, PR creation, merge, deployment, release/publication, destructive operations, unrelated external mutation, or force push. Dependency installation/replacement or permission expansion requires separate authority.

### Explicitly authorized side effects

- Repository-local implementation commits and ordinary non-force pushes to the authorized task branch when separately instructed by the active execution handoff.
- Non-destructive local verification and evidence collection.

## Expected terminal outcome

### Review Required

Use when an immutable implementation revision and truthful verification evidence are available for Planner/Reviewer evaluation. The Executor does not self-declare final acceptance or release authorization.

### Planning Required

Use when a stop condition prevents safe completion within this bounded objective; report the affected authority, scope, architecture, dependency, acceptance condition, and supporting evidence.

## Review and remediation handling

The Reviewer evaluates the implementation against this exact governing task revision, the implementation baseline, the implementation revision, applicable authority, and observed evidence. Bounded corrections remain under this same objective and require a new task revision before renewed execution. Materially new objectives or scope expansion return to planning as separate work.

## Publication and rename boundary

This task was published from the verified integrated `main` baseline. Its immutable governing revision is the full commit SHA that contains this file. The actual repository rename is a later, separately authorized operation. Before that operation, re-verify current GitHub documentation, search all repository links and identity-sensitive dependencies, update remotes as appropriate, assess Pages and Actions use, and obtain Planner/Reviewer acceptance. GitHub's current guidance says ordinary web/Git operations redirect after a repository rename, while calls to an Action hosted by the renamed repository do not.
