# Set these to match your main script or edit as needed
$PSScriptRoot = Split-Path -Parent $MyInvocation.MyCommand.Definition
$SnapshotFile = "$PSScriptRoot/snapshot.json"
$NewDirLog    = "$PSScriptRoot/new_directories.json"

# Show contents of snapshot.json and new_directories.json
Write-Host "--- snapshot.json ---"
if (Test-Path $SnapshotFile) {
    Get-Content $SnapshotFile | Write-Host
} else {
    Write-Host "(File not found)"
}

Write-Host "--- new_directories.json ---"
if (Test-Path $NewDirLog) {
    Get-Content $NewDirLog | Write-Host
} else {
    Write-Host "(File not found)"
}

# Show debug output for current and previous directories
Write-Host "--- Previous Directories (from snapshot) ---"
$prev = @{}
if (Test-Path $SnapshotFile) {
    try {
        (Get-Content $SnapshotFile -Raw | ConvertFrom-Json).ForEach{
            $prev[$_.Path.ToLower()] = $true
        }
    } catch {
        Write-Host "(Could not parse snapshot.json)"
    }
}
$prev.Keys | Sort-Object | ForEach-Object { Write-Host $_ }

Write-Host "--- Current Directories (from scan) ---"
# Set this to the folder you want to scan, or prompt for it
$RootPath = Read-Host 'Enter the folder path to scan (same as -RootPath in main script)'
if (Test-Path $RootPath -PathType Container) {
    $currentItems = Get-ChildItem -Path $RootPath -Directory -Recurse
    $currentItems | ForEach-Object { Write-Host $_.FullName }
} else {
    Write-Host "(Invalid or missing folder path)"
}
