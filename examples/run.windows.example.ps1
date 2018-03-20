## Please configure the following!

$install_path = "D:\bash-backup"
$files_to_backup = "C:\Users\Harry\Important-Files"
$backup_location = "C:\Users\Harry\Desktop\backup"

## DON'T EDIT BELOW THIS LINE

$drive_exists = Test-Path "$install_path/README.md"

if ($drive_exists -eq $false)
{
	Write-Host "Unable to locate the install path"
	Exit
}

$drive_exists = Test-Path "$files_to_backup"

if ($drive_exists -eq $false)
{
	Write-Host "Unable to locate the drive to back up"
	Exit
}

$drive_exists = Test-Path "$backup_location"

if ($drive_exists -eq $false)
{
	Write-Host "Unable to locate the drive to store backup files in"
	Exit
}

Write-Host "Ensure we have the latest version of BASH-backup"
git -C $install_path pull

Write-Host "Build the latest version of BASH-backup"
docker build -t bash_backup:latest ./

Write-Host "Execute a backup run"
docker run -h bash-backup --rm --mount type=bind,source="$files_to_backup,target=/backup/source" --mount type=bind,source="$backup_location,target=/backup/destination" bash_backup:latest
