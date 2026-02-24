param(
    [ValidateSet("major", "minor", "patch")]
    [string]$Bump = "patch",

    [string]$Version,

    [switch]$Push
)

$ErrorActionPreference = "Stop"

function Get-LatestSemVerTag {
    $tags = git tag --list "v*"
    $semver = $tags | Where-Object { $_ -match '^v\d+\.\d+\.\d+$' }

    if (-not $semver) {
        return $null
    }

    return $semver |
        Sort-Object { [version]($_.TrimStart('v')) } |
        Select-Object -Last 1
}

function Get-NextVersion([string]$currentTag, [string]$bump) {
    if (-not $currentTag) {
        return "v1.0.0"
    }

    $v = [version]($currentTag.TrimStart('v'))

    switch ($bump) {
        "major" { return "v$($v.Major + 1).0.0" }
        "minor" { return "v$($v.Major).$($v.Minor + 1).0" }
        default { return "v$($v.Major).$($v.Minor).$($v.Build + 1)" }
    }
}

$dirty = git status --porcelain
if ($dirty) {
    throw "Working tree is not clean. Commit or stash changes before releasing."
}

git fetch --tags | Out-Null

$latest = Get-LatestSemVerTag

if ($Version) {
    $newTag = if ($Version.StartsWith("v")) { $Version } else { "v$Version" }
    if ($newTag -notmatch '^v\d+\.\d+\.\d+$') {
        throw "Version must match SemVer format: vMAJOR.MINOR.PATCH"
    }
} else {
    $newTag = Get-NextVersion -currentTag $latest -bump $Bump
}

$exists = git tag --list $newTag
if ($exists) {
    throw "Tag $newTag already exists."
}

git tag -a $newTag -m "Release $newTag"

if ($Push) {
    git push origin $newTag
    Write-Host "Created and pushed tag: $newTag"
} else {
    Write-Host "Created local tag: $newTag"
    Write-Host "Push with: git push origin $newTag"
}

if ($latest) {
    Write-Host "Previous tag: $latest"
} else {
    Write-Host "Previous tag: none"
}
