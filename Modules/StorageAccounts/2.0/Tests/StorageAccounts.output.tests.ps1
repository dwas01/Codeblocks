<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		StorageAccounts.output.tests.ps1

		Purpose:	Test - Storage Accounts ARM Template Output Variables

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
		This script contains functionality used to test Storage Account ARM template output variables.

	.DESCRIPTION
		This script contains functionality used to test Storage Account ARM template output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic to pipeline

	.PARAMETER storageAccountName
		Specify the Storage Account Name output parameter.

	.PARAMETER storageAccountResourceId
		Specify the Storage Account Resource Id output parameter.

	.PARAMETER storageAccountResourceGroup
		Specify the Storage Account Resource Group output parameter.

	.PARAMETER storageAccountAccessKey
		Specify the Storage Account Access Key output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\StorageAccounts.output.tests.ps1
			-storageAccountName "$(storageAccountName)"
			-storageAccountResourceId "$(storageAccountResourceId)"
			-storageAccountResourceGroup "$(storageAccountResourceGroup)"
			-storageAccountAccessKey "$(storageAccountAccessKey)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$storageAccountName,

	[Parameter(Mandatory = $false)]
	[string]$storageAccountResourceId,

	[Parameter(Mandatory = $false)]
	[string]$storageAccountResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$storageAccountAccessKey
)

#region - Output Tests
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['storageAccountName']))
{
	Write-Output "Storage Account Name: $($storageAccountName)"
}
else
{
	Write-Output "Storage Account Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['storageAccountResourceId']))
{
	Write-Output "Storage Account ResourceId: $($storageAccountResourceId)"
}
else
{
	Write-Output "Storage Account ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['storageAccountResourceGroup']))
{
	Write-Output "Storage Account Resource Group: $($storageAccountResourceGroup)"
}
else
{
	Write-Output "Storage Account Resource Group : []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['storageAccountAccessKey']))
{
	Write-Output "Storage Account Access Key: $($storageAccountAccessKey)"
}
else
{
	Write-Output "Storage Account Access Key: []"
}
#endregion