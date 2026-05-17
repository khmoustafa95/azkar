# Optional mushaf PNG → WebP. Pre-optimized mushaf PNGs in this repo are often
# SMALLER than WebP; prefer [cacheWidth] decode resize in QuranReadingView instead.
# Usage: .\tool\convert_mushaf_webp.ps1 [-Quality 90]
param([int]$Quality = 90)

$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path "$root\pubspec.yaml")) { $root = (Get-Location).Path }

$dir = Join-Path $root "assets\quran_data"
$pngs = Get-ChildItem -Path $dir -Filter "*.png" -File
if ($pngs.Count -eq 0) { Write-Host "No PNG files."; exit 0 }

$before = ($pngs | Measure-Object Length -Sum).Sum
Write-Host "Converting $($pngs.Count) pages to WebP q$Quality..."
foreach ($png in $pngs) {
    $webp = Join-Path $dir ($png.BaseName + ".webp")
    & ffmpeg -y -hide_banner -loglevel error -i $png.FullName `
        -c:v libwebp -quality $Quality -compression_level 6 -preset picture $webp
    if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed for $($png.FullName)" }
}
$webps = Get-ChildItem $dir -Filter "*.webp"
$after = ($webps | Measure-Object Length -Sum).Sum
Write-Host ("PNG {0:N2} MB | WebP {1:N2} MB — only delete PNGs if WebP is smaller." -f ($before/1MB), ($after/1MB))
