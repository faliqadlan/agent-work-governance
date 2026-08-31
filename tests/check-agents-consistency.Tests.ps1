$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$softwareAgents = Join-Path $root 'templates/software/.agents'

if (-not (Test-Path -LiteralPath $softwareAgents)) { throw 'Expected Software package was not found.' }

function New-Fixture {
    $fixture = Join-Path ([System.IO.Path]::GetTempPath()) ('agents-check-' + [guid]::NewGuid())
    New-Item -ItemType Directory -Path $fixture | Out-Null
    Copy-Item -Recurse -LiteralPath $softwareAgents -Destination (Join-Path $fixture '.agents')
    return $fixture
}

function Invoke-FixtureChecker([string]$Fixture) {
    $checker = Join-Path $Fixture '.agents/check-consistency.ps1'
    $output = @(& $checker -Root (Join-Path $Fixture '.agents') 2>&1)
    return [pscustomobject]@{ ExitCode = $LASTEXITCODE; Output = ($output -join "`n") }
}

function Assert-CheckerFails([string]$Fixture, [string]$ExpectedMessage) {
    $result = Invoke-FixtureChecker $Fixture
    if ($result.ExitCode -eq 0 -or $result.Output -notmatch [regex]::Escape($ExpectedMessage)) {
        throw "Expected checker failure containing '$ExpectedMessage'. Exit=$($result.ExitCode) Output=$($result.Output)"
    }
}

# 1. Base check should pass
$baseResult = Invoke-FixtureChecker (Join-Path $root 'templates/software')
if ($baseResult.ExitCode -ne 0) { throw "Software package should pass consistency check. Output=$($baseResult.Output)" }

# 2. Canonical artifact reordering should pass
$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.canonical_artifacts = @($manifest.canonical_artifacts | Sort-Object -Property path -Descending)
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    $result = Invoke-FixtureChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Harmless canonical artifact reordering should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 3. Antigravity tree entry with materialized filename should fail
$fixture = New-Fixture
try {
    $antigravityReadmePath = Join-Path $fixture '.agents/runtime-adapters/antigravity/README.md'
    $antigravityReadme = Get-Content -Raw -LiteralPath $antigravityReadmePath
    $validTreeEntry = '    │           └── antigravity-code-agent-workflow.md'
    $invalidTreeEntry = '    │           └── code-agent-workflow.md'
    $antigravityReadme = $antigravityReadme.Replace($validTreeEntry, $invalidTreeEntry)
    Set-Content -LiteralPath $antigravityReadmePath -Value $antigravityReadme
    Assert-CheckerFails $fixture "Antigravity retained source depiction uses materialized filename 'code-agent-workflow.md'"

    $antigravityReadme = $antigravityReadme.Replace($invalidTreeEntry, $validTreeEntry)
    Set-Content -LiteralPath $antigravityReadmePath -Value $antigravityReadme
    $result = Invoke-FixtureChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored valid Antigravity tree should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 4. Antigravity rule path pointing to code-agent-workflow.md should fail
$fixture = New-Fixture
try {
    $antigravityReadmePath = Join-Path $fixture '.agents/runtime-adapters/antigravity/README.md'
    $antigravityReadme = Get-Content -Raw -LiteralPath $antigravityReadmePath
    $antigravityReadme = $antigravityReadme.Replace('runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md', 'runtime-adapters/antigravity/rules/code-agent-workflow.md')
    Set-Content -LiteralPath $antigravityReadmePath -Value $antigravityReadme
    Assert-CheckerFails $fixture "Antigravity retained source depiction uses materialized filename 'code-agent-workflow.md'"
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 5. Missing runtime source file in manifest should fail
$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.runtime_adapters.antigravity.source_files[0] = '.agents/runtime-adapters/antigravity/rules/missing.md'
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Manifest runtime source path '.agents/runtime-adapters/antigravity/rules/missing.md' does not exist."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 6. Missing canonical artifact in manifest should fail
$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.canonical_artifacts = @($manifest.canonical_artifacts | Where-Object path -ne '.agents/AGENTS.md')
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Manifest is missing expected canonical artifact '.agents/AGENTS.md'."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 7. Duplicate canonical artifact in manifest should fail
$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $expected = $manifest.canonical_artifacts | Where-Object path -eq '.agents/AGENTS.md'
    $manifest.canonical_artifacts = @($manifest.canonical_artifacts) + $expected
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Manifest contains duplicate canonical artifact identity '.agents/AGENTS.md'."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 8. Conflating bootstrap source and materialization target should fail
$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.runtime_adapters.antigravity.bootstrap.source = '.agents/rules/code-agent-workflow.md'
    $manifest.runtime_adapters.antigravity.bootstrap.materialization_target = '.agents/rules/code-agent-workflow.md'
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Runtime adapter 'antigravity' conflates retained source '.agents/rules/code-agent-workflow.md' with materialization target '.agents/rules/code-agent-workflow.md'."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 9. Scientific package base check should pass
$scientificAgents = Join-Path $root 'templates/scientific/.agents'
if (-not (Test-Path -LiteralPath $scientificAgents)) { throw 'Expected Scientific package was not found.' }
$sciChecker = Join-Path $scientificAgents 'check-consistency.ps1'
$sciResult = @(& $sciChecker -Root $scientificAgents 2>&1)
if ($LASTEXITCODE -ne 0) { throw "Scientific package should pass consistency check. Output=$($sciResult -join "`n")" }

# ==============================================================================
# Repository-Level Two-Template Governance Regressions (AWG-R1 and AWG-R2)
# ==============================================================================

$twoTemplateChecker = Join-Path $root 'tests/check-two-template-governance.ps1'
if (-not (Test-Path -LiteralPath $twoTemplateChecker)) { throw 'Expected check-two-template-governance.ps1 was not found.' }

function New-RepoFixture {
    $fixture = Join-Path ([System.IO.Path]::GetTempPath()) ('repo-check-' + [guid]::NewGuid())
    New-Item -ItemType Directory -Path $fixture | Out-Null
    $softDir = Join-Path $fixture 'templates/software/.agents'
    $sciDir = Join-Path $fixture 'templates/scientific/.agents'
    $rootAgentsDir = Join-Path $fixture '.agents'
    New-Item -ItemType Directory -Path (Join-Path $fixture 'templates/software') -Force | Out-Null
    New-Item -ItemType Directory -Path (Join-Path $fixture 'templates/scientific') -Force | Out-Null
    Copy-Item -Recurse -LiteralPath (Join-Path $root 'templates/software/.agents') -Destination $softDir
    Copy-Item -Recurse -LiteralPath (Join-Path $root 'templates/scientific/.agents') -Destination $sciDir
    Copy-Item -Recurse -LiteralPath (Join-Path $root '.agents') -Destination $rootAgentsDir
    Copy-Item -LiteralPath (Join-Path $root 'README.md') -Destination (Join-Path $fixture 'README.md')
    return $fixture
}

function Invoke-RepoChecker([string]$Fixture) {
    $output = @(& $twoTemplateChecker -Root $Fixture 2>&1)
    return [pscustomobject]@{ ExitCode = $LASTEXITCODE; Output = ($output -join "`n") }
}

function Assert-RepoCheckerFails([string]$Fixture, [string]$ExpectedMessage) {
    $result = Invoke-RepoChecker $Fixture
    if ($result.ExitCode -eq 0 -or $result.Output -notmatch [regex]::Escape($ExpectedMessage)) {
        throw "Expected repo checker failure containing '$ExpectedMessage'. Exit=$($result.ExitCode) Output=$($result.Output)"
    }
}

# 10. Base repo-level check should pass
$baseRepoResult = Invoke-RepoChecker $root
if ($baseRepoResult.ExitCode -ne 0) { throw "Base repository should pass two-template governance check. Output=$($baseRepoResult.Output)" }

# 11. AWG-R1: Software invariant broken substantively while manifest marker remains should fail
$fixture = New-RepoFixture
try {
    $agentsPath = Join-Path $fixture 'templates/software/.agents/AGENTS.md'
    $workflowPath = Join-Path $fixture 'templates/software/.agents/software-workflow.md'
    $origAgents = Get-Content -Raw -LiteralPath $agentsPath
    $origWorkflow = Get-Content -Raw -LiteralPath $workflowPath

    # Break substantive evidence for authority-vs-evidence across Software canonical governance without changing manifest
    $brokenAgents = $origAgents -replace '(?i)intended\s+authority', 'unified intent' -replace '(?i)observed\s+(implementation\s+reality|evidence)', 'actual code'
    $brokenWorkflow = $origWorkflow -replace '(?i)intended\s+authority', 'unified intent' -replace '(?i)observed\s+(implementation\s+reality|evidence)', 'actual code'
    Set-Content -LiteralPath $agentsPath -Value $brokenAgents
    Set-Content -LiteralPath $workflowPath -Value $brokenWorkflow
    Assert-RepoCheckerFails $fixture "Software package canonical governance is missing substantive evidence for invariant 'authority-vs-evidence'"

    # Restore valid content
    Set-Content -LiteralPath $agentsPath -Value $origAgents
    Set-Content -LiteralPath $workflowPath -Value $origWorkflow
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored Software invariant substantive evidence should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 12. AWG-R1: Scientific invariant broken substantively while manifest marker remains should fail
$fixture = New-RepoFixture
try {
    $agentsPath = Join-Path $fixture 'templates/scientific/.agents/AGENTS.md'
    $govPath = Join-Path $fixture 'templates/scientific/.agents/research-governance.md'
    $origAgents = Get-Content -Raw -LiteralPath $agentsPath
    $origGov = Get-Content -Raw -LiteralPath $govPath

    # Break substantive evidence for acceptance-not-consequential-authorization in both files
    $brokenAgents = $origAgents -replace '(?i)acceptance.*?dissemination', 'acceptance allows publication'
    $brokenGov = $origGov -replace '(?i)acceptance.*?dissemination', 'acceptance allows publication'
    Set-Content -LiteralPath $agentsPath -Value $brokenAgents
    Set-Content -LiteralPath $govPath -Value $brokenGov
    Assert-RepoCheckerFails $fixture "Scientific package canonical governance is missing substantive evidence for invariant 'acceptance-not-consequential-authorization'"

    # Restore valid content
    Set-Content -LiteralPath $agentsPath -Value $origAgents
    Set-Content -LiteralPath $govPath -Value $origGov
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored Scientific invariant substantive evidence should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 13. AWG-R1: Role separation invariant broken in Scientific package should fail
$fixture = New-RepoFixture
try {
    $agentsPath = Join-Path $fixture 'templates/scientific/.agents/AGENTS.md'
    $origAgents = Get-Content -Raw -LiteralPath $agentsPath
    $brokenAgents = $origAgents -replace '(?i)Planner,\s+Executor,\s+and\s+Reviewer\s+are\s+logical\s+responsibilities', 'Unified single agent performs all roles with no distinct responsibilities'
    Set-Content -LiteralPath $agentsPath -Value $brokenAgents
    Assert-RepoCheckerFails $fixture "Scientific package canonical governance is missing substantive evidence for invariant 'planner-reviewer-executor'"

    Set-Content -LiteralPath $agentsPath -Value $origAgents
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored Scientific role separation evidence should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 14. AWG-R2: Dynamic README version drift mutation fixture
$fixture = New-RepoFixture
try {
    $manifestPath = Join-Path $fixture 'templates/software/.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $targetArtifact = $manifest.canonical_artifacts | Where-Object path -eq '.agents/prompts/plan-create-task.md'
    $currentVersion = [string]$targetArtifact.version
    $docId = [string]$targetArtifact.document_id

    $readmePath = Join-Path $fixture 'README.md'
    $readmeContent = Get-Content -Raw -LiteralPath $readmePath

    # Locate the target entry in Software section and verify exactly one match
    $searchPattern = '(?m)^\|\s*\[`?[^`\]]+`?\]\([^)]*prompts/plan-create-task\.md[^)]*\)\s*\|\s*`?' + [regex]::Escape($docId) + '`?\s*\|\s*' + [regex]::Escape($currentVersion) + '\s*\|\s*[^|]+\s*\|'
    $matches = [regex]::Matches($readmeContent, $searchPattern)
    if ($matches.Count -ne 1) {
        throw "Expected exactly 1 match for prompts/plan-create-task.md in README before mutation, got $($matches.Count)."
    }

    # Dynamically derive an invalid version different from the current version
    $invalidVersion = "$currentVersion.99-drift-test"
    $origLine = $matches[0].Value
    $invalidLine = $origLine.Replace(" $currentVersion ", " $invalidVersion ")
    $mutatedReadme = $readmeContent.Replace($origLine, $invalidLine)
    Set-Content -LiteralPath $readmePath -Value $mutatedReadme

    Assert-RepoCheckerFails $fixture "README version for Software artifact '.agents/prompts/plan-create-task.md' ($docId) is '$invalidVersion', but manifest declares '$currentVersion'."

    # Restore valid README
    Set-Content -LiteralPath $readmePath -Value $readmeContent
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored valid README should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 15. AWG-R2: Missing mirrored README entry should fail
$fixture = New-RepoFixture
try {
    $readmePath = Join-Path $fixture 'README.md'
    $readmeContent = Get-Content -Raw -LiteralPath $readmePath
    $targetLine = [regex]::Match($readmeContent, '(?m)^.*prompts/plan-create-task\.md.*$').Value
    if (-not $targetLine) { throw "Could not find plan-create-task.md line in README." }
    $mutatedReadme = $readmeContent.Replace($targetLine + "`r`n", '').Replace($targetLine + "`n", '')
    Set-Content -LiteralPath $readmePath -Value $mutatedReadme

    Assert-RepoCheckerFails $fixture "README is missing mirrored version entry for Software canonical artifact '.agents/prompts/plan-create-task.md'"
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 16. AWG-R2: Duplicate mirrored README entry should fail
$fixture = New-RepoFixture
try {
    $readmePath = Join-Path $fixture 'README.md'
    $readmeContent = Get-Content -Raw -LiteralPath $readmePath
    $targetLine = [regex]::Match($readmeContent, '(?m)^.*prompts/plan-create-task\.md.*$').Value
    if (-not $targetLine) { throw "Could not find plan-create-task.md line in README." }
    $mutatedReadme = $readmeContent.Replace($targetLine, "$targetLine`n$targetLine")
    Set-Content -LiteralPath $readmePath -Value $mutatedReadme

    Assert-RepoCheckerFails $fixture "README contains multiple (2) mirrored version entries for Software canonical artifact '.agents/prompts/plan-create-task.md'"
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# ==============================================================================
# AWG-R3: Live Root Governance Stale References Regression Tests
# ==============================================================================

# 17. AWG-R3: Stale core-governance.md reference in live root prompt should fail
$fixture = New-RepoFixture
try {
    $promptPath = Join-Path $fixture '.agents/prompts/plan-create-task.md'
    $origPrompt = Get-Content -Raw -LiteralPath $promptPath
    $mutatedPrompt = $origPrompt.Replace('2. `.agents/software-workflow.md`;', "2. `.agents/core-governance.md`;`n3. `.agents/software-workflow.md`;")
    Set-Content -LiteralPath $promptPath -Value $mutatedPrompt

    Assert-RepoCheckerFails $fixture "Root governance file '.agents/prompts/plan-create-task.md' contains forbidden stale reference 'core-governance.md'."

    # Restore valid prompt
    Set-Content -LiteralPath $promptPath -Value $origPrompt
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored root plan-create-task.md should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 18. AWG-R3: Stale profiles/ reference in live root project context should fail
$fixture = New-RepoFixture
try {
    $projectPath = Join-Path $fixture '.agents/context/project.md'
    $origProject = Get-Content -Raw -LiteralPath $projectPath
    $mutatedProject = $origProject.Replace('Use the canonical gate states from `.agents/software-workflow.md`:', "Use the canonical gate states from `.agents/profiles/scientific-governance.md`:")
    Set-Content -LiteralPath $projectPath -Value $mutatedProject

    Assert-RepoCheckerFails $fixture "Root governance file '.agents/context/project.md' contains forbidden stale reference 'profiles/'."

    # Restore valid project context
    Set-Content -LiteralPath $projectPath -Value $origProject
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored root project.md should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 19. AWG-R3: Stale selected profile reference in live root runtime adapter should fail
$fixture = New-RepoFixture
try {
    $codexAgentsPath = Join-Path $fixture '.agents/runtime-adapters/codex/AGENTS.md'
    $origCodexAgents = Get-Content -Raw -LiteralPath $codexAgentsPath
    $mutatedCodexAgents = $origCodexAgents.Replace('2. `.agents/software-workflow.md`;', '2. `.agents/core-governance.md` and the relevant selected profile;')
    Set-Content -LiteralPath $codexAgentsPath -Value $mutatedCodexAgents

    Assert-RepoCheckerFails $fixture "Root governance file '.agents/runtime-adapters/codex/AGENTS.md' contains forbidden stale reference 'selected profile'."

    # Restore valid adapter
    Set-Content -LiteralPath $codexAgentsPath -Value $origCodexAgents
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored root codex AGENTS.md should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

# 20. AWG-R3: Stale transition-inventory role in live root manifest should fail
$fixture = New-RepoFixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $origManifest = Get-Content -Raw -LiteralPath $manifestPath
    $mutatedManifest = $origManifest.Replace('"manifest_role": "repository-governance"', '"manifest_role": "transition-inventory"')
    Set-Content -LiteralPath $manifestPath -Value $mutatedManifest

    Assert-RepoCheckerFails $fixture "Root governance file '.agents/manifest.json' contains forbidden stale reference 'transition-inventory'."

    # Restore valid manifest
    Set-Content -LiteralPath $manifestPath -Value $origManifest
    $result = Invoke-RepoChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Restored root manifest.json should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

Write-Output 'All consistency checker and two-template governance regression tests passed.'
exit 0
