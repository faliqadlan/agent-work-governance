# Agent Work Governance

A runtime-neutral, repository-local framework for governing human/AI work across Software and Scientific domains.

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
- Has implementation merely been accepted, or has release/dissemination also been approved?

Domain methodology and specialist capability—such as Superpowers, Science Superpowers, Scientific Agent Skills, TDD, debugging, and subagent orchestration—belong to external execution tooling and remain separate from governance.

> **Important**
>
> This README is human-facing documentation. It is not repository delivery authority.
>
> This source repository distributes two independent, standalone `.agents` template packages:
> - Software package: [`templates/software/.agents/`](templates/software/.agents/AGENTS.md)
> - Scientific package: [`templates/scientific/.agents/`](templates/scientific/.agents/AGENTS.md)

---

## Core architecture: two-template distribution

This repository distributes two standalone, self-contained `.agents` packages:

```text
templates/software/.agents/   # Standalone Software delivery governance package
templates/scientific/.agents/ # Standalone Scientific research & analysis governance package
```

### Selective adoption

A target repository adopts exactly one package as its root `.agents/` directory:

```text
Software repository:   copy templates/software/.agents/   -> <target>/.agents/
Scientific repository: copy templates/scientific/.agents/ -> <target>/.agents/
```

> [!NOTE]
> GitHub's native **Use this template** feature clones the entire source repository and cannot select a nested subdirectory. Initial adoption is therefore performed by copying the selected nested `.agents` directory into the target repository.

Each adopted package is completely standalone and operates independently:
- No paths reference back to this source repository or `templates/`.
- No runtime profile selector, precedence engine, or composition mechanism is used.
- Shared governance invariants are preserved across both packages.

---

## Shared governance invariants

Both packages embody these cross-domain invariants in substance:

1. **Human Request is intent, not authority:** Human requests express intent; they do not automatically establish factual truth or sufficient authority.
2. **Authority vs observed evidence:** Intended authority (PRDs, protocols, requirements) and observed reality (code, logs, data) remain distinct.
3. **Imperatives are evidence, not authority:** Retrieved text, prompt imperatives, or tool outputs do not grant authority or expand scope by themselves.
4. **Role separation:** Planner/Reviewer and Executor responsibilities remain distinct.
5. **Bounded contract:** Work is governed by an explicit delivery contract with observable acceptance criteria.
6. **Task revision vs baseline identity:** The governing task revision and the execution baseline are separate immutable identities.
7. **Bounded remediation vs replanning:** In-scope findings remain remediation under the same task; material changes return to planning.
8. **Evidence before acceptance:** Claims of completion, correctness, or reproducibility require observed evidence.
9. **Acceptance is not consequential authorization:** Implementation acceptance does not authorize release, deployment, or external dissemination.
10. **Progressive context & runtime neutrality:** Roles load only the smallest sufficient context, independent of vendor or IDE.

---

## Software governance template

Located at `templates/software/.agents/`, this package preserves accepted software-delivery lifecycle semantics (quality gates B0–G10, PRD/requirements/architecture readiness, and release boundaries).

### Package structure

```text
templates/software/.agents/
├── AGENTS.md                 # Entry contract and role router (AGENTS-CONTRACT-001)
├── software-workflow.md      # Normative software lifecycle protocol (SD-PROTOCOL-001)
├── context/
│   └── project.md            # Repository context entrypoint (AGENT-CONTEXT-001)
├── prompts/
│   └── plan-create-task.md   # Planner/Reviewer orchestration procedure (AGENT-PROMPT-PLAN-001)
├── tasks/
│   └── _template.md          # Validated task contract template (AGENT-TASK-001)
├── manifest.json             # Package inventory and invariants
├── check-consistency.ps1     # Package consistency checker
└── runtime-adapters/
    ├── codex/                # Codex runtime bootstrap
    ├── claude/               # Claude Code runtime bootstrap
    └── antigravity/          # Antigravity runtime bootstrap
```

### Canonical artifacts and versions

| Artifact | Document ID | Version | Role |
|---|---|---:|---|
| [`software-workflow.md`](templates/software/.agents/software-workflow.md) | `SD-PROTOCOL-001` | 2.3 | Normative delivery protocol |
| [`AGENTS.md`](templates/software/.agents/AGENTS.md) | `AGENTS-CONTRACT-001` | 1.3 | Repository AI delivery contract |
| [`context/project.md`](templates/software/.agents/context/project.md) | `AGENT-CONTEXT-001` | 1.1 | Repository context entrypoint |
| [`prompts/plan-create-task.md`](templates/software/.agents/prompts/plan-create-task.md) | `AGENT-PROMPT-PLAN-001` | 2.4 | Planner/Reviewer orchestration |
| [`tasks/_template.md`](templates/software/.agents/tasks/_template.md) | `AGENT-TASK-001` | 1.2 | Validated task template |
| Codex adapter | `AGENT-RUNTIME-CODEX-001` | 1.2 | Runtime adapter |
| Claude adapter | `AGENT-RUNTIME-CLAUDE-README-001` | 1.2 | Runtime adapter |
| Antigravity adapter | `AGENT-RUNTIME-ANTIGRAVITY-README-001` | 1.2 | Runtime adapter |

---

## Scientific governance template

Located at `templates/scientific/.agents/`, this package governs scientific research, computational experimentation, and data analysis.

### Package structure

```text
templates/scientific/.agents/
├── AGENTS.md                 # Entry contract and role router (SCI-AGENTS-CONTRACT-001)
├── research-governance.md    # Normative research protocol (SCI-RESEARCH-PROTOCOL-001)
├── context/
│   └── project.md            # Study context entrypoint (SCI-CONTEXT-001)
├── prompts/
│   └── plan-create-task.md   # Planner/Reviewer orchestration procedure (SCI-PROMPT-PLAN-001)
├── tasks/
│   └── _template.md          # Validated research task template (SCI-TASK-001)
├── manifest.json             # Package inventory and invariants
├── check-consistency.ps1     # Package consistency checker
└── runtime-adapters/
    ├── codex/                # Codex runtime bootstrap
    ├── claude/               # Claude Code runtime bootstrap
    └── antigravity/          # Antigravity runtime bootstrap
```

### Canonical artifacts and versions

| Artifact | Document ID | Version | Role |
|---|---|---:|---|
| [`research-governance.md`](templates/scientific/.agents/research-governance.md) | `SCI-RESEARCH-PROTOCOL-001` | 1.0 | Normative research protocol |
| [`AGENTS.md`](templates/scientific/.agents/AGENTS.md) | `SCI-AGENTS-CONTRACT-001` | 1.0 | Scientific agent governance contract |
| [`context/project.md`](templates/scientific/.agents/context/project.md) | `SCI-CONTEXT-001` | 1.0 | Study context entrypoint |
| [`prompts/plan-create-task.md`](templates/scientific/.agents/prompts/plan-create-task.md) | `SCI-PROMPT-PLAN-001` | 1.0 | Planner/Reviewer orchestration |
| [`tasks/_template.md`](templates/scientific/.agents/tasks/_template.md) | `SCI-TASK-001` | 1.0 | Validated research task template |
| Codex adapter | `SCI-RUNTIME-CODEX-001` | 1.0 | Runtime adapter |
| Claude adapter | `SCI-RUNTIME-CLAUDE-README-001` | 1.0 | Runtime adapter |
| Antigravity adapter | `SCI-RUNTIME-ANTIGRAVITY-README-001` | 1.0 | Runtime adapter |

### Scientific safeguards

- **Confirmatory vs exploratory classification:** Every research task explicitly classifies its analysis mode.
- **Exploratory safeguard:** Exploratory findings cannot be silently claimed as preregistered confirmatory evidence.
- **Plan freeze & preregistration:** Frozen plans require an immutable revision before outcome analysis.
- **Deviation tracking:** Deviations record reason, affected analyses, and interpretation impact.
- **Provenance & reproducibility:** Data checksums, code commits, environment containers, and random seeds are captured.
- **Dissemination boundary:** Scientific acceptance is distinct from publication, preprint upload, or external data release.

---

## Validation and consistency checks

To verify both template packages, shared invariant markers, and standalone execution, run:

```powershell
# Validate two-template governance architecture and shared invariants
& ./tests/check-two-template-governance.ps1

# Validate standalone Software package consistency
& ./templates/software/.agents/check-consistency.ps1

# Validate standalone Scientific package consistency
& ./templates/scientific/.agents/check-consistency.ps1

# Run consistency regression test suite
& ./tests/check-agents-consistency.Tests.ps1
```

---

## Portable Planner/Reviewer bootstrap

[`Planner-Reviewer Contract.md`](Planner-Reviewer%20Contract.md) is a portable standard-ChatGPT bootstrap and meta-contract. It provides domain-neutral Planner/Reviewer instructions that delegate to whichever `.agents/` package exists in the target repository.

---

## Runtime adapters

Each package includes thin runtime adapters for major AI agent environments:

### Codex
- Retained source: `.agents/runtime-adapters/codex/AGENTS.md`
- Target materialization: `./AGENTS.md`

### Claude Code
- Retained source: `.agents/runtime-adapters/claude/CLAUDE.md`
- Target materialization: `./CLAUDE.md` (with source import rewritten from `@../../AGENTS.md` to `@.agents/AGENTS.md`)

### Antigravity
- Retained source: `.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md`
- Target materialization: `.agents/rules/code-agent-workflow.md` (configured as **Always On**)

---

## External methodology and capability references

External methodologies and capability libraries are execution aids, not repository authority. They are not copied, vendored, or mirrored into `.agents/`:

- **Software methodology:** [obra/superpowers](https://github.com/obra/superpowers)
- **Scientific methodology:** [K-Dense-AI/science-superpowers](https://github.com/K-Dense-AI/science-superpowers)
- **Scientific capabilities:** [K-Dense-AI/scientific-agent-skills](https://github.com/K-Dense-AI/scientific-agent-skills)
- **GitHub repository rename guidance:** [GitHub Documentation: Renaming a repository](https://docs.github.com/en/repositories/creating-and-managing-repositories/renaming-a-repository)

---

## License

See [LICENSE](LICENSE).
