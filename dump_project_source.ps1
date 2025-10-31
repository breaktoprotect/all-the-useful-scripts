$OutputFile = "z_whole_code_dump.txt"
$includeExt = @("*.gd", "*.tscn", "*.cs", "*.md", "*.txt", "project.godot")

# folders to exclude
$excludeDirs = @(
    ".godot",     # editor cache & metadata
    ".import",    # texture import cache
    "imported",  
    "shader_cache"
)

# Start file fresh
"===== PROJECT TREE (clean) =====" | Set-Content $OutputFile

# Custom tree excluding noise
Get-ChildItem -Recurse -Directory | Where-Object {
    $excludeDirs -notcontains $_.Name
} | Select-Object FullName | Out-File -Append $OutputFile

"`n===== FILE DUMPS =====" | Add-Content $OutputFile

Get-ChildItem -Recurse -File | Where-Object {
    ($includeExt | ForEach-Object { $_ -like "*$($_.Extension)" }) -contains $true -and
    ($excludeDirs | ForEach-Object { $_ -notmatch $_.FullName }) -contains $true
} | Sort-Object FullName | ForEach-Object {
    "===== FILE: $($_.FullName) =====" | Add-Content $OutputFile
    Get-Content $_.FullName | Add-Content $OutputFile
    "`n" | Add-Content $OutputFile
}

Write-Host "✅ Minimal project dump saved to $OutputFile"
