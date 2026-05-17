# Aggressive video compression: 720p max, H.264 CRF 32, AAC 96k
# Backs up originals to assets/_backup_videos/ then replaces in place.

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path "$root\pubspec.yaml")) { $root = (Get-Location).Path }

$backupRoot = Join-Path $root "assets\_backup_videos"
$dirs = @(
    "assets\with_hajj",
    "assets\do_you_know",
    "assets\fiqh_hajj1",
    "assets\figh_hajj2",
    "assets\videos"
)

function Compress-Video {
    param([string]$InputPath, [string]$OutputPath)
    $dir = Split-Path $OutputPath -Parent
    if (-not (Test-Path $dir)) { New-Item -ItemType Directory -Path $dir -Force | Out-Null }
    & ffmpeg -y -hide_banner -loglevel error -i $InputPath `
        -vf "scale=-2:min(720\,ih)" `
        -c:v libx264 -crf 32 -preset medium `
        -c:a aac -b:a 96k -ac 2 `
        -movflags +faststart `
        $OutputPath
    if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed for $InputPath" }
}

$videos = @()
foreach ($d in $dirs) {
    $full = Join-Path $root $d
    if (Test-Path $full) {
        $videos += Get-ChildItem -Path $full -Filter "*.mp4" -File
    }
}

Write-Host "Found $($videos.Count) videos to compress"
$totalBefore = ($videos | Measure-Object Length -Sum).Sum
Write-Host ("Total size before: {0:N2} MB" -f ($totalBefore / 1MB))

$i = 0
foreach ($v in $videos) {
    $i++
    $rel = $v.FullName.Substring($root.Length + 1)
    $backupPath = Join-Path $backupRoot $rel
    $backupDir = Split-Path $backupPath -Parent
    if (-not (Test-Path $backupDir)) {
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    }
    if (-not (Test-Path $backupPath)) {
        Copy-Item $v.FullName $backupPath
    }
    $temp = "$($v.FullName).tmp.mp4"
    Write-Host "[$i/$($videos.Count)] $($v.Name)"
    Compress-Video -InputPath $v.FullName -OutputPath $temp
    Move-Item -Force $temp $v.FullName
}

$after = ($videos | ForEach-Object { Get-Item $_.FullName } | Measure-Object Length -Sum).Sum
Write-Host ("Total size after: {0:N2} MB ({1:P0} of original)" -f ($after / 1MB), ($after / $totalBefore))
Write-Host "Backups: $backupRoot"
