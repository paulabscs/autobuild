$RootFolder = Join-Path -Path (Get-Location).Path -ChildPath "python"

$jsonPath = Join-Path -Path (Get-Location).Path -ChildPath "powershell\json_pre_loading\paths.json" 


# Check if paths_remove.json exists
if (Test-Path $jsonPath) {
    $saved_data = $true
} else {
    $saved_data = $false
}

# Standard Method
function StandardMethod {
    $SubFolders = Get-ChildItem -Path $RootFolder -Directory

    $RootFolderPath = "$($RootFolder)\__init__.py"
    $existsrfp = Get-Item -Path $RootFolderPath -ErrorAction SilentlyContinue
    if ($existsrfp) {
        Remove-Item -Path $RootFolderPath -Force -ErrorAction SilentlyContinue
    } else {
        Write-Output $RootFolderPath # New-Item -Path $RootFolderPath -ItemType "file" -Force
    }


    $paths = @()

    Foreach($SubFolder in $SubFolders) {
        $subFolderPath = "$($SubFolder.FullName)\__init__.py"
        $exists = Get-Item -Path $subFolderPath -ErrorAction SilentlyContinue
        if ($exists) {
            Remove-Item -Path $subFolderPath -ErrorAction SilentlyContinue
        } else {
            Write-Output $subFolderPath # New-Item -Path $subFolderPath -ItemType "file" -Force
        }
        
        $paths += $subFolderPath
    }

    $paths += $RootFolderPath

    $paths | ConvertTo-Json | Out-File -FilePath $jsonPath -Force
}

# Optimized Method
# -delete generated path json file when your folder structure changes
function OptimizedMethod {
    $paths = Get-Content -Path $jsonPath | ConvertFrom-Json

    Foreach($path in $paths) {
        if (Test-Path $path) {
            Remove-Item -Path $path -Force -Recurse -ErrorAction SilentlyContinue
        }
    }
}

# Determine which method to use based on the existence of paths_remove.json
if ($saved_data) {
    OptimizedMethod
} else {
    StandardMethod
}

$message = "Removed all necessary python __init__.py files."

# Output the message
Write-Output $message

