[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'
$root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
$errors = [System.Collections.Generic.List[string]]::new()

function Add-Error([string]$Message) {
    $script:errors.Add($Message)
}

$expectedMarkers = @(
    'authority-vs-evidence',
    'external-imperative-not-authority',
    'planner-reviewer-executor',
    'bounded-contract',
    'governing-revision',
    'implementation-or-execution-baseline',
    'remediation-vs-replanning',
    'evidence-before-acceptance',
    'acceptance-not-consequential-authorization',
    'progressive-context-runtime-neutrality'
)

$softwareRel = 'templates/software/.agents'
$scientificRel = 'templates/scientific/.agents'

$softwareExpectedFiles = @(
    'AGENTS.md',
    'software-workflow.md',
    'context/project.md',
    'prompts/plan-create-task.md',
    'tasks/_template.md',
    'manifest.json',
    'check-consistency.ps1',
    'runtime-adapters/codex/AGENTS.md',
    'runtime-adapters/codex/README.md',
    'runtime-adapters/claude/CLAUDE.md',
    'runtime-adapters/claude/README.md',
    'runtime-adapters/antigravity/README.md',
    'runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md'
)

$scientificExpectedFiles = @(
    'AGENTS.md',
    'research-governance.md',
    'context/project.md',
    'prompts/plan-create-task.md',
    'tasks/_template.md',
    'manifest.json',
    'check-consistency.ps1',
    'runtime-adapters/codex/AGENTS.md',
    'runtime-adapters/codex/README.md',
    'runtime-adapters/claude/CLAUDE.md',
    'runtime-adapters/claude/README.md',
    'runtime-adapters/antigravity/README.md',
    'runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md'
)

# 1. Check Software package files
$softwareDir = Join-Path $root $softwareRel
if (-not (Test-Path -LiteralPath $softwareDir -PathType Container)) {
    Add-Error "Software package directory '$softwareRel' does not exist."
} else {
    foreach ($file in $softwareExpectedFiles) {
        $fullPath = Join-Path $softwareDir ($file -replace '/', [IO.Path]::DirectorySeparatorChar)
        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            Add-Error "Software package is missing required path '$file'."
        }
    }
}

# 2. Check Scientific package files
$scientificDir = Join-Path $root $scientificRel
if (-not (Test-Path -LiteralPath $scientificDir -PathType Container)) {
    Add-Error "Scientific package directory '$scientificRel' does not exist."
} else {
    foreach ($file in $scientificExpectedFiles) {
        $fullPath = Join-Path $scientificDir ($file -replace '/', [IO.Path]::DirectorySeparatorChar)
        if (-not (Test-Path -LiteralPath $fullPath -PathType Leaf)) {
            Add-Error "Scientific package is missing required path '$file'."
        }
    }
}

# 3. Forbidden content in repository (vendored external skills, mandatory root core in packages)
$forbiddenPaths = @(
    'templates/software/.agents/core-governance.md',
    'templates/scientific/.agents/core-governance.md',
    'templates/software/.agents/skills',
    'templates/scientific/.agents/skills',
    'skills'
)
foreach ($badPath in $forbiddenPaths) {
    $fullBadPath = Join-Path $root ($badPath -replace '/', [IO.Path]::DirectorySeparatorChar)
    if (Test-Path -LiteralPath $fullBadPath) {
        Add-Error "Forbidden path '$badPath' exists (must not vendor skills or duplicate root core-governance)."
    }
}

# 4. Check for forbidden references inside each package
function Check-ForbiddenPackageReferences([string]$PackageDir, [string]$PackageName) {
    if (-not (Test-Path -LiteralPath $PackageDir -PathType Container)) { return }
    $allFiles = Get-ChildItem -Recurse -File -LiteralPath $PackageDir
    $forbiddenStrings = @(
        'templates/software',
        'templates/scientific',
        '../',
        'profile_selection',
        'profiles/'
    )
    foreach ($file in $allFiles) {
        $content = Get-Content -Raw -LiteralPath $file.FullName
        foreach ($pattern in $forbiddenStrings) {
            if ($content.Contains($pattern)) {
                $relFile = $file.FullName.Substring($PackageDir.Length).TrimStart('\', '/')
                Add-Error "$PackageName package file '$relFile' contains forbidden reference '$pattern'."
            }
        }
    }
}

Check-ForbiddenPackageReferences $softwareDir 'Software'
Check-ForbiddenPackageReferences $scientificDir 'Scientific'

# 5. Check shared invariant markers in manifests
function Check-ManifestMarkers([string]$ManifestPath, [string]$PackageName) {
    if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) { return }
    try {
        $manifest = Get-Content -Raw -LiteralPath $ManifestPath | ConvertFrom-Json
        $markers = @($manifest.shared_invariants)
        if ($markers.Count -eq 0 -and $manifest.invariant_markers) {
            $markers = @($manifest.invariant_markers)
        }
        foreach ($expected in $expectedMarkers) {
            if ($markers -notcontains $expected) {
                Add-Error "$PackageName manifest '$ManifestPath' is missing required invariant marker '$expected'."
            }
        }
    } catch {
        Add-Error "$PackageName manifest could not be parsed: $_"
    }
}

if (Test-Path -LiteralPath $softwareDir) {
    Check-ManifestMarkers (Join-Path $softwareDir 'manifest.json') 'Software'
}
if (Test-Path -LiteralPath $scientificDir) {
    Check-ManifestMarkers (Join-Path $scientificDir 'manifest.json') 'Scientific'
}

# 6. Copy-And-Check: Standalone package check in temporary isolation
function Copy-And-Check([string]$SourcePackageDir, [string]$PackageName) {
    if (-not (Test-Path -LiteralPath $SourcePackageDir -PathType Container)) { return }
    $tempDir = Join-Path ([System.IO.Path]::GetTempPath()) ('agent-pkg-test-' + [guid]::NewGuid())
    try {
        New-Item -ItemType Directory -Path $tempDir | Out-Null
        $destAgents = Join-Path $tempDir '.agents'
        Copy-Item -Recurse -LiteralPath $SourcePackageDir -Destination $destAgents
        $checkerScript = Join-Path $destAgents 'check-consistency.ps1'
        if (-not (Test-Path -LiteralPath $checkerScript -PathType Leaf)) {
            Add-Error "Standalone $PackageName package is missing check-consistency.ps1."
            return
        }
        $output = @(& $checkerScript 2>&1)
        $exitCode = $LASTEXITCODE
        if ($exitCode -ne 0) {
            Add-Error "Standalone $PackageName checker failed with exit code $exitCode in isolated directory. Output:`n$($output -join "`n")"
        }
    } catch {
        Add-Error "Error executing isolated $PackageName check: $_"
    } finally {
        if (Test-Path -LiteralPath $tempDir) {
            Remove-Item -Recurse -Force -LiteralPath $tempDir
        }
    }
}

Copy-And-Check $softwareDir 'Software'
Copy-And-Check $scientificDir 'Scientific'

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Output "ERROR: $_" }
    exit 1
}

Write-Output 'Two-template governance validation passed.'
exit 0
