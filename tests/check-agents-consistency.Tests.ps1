$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$checker = Join-Path $root '.agents/check-consistency.ps1'

if (-not (Test-Path -LiteralPath $checker)) {
    throw 'Expected consistency checker was not found.'
}

& $checker -Root $root
if ($LASTEXITCODE -ne 0) {
    throw 'The current repository should pass the consistency check.'
}

$fixture = Join-Path ([System.IO.Path]::GetTempPath()) ('agents-check-' + [guid]::NewGuid())
try {
    New-Item -ItemType Directory -Path $fixture | Out-Null
    Copy-Item -Recurse -LiteralPath (Join-Path $root '.agents') -Destination $fixture
    Copy-Item -LiteralPath (Join-Path $root 'README.md') -Destination $fixture
    $manifestPath = Join-Path $fixture '.agents/manifest.json'
    $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
    $manifest.runtime_adapters.antigravity.bootstrap.source = '.agents/runtime-adapters/antigravity/rules/missing.md'
    $manifest | ConvertTo-Json -Depth 10 | Set-Content -LiteralPath $manifestPath

    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $checker -Root $fixture 2>&1
    $checkerExitCode = $LASTEXITCODE
    if ($checkerExitCode -eq 0 -or ($output -join "`n") -notmatch 'does not exist') {
        throw 'The checker did not report the missing manifest source path.'
    }

    $readmePath = Join-Path $fixture 'README.md'
    $readme = Get-Content -Raw -LiteralPath $readmePath
    $readme = $readme.Replace('| `prompts/plan-create-task.md` | 2.3 |', '| `prompts/plan-create-task.md` | 2.2 |')
    Set-Content -LiteralPath $readmePath -Value $readme

    $output = & powershell -NoProfile -ExecutionPolicy Bypass -File $checker -Root $fixture 2>&1
    $checkerExitCode = $LASTEXITCODE
    if ($checkerExitCode -eq 0 -or ($output -join "`n") -notmatch 'README version') {
        throw 'The checker did not report the README version drift.'
    }
}
finally {
    if (Test-Path -LiteralPath $fixture) {
        Remove-Item -Recurse -Force -LiteralPath $fixture
    }
}

Write-Output 'Consistency checker regression tests passed.'
exit 0
