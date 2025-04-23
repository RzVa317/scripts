function Start-FilenameFixer {
	$Title = "Filename Fixer!"
	Write-Host "$Title"
	#$WorkingDir = Read-Host "Enter directory to work in"
	$WorkingDir = 'O:\DLs\Invader ZIM (2001) [tmdbid-3793]\Season 02'
	Push-Location -LiteralPath $WorkingDir
	$FilesToRename = Get-ChildItem -File | Sort-Object -Unique
	ForEach ($File in $FilesToRename) {
		$FileName = $File.name
		Write-Host "$FileName" -NoNewline -ForegroundColor DarkYellow
		Write-Host " will be renamed to:"
		# Using .Replace for literal match of string, -replace would be for Regex
		$NewName = $FileName.Replace("Invader Zim_", "Episode ")
		$NewName = $NewName.Replace("_"," ")
		$NewName = $NewName.Replace("(2)","")
		Write-Host $NewName -ForegroundColor DarkGreen
		Rename-Item -Path $File -NewName $NewName
	}
	Pop-Location
}
Start-FilenameFixer