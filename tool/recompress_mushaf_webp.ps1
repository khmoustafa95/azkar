# Re-compress mushaf WebP (q85 — balances APK size and mushaf readability).
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent (Split-Path -Parent $PSScriptRoot)
if (-not (Test-Path "$root\pubspec.yaml")) { $root = (Get-Location).Path }

$dir = Join-Path $root "assets\quran_data"
$quality = 85
if ($args.Count -gt 0) { $quality = [int]$args[0] }

$webps = Get-ChildItem -Path $dir -Filter "*.webp" -File | Sort-Object { [int]($_.BaseName) }
$before = ($webps | Measure-Object Length -Sum).Sum
Write-Host "Recompressing $($webps.Count) pages at WebP q$quality..."

$i = 0
foreach ($w in $webps) {
    $i++
    if ($i % 100 -eq 0) { Write-Host "[$i/$($webps.Count)]" }
    $temp = "$("$($w.FullName).tmp.webp")"
    & ffmpeg -y -hide_banner -loglevel error -i $w.FullName `
        -c:v libwebp -quality $quality -compression_level 6 -preset picture `
        $temp
    if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed for $($w.FullName)" }
    Move-Item -Force $temp $w.FullName
}

$after = (Get-ChildItem $dir -Filter "*.webp" | Measure-Object Length -Sum).Sum
Write-Host ("{0:N2} MB -> {1:N2} MB ({2:P0} of previous)" -f ($before / 1MB), ($after / 1MB), ($after / $before))
