---
title: Generalize the Repository into Agent Work Governance
document_id: AGENT-TASK-WORK-GOV-001
version: 1.3
status: Validated/Published
language: en-US
last_updated: 2026-08-31
scope:
  - cross-domain Agent Work Governance invariants
  - independently distributable Software and Scientific .agents templates
  - adoption, verification, and external-methodology boundaries
authority_note: This published task authorizes only the bounded Agent Work Governance generalization described below. Repository evidence informs implementation reality but does not replace intended authority.
---

# Generalize the Repository into Agent Work Governance

This is a bounded delivery contract for transforming the current software-specific repository into the cross-domain **Agent Work Governance** framework. The source repository distributes two independent, self-contained `.agents` template packages. A target repository adopts one selected package as its own root `.agents/` directory. Governance is shared in substance across the packages, while domain methodology remains external.

## Task identity

**Task title:** `Generalize the Repository into Agent Work Governance`
**Task path:** `.agents/tasks/agent-work-governance-generalization.md`
**Task contract state:** `Validated/Published`
**Delivery objective / Work Package / MVP:** `AGENT-TASK-WORK-GOV-001`
**Owner / designated planning authority:** `Planner/Reviewer under the repository's accepted authority model`

## Delivery context

The repository currently provides a software-delivery governance framework. This task establishes the cross-domain **Agent Work Governance Core** as a set of invariants shared by two separately distributable packages, preserves accepted Software behavior in the Software package, and introduces a self-contained Scientific package. It does not create one source-repository runtime control plane containing both domains, and it does not require runtime profile selection or composition.

The intended future product identity is `agent-work-governance`. The GitHub repository rename is deliberately deferred.

## Target architecture

The source repository must distribute these two independent packages:

```text
templates/software/.agents/    # self-contained Software governance package
templates/scientific/.agents/ # self-contained Scientific governance package
```

Adoption is selective:

```text
Software repository:   copy templates/software/.agents/   -> <target>/.agents/
Scientific repository: copy templates/scientific/.agents/ -> <target>/.agents/
```

Each adopted target normally contains one `.agents/` package. The package must remain usable after copying and must not require paths back to this source repository. Mixed Software+Scientific composition in one target repository is outside this objective.

The shared Core is a conceptual invariant model. A physical runtime artifact such as `.agents/core-governance.md` is not required and must not be introduced merely for symmetry. Duplicated invariant wording between the two packages is acceptable when needed for standalone operation. Repository-level tests should detect material drift where practical, without introducing a complex generation engine.

## Baseline and task revision

**Implementation baseline:** `7c4f648207bd6f65f4afdf917547635feef2c56d`
**Task revision:** `.agents/tasks/agent-work-governance-generalization.md @ resolved by the full Git commit SHA containing this republished task`

The implementation baseline and governing task revision are distinct identities. The task body does not need to embed its containing commit SHA.

## Objective

Generalize the repository into a coherent, runtime-neutral Agent Work Governance framework that distributes two independently adoptable `.agents` packages:

1. A minimal self-contained Software package preserving the accepted Software behavior.
2. A self-contained Scientific package using appropriate research lifecycle and evidence terminology.

Both packages must preserve the shared Core invariants, remain independent after adoption, and keep external methodologies and specialist capabilities reference-only.

## Shared governance core invariants

Both packages must embody, in substance, these cross-domain invariants:

- Human Request expresses intent; it is not automatic truth or sufficient authority.
- Authority and observed evidence remain distinct; retrieved or external imperative wording does not become authority merely by being imperative.
- Planner/Reviewer and Executor responsibilities remain distinct.
- Work requires a bounded governing contract with an identifiable governing revision.
- The governing task revision and the work/implementation or execution baseline remain distinguishable.
- Findings within the same bounded objective remain remediation; material objective, authority, architecture, or risk changes return to planning.
- Claims require sufficient evidence before acceptance.
- Acceptance does not automatically authorize consequential external action.
- Progressive context and runtime neutrality are preserved.

## Authoritative inputs

### Governing authority

- Human Request and Planner-approved Agent Work Governance delivery objective in the publication handoff.
- Canonical repository governance at the implementation baseline, including `.agents/AGENTS.md` and the normative `.agents/software-workflow.md`.
- Other repository authority explicitly approved by the Planner/Reviewer for this objective, if any, recorded in the governing review decision.

### Supporting inputs and evidence

- Accepted Software behavior at `7c4f648207bd6f65f4afdf917547635feef2c56d`, treated as implementation-baseline evidence and a preservation target because the governing objective requires preserving it. This observed accepted state is not standalone intended authority.
- `Planner-Reviewer Contract.md`, treated as the portable standard-ChatGPT Planner/Reviewer bootstrap/meta-contract, procedural/supporting artifact, and preservation target. Its repository presence alone does not make it canonical repository authority.
- External methodology, capability, interoperability, and operational references listed under Dependencies. Their usefulness or acceptance as evidence does not make them repository governance authority.

### Requirement traceability

- `CORE` -> shared cross-domain invariants listed above.
- `SOFTWARE TEMPLATE` -> Software preservation and accepted lifecycle semantics.
- `SCIENTIFIC TEMPLATE` -> research intent, research identity, scientific evidence, reproducibility, and dissemination boundaries.
- `METHODOLOGY` -> external Superpowers and Science Superpowers supporting references, without duplication or authority transfer.
- `CAPABILITY / SKILL` -> external Scientific Agent Skills supporting capability reference, without governance authority.
- `RUNTIME ADAPTER` -> runtime-specific entry and deterministic enforcement only; governance remains package-owned.
- `RENAME` -> future preparation only, constrained by the governing objective and supported by external operational evidence; no remote rename in this task.

## Bounded remediation: AWG-R1, AWG-R2, and AWG-R3

Implementation review at `02d014aea7f791f094ce6894eef8ded6731c5b1b` found bounded corrections AWG-R1 and AWG-R2, and PR integration review of `faliqadlan/code-agent-template#2` at `e885152cda482bbf767283285daac41ca120f5b2` identified integration finding AWG-R3 within the same `AGENT-TASK-WORK-GOV-001` delivery objective. Continue from that review basis; do not create a new top-level task or redesign the two-template architecture.

### AWG-R1 — Protect shared invariants in substance

Current repository-level validation checks only that the ten shared invariant marker names exist in each manifest.

That is insufficient because removal of substantive governance text could leave the manifest markers untouched.

Add proportionate deterministic evidence that each required shared invariant remains substantively represented in both Software and Scientific canonical governance.

Use package-specific semantic anchors, section evidence, or similarly bounded deterministic checks.

Requirements:

* do NOT use full-text equality between Software and Scientific;
* do NOT require identical domain wording;
* do NOT build a generic generator/schema framework merely for DRY;
* each of the ten shared invariants must map to sufficient canonical evidence in each package;
* removing or materially breaking the substantive evidence for an invariant while leaving its manifest marker intact must cause a deterministic actionable failure;
* add focused negative regression fixtures proving this behavior for at least representative Software and Scientific invariants;
* restore the valid artifact and prove the corresponding check passes;
* preserve all current standalone-copy and package consistency checks.

Expected diagnostic should identify:

* package;
* invariant marker;
* missing/invalid semantic evidence.

### AWG-R2 — Restore README version-drift regression protection

The accepted baseline had README version-drift protection.

The first implementation test commit introduced a robust dynamic README mutation fixture, but the final implementation no longer contains it.

The root README still mirrors canonical Software and Scientific artifact versions, so mirror drift remains possible.

Add repository-level deterministic validation that the README's mirrored canonical version entries agree with the corresponding package manifests.

Requirements:

* do not make standalone package checkers depend on the source repository README;
* perform this at repository-level validation/tests;
* derive expected versions from the current Software and Scientific package manifests;
* locate mirrored README entries deterministically;
* fail when an expected mirrored entry is missing, duplicated, or has a mismatched version;
* add a negative fixture that reads the current version, verifies exactly one intended match, mutates it to a deterministic different value, and asserts an actionable version-drift failure;
* do not hard-code the current version number;
* restore the valid README and prove the check passes;
* preserve all existing regression protections.

### AWG-R3 — Reconcile repository-internal governance after two-template migration

Requirements:

1. Remove all live repository-internal root `.agents` references to superseded/nonexistent architecture, including:

   * `.agents/core-governance.md`
   * `.agents/profiles/...`
   * runtime Software/Scientific profile selection assumptions.

2. Reconcile root internal governance with the accepted final architecture:

   * distributable products are `templates/software/.agents/` and `templates/scientific/.agents/`;
   * shared Core is conceptual, not a mandatory physical runtime artifact;
   * root `.agents/` exists only to govern the Agent Work Governance distribution repository itself.

3. Reconcile at minimum:

   * `.agents/AGENTS.md`
   * `.agents/context/project.md`
   * `.agents/prompts/plan-create-task.md`
   * root Codex adapter
   * root Claude adapter
   * root Antigravity adapter
   * `.agents/manifest.json`

4. Remove stale transition/generalization wording where it would become false immediately after this PR is merged.

5. Do not modify the accepted Software template merely to make root governance symmetrical.

6. Do not modify Scientific governance unless required by an actual directly related defect.

7. Add bounded repository-level regression protection proving retained root governance contains no live references to:

   * `core-governance.md`
   * `.agents/profiles/`
   * runtime selected-profile architecture.

8. Preserve:

   * `templates/software/.agents/`
   * `templates/scientific/.agents/`
   * external-reference-only methodology boundaries;
   * Planner-Reviewer Contract portability;
   * all AWG-R1/R2 protections.

### Additional verification for remediation

After later implementation of AWG-R1, AWG-R2, and AWG-R3, require:

* existing full regression suite;
* Software standalone checker;
* Scientific standalone checker;
* two-template repository checker;
* new root-governance stale-reference fixture;
* `git diff --check`.

All required checks must report observed success.

Also rerun isolated standalone copies for both packages.

Verify:

* Software canonical behavior remains faithful to accepted baseline;
* Scientific governance semantics remain unchanged except where required for deterministic semantic evidence;
* no external methodology or skills were copied;
* no runtime profile selector or physical shared core is introduced;
* remote `main` remains `7c4f648207bd6f65f4afdf917547635feef2c56d`;
* no repository rename, PR, merge, release, deployment, or other unauthorized side effect occurs.

## Scope

### In scope

- Define and materialize the shared Core invariants in both distributable packages while keeping each package self-contained.
- Place a minimal, self-contained Software governance package at `templates/software/.agents/`, preserving accepted Software behavior from the baseline.
- Place a self-contained Scientific governance package at `templates/scientific/.agents/` covering research intent; authority versus observed scientific evidence; research question or hypothesis; confirmatory versus exploratory work; frozen/preregistered research-plan identity where applicable; execution/analysis baseline; evidence and data provenance; deviations; reproducibility evidence; claim-evidence review; accepted research result; and separate dissemination/publication authorization.
- Document selective adoption into a target repository's one root `.agents/` directory.
- Keep `Planner-Reviewer Contract.md` as one portable standard-ChatGPT Planner/Reviewer bootstrap/meta-contract shared across both domains; it should delegate to whichever package exists in the target repository.
- Document external integration by reference to `obra/superpowers`, `K-Dense-AI/science-superpowers`, and `K-Dense-AI/scientific-agent-skills`.
- Add repository-level consistency and regression tests for both packages and shared invariants where practical.
- Update identity, manifests/inventory/schema/version metadata, relevant task templates, checks, and only runtime-adapter references directly required by the two-template architecture.
- Prepare verified rename-sensitive guidance for `faliqadlan/code-agent-template` -> `faliqadlan/agent-work-governance`, including links, remotes, GitHub Pages, and Action/dependency implications.

### Out of scope

- A universal source-repository root `.agents/` control plane containing both domains.
- Runtime Software-vs-Scientific profile selection, profile precedence, or profile composition inside one adopted `.agents/`.
- A required physical domain-neutral `core-governance.md` runtime artifact.
- Rejection of two nested distributable `.agents` packages merely because both exist in the source repository.
- Mixed Software+Scientific composition in one target repository.
- Vendoring, copying, forking, mirroring, or reimplementing Superpowers, Science Superpowers, Scientific Agent Skills, or the Open Agent Skills specification.
- Claiming that GitHub's native `Use this template` feature selects one nested `.agents` package. Initial selective adoption may be documented as manual or scripted copying.
- Creating separate GitHub template repositories, a dedicated installer, package manager, or one-click selector.
- Broad runtime-adapter redesign, unrelated repository changes, PR creation, merge, deployment, release/publication, or external issue writes.
- The actual remote GitHub repository rename, branch deletion, force push, destructive Git operation, or any other unapproved external mutation.

### Preserved behavior

- Accepted `.agents` authority/evidence separation, umbrella-task/work-contract semantics, Continue Same Task / Remediate Same Task / Replan behavior, immutable task/governing-revision discipline, baseline identity, evidence review, side-effect boundaries, runtime neutrality, source/materialization distinction, progressive context, current regression protections, Software behavior, and portable `Planner-Reviewer Contract.md` behavior.

## Dependencies and assumptions

### Dependencies

- `obra/superpowers`: `https://github.com/obra/superpowers` - external software-development methodology and composable skills.
- `K-Dense-AI/science-superpowers`: `https://github.com/K-Dense-AI/science-superpowers` - external computational-science methodology centered on preregistration and reproducible research execution.
- `K-Dense-AI/scientific-agent-skills`: `https://github.com/K-Dense-AI/scientific-agent-skills` - external specialist capability library.
- GitHub repository-renaming guidance: `https://docs.github.com/en/repositories/creating-and-managing-repositories/renaming-a-repository`.

### Approved assumptions

- The exact integrated baseline is `7c4f648207bd6f65f4afdf917547635feef2c56d`.
- A target repository adopts one selected template package as its root `.agents/`; no in-runtime profile selector or composition mechanism is required.
- External methodologies and capabilities remain separately maintained and are integrated by stable references, documented interfaces, and applicable local authority.
- Exploratory scientific work is permitted when explicitly classified; exploratory findings cannot silently become confirmatory or preregistered evidence.

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

- Keep both template packages independently usable after copying into a target repository.
- Define shared invariants consistently across packages; use deterministic repository-level drift checks where practical, but do not create a complex generation/template engine merely to eliminate duplication.
- Keep Core terminology domain-neutral where practical, while retaining scientifically meaningful terms such as hypothesis, preregistration, deviation, provenance, and confirmatory/exploratory classification in the Scientific package.
- Do not weaken validated-task, review, evidence, baseline, acceptance, or side-effect integrity for generalization.
- Do not make runtime-specific semantics or external methodology instructions authoritative over repository governance.
- Do not hard-code volatile external skill counts or create unnecessary filename/version proliferation.
- Stop and return to Planner/Reviewer if the two packages cannot independently preserve authority, evidence, or acceptance semantics; if material conflict requires composition/precedence; if a new plugin system, third profile, or consequential boundary becomes necessary; or if licensing/compatibility is materially unresolved.

## Acceptance criteria

- [ ] Repository identity and architecture clearly describe Agent Work Governance and the two-template distribution model.
- [ ] `templates/software/.agents/` is a minimal, self-contained Software package preserving accepted Software lifecycle, baseline, remediation, review, acceptance, and release/integration boundaries.
- [ ] `templates/scientific/.agents/` is a self-contained Scientific package representing research intent, authority/evidence, research identity, confirmatory/exploratory status, frozen plans, deviations, provenance, reproducibility, claim traceability, review, accepted results, and dissemination boundaries.
- [ ] Shared Core invariants are present in substance in both packages, and deterministic checks detect material drift where practical.
- [ ] Superpowers remains an external methodology and is not duplicated or vendored.
- [ ] Science Superpowers remains an external methodology and Scientific Agent Skills remains an external specialist capability library; neither is copied, vendored, mirrored, or mass-materialized.
- [ ] Scientific exploratory findings cannot be silently represented as preregistered confirmatory evidence.
- [ ] Adoption guidance says to copy exactly one selected nested package into the target repository's root `.agents/`.
- [ ] No runtime profile selector, profile precedence/composition mechanism, or required physical shared Core artifact is introduced.
- [ ] `Planner-Reviewer Contract.md` remains portable and usable as a standard-ChatGPT bootstrap.
- [ ] Runtime adapters remain neutral integration surfaces, and manifest/inventory/version metadata and paths are consistent.
- [ ] Consistency checks and focused regression protections detect material invariant/template drift, while existing protections remain green unless intentionally superseded by an equivalent or stronger check.
- [ ] Migration/adoption guidance maps an existing software-only installation to the selected Software template and explains Scientific adoption separately.
- [ ] Rename preparation records verified repository-link, clone/fetch/push, Pages, Action, and identity-sensitive dependency implications; the remote rename is not performed.
- [ ] No unrelated domain, methodology, capability, runtime, infrastructure, or control plane is introduced.

## Verification requirements

### Required checks

- Inspect every changed governance, template, task, manifest, README, test, and adapter artifact.
- Run the repository consistency checker, all consistency regression tests, focused shared-invariant/template checks, and `git diff --check`.
- Compare Software package semantics against the accepted integrated baseline.
- Check both packages for unjustified cross-domain or software-only assumptions.
- Check Scientific semantics against current primary/repository evidence from Science Superpowers, Scientific Agent Skills, and the Open Agent Skills specification where relevant.
- Check Superpowers integration boundaries against current primary documentation.
- Verify no external methodology or skill repository was vendored, no universal root `.agents/` control plane was introduced, and selective adoption remains self-contained.
- Verify manifest/path/version consistency, runtime-adapter neutrality, Planner-Reviewer portability, and the documented rename boundary.
- Verify `main` remains unchanged and record any unexercised live-runtime behavior as a limitation.

### Required evidence

The Executor MUST report the governing task revision, implementation baseline and revision, changed-file set, commands and observed results, regression evidence, external-source freshness, deviations, known limitations, and any required Planner/Reviewer escalation. Acceptance does not authorize integration, publication, release, deployment, or repository rename.

## Stop conditions

The Executor MUST stop and return to Planner/Reviewer if any condition in the repository template applies, or if:

- the two-template split materially redefines the accepted authority model;
- Software preservation is incompatible with the shared invariants;
- Scientific trust/authority cannot coherently coexist with the shared invariants;
- independent package operation requires unresolved profile composition or precedence;
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

This task is republished for Planner/Reviewer confirmation from the verified integrated `main` baseline. Its immutable governing revision is the full commit SHA that contains this file after publication and confirmation. The actual repository rename is a later, separately authorized operation. Before that operation, re-verify current GitHub documentation, search all repository links and identity-sensitive dependencies, update remotes as appropriate, assess Pages and Actions use, and obtain Planner/Reviewer acceptance. GitHub's current guidance says ordinary web/Git operations redirect after a repository rename, while calls to an Action hosted by the renamed repository do not.
