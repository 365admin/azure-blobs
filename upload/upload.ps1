<#---
title: Upload

connection: sharepoint
input: blobdata.json

tag: upload
---

#>

param 
(
  
    [string]$SAS = $env:BLOBFILE
 
)
$body = Get-Content "$env:WORKDIR/blobdata.json" 




$result = Invoke-WebRequest -Uri $SAS -Method PUT -Body $body -Headers @{
    'contenttype'    = 'application/json'
    'x-ms-blob-type' = 'BlockBlob'
}

