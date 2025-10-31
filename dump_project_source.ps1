# dump_project_source.ps1
$OutputFile = "z_whole_code_dump.txt"

Add-Content $OutputFile "===== PROJECT TREE ====="
tree /F /A | Add-Content $OutputFile

Add-Content $OutputFile "`n===== FILE DUMPS ====="

$extensions = @("*.gd","*.tscn","*.cs","*.py","*.csv","Pipfile","*.md")

Get-ChildItem -Recurse -File | Where-Object {
    $ext = $_.Name
    ($extensions | ForEach-Object { $_ -like "*$ext" }) -contains $true -and
    $_.Name -ne "Pipfile.lock"
} | Sort-Object FullName | ForEach-Object {
    Add-Content $OutputFile "===== FILE: $($_.FullName) ====="
    Get-Content $_.FullName | Add-Content $OutputFile
    Add-Content $OutputFile "`n"
}

Write-Host "✅ Project dumped to $OutputFile"
