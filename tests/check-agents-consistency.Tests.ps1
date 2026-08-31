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

Write-Output 'Software package consistency checker regression tests passed.'
exit 0
