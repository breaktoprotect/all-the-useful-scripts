# dump_godot.ps1

$OutputFile = "z_whole_code_dump.txt"
$Here       = Get-Location

# include only what matters for Godot scripts/scenes
$includeNameRegex = '(?i)\.(gd|tscn)$|^project\.godot$'

# exclude engine/editor/generated folders
$excludeRegex = '(?i)(\\|/)\.godot(\\|/|$)|(\\|/)\.import(\\|/|$)|(\\|/)imported(\\|/|$)|(\\|/)shader_cache(\\|/|$)'

# prepare output
if (Test-Path $OutputFile) { Remove-Item $OutputFile }
function W([string]$s){ $s | Out-File $OutputFile -Append -Encoding utf8 }

# find matching files
$files = Get-ChildItem -Recurse -File | Where-Object {
    -not ($_.FullName -match $excludeRegex) -and
    ($_.Name -match $includeNameRegex)
} | Sort-Object FullName

# collect dirs containing those files
$dirs = $files | ForEach-Object {
    Split-Path $_.FullName -Parent
} | Sort-Object -Unique

# write clean tree
W "===== PROJECT TREE (clean) ====="
foreach($d in $dirs){
    $rel = $d.Replace($Here.Path + [IO.Path]::DirectorySeparatorChar, "")
    W $rel
}

W "`n===== FILE DUMPS =====`n"

foreach($f in $files){
    $rel = $f.FullName.Replace($Here.Path + [IO.Path]::DirectorySeparatorChar, "")
    W "===== FILE: $rel ====="
    Get-Content $f.FullName -Raw -Encoding UTF8 | Out-File $OutputFile -Append -Encoding utf8
    W "`n"
}

Write-Host "✅ Godot code dump completed → $OutputFile"
