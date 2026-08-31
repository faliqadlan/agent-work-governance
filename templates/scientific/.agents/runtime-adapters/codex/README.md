---
title: Codex Runtime Adapter Setup for Scientific Research
document_id: SCI-RUNTIME-CODEX-README-001
version: 1.0
status: approved-template
language: en-US
last_updated: 2026-08-31
runtime: Codex
scope:
  - Codex adapter installation for scientific research
  - materialization reconciliation
  - methodology integration
authority_note: This document explains runtime adapter setup. It is not repository authority and MUST NOT override .agents/AGENTS.md, .agents/research-governance.md, or the governing research task.
---

# Codex Runtime Adapter Setup for Scientific Research

This directory contains the Codex runtime adapter for the Scientific Research Governance package.

## Files

- `AGENTS.md`: The adapter bootstrap file.

## Setup

To enable Codex in a target scientific repository:

1. Copy `.agents/runtime-adapters/codex/AGENTS.md` to `AGENTS.md` in the repository root.
2. Verify that `AGENTS.md` links correctly to `.agents/AGENTS.md`.
3. Follow the canonical progressive-loading protocol defined in [`.agents/AGENTS.md`](.agents/AGENTS.md).
