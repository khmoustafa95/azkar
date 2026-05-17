# Second-pass video compression (already ran compress_videos.ps1 once).
# with_hajj: 480p CRF 34 | other folders: 720p CRF 34

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path "$root\pubspec.yaml")) { $root = (Get-Location).Path }

$backupRoot = Join-Path $root "assets\_backup_videos_pass2"
$configs = @(
    @{ Dir = "assets\with_hajj"; MaxHeight = 480; Crf = 34 },
    @{ Dir = "assets\do_you_know"; MaxHeight = 720; Crf = 34 },
    @{ Dir = "assets\fiqh_hajj1"; MaxHeight = 720; Crf = 34 },
    @{ Dir = "assets\figh_hajj2"; MaxHeight = 720; Crf = 34 },
    @{ Dir = "assets\videos"; MaxHeight = 720; Crf = 34 }
)

function Compress-Video {
    param([string]$InputPath, [string]$OutputPath, [int]$MaxHeight, [int]$Crf)
    $parent = Split-Path $OutputPath -Parent
    if (-not (Test-Path $parent)) { New-Item -ItemType Directory -Path $parent -Force | Out-Null }
    & ffmpeg -y -hide_banner -loglevel error -i $InputPath `
        -vf "scale=-2:min($MaxHeight\,ih)" `
        -c:v libx264 -crf $Crf -preset medium `
        -c:a aac -b:a 64k -ac 2 `
        -movflags +faststart `
        $OutputPath
    if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed for $InputPath" }
}

$videos = @()
foreach ($cfg in $configs) {
    $full = Join-Path $root $cfg.Dir
    if (Test-Path $full) {
        $videos += Get-ChildItem -Path $full -Filter "*.mp4" -File
    }
}

Write-Host "Pass 2: $($videos.Count) videos"
$totalBefore = ($videos | Measure-Object Length -Sum).Sum
Write-Host ("Before: {0:N2} MB" -f ($totalBefore / 1MB))

$i = 0
foreach ($v in $videos) {
    $i++
    $rel = $v.FullName.Substring($root.Length + 1)
    $cfg = $configs | Where-Object { $rel.StartsWith($_.Dir.Replace('\', '/')) -or $rel.StartsWith($_.Dir) } | Select-Object -First 1
    if (-not $cfg) { $cfg = $configs[-1] }

    $backupPath = Join-Path $backupRoot $rel
    $backupDir = Split-Path $backupPath -Parent
    if (-not (Test-Path $backupDir)) {
        New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
    }
    if (-not (Test-Path $backupPath)) {
        Copy-Item $v.FullName $backupPath
    }

    $temp = "$($v.FullName).tmp.mp4"
    Write-Host "[$i/$($videos.Count)] $($v.Name) (max $($cfg.MaxHeight)p crf $($cfg.Crf))"
    Compress-Video -InputPath $v.FullName -OutputPath $temp -MaxHeight $cfg.MaxHeight -Crf $cfg.Crf
    Move-Item -Force $temp $v.FullName
}

$after = ($videos | ForEach-Object { Get-Item $_.FullName } | Measure-Object Length -Sum).Sum
Write-Host ("After: {0:N2} MB ({1:P0})" -f ($after / 1MB), ($after / $totalBefore))
Write-Host "Backups: $backupRoot"
