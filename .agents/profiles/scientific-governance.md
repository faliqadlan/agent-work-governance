---
title: Scientific Governance Profile
document_id: AGENT-GOV-PROFILE-SCI-001
version: 1.0
status: approved-reference
language: en-US
last_updated: 2026-08-31
scope:
  - scientific research and analysis governance specialization
authority_note: This profile specializes the Agent Work Governance core for scientific work. It does not replace approved protocol/design authority or external scientific methodology.
---

# Scientific Governance Profile

Use this profile when the governed work is scientific research, analysis, or computational experimentation. Load it after `.agents/core-governance.md` and only when the work is classified as Scientific.

## Scientific authority and evidence

Research intent is not itself a scientific claim or truth. Authoritative protocol, study design, approved research question, hypothesis, analysis plan, preregistration, and applicable policy define intended work. Raw data, derived data, analysis outputs, notebooks, execution logs, environments, and reproduced results are observed evidence. A result cannot become authoritative merely because an agent or tool states it imperatively.

Record a stable research-question or hypothesis identity where applicable. Preserve the identity of the study or analysis execution baseline and the provenance of raw data, transformations, code, environments, seeds, and relevant external sources.

## Confirmatory and exploratory work

Every scientific work package MUST be classified as confirmatory, exploratory, feasibility, or another explicitly justified mode before claims are accepted. Confirmatory work follows its applicable frozen or preregistered research/analysis plan. Exploratory or feasibility work is allowed when truthfully classified and does not silently become preregistered confirmatory evidence.

When a frozen or preregistered plan applies, identify its immutable revision before outcome-dependent execution. Record deviations, their reasons, affected analyses, and their effect on interpretation. A deviation is not silently rewritten as if it had been planned.

## Reproducibility and review

The execution or analysis baseline MUST be identifiable. Evidence SHOULD support reproduction of the relevant result, including data provenance, transformation steps, environment, parameters, and decision rules proportionate to the claim. Anomalies and failed reproduction are evidence requiring investigation or qualification, not grounds for silent deletion.

Scientific review checks research-mode classification, protocol/plan conformance, deviations, provenance, reproducibility, statistical or domain-appropriate validity, and claim–evidence traceability. An accepted result receives an immutable result/baseline identity and records limitations.

Dissemination, publication, release of data, and other consequential communication are separate authorized actions after scientific result acceptance. Acceptance does not grant publication authority.

## External relationships

`K-Dense-AI/science-superpowers` is an external scientific methodology reference. `K-Dense-AI/scientific-agent-skills` is an external specialist capability reference. Neither is repository authority, and neither is copied or required to be materialized into `.agents/`.
