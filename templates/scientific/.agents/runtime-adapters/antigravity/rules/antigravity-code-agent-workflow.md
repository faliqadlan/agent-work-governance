<!-- runtime-adapter: antigravity | version: 1.0 | status: approved-template -->

# Scientific Research Agent Workflow Bootstrap for Antigravity

This workspace rule connects Antigravity to the repository-local, runtime-neutral Scientific Research Governance contract under `.agents/`.

Configure this rule as **Always On** when materialized at:

```text
.agents/rules/code-agent-workflow.md
```

## Canonical routing

The canonical repository contract is:

- [`.agents/AGENTS.md`](.agents/AGENTS.md)

Use `.agents/AGENTS.md` for role routing and progressive loading.

`.agents/research-governance.md` remains the normative research governance protocol.

When acting as Planner or Reviewer, follow the canonical loading rules and use:

- [`.agents/prompts/plan-create-task.md`](.agents/prompts/plan-create-task.md)

## Methodology and specialist capability boundaries

External methodologies (such as `K-Dense-AI/science-superpowers`) and specialist capabilities (such as `K-Dense-AI/scientific-agent-skills`) are execution aids.

Runtime methodology remains subordinate to:
1. applicable human and study authority;
2. `.agents/research-governance.md`;
3. `.agents/AGENTS.md`;
4. the exact governing validated task when executing;
5. applicable approval, permission, privacy, and side-effect boundaries.
