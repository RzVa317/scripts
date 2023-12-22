$List = ls;$Count = 1;$List.foreach{
		$DirName = "Season ";
		$DirName += ("{0:D2}" -f $count);
		Write-Host $DirName;
		#Rename-Item -Path $_ -NewName $DirName;
		$Count++
}