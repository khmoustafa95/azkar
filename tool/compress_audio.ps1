# Re-encode MP3 prayer audio: mono 64k
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$dir = Join-Path $root "assets\sound_prayers"
$backupRoot = Join-Path $root "assets\_backup_audio\sound_prayers"

if (-not (Test-Path $backupRoot)) {
    New-Item -ItemType Directory -Path $backupRoot -Force | Out-Null
}

$files = Get-ChildItem -Path $dir -Filter "*.mp3" -File
$before = ($files | Measure-Object Length -Sum).Sum
Write-Host "Compressing $($files.Count) MP3 files..."

$i = 0
foreach ($f in $files) {
    $i++
    $backup = Join-Path $backupRoot $f.Name
    if (-not (Test-Path $backup)) { Copy-Item $f.FullName $backup }
    $temp = "$($f.FullName).tmp.mp3"
    Write-Host "[$i/$($files.Count)] $($f.Name)"
    & ffmpeg -y -hide_banner -loglevel error -i $f.FullName -ac 1 -c:a libmp3lame -b:a 64k $temp
    if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed for $($f.Name)" }
    Move-Item -Force $temp $f.FullName
}

$after = (Get-ChildItem $dir -Filter "*.mp3" | Measure-Object Length -Sum).Sum
Write-Host ("Before: {0:N2} MB -> After: {1:N2} MB" -f ($before/1MB), ($after/1MB))
