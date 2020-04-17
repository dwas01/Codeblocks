<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		Cosmosdb.provision.rule.setcollection.ps1

		Purpose:	Deploys Cosmosdb Database Account Provision RuleSet Collection

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
		This script deploys Cosmosdb Database Account Provision RuleSet Collection

	.DESCRIPTION
		This script deploys Cosmosdb Database Account Provision RuleSet Collection

		Deployment steps of the script are outlined below.
			1) Import CosmosDB PowerShell Module
			2) Azure Parameter Configuration
			3) Cosmosdb Database creation if required
			4) Cosmosdb Collection Configuration

	.PARAMETER azureSearchName
		Specify the Azure Search Name parameter.

	.PARAMETER cosmosdbAccountName
		Specify the Cosmosdb Database Account Name parameter.

	.PARAMETER cosmosdbAccountKey
		Specify the Cosmosdb Database Account Primary Master Key parameter.

	.PARAMETER cosmosdbName
		Specify the Cosmosdb Database Name parameter.

	.PARAMETER cosmosdbContainerName
		Specify the Cosmosdb Database Container Name parameter.

	.PARAMETER cosmosdbResourceGroup
		Specify the Cosmosdb Database Account ResourceGroup parameter.

	.EXAMPLE
		Default:
		C:\PS>.\Cosmosdb.provision.rule.setcollection.ps1
			-cosmosdbAccountName "$(cosmosdbAccountName)"
			-cosmosdbAccountKey "$(cosmosdbAccountKey)"
			-cosmosdbName "$(cosmosdbName)"
			-cosmosdbContainerName "$cosmosdbContainerName)"
			-cosmosdbResourceGroup "$(cosmosdbResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$cosmosdbAccountName,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbAccountKey,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbName,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbContainerName,

	[Parameter(Mandatory = $false)]
	[string]$cosmosdbResourceGroup
)

#region - Import CosmosDB PowerShell Module
$paramInstallPackageProvider = @{
	Name  = 'NuGet'
	Force = $true
	Scope = 'CurrentUser'
}
Install-PackageProvider @paramInstallPackageProvider

$paramInstallModule = @{
	Name            = 'CosmosDB'
	RequiredVersion = '2.1.15.239'
	Force           = $true
	Verbose         = $true
	Scope           = 'CurrentUser'
}
Install-Module @paramInstallModule
#endregion

#region - Azure Parameter Configuration
Write-Output "Cosmosdb Account Name:          $cosmosdbAccountName"
Write-Output "Cosmosdb Account Key:           $cosmosdbAccountKey"
Write-Output "Cosmosdb Database Name:         $cosmosdbName"
Write-Output "Cosmosdb Container Name:        $cosmosdbContainerName"
Write-Output "Cosmosdb Resource Group Name:   $cosmosdbResourceGroup"

$cosmosdbPartitionKeyPath = "Identifier"

$paramNewCosmosDbContext = @{
	Account           = $cosmosdbAccountName
	Database          = $cosmosdbName
	ResourceGroupName = $cosmosdbResourceGroup
	MasterKeyType     = 'PrimaryMasterKey'
}
$cosmosdbContext = New-CosmosDbContext @paramNewCosmosDbContext

try
{
	$paramGetCosmosDbDatabase = @{
		Context = $cosmosdbContext
		Id      = $cosmosdbName
	}
	$cosmosdbDatabase = Get-CosmosDbDatabase @paramGetCosmosDbDatabase
}
catch
{
	if ($cosmosdbDatabase)
	{
		Write-Output "Existing cosmosdb database: $cosmosdbName - Skipping"
	}
	else
	{
		Write-Output "Creating New cosmosdb database: $cosmosdbName"

		$paramNewCosmosDbDatabase = @{
			Context = $cosmosdbContext
			Id      = $cosmosdbName
		}
		New-CosmosDbDatabase @paramNewCosmosDbDatabase
	}
}
#endregion

#region - cosmosDB Collection Configuration
try
{
	$paramGetCosmosDbCollection = @{
		Context = $cosmosdbContext
		Id      = $cosmosdbContainerName
	}
	$cosmosdbCollection = Get-CosmosDbCollection @paramGetCosmosDbCollection
}
catch
{
	if ($cosmosdbCollection)
	{
		Write-Output "cosmosDB Collection Configuration already exists - Skipping"
	}
	else
	{
		Write-Output "Performing cosmosDB Collection Configuration"

		$paramNewCosmosDbCollectionIncludedPathIndex = @{
			Kind      = 'Hash'
			DataType  = 'String'
			Precision = 3
		}
		$indexStringHash = New-CosmosDbCollectionIncludedPathIndex @paramNewCosmosDbCollectionIncludedPathIndex

		$paramNewCosmosDbCollectionIncludedPathIndex = @{
			Kind      = 'Range'
			DataType  = 'Number'
			Precision = -1
		}
		$indexNumberRange = New-CosmosDbCollectionIncludedPathIndex @paramNewCosmosDbCollectionIncludedPathIndex

		$paramNewCosmosDbCollectionIncludedPathIndex = @{
			Kind     = 'Spatial'
			DataType = 'Point'
		}
		$indexNumberSpatial = New-CosmosDbCollectionIncludedPathIndex @paramNewCosmosDbCollectionIncludedPathIndex

		$paramNewCosmosDbCollectionIncludedPath = @{
			Path  = '/*'
			Index = $indexStringHash, $indexNumberRange, $indexNumberSpatial
		}
		$indexIncludedPathAll = New-CosmosDbCollectionIncludedPath @paramNewCosmosDbCollectionIncludedPath

		$paramNewCosmosDbCollectionIncludedPath = @{
			Path  = '/Version/?'
			Index = $indexNumberRange
		}
		$indexIncludedPathVersion = New-CosmosDbCollectionIncludedPath @paramNewCosmosDbCollectionIncludedPath

		$paramNewCosmosDbCollectionIncludedPath = @{
			Path  = '/ApplicableDateUtcEpoch/?'
			Index = $indexNumberRange
		}
		$indexIncludedPathApplicableDateUtcEpoch = New-CosmosDbCollectionIncludedPath @paramNewCosmosDbCollectionIncludedPath

		$paramNewCosmosDbCollectionIndexingPolicy = @{
			Automatic    = $true
			IndexingMode = 'Consistent'
			IncludedPath = $indexIncludedPathAll, $indexIncludedPathVersion, $indexIncludedPathApplicableDateUtcEpoch
		}
		$indexingPolicy = New-CosmosDbCollectionIndexingPolicy @paramNewCosmosDbCollectionIndexingPolicy

		$paramNewCosmosDbCollection = @{
			Context         = $cosmosdbContext
			Id              = $cosmosdbContainerName
			PartitionKey    = $cosmosdbPartitionKeyPath
			IndexingPolicy  = $indexingPolicy
			OfferThroughput = 10000
		}
		New-CosmosDbCollection @paramNewCosmosDbCollection
	}
}
#endregion