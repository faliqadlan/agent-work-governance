$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$checker = Join-Path $root '.agents/check-consistency.ps1'

if (-not (Test-Path -LiteralPath $checker)) { throw 'Expected consistency checker was not found.' }

function New-Fixture {
    $fixture = Join-Path ([System.IO.Path]::GetTempPath()) ('agents-check-' + [guid]::NewGuid())
    New-Item -ItemType Directory -Path $fixture | Out-Null
    Copy-Item -Recurse -LiteralPath (Join-Path $root '.agents') -Destination $fixture
    Copy-Item -LiteralPath (Join-Path $root 'README.md') -Destination $fixture
    return $fixture
}

function Invoke-FixtureChecker([string]$Fixture) {
    $output = @(& $checker -Root $Fixture 2>&1)
    return [pscustomobject]@{ ExitCode = $LASTEXITCODE; Output = ($output -join "`n") }
}

function Assert-CheckerFails([string]$Fixture, [string]$ExpectedMessage) {
    $result = Invoke-FixtureChecker $Fixture
    if ($result.ExitCode -eq 0 -or $result.Output -notmatch [regex]::Escape($ExpectedMessage)) {
        throw "Expected checker failure containing '$ExpectedMessage'. Exit=$($result.ExitCode) Output=$($result.Output)"
    }
}

& $checker -Root $root
if ($LASTEXITCODE -ne 0) { throw 'The current repository should pass the consistency check.' }

$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.architecture.core.path = '.agents/core-governance.md'
    Remove-Item -LiteralPath (Join-Path $fixture '.agents/core-governance.md')
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Manifest architecture core path '.agents/core-governance.md' does not exist."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.canonical_artifacts = @($manifest.canonical_artifacts | Sort-Object -Property path -Descending)
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    $result = Invoke-FixtureChecker $fixture
    if ($result.ExitCode -ne 0) { throw "Harmless canonical artifact reordering should pass. Output=$($result.Output)" }
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

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

$fixture = New-Fixture
try {
    $antigravityReadmePath = Join-Path $fixture '.agents/runtime-adapters/antigravity/README.md'
    $antigravityReadme = Get-Content -Raw -LiteralPath $antigravityReadmePath
    $antigravityReadme = $antigravityReadme.Replace('runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md', 'runtime-adapters/antigravity/rules/code-agent-workflow.md')
    Set-Content -LiteralPath $antigravityReadmePath -Value $antigravityReadme
    Assert-CheckerFails $fixture "Antigravity retained source depiction uses materialized filename 'code-agent-workflow.md'"
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.runtime_adapters.antigravity.source_files[0] = '.agents/runtime-adapters/antigravity/rules/missing.md'
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Manifest runtime source path '.agents/runtime-adapters/antigravity/rules/missing.md' does not exist."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.canonical_artifacts = @($manifest.canonical_artifacts | Where-Object path -ne '.agents/AGENTS.md')
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Manifest is missing expected canonical artifact '.agents/AGENTS.md'."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $expected = $manifest.canonical_artifacts | Where-Object path -eq '.agents/AGENTS.md'
    $manifest.canonical_artifacts = @($manifest.canonical_artifacts) + $expected
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Manifest contains duplicate canonical artifact identity '.agents/AGENTS.md'."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

$fixture = New-Fixture
try {
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.runtime_adapters.antigravity.bootstrap.source = '.agents/rules/code-agent-workflow.md'
    $manifest.runtime_adapters.antigravity.bootstrap.materialization_target = '.agents/rules/code-agent-workflow.md'
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath
    Assert-CheckerFails $fixture "Runtime adapter 'antigravity' conflates retained source '.agents/rules/code-agent-workflow.md' with materialization target '.agents/rules/code-agent-workflow.md'."
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

$fixture = New-Fixture
try {
    $readmePath = Join-Path $fixture 'README.md'
    $readme = Get-Content -Raw -LiteralPath $readmePath
    $readme = $readme.Replace('| `prompts/plan-create-task.md` | 2.4 |', '| `prompts/plan-create-task.md` | 2.3 |')
    Set-Content -LiteralPath $readmePath -Value $readme
    Assert-CheckerFails $fixture "README version for 'prompts/plan-create-task.md'"
} finally { if (Test-Path -LiteralPath $fixture) { Remove-Item -Recurse -Force -LiteralPath $fixture } }

Write-Output 'Consistency checker regression tests passed.'
exit 0
