---
title: Claude Code Runtime Adapter Setup for Scientific Research
document_id: SCI-RUNTIME-CLAUDE-README-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-31
runtime: Claude Code
scope:
  - Claude Code adapter installation for scientific research
  - materialization reconciliation
  - methodology integration
authority_note: This document explains runtime adapter setup. It is not repository authority and MUST NOT override .agents/AGENTS.md, .agents/research-governance.md, or the governing research task.
---

# Claude Code Runtime Adapter Setup for Scientific Research

This directory contains the Claude Code runtime adapter for the Scientific Research Governance package.

## Files

- `CLAUDE.md`: The adapter bootstrap file.

## Setup

To enable Claude Code in a target scientific repository:

1. Copy `.agents/runtime-adapters/claude/CLAUDE.md` to `CLAUDE.md` in the repository root.
2. In the copied `CLAUDE.md`, rewrite the import from `@../../AGENTS.md` to `@.agents/AGENTS.md`.
3. Verify that `CLAUDE.md` imports `.agents/AGENTS.md` cleanly.
