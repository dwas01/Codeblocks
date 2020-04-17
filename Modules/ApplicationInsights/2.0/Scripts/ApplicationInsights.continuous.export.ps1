<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ApplicationInsights.continuous.export.ps1

		Purpose:	Deploys Application Insights Continuous Export Configuration

		Version: 	2.0.0.0 - 1st October 2019 - Codeblock Development Team
		==============================================================================================

		DISCLAIMER
		==============================================================================================
		This script is not supported under any Microsoft standard support program or service.

		This script is provided AS IS without warranty of any kind.
		Microsoft further disclaims all implied warranties including, without limitation, any
		implied warranties of merchantability or of fitness for a particular purpose.

		The entire risk arising out of the use or performance of the script
		and documentation remains with you. In no event shall Microsoft, its authors,
		or anyone else involved in the creation, production, or delivery of the
		script be liable for any damages whatsoever (including, without limitation,
		damages for loss of business profits, business interruption, loss of business
		information, or other pecuniary loss) arising out of the use of or inability
		to use the sample scripts or documentation, even if Microsoft has been
		advised of the possibility of such damages.

		IMPORTANT
		==============================================================================================
		This script uses or is used to either create or sets passwords and secrets.
		All coded passwords or secrests supplied from input files must be created and provided by the customer.
		Ensure all passwords used by any script are generated and provided by the customer
		==============================================================================================

	.SYNOPSIS
		This script Deploys Application Insights Continuous Export Configuration

	.DESCRIPTION
		This script Deploys Application Insights Continuous Export Configuration

		Deployment steps of the script are outlined below.
		1) Azure Parameter Configuration
		2) Configure Application Insights Continuous Export

	.PARAMETER appInsightsName
		Specify the Azure Application Insights Name parameter.

	.PARAMETER storageAccountName
		Specify the Storage Account Name parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ApplicationInsights.continuous.export.ps1
			-appInsightsName "$(appInsightsName)"
			-storageAccountName "$(storageAccountName)"
#>

#Requires -Version 5
#Requires -Module Az.ApplicationInsights
#Requires -Module Az.Storage
#Requires -Module Az.Resources

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$appInsightsName,

	[Parameter(Mandatory = $true)]
	[string]$storageAccountName
)

#region - Application Insights Continuous Export Configuration
Write-Output "Application Insights Name:  $appInsightsName"
Write-Output "Storage Account Name:       $storageAccountName"

$paramGetAzResource = @{
	ResourceType = "Microsoft.Insights/components"
	ResourceName = $appInsightsName
}
$resource = Get-AzResource @paramGetAzResource
$resourceGroup = $resource.ResourceGroupName

$paramGetAzApplicationInsightsContinuousExport = @{
	ResourceGroupName = $resourceGroup
	Name              = $appInsightsName
}
$continuousExport = Get-AzApplicationInsightsContinuousExport @paramGetAzApplicationInsightsContinuousExport

if (-not ($continuousExport))
{
	$paramGetAzResource = @{
		ResourceType = "Microsoft.Storage/storageAccounts"
		ResourceName = $storageAccountName
	}
	$resource = Get-AzResource @paramGetAzResource

	$paramGetAzResource = @{
		ResourceId = $resource.Id
	}
	$resource = Get-AzResource @paramGetAzResource

	$paramInvokeAzResourceAction = @{
		Action     = 'listkeys'
		ResourceId = $resource.ResourceId
		Force      = $true
	}
	$storagekey = (Invoke-AzResourceAction @paramInvokeAzResourceAction).keys[0].value

	$paramNewAzStorageContext = @{
		StorageAccountName = $storageAccountName
		StorageAccountKey  = $storagekey
	}
	$context = New-AzStorageContext @paramNewAzStorageContext

	$paramNewAzStorageContainer = @{
		Name       = "appinsights"
		Context    = $context
		Permission = 'Off'
	}
	New-AzStorageContainer @paramNewAzStorageContainer

	$paramNewAzStorageContainerSASToken = @{
		Name       = "appinsights"
		Context    = $context
		ExpiryTime = (Get-Date).AddYears(50)
		Permission = 'w'
	}
	$sasToken = New-AzStorageContainerSASToken @paramNewAzStorageContainerSASToken
	$sasURI = $resource.Properties.primaryEndpoints.blob + "appinsights" + $sasToken

	$paramNewAzApplicationInsightsContinuousExport = @{
		ResourceGroupName = $ResourceGroup
		Name              = $appInsightsName
		DocumentType      = "Request", "Exception", "Custom Event", "Metric", "Page Load", "Page View", "Dependency", "Availability", "Performance Counter"
		StorageAccountId  = $resource.ResourceId
		StorageLocation   = $resource.Properties.primaryLocation
		StorageSASUri     = $sasURI
		ErrorAction       = 'Stop'
	}
	New-AzApplicationInsightsContinuousExport @paramNewAzApplicationInsightsContinuousExport
}
else
{
	Write-Output "Skipping - Existing Application Insights Continuous Export Configuration Found"
}
#endregion