# Agent Work Governance

A runtime-neutral, repository-local framework for governing human/AI work across Software and Scientific profiles.

This repository defines **delivery governance**, not a generic coding methodology.

It answers questions such as:

- What authority governs the intended behavior?
- What does the repository actually do today?
- What delivery state are we in?
- Is implementation work legitimately ready to start?
- What exact task and baseline govern execution?
- What evidence is required before review?
- When does remediation remain bounded, and when must work return to planning?
- Which exact repository revision becomes the next accepted baseline?
- Has implementation merely been accepted, or has release also been approved?

Domain methodology and specialist capability—such as Superpowers, Science Superpowers, Scientific Agent Skills, TDD, debugging, and subagent orchestration—belongs to external execution tooling and remains separate from governance.

> **Important**
>
> This README is human-facing documentation. It is not repository delivery authority.
>
> The canonical repository contract is [`.agents/AGENTS.md`](.agents/AGENTS.md), the domain-neutral core is [`.agents/core-governance.md`](.agents/core-governance.md), and the selected profiles are [`.agents/software-workflow.md`](.agents/software-workflow.md) and [`.agents/profiles/scientific-governance.md`](.agents/profiles/scientific-governance.md).

---

## Core idea

The framework separates three concerns:

```text
.agents/
= WHAT delivery work is legitimate, bounded, reviewable, and acceptable

runtime adapter
= HOW Codex / Claude Code / Antigravity enters the repository contract

runtime methodology
= HOW technical engineering is performed
  (skills, plugins, Superpowers, MCP, subagents, native tooling)
```

This separation keeps governance stable while the runtime, model, domain methodology, or specialist capability changes.

```text
Agent Work Governance
├── Core: cross-domain governance invariants
├── Software profile: accepted software lifecycle semantics
├── Scientific profile: research authority, provenance, and claim review
├── External methodology: Superpowers / Science Superpowers
├── External capability: Scientific Agent Skills
└── Runtime adapters: entry and deterministic enforcement bridges
```

---

## Repository structure

```text
.agents/
├── AGENTS.md
├── core-governance.md
├── software-workflow.md
├── profiles/
│   ├── README.md
│   └── scientific-governance.md
├── context/
│   └── project.md
├── prompts/
│   └── plan-create-task.md
├── tasks/
│   └── _template.md
└── runtime-adapters/
    ├── codex/
    │   ├── AGENTS.md
    │   └── README.md
    ├── claude/
    │   ├── CLAUDE.md
    │   └── README.md
    └── antigravity/
        ├── README.md
        └── rules/
            └── antigravity-code-agent-workflow.md
```

### Canonical artifacts

| Path | Purpose |
|---|---|
| [`.agents/core-governance.md`](.agents/core-governance.md) | Domain-neutral governance core shared by profiles. |
| [`.agents/software-workflow.md`](.agents/software-workflow.md) | Normative, runtime-neutral software-delivery lifecycle and quality gates. |
| [`.agents/profiles/scientific-governance.md`](.agents/profiles/scientific-governance.md) | Scientific governance profile for research and analysis work. |
| [`.agents/profiles/README.md`](.agents/profiles/README.md) | Profile selection, precedence, progressive loading, and adoption guidance. |
| [`.agents/AGENTS.md`](.agents/AGENTS.md) | Compact repository AI delivery contract and role router. |
| [`.agents/context/project.md`](.agents/context/project.md) | Refreshable repository orientation, authority map, observed-evidence map, delivery state, and scoped-context router. |
| [`.agents/prompts/plan-create-task.md`](.agents/prompts/plan-create-task.md) | Reusable Planner/Reviewer orchestration procedure. |
| [`.agents/tasks/_template.md`](.agents/tasks/_template.md) | Template for bounded validated executable tasks. |
| [`.agents/runtime-adapters/`](.agents/runtime-adapters/) | Runtime-native bootstrap and integration guidance. |

### Current canonical versions

| Artifact | Version |
|---|---:|
| `core-governance.md` | 1.0 |
| `software-workflow.md` | 2.3 |
| `AGENTS.md` | 1.4 |
| `profiles/scientific-governance.md` | 1.0 |
| `context/project.md` | 1.2 |
| `prompts/plan-create-task.md` | 2.5 |
| `tasks/_template.md` | 1.3 |
| Codex adapter | 1.3 |
| Claude adapter | 1.3 |
| Antigravity adapter | 1.3 |

The root README does not define canonical protocol versioning. Each normative or runtime-specific artifact carries its own version where needed.

To verify manifest paths, mirrored versions, Antigravity source/target identity, and repository-local README links, run:

```powershell
.\.agents\check-consistency.ps1
```

The check treats `.agents/context/project.md` as an approved reusable template, so its intentional placeholders do not fail validation.

---

# Delivery model

## Two-axis model: intended authority vs observed reality

The framework deliberately separates what the system **should** do from what the repository **currently does**.

### Intended authority

Depending on the repository, intended authority may include:

```text
approved business sources
→ approved product / PRD authority
→ approved requirements
→ approved architecture and repository policy
→ approved delivery planning
→ governing validated task
```

### Observed implementation evidence

Observed reality may include:

```text
source code
configuration
migrations
tests
runtime observations
Git history
CI evidence
accepted baseline records
```

Neither side silently overrides the other.

```text
approved requirement
≠ proof that implementation satisfies it

existing implementation
≠ retroactive authority for undocumented behavior
```

When authority and observed reality disagree, the discrepancy must be made explicit and resolved through planning, remediation, or an authority decision.

---

# Quality gates

The canonical lifecycle uses stable quality gates:

| Gate | Name |
|---|---|
| `B0` | Business Framing |
| `P1` | Product Definition |
| `R2` | Requirements Traceability |
| `A3` | Architecture Clarity |
| `D4` | Delivery Readiness |
| `T5` | Task Readiness |
| `E6` | Execution Verification |
| `V7` | Implementation Review |
| `R8` | Remediation Closure |
| `A9` | Baseline Acceptance |
| `G10` | Release Approval |

Canonical gate states are:

```text
pending
in_review
blocked
passed
reopened
not_applicable
```

A gate is not considered passed merely because a corresponding file exists.

Evidence must support the gate condition.

---

# Existing repositories do not restart from zero

The framework is designed for both greenfield and existing repositories.

Adoption begins by inspecting what already exists and continuing from the **earliest unmet or materially unreliable gate**.

```text
inspect repository
→ map valid authority and implementation evidence
→ identify stale / missing / contradictory concerns
→ preserve valid upstream work
→ continue from earliest unreliable gate
```

Existing documentation and conventions should be reused when they already satisfy the required responsibility.

The framework defines logical responsibilities, not mandatory business-document filenames or directory structures.

---

# Planner, Executor, and Reviewer

Planner, Executor, and Reviewer are **logical responsibilities**, not fixed models or agent products.

A runtime may assign multiple responsibilities to one model/session when repository policy permits it.

## Planner

The Planner:

- establishes the current delivery state;
- identifies the earliest unmet or unreliable gate;
- repairs planning-stage authority/context only when necessary;
- selects the next coherent delivery objective;
- creates or updates a bounded task;
- publishes executable work only when Task Readiness is satisfied.

## Executor

The Executor:

- implements only a published validated task;
- works against the exact implementation baseline;
- remains tied to the exact governing task revision;
- retains bounded technical discretion;
- stops when a material authority, dependency, architecture, scope, approval, or safety boundary is reached;
- reports truthful verification evidence and a terminal state.

## Reviewer

The Reviewer:

- reviews implementation against the correct task revision and baseline;
- checks applicable authority, scope, acceptance criteria, architecture, evidence, and risk;
- determines acceptance, bounded remediation, or return to planning;
- may establish the reviewed immutable implementation revision as the next accepted baseline when repository policy permits.

Implementation acceptance is **not** release authorization.

---

# The control loop

The main reusable Planner/Reviewer procedure is:

[`.agents/prompts/plan-create-task.md`](.agents/prompts/plan-create-task.md)

Despite its filename, task creation is only one possible outcome.

Typical delivery loop:

```text
Planner / Reviewer
        ↓
establish current delivery state
        ↓
resolve pending execution / review / remediation / approval first
        ↓
establish or confirm accepted baseline
        ↓
advance earliest applicable planning gate
        ↓
publish validated task when T5 passes
        ↓
Executor
        ↓
implementation + observed evidence
        ↓
Planner / Reviewer
        ↓
accept
or bounded remediation
or return to planning
        ↓
next legitimate action
```

Possible Planner/Reviewer outcomes include:

```text
VALIDATED TASK PUBLISHED
EXECUTION REQUIRED
REMEDIATION TASK PUBLISHED
IMPLEMENTATION ACCEPTED
IMPLEMENTATION ACCEPTED + NEXT TASK PUBLISHED
AUTHORITY UPDATE REQUIRED
APPROVAL REQUIRED
PLANNING BLOCKED
SIDE-EFFECT AUTHORIZATION REQUIRED
NO DELIVERY ACTION REQUIRED
```

The framework itself is not an autonomous daemon.

The runtime or human operator is responsible for invoking the next appropriate role.

---

# How to invoke the workflow

The framework is designed to be invoked with simple, explicit prompts.

Runtime adapters already route the coding agent into `.agents/AGENTS.md`, so normal usage should point the agent at the canonical Planner/Reviewer procedure or the exact validated task that should be executed.

## Plan, review, or create the next task

Use the canonical Planner/Reviewer procedure:

```text
Read and follow `.agents/prompts/plan-create-task.md`.
```

For a more explicit invocation:

```text
Read and follow `.agents/prompts/plan-create-task.md`.

Assess the current repository delivery state, resolve any pending execution,
review, remediation, approval, or baseline state first, and then perform the
next legitimate Planner/Reviewer action.
```

This single procedure is reusable throughout the project.

It may result in:

```text
VALIDATED TASK PUBLISHED
EXECUTION REQUIRED
REMEDIATION TASK PUBLISHED
IMPLEMENTATION ACCEPTED
IMPLEMENTATION ACCEPTED + NEXT TASK PUBLISHED
AUTHORITY UPDATE REQUIRED
APPROVAL REQUIRED
PLANNING BLOCKED
SIDE-EFFECT AUTHORIZATION REQUIRED
NO DELIVERY ACTION REQUIRED
```

Do not assume that invoking `plan-create-task.md` always creates a new task.

For example, when a validated task is already waiting for implementation, the correct result is normally:

```text
EXECUTION REQUIRED
```

When implementation is waiting for review, the procedure should review that implementation before planning dependent successor work.

## Execute a validated task

Once the Planner/Reviewer has published a validated task and its exact immutable governing revision is resolvable, invoke the Executor against that task.

Convenience prompt:

```text
Read and execute `.agents/tasks/<task-name>.md`.
```

Use that short form only when the current runtime/orchestrator has already established the exact governing task revision and implementation baseline. The task path by itself is not sufficient identity for execution when multiple revisions exist.

Recommended explicit form:

```text
Read `.agents/AGENTS.md`.

Then execute the validated task:

`.agents/tasks/<task-name>.md`

Governing task revision:
<full immutable revision containing the governing task>

Implementation baseline:
<full immutable baseline revision>

Stay within the task's scope, constraints, preserved behavior, approval
requirements, side-effect authorization, and stop conditions.

When execution ends, report the observed verification evidence and the correct
terminal outcome: `Review Required` or `Planning Required`.
```

If the runtime can resolve the immutable task revision and baseline from approved orchestration metadata, they do not need to be duplicated manually in the prompt. They still must be unambiguous before Executor work begins.

Example:

```text
Read `.agents/AGENTS.md`.

Then read and execute the exact validated task:

`.agents/tasks/member-dicom-generation.md`

Use the exact governing task revision and implementation baseline identified
for this execution. Do not expand the delivery objective or perform
unauthorized side effects.
```

The task path alone is a human-friendly locator.

Execution must still be tied to the exact immutable governing task revision, for example:

```text
.agents/tasks/member-dicom-generation.md
@
<full-git-commit-sha-containing-the-governing-task>
```

A Draft task whose publication revision is still unresolved must not be executed as a validated task.

## Typical manual loop

A simple human-driven delivery loop can therefore look like:

```text
1. "Read and follow `.agents/prompts/plan-create-task.md`."
            ↓
2. Planner/Reviewer publishes or identifies the next validated task.
            ↓
3. "Read and execute `.agents/tasks/<task-name>.md`."
   (using the exact governing task revision and implementation baseline)
            ↓
4. Executor returns implementation + evidence.
            ↓
5. "Read and follow `.agents/prompts/plan-create-task.md`."
            ↓
6. Planner/Reviewer accepts, remediates, returns to planning,
   or publishes the next legitimate task.
```

If remediation is required, use the newly published immutable revision of the same stable task path before executing again.

The runtime-specific adapter may provide additional invocation conveniences, but it must not replace this canonical control loop.

---

# Validated tasks

Implementation-changing work requires a published validated task.

A task is a **delivery contract**, not a line-by-line coding recipe.

A validated task should define, directly or by unambiguous reference:

- task identity;
- delivery objective;
- implementation baseline;
- exact governing task revision;
- authoritative inputs;
- requirement traceability;
- in-scope work;
- out-of-scope boundaries;
- preserved behavior and invariants;
- dependencies;
- approved assumptions;
- required capabilities;
- execution constraints;
- acceptance criteria;
- verification requirements;
- remaining approval requirements;
- stop conditions;
- explicitly authorized side effects;
- expected terminal outcome.

Use:

[`.agents/tasks/_template.md`](.agents/tasks/_template.md)

Task filenames should remain stable.

Version-control history stores immutable revisions.

For Git-backed repositories, a governing task can be identified as:

```text
<task path> @ <full immutable Git revision containing the task>
```

A Draft task may temporarily say its publication revision will be resolved later, but T5 must not pass and Executor work must not begin until the exact immutable governing task revision is resolvable.

Task lifecycle status is distinct from the governing task revision.

A status-only change must not silently replace the revision that governed an execution attempt.

---

# Execution and review outcomes

## Reviewable implementation

When the Executor produces a reviewable implementation state, E6 may proceed to V7 even if some checks failed or limitations remain, provided the evidence is truthful and sufficient for review.

```text
Executor
→ reviewable implementation
→ truthful evidence
→ V7 review
```

## Valid stop without reviewable implementation

If the Executor legitimately reaches a stop condition before producing reviewable implementation:

```text
Executor
→ Planning Required
→ no fabricated implementation review
```

For that attempt:

```text
V7 = not applicable
R8 = not applicable
A9 = not applicable
```

Control returns to planning or the applicable approval boundary.

## Bounded remediation

A bounded defect inside the same approved delivery objective normally updates the **same stable task path** and republishes a new immutable task revision.

Materially new scope, objectives, architecture decisions, or unrelated findings return to planning instead.

---

# Accepted baseline vs release

A successful implementation review may establish a new immutable development baseline.

For Git repositories, prefer a full commit SHA.

```text
reviewed immutable implementation revision
→ A9 Baseline Acceptance
```

A mutable working tree may be reviewable under repository policy, but it cannot itself be the accepted immutable baseline.

Release remains independent:

```text
A9 Baseline Acceptance
≠
G10 Release Approval
```

Accepted software is not automatically deployed, published, production-ready, or released.

---

# Side effects and authorization

A validated task authorizes only the bounded implementation mutations defined by the task and applicable repository policy.

It does not automatically authorize actions such as:

- Git commit;
- push;
- pull-request creation;
- dependency installation or replacement;
- production mutation;
- destructive data or infrastructure operations;
- external-system mutation;
- permission expansion;
- secret access or disclosure;
- deployment;
- publication;
- release;
- unrelated repository changes.

The general runtime rule is:

```text
runtime capability / permission
AND
repository delivery authorization
```

Both must permit an action.

A coding agent being technically capable of performing an operation does not make that operation authorized.

---

# Runtime adapters

The canonical `.agents/` framework is runtime-neutral.

Runtime adapters provide only:

- native runtime discovery/bootstrap;
- runtime-specific installation guidance;
- skill/plugin/MCP integration boundaries;
- runtime permission and automation guidance;
- compatibility notes specific to that runtime.

They do **not** redefine the canonical delivery protocol.

## Codex

Adapter:

[`.agents/runtime-adapters/codex/README.md`](.agents/runtime-adapters/codex/README.md)

Bootstrap source:

[`.agents/runtime-adapters/codex/AGENTS.md`](.agents/runtime-adapters/codex/AGENTS.md)

Typical materialization:

```text
.agents/runtime-adapters/codex/AGENTS.md
→
./AGENTS.md
```

Existing root Codex instructions must be reconciled rather than overwritten blindly.

Follow the adapter README for `AGENTS.override.md`, configured fallback filenames, instruction-size limits, and verification.

## Claude Code

Adapter:

[`.agents/runtime-adapters/claude/README.md`](.agents/runtime-adapters/claude/README.md)

Bootstrap source:

[`.agents/runtime-adapters/claude/CLAUDE.md`](.agents/runtime-adapters/claude/CLAUDE.md)

Typical materialization:

```text
.agents/runtime-adapters/claude/CLAUDE.md
→
./CLAUDE.md
```

The retained adapter source imports:

```text
@../../AGENTS.md
```

When materialized at repository root, rewrite that import to:

```text
@.agents/AGENTS.md
```

Follow the adapter README for existing Claude instructions, rules, settings, hooks, subagents, memory, added directories, workspace trust, and launch-directory-sensitive configuration.

## Antigravity

Adapter:

[`.agents/runtime-adapters/antigravity/README.md`](.agents/runtime-adapters/antigravity/README.md)

Bootstrap source:

[`.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md`](.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md)

Typical materialization:

```text
.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md
→
.agents/rules/code-agent-workflow.md
```

The retained source filename and the materialized target filename are intentionally different identities.

Configure the materialized Workspace Rule as:

```text
Always On
```

The rule routes to the canonical contract using:

```text
@../AGENTS.md
```

Follow the adapter README for Global Rules, Workspace Rules, legacy rule locations, Projects, JSON Hooks, plugins, permissions, and verification.

---

# Using multiple runtimes

A repository may support more than one runtime at the same time.

For example:

```text
./AGENTS.md
→ Codex bootstrap

./CLAUDE.md
→ Claude bootstrap

.agents/rules/code-agent-workflow.md
→ Antigravity bootstrap
```

Each runtime still routes into the same canonical:

```text
.agents/AGENTS.md
```

Runtime-specific instructions must remain compatible with that shared contract.

When an existing repository already contains native runtime instructions, follow the relevant adapter README and reconcile rather than blindly overwrite them.

---

# Runtime methodology and Superpowers

The framework intentionally does not prescribe one generic engineering methodology.

Runtime-native or externally installed methodologies may be used when appropriate, including:

- brainstorming;
- implementation planning;
- TDD;
- debugging;
- worktree isolation;
- security review;
- code review;
- verification;
- subagent coordination;
- domain-specific skills.

[Superpowers](https://github.com/obra/superpowers) is a recommended optional methodology for supported runtimes.

It remains runtime tooling:

```text
Superpowers / skills / plugins
→ HOW technical work is performed

.agents/
→ WHAT delivery work is authorized
```

A methodology-generated specification, plan, task list, memory entry, or other artifact does not automatically become repository authority.

If runtime methodology conflicts with applicable repository authority, the governing task, approval boundaries, or required stop conditions, the conflict must be surfaced rather than used to weaken delivery governance.

Installation instructions for optional runtime tooling belong in the corresponding runtime-adapter README or the tooling's upstream documentation.

---

# Repository intelligence

Repository-intelligence systems can improve discovery and impact analysis, but they remain derived evidence.

When available:

## Graphify

Use for documentation-oriented discovery and relationship analysis, such as:

- locating relevant business/product/requirement/architecture artifacts;
- narrowing the authoritative document set;
- identifying potentially stale, duplicated, or disconnected documentation.

## Codebase Memory MCP

Use for implementation-oriented discovery, such as:

- symbols and implementations;
- callers and call paths;
- routes and handlers;
- services and persistence boundaries;
- tests;
- dependencies;
- implementation impact;
- existing repository mechanisms.

Derived graphs, indexes, summaries, and retrieval results are not authority.

Material conclusions should be verified against the exact repository source or observed implementation evidence.

Reuse sufficiently fresh indexes and prefer incremental refresh when practical.

---

# Repository context

[`.agents/context/project.md`](.agents/context/project.md) is a generic template in this repository.

When adopted into a target repository, it becomes the root repository orientation and context router.

It may summarize:

- repository identity and purpose;
- intended-authority locations;
- observed implementation-evidence locations;
- top-level architecture and boundaries;
- current delivery state;
- active tasks;
- blocking items;
- accepted baseline;
- scoped context locations;
- verification freshness.

Additional scoped context may be organized however the repository naturally requires:

```text
.agents/context/
├── project.md
├── modules/
├── services/
├── domains/
├── packages/
└── integrations/
```

Only the root `context/project.md` path is standardized.

Scoped physical hierarchy is repository-defined.

Context is supporting and refreshable. It does not replace approved authority.

---

# Adoption

## 1. Review the framework

Before copying it into a repository, read:

1. [`.agents/software-workflow.md`](.agents/software-workflow.md)
2. [`.agents/AGENTS.md`](.agents/AGENTS.md)
3. the runtime adapter you intend to use.

## 2. Copy `.agents/`

Copy the `.agents/` directory into the target repository.

Review path collisions before replacing any existing repository content.

Do not reorganize valid existing business, product, requirement, architecture, or delivery artifacts merely to match this template.

## 3. Populate repository context

Adapt:

```text
.agents/context/project.md
```

to the target repository using verified repository evidence.

Existing repositories should map their current authority and implementation reality rather than starting from fictional greenfield state.

## 4. Install one or more runtime adapters

Choose the runtimes the repository will actually use:

- [Codex](.agents/runtime-adapters/codex/README.md)
- [Claude Code](.agents/runtime-adapters/claude/README.md)
- [Antigravity](.agents/runtime-adapters/antigravity/README.md)

Follow each adapter's installation and reconciliation procedure.

Do not blindly overwrite pre-existing runtime-native instructions.

## 5. Establish the current delivery state

Invoke the Planner/Reviewer procedure:

```text
.agents/prompts/plan-create-task.md
```

The first legitimate outcome might be:

- authority repair;
- approval required;
- context repair;
- execution of an already-published task;
- review of pending implementation;
- bounded remediation;
- publication of a new validated task;
- no delivery action.

Do not assume adoption necessarily starts by creating a new task.

---

# Progressive loading

The framework intentionally avoids loading every document into every role.

## Planner

Normally loads:

```text
.agents/AGENTS.md
.agents/software-workflow.md
.agents/context/project.md
relevant scoped context
relevant authority
.agents/prompts/plan-create-task.md
```

## Reviewer

Normally loads the Planner set plus:

```text
exact governing task revision
implementation baseline
implementation revision / exact review state
verification evidence
available CI
```

## Executor

Normally loads:

```text
.agents/AGENTS.md
exact governing validated task revision
implementation baseline
authority referenced by the task
relevant context
relevant implementation
```

The Executor normally should not reload the full Planner/Reviewer orchestration prompt or redo delivery planning.

This progressive-loading model keeps runtime context focused while preserving governance.

---

# Reuse discipline

The framework uses a simple reuse principle:

> Prefer established repository patterns, boundaries, primitives, and mechanisms over parallel replacements.

Before introducing a new framework, abstraction, service layer, authorization model, persistence mechanism, state machine, queue, transaction mechanism, testing architecture, or similar infrastructure, inspect whether the repository already provides an adequate mechanism.

A new abstraction should arise from a concrete approved delivery need, not speculative generalization.

Preserve unrelated behavior and avoid opportunistic refactoring outside the governing delivery objective.

---

# What this framework intentionally does not define

The canonical protocol does not prescribe:

- a particular AI model;
- a particular coding agent;
- a specific IDE;
- mandatory TDD;
- mandatory brainstorming;
- mandatory subagents;
- mandatory worktrees;
- a specific testing framework;
- mandatory Graphify or Codebase Memory;
- a universal security profile;
- a universal release process;
- mandatory business-document filenames;
- mandatory architecture-document layout;
- mandatory one-file-per-artifact organization.

Repositories and runtimes retain those implementation choices unless approved repository policy constrains them.

---

# Updating the template

The canonical framework and runtime adapters evolve independently.

When changing a canonical artifact:

1. preserve the intended-authority / observed-evidence model;
2. preserve gate semantics;
3. preserve exact task-revision and baseline semantics;
4. preserve acceptance vs release separation;
5. audit affected canonical files for behavioral compatibility;
6. update runtime adapters only when the runtime bootstrap or boundary semantics are actually affected.

When changing a runtime adapter:

1. verify current runtime behavior from the runtime's authoritative documentation;
2. preserve compatibility with canonical `.agents/`;
3. change only runtime-specific behavior;
4. re-audit the adapter before publishing it.

Do not push runtime-specific implementation details back into the canonical protocol unless they reveal a genuinely runtime-neutral delivery requirement.

---

# Design principles

The framework is built around these principles:

1. **Runtime-neutral governance**  
   Delivery authority should survive changes in agent runtime and methodology.

2. **Strict semantics, proportional artifacts**  
   Required concerns are explicit, but document depth should match risk and complexity.

3. **Evidence over assertion**  
   Implementation and verification claims come from observed evidence.

4. **No mandatory restart**  
   Existing repositories reuse valid work and continue from the earliest unreliable gate.

5. **Progressive traceability**  
   Business intent should be traceable toward implementation and evidence as delivery progresses.

6. **Bidirectional traceability**  
   Code, tasks, and tests should also be traceable back to legitimate authority.

7. **Bounded executable work**  
   A validated task defines what implementation may legitimately change.

8. **Immutable review identity**  
   Execution and review remain tied to exact task and implementation revisions.

9. **Bounded remediation**  
   Corrections stay inside the approved objective; materially new work returns to planning.

10. **Acceptance is not release**  
    A9 and G10 remain separate decisions.

11. **Runtime capability is not authorization**  
    Technical ability does not grant delivery authority.

12. **Reuse before invention**  
    Extend repository patterns before creating parallel mechanisms.

---

# License

See [LICENSE](LICENSE).

