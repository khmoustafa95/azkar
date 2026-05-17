# Convert admin instruction/advice JPEGs to WebP (quality 85)
$ErrorActionPreference = "Stop"
$root = Split-Path -Parent $PSScriptRoot
$backupRoot = Join-Path $root "assets\_backup_images"

$folders = @(
    @{ Path = "assets\admin_instructions"; Ext = @(".jpeg", ".jpg") },
    @{ Path = "assets\admin_advices"; Ext = @(".jpeg", ".jpg") }
)

foreach ($folder in $folders) {
    $full = Join-Path $root $folder.Path
    $images = Get-ChildItem -Path $full -File | Where-Object {
        $folder.Ext -contains $_.Extension.ToLower()
    }
    foreach ($img in $images) {
        $rel = $img.FullName.Substring($root.Length + 1)
        $backup = Join-Path $backupRoot $rel
        $backupDir = Split-Path $backup -Parent
        if (-not (Test-Path $backupDir)) {
            New-Item -ItemType Directory -Path $backupDir -Force | Out-Null
        }
        if (-not (Test-Path $backup)) { Copy-Item $img.FullName $backup }

        $webp = [System.IO.Path]::ChangeExtension($img.FullName, ".webp")
        Write-Host "Converting $($img.Name) -> $([System.IO.Path]::GetFileName($webp))"
        & ffmpeg -y -hide_banner -loglevel error -i $img.FullName -quality 85 $webp
        if ($LASTEXITCODE -ne 0) { throw "ffmpeg failed for $($img.FullName)" }
        Remove-Item $img.FullName
    }
}

Write-Host "Done. Update .dart asset paths to .webp"
