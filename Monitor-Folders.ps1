param(
    [Parameter(Mandatory = $true)]
    [ValidateScript({Test-Path $_ -PathType Container})]
    [string] $RootPath,

    [string] $SnapshotFile = "$PSScriptRoot/snapshot.json",
    [string] $NewDirLog    = "$PSScriptRoot/new_directories.json"
)

# ---------- 1. Load previous snapshot ----------
$prev = @{}
if (Test-Path $SnapshotFile) {
    try {
        (Get-Content $SnapshotFile -Raw | ConvertFrom-Json).ForEach{
            $prev[$_.Path.ToLower()] = $true
        }
    } catch {
        Write-Warning "Snapshot file unreadable - starting fresh."
    }
}

# ---------- 2. Enumerate current directories (RECURSIVELY!) ----------
$currentItems = Get-ChildItem -Path $RootPath -Directory -Recurse |
    ForEach-Object {
        $acl = Get-Acl $_.FullName
        $accessList = $acl.Access |
            Sort-Object IdentityReference, FileSystemRights -Unique |
            ForEach-Object {
                '{0} : {1}' -f $_.IdentityReference, $_.FileSystemRights
            }

        [PSCustomObject]@{
            Path         = $_.FullName
            DateCreated  = $_.CreationTimeUtc.ToString('yyyy-MM-ddTHH:mm:ssZ')
            User_Access  = $accessList
        }
    }

# ---------- DEBUG: Print all found directories ----------
Write-Host "`n--- Current Directories (from scan) ---"
$currentItems | ForEach-Object { Write-Host $_.Path }

# ---------- 3. Identify newly created directories ----------
$newDirs = @($currentItems | Where-Object {
    -not $prev.ContainsKey($_.Path.ToLower())
})

# ---------- DEBUG: Print new directories ----------
Write-Host "`n--- NEW Directories Found ---"
if ($newDirs.Count -eq 0) {
    Write-Host "None"
} else {
    $newDirs | ForEach-Object { Write-Host $_.Path }
}

# ---------- 4. Append to running log (with logging info) ----------
if ($newDirs.Count) {
    try {
        if (-not (Test-Path $NewDirLog)) {
            $newDirs | ConvertTo-Json -Depth 4 | Set-Content $NewDirLog
            Write-Host "`nCreated new new_directories.json log."
        } else {
            $existingLog = Get-Content $NewDirLog -Raw | ConvertFrom-Json
            $combined = @($existingLog + $newDirs)
            $combined | ConvertTo-Json -Depth 4 | Set-Content $NewDirLog
            Write-Host "`nAppended to existing new_directories.json log."
        }
    } catch {
        Write-Warning "Failed to write to $NewDirLog. Error: $_"
    }
} else {
    Write-Host "No new directories found."
}

# ---------- 5. Save THIS run as the next baseline ----------
$currentItems | ConvertTo-Json -Depth 4 | Set-Content $SnapshotFile
