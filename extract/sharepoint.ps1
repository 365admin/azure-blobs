<#---
title: Get Item
connection: sharepoint
output: blobdata.json
tag: get-item
---


#>
param(
    [string]$siteUrl = "https://christianiabpos.sharepoint.com/sites/DeviceReporting"

)

<#

## Connect to SharePoint Online and get list items
#>

Connect-PnPOnline -Url $siteUrl  -ClientId $PNPAPPID -Tenant $PNPTENANTID -CertificatePath "$PNPCERTIFICATEPATH"

$listItems = Get-PnpListItem -List "KPI Data"  

write-host "Items in list: $($listItems.Count)"

$item = $listItems | Select-Object -First 1

<#
## Build JSON data
#>


$jsondata = @"
	{
		"created": "2023-09-18T00:00:00Z",
		"w5": [
			{
				"num": "$($item.FieldValues.workstationswithantivirusmonitor)",
				"den": "$($item.FieldValues.totalworkstations)"
			}
		],
		"w6": [
			{
				"num": "$($item.FieldValues.workstationswithDLPmonitored)",
				"den": "$($item.FieldValues.totalworkstations)"
			}
		],
		"w4": [
			{
				"num": "$($item.FieldValues.workstationswithanti_x002d_malwa)",
				"den": "$($item.FieldValues.totalworkstations)"
			}
		],
		"w3": [
			{
				"num": "$($item.FieldValues.workstationsprotectedbyencryptio)",
				"den": "$($item.FieldValues.totalworkstations)"
			}
		],
		"w2": [
			{
				"num": "$($item.FieldValues.mobileswithactiveMDMsegregation)",
				"den": "$($item.FieldValues.totalmobiles)"
			}
		],
		"w8": [
			{
				"num": "$($item.FieldValues.workstationswithsystemsoftwareup)",
				"den": "$($item.FieldValues.totalworkstations)"
			}
		],
		"w7a": [
			{
				"num": "$($item.FieldValues.userswithUSBenabled_x0028_withen)"
			}
		],
		"w7b": [
			{
				"num": "$($item.FieldValues.userswithUSBenabled_x0028_withou)"
			}
		],
		"cs11": [
			{
				"num": "$($item.FieldValues.SPAMMailofpreviousmonth)"
			}
		]
	}
"@


<#
## Write JSON data to file
#>
   
$result = "$env:WORKDIR/blobdata.json"

$jsondata | Out-File -FilePath $result -Encoding utf8NoBOM
