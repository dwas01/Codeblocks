<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ApiManagement.output.tests.ps1

		Purpose:	Test - Api Management Service ARM Template Output Variables

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
		This script contains functionality used to test Api Management Service ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Api Management Service ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER apimServiceName
		Specify the Api Management Service Name output parameter.

	.PARAMETER apimServiceResourceId
		Specify the Api Management Service ResourceId output parameter.

	.PARAMETER apimServiceResourceGroup
		Specify the Api Management Service ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ApiManagement.output.tests.ps1
			-apimServiceName "$(apimServiceName)"
			-apimServiceResourceId "$(apimServiceResourceId)"
			-apimServiceResourceGroup "$(apimServiceResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$apimServiceName,

	[Parameter(Mandatory = $false)]
	[string]$apimServiceResourceId,

	[Parameter(Mandatory = $false)]
	[string]$apimServiceResourceGroup
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['apimServiceName']))
{
	Write-Output "Api Management Service Name: $($apimServiceName)"
}
else
{
	Write-Output "Api Management Service Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['apimServiceResourceId']))
{
	Write-Output "Api Management Service ResourceId: $($apimServiceResourceId)"
}
else
{
	Write-Output "Api Management Service ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['apimServiceResourceGroup']))
{
	Write-Output "Api Management Service Resource Group: $($apimServiceResourceGroup)"
}
else
{
	Write-Output "Api Management Service Resource Group: []"
}
#endregion