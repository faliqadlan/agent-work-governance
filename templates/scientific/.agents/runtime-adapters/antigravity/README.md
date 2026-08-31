---
title: Antigravity Runtime Adapter Setup for Scientific Research
document_id: SCI-RUNTIME-ANTIGRAVITY-README-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-31
runtime: Antigravity
scope:
  - Antigravity adapter installation for scientific research
  - rules configuration
  - methodology integration
authority_note: This document explains runtime adapter setup. It is not repository authority and MUST NOT override .agents/AGENTS.md, .agents/research-governance.md, or the governing research task.
---

# Antigravity Runtime Adapter Setup for Scientific Research

This directory contains the Antigravity runtime adapter for the Scientific Research Governance package.

## Retained source and materialization target

- **Retained source:** `.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md`
- **Materialization target:** `.agents/rules/code-agent-workflow.md`

## Setup

To enable Antigravity in a target scientific repository:

1. Copy `.agents/runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md` to `.agents/rules/code-agent-workflow.md`.
2. Configure this rule as **Always On** in Antigravity.
3. Verify that the rule imports or references [`.agents/AGENTS.md`](.agents/AGENTS.md).

Typical resulting repository:

```text
.agents/
├── AGENTS.md
├── research-governance.md
├── rules/
│   └── code-agent-workflow.md
└── runtime-adapters/
    └── antigravity/
        ├── README.md
        └── rules/
            └── antigravity-code-agent-workflow.md
```
