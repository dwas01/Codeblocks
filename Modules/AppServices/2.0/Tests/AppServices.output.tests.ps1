<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		AppServices.output.tests.ps1

		Purpose:	Test - Application Web Services ARM Template Output Variables

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
		This script contains functionality used to test Application Web Services ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Application Web Services ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER appServiceName
		Specify the Application Web Services Name output parameter.

	.PARAMETER appServiceResourceId
		Specify the Application Web Services ResourceId output parameter.

	.PARAMETER appServiceResourceGroup
		Specify the Application Web Services ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\AppServices.output.tests.ps1
			-appServiceName "$(appServiceName)"
			-appServiceResourceId "$(appServiceResourceId)"
			-appServiceResourceGroup "$(appServiceResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$appServiceName,

	[Parameter(Mandatory = $false)]
	[string]$appServiceResourceId,

	[Parameter(Mandatory = $false)]
	[string]$appServiceResourceGroup
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appServiceName']))
{
	Write-Output "Application Web Services Name: $($appServiceName)"
}
else
{
	Write-Output "Application Web Services Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appServiceResourceId']))
{
	Write-Output "Application Web Services ResourceId: $($appServiceResourceId)"
}
else
{
	Write-Output "Application Web Services ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appServiceResourceGroup']))
{
	Write-Output "Application Web Services Resource Group: $($appServiceResourceGroup)"
}
else
{
	Write-Output "Application Web Services Resource Group: []"
}
#endregion