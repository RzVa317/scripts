$Season = "S02";$List = ls;$Count = 1;$List.foreach{
    $Episode = $_.split($Season)[0];
    $ext = $_.split(".")[1];
    $FileName = "Episode $Season"+"E";
    $FileName += ("{0:D2}" -f $count) + ".$ext";
    Write-Host $FileName;
    Rename-Item -Path $_ -NewName $FileName;
    $Count++
}