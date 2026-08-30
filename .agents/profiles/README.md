# Governance profile selection

An adopted repository has one `.agents/` control plane. The core is always loaded; exactly the profile(s) relevant to the governed work are selected by the repository's adoption metadata or task classification.

| Profile | Select when | Profile-owned semantics |
|---|---|---|
| Software | Software delivery is governed | product/requirements/architecture readiness, executable implementation tasks, E6/V7/R8/A9 lifecycle, implementation acceptance, and release separation in `.agents/software-workflow.md` |
| Scientific | Research or scientific analysis is governed | research-question identity, protocol and plan authority, confirmatory/exploratory classification, preregistration/frozen plans, provenance, reproducibility, deviations, claim traceability, and dissemination separation in `scientific-governance.md` |

Selection precedence is: applicable human and approved repository authority, the published governing task and its classification, then this profile routing metadata. A profile cannot override the core, repository authority, or task side-effect boundaries. Unselected profiles need not be loaded into context.

Superpowers, Science Superpowers, Scientific Agent Skills, and the Open Agent Skills specification remain external references. They are not copied, vendored, or made authoritative by profile selection.

## Adoption from the current software-only layout

Keep the existing `.agents/` tree and treat `.agents/AGENTS.md` as the runtime-neutral entry contract. Add the core and profile metadata, retain `.agents/software-workflow.md` as the Software profile, and select Scientific only for scientific work. Existing runtime adapters continue to materialize their thin bootstrap into the same `.agents/` control plane. Do not create `.agents-software/`, `.agents-scientific/`, or a second governance tree.
