[CmdletBinding()]
param(
    [string]$Root
)

$ErrorActionPreference = 'Stop'

if ($Root) {
    $resolvedRoot = (Resolve-Path -LiteralPath $Root).Path
    if (Test-Path -LiteralPath (Join-Path $resolvedRoot '.agents') -PathType Container) {
        $packageRoot = Join-Path $resolvedRoot '.agents'
    } else {
        $packageRoot = $resolvedRoot
    }
} else {
    $packageRoot = $PSScriptRoot
}

$errors = [System.Collections.Generic.List[string]]::new()

function Add-Error([string]$Message) {
    $script:errors.Add($Message)
}

function Resolve-PackagePath([string]$RelativePath) {
    $clean = $RelativePath.TrimStart('/', '\')
    if ($clean.StartsWith('.agents/') -or $clean.StartsWith('.agents\')) {
        $clean = $clean.Substring(8)
    }
    $normalized = $clean -replace '/', [IO.Path]::DirectorySeparatorChar
    return Join-Path $packageRoot $normalized
}

function Read-Text([string]$RelativePath) {
    return Get-Content -Raw -LiteralPath (Resolve-PackagePath $RelativePath)
}

function Get-DeclaredVersion([string]$Text, [string]$Path) {
    $match = [regex]::Match($Text, '(?m)^version:\s*([^\s]+)\s*$')
    if (-not $match.Success) {
        $match = [regex]::Match($Text, 'version:\s*([^\s|]+)\s*\|')
    }
    if (-not $match.Success) {
        Add-Error "No version declaration found in $Path."
        return $null
    }
    return $match.Groups[1].Value.Trim("'").Trim('"')
}

$manifestRelative = 'manifest.json'
$manifestPath = Resolve-PackagePath $manifestRelative
if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
    Add-Error "Manifest '$manifestRelative' was not found in package root '$packageRoot'."
    $errors | ForEach-Object { Write-Output "ERROR: $_" }
    exit 1
}

$manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json

# Canonical artifacts validation
$expectedCanonicalArtifacts = @{
    '.agents/software-workflow.md' = 'software-workflow.md'
    '.agents/AGENTS.md' = 'AGENTS.md'
    '.agents/context/project.md' = 'context/project.md'
    '.agents/prompts/plan-create-task.md' = 'prompts/plan-create-task.md'
    '.agents/tasks/_template.md' = 'tasks/_template.md'
}

$canonicalByPath = @{}
foreach ($artifact in @($manifest.canonical_artifacts)) {
    $path = [string]$artifact.path
    $normalizedKey = if ($path.StartsWith('.agents/')) { $path } else { ".agents/$path" }
    if ($expectedCanonicalArtifacts.ContainsKey($normalizedKey)) {
        if ($canonicalByPath.ContainsKey($normalizedKey)) {
            Add-Error "Manifest contains duplicate canonical artifact identity '$path'."
        } else {
            $canonicalByPath[$normalizedKey] = $artifact
        }
    }
}

foreach ($expectedPath in $expectedCanonicalArtifacts.Keys) {
    if (-not $canonicalByPath.ContainsKey($expectedPath)) {
        Add-Error "Manifest is missing expected canonical artifact '$expectedPath'."
    }
}

foreach ($artifact in $manifest.canonical_artifacts) {
    $path = [string]$artifact.path
    $absolute = Resolve-PackagePath $path
    if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
        Add-Error "Manifest path '$path' does not exist."
        continue
    }
    $actual = Get-DeclaredVersion (Read-Text $path) $path
    if ($actual -and $actual -ne [string]$artifact.version) {
        Add-Error "Manifest version for '$path' is '$($artifact.version)', but the artifact declares '$actual'."
    }
}

# Runtime adapters validation
if ($manifest.runtime_adapters) {
    foreach ($adapterProperty in $manifest.runtime_adapters.psobject.Properties) {
        $adapter = $adapterProperty.Value
        foreach ($path in $adapter.source_files) {
            $path = [string]$path
            $absolute = Resolve-PackagePath $path
            if (-not (Test-Path -LiteralPath $absolute -PathType Leaf)) {
                Add-Error "Manifest runtime source path '$path' does not exist."
                continue
            }
            $actual = Get-DeclaredVersion (Read-Text $path) $path
            if ($actual -and $actual -ne [string]$adapter.version) {
                Add-Error "Manifest version for runtime adapter '$($adapterProperty.Name)' is '$($adapter.version)', but '$path' declares '$actual'."
            }
        }

        $source = [string]$adapter.bootstrap.source
        $target = [string]$adapter.bootstrap.materialization_target
        $sourceAbs = Resolve-PackagePath $source
        if (-not (Test-Path -LiteralPath $sourceAbs -PathType Leaf)) {
            Add-Error "Manifest bootstrap source path '$source' does not exist."
        }
        if ($source -eq $target -or ($source.TrimStart('.agents/') -eq $target.TrimStart('.agents/'))) {
            Add-Error "Runtime adapter '$($adapterProperty.Name)' conflates retained source '$source' with materialization target '$target'."
        }
    }
}

# Antigravity specific checks
$antigravityReadmeRel = 'runtime-adapters/antigravity/README.md'
$antigravitySourceRel = 'runtime-adapters/antigravity/rules/antigravity-code-agent-workflow.md'
$staleSourceRel = 'runtime-adapters/antigravity/rules/code-agent-workflow.md'
$targetRule = '.agents/rules/code-agent-workflow.md'

if (Test-Path -LiteralPath (Resolve-PackagePath $antigravityReadmeRel) -PathType Leaf) {
    $antigravityReadme = Read-Text $antigravityReadmeRel

    if ($antigravityReadme.Contains($staleSourceRel)) {
        Add-Error "A retained Antigravity source reference still uses the stale path '$staleSourceRel'."
    }
    if (-not $antigravityReadme.Contains($antigravitySourceRel) -and -not $antigravityReadme.Contains(".agents/$antigravitySourceRel")) {
        Add-Error "Antigravity README does not identify the retained Antigravity source '$antigravitySourceRel'."
    }
    if (-not $antigravityReadme.Contains($targetRule)) {
        Add-Error "Antigravity README does not identify the Antigravity materialization target '$targetRule'."
    }

    function Test-AntigravityTreeUsesMaterializedName([string]$Text) {
        $lines = $Text -split "`r?`n"
        $inTypicalTree = $false
        $inFence = $false
        $treeState = 0

        foreach ($line in $lines) {
            if ($line -match '^Typical resulting repository:\s*$') {
                $inTypicalTree = $true
                continue
            }
            if (-not $inTypicalTree) { continue }
            if ($line -match '^```') {
                $inFence = -not $inFence
                continue
            }
            if (-not $inFence) { continue }

            if ($treeState -eq 0 -and $line -match 'runtime-adapters/') { $treeState = 1; continue }
            if ($treeState -eq 1 -and $line -match 'antigravity/') { $treeState = 2; continue }
            if ($treeState -eq 2 -and $line -match 'rules/') { $treeState = 3; continue }
            if ($treeState -eq 3) {
                return $line -match '(?<!antigravity-)code-agent-workflow\.md\s*$'
            }
        }
        return $false
    }

    $staleRetainedSourcePatterns = @('runtime-adapters/antigravity/rules[/\\]code-agent-workflow\.md')
    if (($staleRetainedSourcePatterns | Where-Object { [regex]::IsMatch($antigravityReadme, $_) }) -or (Test-AntigravityTreeUsesMaterializedName $antigravityReadme)) {
        Add-Error "Antigravity retained source depiction uses materialized filename 'code-agent-workflow.md'; use 'antigravity-code-agent-workflow.md' beneath runtime-adapters/antigravity/rules/."
    }
}

if (Test-Path -LiteralPath (Resolve-PackagePath $antigravitySourceRel) -PathType Leaf) {
    $sourceText = Read-Text $antigravitySourceRel
    if (-not $sourceText.Contains($targetRule)) {
        Add-Error "The retained Antigravity source does not identify materialization target '$targetRule'."
    }
}

# Invariant markers check
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
$markers = @($manifest.shared_invariants)
if ($markers.Count -eq 0 -and $manifest.invariant_markers) {
    $markers = @($manifest.invariant_markers)
}
foreach ($marker in $expectedMarkers) {
    if ($markers -notcontains $marker) {
        Add-Error "Manifest is missing required invariant marker '$marker'."
    }
}

# Forbidden references check
$forbiddenPatterns = @(
    'templates/software',
    'templates/scientific',
    'profile_selection',
    'profiles/',
    'core-governance.md'
)
$packageFiles = Get-ChildItem -Recurse -File -LiteralPath $packageRoot
foreach ($file in $packageFiles) {
    if ($file.Name -eq 'check-consistency.ps1') { continue }
    $content = Get-Content -Raw -LiteralPath $file.FullName
    foreach ($pattern in $forbiddenPatterns) {
        if ($content.Contains($pattern)) {
            $relFile = $file.FullName.Substring($packageRoot.Length).TrimStart('\', '/')
            Add-Error "Package file '$relFile' contains forbidden reference '$pattern'."
        }
    }
}

# Link validation within package Markdown files
foreach ($file in ($packageFiles | Where-Object Extension -eq '.md')) {
    $content = Get-Content -Raw -LiteralPath $file.FullName
    foreach ($match in [regex]::Matches($content, '\]\(([^)#]+)(?:#[^)]*)?\)')) {
        $link = $match.Groups[1].Value
        if ($link -match '^(https?|mailto):' -or $link.StartsWith('@') -or $link.StartsWith('#')) { continue }
        if ($link.StartsWith('.agents/')) {
            $targetPath = Resolve-PackagePath $link
            if (-not (Test-Path -LiteralPath $targetPath)) {
                $relSource = $file.FullName.Substring($packageRoot.Length).TrimStart('\', '/')
                Add-Error "$($relSource): Link '$link' does not resolve to an existing file in the package."
            }
        }
    }
}

if ($errors.Count -gt 0) {
    $errors | ForEach-Object { Write-Output "ERROR: $_" }
    exit 1
}

Write-Output 'Software package consistency check passed.'
exit 0
