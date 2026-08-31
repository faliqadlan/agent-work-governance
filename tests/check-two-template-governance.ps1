[CmdletBinding()]
param(
    [string]$Root
)

$ErrorActionPreference = 'Stop'
if ($Root) {
    $root = (Resolve-Path -LiteralPath $Root).Path
} else {
    $root = (Resolve-Path (Join-Path $PSScriptRoot '..')).Path
}

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
        'profile_selection',
        'profiles/',
        'core-governance.md'
    )
    foreach ($file in $allFiles) {
        if ($file.Name -eq 'check-consistency.ps1') { continue }
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

# 5. Check shared invariant markers and substantive canonical evidence (AWG-R1)
$softwareInvariantAnchors = [ordered]@{
    'authority-vs-evidence' = @{
        Name = 'Separation of intended authority from observed implementation reality/evidence'
        Pattern = '(?si)(intended\s+authority.*?observed\s+(implementation\s+reality|evidence)|intended\s+authority\s+versus\s+observed\s+reality)'
    }
    'external-imperative-not-authority' = @{
        Name = 'Instruction provenance and imperative wording not authority'
        Pattern = '(?si)(instruction\s+provenance\s+is\s+separate\s+from\s+instruction\s+wording|imperative\s+language.*?MUST\s+NOT.*?override\s+authority)'
    }
    'planner-reviewer-executor' = @{
        Name = 'Planner, Executor, and Reviewer logical role separation'
        Pattern = '(?si)Planner,\s+Executor,\s+and\s+Reviewer\s+are\s+logical\s+responsibilities'
    }
    'bounded-contract' = @{
        Name = 'Bounded delivery task contract with observable criteria'
        Pattern = '(?si)(validated\s+task\s+is\s+a\s+delivery\s+contract|One\s+task\s+normally\s+represents\s+one\s+coherent\s+bounded\s+delivery\s+objective)'
    }
    'governing-revision' = @{
        Name = 'Governing task revision identity (<task path> @ <immutable revision>)'
        Pattern = '(?si)(tied\s+to\s+the\s+exact\s+task\s+revision|<task\s+path>\s+@\s+<immutable\s+Git\s+revision)'
    }
    'implementation-or-execution-baseline' = @{
        Name = 'Implementation baseline distinct from governing task revision'
        Pattern = '(?si)(Task\s+lifecycle\s+state\s+and\s+governing\s+task\s+revision\s+are\s+distinct|the\s+implementation\s+baseline\s+and\s+implementation\s+revision)'
    }
    'remediation-vs-replanning' = @{
        Name = 'Remediation vs replanning boundary (CONTINUE / REMEDIATE / REPLAN)'
        Pattern = '(?si)(CONTINUE\s+SAME\s+TASK.*?REMEDIATE\s+SAME\s+TASK.*?REPLAN|Bounded\s+remediation.*?return\s+to\s+Delivery\s+Planning)'
    }
    'evidence-before-acceptance' = @{
        Name = 'Observed evidence required before acceptance'
        Pattern = '(?si)(Claims\s+of\s+completion.*?MUST\s+be\s+based\s+on\s+observed\s+evidence|Evidence\s+must\s+be\s+observed)'
    }
    'acceptance-not-consequential-authorization' = @{
        Name = 'Implementation acceptance is not release authorization'
        Pattern = '(?si)(Implementation\s+acceptance\s+MUST\s+NOT\s+be\s+interpreted\s+as\s+release\s+authorization|Acceptance\s+is\s+not\s+release)'
    }
    'progressive-context-runtime-neutrality' = @{
        Name = 'Progressive context loading and runtime neutrality'
        Pattern = '(?si)canonical\s+`?\.agents/`?\s+contract\s+MUST\s+NOT\s+depend\s+on\s+a\s+specific\s+(coding-agent\s+)?vendor'
    }
}

$scientificInvariantAnchors = [ordered]@{
    'authority-vs-evidence' = @{
        Name = 'Separation of intended scientific authority from observed research evidence'
        Pattern = '(?si)(intended\s+(scientific\s+authority|study\s+design).*?observed\s+(experimental|scientific|analysis)\s+evidence|Scientific\s+authority\s+versus\s+observed\s+evidence)'
    }
    'external-imperative-not-authority' = @{
        Name = 'Instruction provenance and imperatives do not establish study authority'
        Pattern = '(?si)(instruction\s+provenance\s+is\s+separate\s+from\s+instruction\s+wording|imperatives\s+do\s+not\s+establish\s+authority)'
    }
    'planner-reviewer-executor' = @{
        Name = 'Planner, Executor, and Reviewer role separation in research'
        Pattern = '(?si)Planner,\s+Executor,\s+and\s+Reviewer\s+are\s+logical\s+responsibilities'
    }
    'bounded-contract' = @{
        Name = 'Bounded research task contract'
        Pattern = '(?si)(validated\s+task\s+is\s+a\s+delivery\s+contract|One\s+task\s+normally\s+represents\s+one\s+coherent\s+bounded\s+research\s+objective)'
    }
    'governing-revision' = @{
        Name = 'Governing research task revision identity (<task path> @ <immutable revision>)'
        Pattern = '(?si)(tied\s+to\s+the\s+exact\s+task\s+revision|<task\s+path>\s+@\s+<immutable\s+Git\s+revision)'
    }
    'implementation-or-execution-baseline' = @{
        Name = 'Execution/analysis baseline distinct from governing task revision'
        Pattern = '(?si)(execution\s+baseline\s+and\s+analysis\s+revision|approved\s+execution/analysis\s+baseline\s+definition)'
    }
    'remediation-vs-replanning' = @{
        Name = 'Remediation vs replanning in research (CONTINUE / REMEDIATE / REPLAN)'
        Pattern = '(?si)(CONTINUE\s+SAME\s+TASK.*?REMEDIATE\s+SAME\s+TASK.*?REPLAN|Bounded\s+remediation\s+\(Same\s+Task\).*?Material\s+replanning)'
    }
    'evidence-before-acceptance' = @{
        Name = 'Observed research evidence and provenance required before acceptance'
        Pattern = '(?si)(Claims\s+of\s+completion.*?MUST\s+be\s+based\s+on\s+observed\s+evidence|Scientific\s+claims\s+require\s+verifiable\s+provenance\s+and\s+reproducibility)'
    }
    'acceptance-not-consequential-authorization' = @{
        Name = 'Scientific result acceptance is not dissemination or publication authorization'
        Pattern = '(?si)(Scientific\s+result\s+acceptance\s+MUST\s+NOT\s+be\s+interpreted\s+as\s+dissemination|Acceptance\s+is\s+not\s+dissemination)'
    }
    'progressive-context-runtime-neutrality' = @{
        Name = 'Progressive context loading and runtime neutrality'
        Pattern = '(?si)canonical\s+`?\.agents/`?\s+contract\s+MUST\s+NOT\s+depend\s+on\s+a\s+specific\s+(coding-agent\s+)?vendor'
    }
}

function Check-SharedInvariants([string]$PackageDir, [string]$PackageName, [hashtable]$AnchorMap, [string[]]$CanonicalRelFiles) {
    if (-not (Test-Path -LiteralPath $PackageDir -PathType Container)) { return }
    $manifestPath = Join-Path $PackageDir 'manifest.json'
    if (-not (Test-Path -LiteralPath $manifestPath -PathType Leaf)) {
        Add-Error "$PackageName package manifest was not found at '$manifestPath'."
        return
    }

    # 1. Manifest markers check
    $manifestMarkers = @()
    try {
        $manifest = Get-Content -Raw -LiteralPath $manifestPath | ConvertFrom-Json
        $manifestMarkers = @($manifest.shared_invariants)
        if ($manifestMarkers.Count -eq 0 -and $manifest.invariant_markers) {
            $manifestMarkers = @($manifest.invariant_markers)
        }
        foreach ($expected in $expectedMarkers) {
            if ($manifestMarkers -notcontains $expected) {
                Add-Error "$PackageName manifest '$manifestPath' is missing required invariant marker '$expected'."
            }
        }
    } catch {
        Add-Error "$PackageName manifest could not be parsed: $_"
        return
    }

    # 2. Canonical governance substantive text check
    $canonicalTexts = [System.Collections.Generic.List[string]]::new()
    foreach ($relFile in $CanonicalRelFiles) {
        $fullPath = Join-Path $PackageDir ($relFile -replace '/', [IO.Path]::DirectorySeparatorChar)
        if (Test-Path -LiteralPath $fullPath -PathType Leaf) {
            $canonicalTexts.Add((Get-Content -Raw -LiteralPath $fullPath))
        }
    }
    $combinedText = $canonicalTexts -join "`n`n"

    foreach ($marker in $expectedMarkers) {
        if (-not $AnchorMap.ContainsKey($marker)) {
            Add-Error "$PackageName validation definition is missing anchor rule for invariant marker '$marker'."
            continue
        }
        $anchor = $AnchorMap[$marker]
        $pattern = $anchor.Pattern
        $name = $anchor.Name
        if (-not [regex]::IsMatch($combinedText, $pattern)) {
            Add-Error "$PackageName package canonical governance is missing substantive evidence for invariant '$marker' (semantic anchor: '$name')."
        }
    }
}

Check-SharedInvariants $softwareDir 'Software' $softwareInvariantAnchors @('AGENTS.md', 'software-workflow.md')
Check-SharedInvariants $scientificDir 'Scientific' $scientificInvariantAnchors @('AGENTS.md', 'research-governance.md')

# 6. Check root README version drift against manifests (AWG-R2)
function Check-ReadmeVersionDrift([string]$RepositoryRoot) {
    $readmePath = Join-Path $RepositoryRoot 'README.md'
    if (-not (Test-Path -LiteralPath $readmePath -PathType Leaf)) {
        Add-Error "Root README.md was not found at '$readmePath'."
        return
    }
    $readmeText = Get-Content -Raw -LiteralPath $readmePath

    function Get-SectionText([string]$Text, [string]$Header, [string]$NextHeader) {
        $start = $Text.IndexOf($Header)
        if ($start -lt 0) { return $null }
        $slice = $Text.Substring($start)
        if ($NextHeader) {
            $end = $slice.IndexOf($NextHeader, $Header.Length)
            if ($end -ge 0) {
                $slice = $slice.Substring(0, $end)
            }
        }
        return $slice
    }

    $softSection = Get-SectionText $readmeText '## Software governance template' '## Scientific governance template'
    $sciSection = Get-SectionText $readmeText '## Scientific governance template' '## Validation and consistency checks'

    if (-not $softSection) {
        Add-Error "README.md is missing '## Software governance template' section."
    }
    if (-not $sciSection) {
        Add-Error "README.md is missing '## Scientific governance template' section."
    }

    function Validate-PackageTable([string]$Section, [string]$ManifestPath, [string]$PackageName, [string]$TemplatePrefix) {
        if (-not (Test-Path -LiteralPath $ManifestPath -PathType Leaf)) { return }
        if (-not $Section) { return }

        $manifest = Get-Content -Raw -LiteralPath $ManifestPath | ConvertFrom-Json

        # Validate canonical artifacts
        foreach ($art in $manifest.canonical_artifacts) {
            $relPath = $art.path.TrimStart('.').TrimStart('/')
            if ($relPath.StartsWith('agents/')) { $relPath = $relPath.Substring(7) }
            $expectedVersion = [string]$art.version
            $docId = [string]$art.document_id

            # Locate row matching the artifact link/path and document ID
            $pattern = '(?m)^\|\s*(?:\[`?[^`\]]+`?\]\([^)]*' + [regex]::Escape($relPath) + '[^)]*\)|`?' + [regex]::Escape($docId) + '`?)\s*\|\s*`?' + [regex]::Escape($docId) + '`?\s*\|\s*([^|\s]+)\s*\|\s*([^|]+)\s*\|'
            $matches = [regex]::Matches($Section, $pattern)
            if ($matches.Count -eq 0) {
                Add-Error "README is missing mirrored version entry for $PackageName canonical artifact '$($art.path)' ($docId)."
            } elseif ($matches.Count -gt 1) {
                Add-Error "README contains multiple ($($matches.Count)) mirrored version entries for $PackageName canonical artifact '$($art.path)' ($docId)."
            } else {
                $actualVersion = $matches[0].Groups[1].Value.Trim()
                if ($actualVersion -ne $expectedVersion) {
                    Add-Error "README version for $PackageName artifact '$($art.path)' ($docId) is '$actualVersion', but manifest declares '$expectedVersion'."
                }
            }
        }

        # Validate runtime adapters
        if ($manifest.runtime_adapters) {
            foreach ($prop in $manifest.runtime_adapters.psobject.Properties) {
                $adapterName = $prop.Name
                $adapter = $prop.Value
                $expectedVersion = [string]$adapter.version

                $pattern = '(?mi)^\|\s*`?' + [regex]::Escape($adapterName) + '\s+adapter`?\s*\|\s*`?[^`|]+`?\s*\|\s*([^|\s]+)\s*\|\s*([^|]+)\s*\|'
                $matches = [regex]::Matches($Section, $pattern)
                if ($matches.Count -eq 0) {
                    Add-Error "README is missing mirrored version entry for $PackageName runtime adapter '$adapterName'."
                } elseif ($matches.Count -gt 1) {
                    Add-Error "README contains multiple ($($matches.Count)) mirrored version entries for $PackageName runtime adapter '$adapterName'."
                } else {
                    $actualVersion = $matches[0].Groups[1].Value.Trim()
                    if ($actualVersion -ne $expectedVersion) {
                        Add-Error "README version for $PackageName runtime adapter '$adapterName' is '$actualVersion', but manifest declares '$expectedVersion'."
                    }
                }
            }
        }
    }

    Validate-PackageTable $softSection (Join-Path $softwareDir 'manifest.json') 'Software' 'templates/software/.agents'
    Validate-PackageTable $sciSection (Join-Path $scientificDir 'manifest.json') 'Scientific' 'templates/scientific/.agents'
}

Check-ReadmeVersionDrift $root

# 7. Copy-And-Check: Standalone package check in temporary isolation
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
