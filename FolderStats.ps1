param([string]$Path = ".")

Write-Host "Analyzing: $Path"
Write-Host ""

# 1. Size of each folder and subfolder
Write-Host "Folder sizes (recursive):"
Get-ChildItem -Path $Path -Directory -Recurse | ForEach-Object {
    $size = (Get-ChildItem $_.FullName -Recurse -File | Measure-Object Length -Sum).Sum
    "{0,-80} {1,10:N0} bytes" -f $_.FullName, $size
}

Write-Host ""
# 2. Number of files in the main folder (not recursive)
$mainCount = (Get-ChildItem -Path $Path -File).Count
Write-Host "Number of files in $Path (not recursive): $mainCount"

# 3. Total number of files (recursive)
$totalCount = (Get-ChildItem -Path $Path -File -Recurse).Count
Write-Host "Total number of files (recursive): $totalCount"

Write-Host ""
# 4. Largest file (recursive)
$largestFile = Get-ChildItem -Path $Path -File -Recurse | Sort-Object Length -Descending | Select-Object -First 1
Write-Host "Largest file: $($largestFile.FullName) ($([Math]::Round($largestFile.Length/1MB,2)) MB)"

Write-Host ""
# 5. Largest folder (recursive)
$largestFolder = Get-ChildItem -Path $Path -Directory -Recurse | ForEach-Object {
    $size = (Get-ChildItem $_.FullName -Recurse -File | Measure-Object Length -Sum).Sum
    [PSCustomObject]@{Folder=$_.FullName; Size=$size}
} | Sort-Object Size -Descending | Select-Object -First 1
Write-Host "Largest folder: $($largestFolder.Folder) ($([Math]::Round($largestFolder.Size/1MB,2)) MB)"
