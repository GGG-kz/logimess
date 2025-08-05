$OutputFile = "project_full_dump.txt"
Remove-Item -Path $OutputFile -ErrorAction SilentlyContinue

# Укажи нужные расширения файлов, которые нужно прочитать:
$extensions = ".py", ".json", ".env", ".ini", ".md"

# Рекурсивно обходим все файлы проекта
Get-ChildItem -Recurse -File | Where-Object {
    $extensions -contains $_.Extension
} | ForEach-Object {
    Add-Content -Path $OutputFile -Value "`n==== $($_.FullName) ====`n"
    Get-Content -Path $_.FullName -Raw | Add-Content -Path $OutputFile
}
