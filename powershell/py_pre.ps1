


# Root folder
$RootFolder = Join-Path -Path (Get-Location).Path -ChildPath "python"

$jsonPath = Join-Path -Path (Get-Location).Path -ChildPath "powershell\json_pre_loading\paths.json" 

# Check if paths.json exists
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
        Write-Output $RootFolderPath
    } else {
        New-Item -Path $RootFolderPath -ItemType "file" -Force -ErrorAction SilentlyContinue
    }

    $paths = @()

    Foreach($SubFolder in $SubFolders) {
        $subFolderPath = "$($SubFolder.FullName)\__init__.py"
        $exists = Get-Item -Path $subFolderPath -ErrorAction SilentlyContinue
        if ($exists) {
            Write-Output $subFolderPath
        } else {
            New-Item -Path $subFolderPath -ItemType "file" -Force
            $paths += $subFolderPath
        }
    }

    $paths += $RootFolderPath

    $paths | ConvertTo-Json | Out-File -FilePath $jsonPath -Force
}

# Optimized Method
# -delete generated path json file when your folder structure changes
function OptimizedMethod {
    $paths = Get-Content -Path $jsonPath | ConvertFrom-Json

    Foreach($path in $paths) {
        if (-not (Test-Path $path)) {
            New-Item -Path $path -ItemType "file" -Force
        }
    }
}

# Determine which method to use based on the existence of paths.json
if ($saved_data) {
    OptimizedMethod
} else {
    StandardMethod
}

$message = "Created all necessary python __init__.py files."

# Output the message
Write-Output $message




