<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		BlobStorageAccounts.output.tests.ps1

		Purpose:	Test - Blob Storage Account ARM Template Output Variables

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
		This script contains functionality used to test Blob Storage Account ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Blob Storage Account ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER blobstorageName
		Specify the Blob Storage Account Name output parameter.

	.PARAMETER blobstorageResourceId
		Specify the Blob Storage Account ResourceId output parameter.

	.PARAMETER blobstorageResourceGroup
		Specify the Blob Storage Account ResourceGroup output parameter.

	.PARAMETER blobstorageConnectionString
		Specify the Blob Storage Account Connection String output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\BlobStorageAccounts.output.tests.ps1
			-blobstorageName "$(blobstorageName)"
			-blobstorageResourceId "$(blobstorageResourceId)"
			-blobstorageResourceGroup "$(blobstorageResourceGroup)"
			-blobstorageConnectionString "$(blobstorageConnectionString)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$blobstorageName,

	[Parameter(Mandatory = $false)]
	[string]$blobstorageResourceId,

	[Parameter(Mandatory = $false)]
	[string]$blobstorageResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$blobstorageConnectionString
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['blobstorageName']))
{
	Write-Output "Blob Storage Accounts Name: $($blobstorageName)"
}
else
{
	Write-Output "Blob Storage Account Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['blobstorageResourceId']))
{
	Write-Output "Blob Storage Account ResourceId: $($blobstorageResourceId)"
}
else
{
	Write-Output "Blob Storage Account ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['blobstorageResourceGroup']))
{
	Write-Output "Blob Storage Account Resource Group: $($blobstorageResourceGroup)"
}
else
{
	Write-Output "Blob Storage Account Resource Group: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['blobstorageConnectionString']))
{
	Write-Output "Blob Storage Account Connection String: $($blobstorageConnectionString)"
}
else
{
	Write-Output "Blob Storage Account Connection String: []"
}
#endregion