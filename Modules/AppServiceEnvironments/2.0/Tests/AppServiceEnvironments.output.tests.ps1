<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		AppServiceEnvironments.output.testss.ps1

		Purpose:	Test - Application Service Environment ARM Template Output Variables

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
		This script contains functionality used to test Application Service Environment ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Application Service Environment ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER appServiceEnvironmentName
		Specify the Application Service Environment Name output parameter.

	.PARAMETER appServiceEnvironmentResourceId
		Specify the Application Service Environment ResourceId output parameter.

	.PARAMETER appServiceEnvironmentResourceGroup
		Specify the Application Service Environment ResourceGroup output parameter.

	.PARAMETER appServiceEnvironmentWebPortalURL
		Specify the Application Service Environment Web Portal URL output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\appServiceEnvironment.output.tests.ps1
			-appServiceEnvironmentName "$(appServiceEnvironmentName)"
			-appServiceEnvironmentResourceId "$(appServiceEnvironmentResourceId)"
			-appServiceEnvironmentResourceGroup "$(appServiceEnvironmentResourceGroup)"
			-appServiceEnvironmentWebPortalURL "$(appServiceEnvironmentWebPortalURL)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$appServiceEnvironmentName,

	[Parameter(Mandatory = $false)]
	[string]$appServiceEnvironmentResourceId,

	[Parameter(Mandatory = $false)]
	[string]$appServiceEnvironmentResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$appServiceEnvironmentWebPortalURL
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appServiceEnvironmentName']))
{
	Write-Output "Application Service Environment Name: $($appServiceEnvironmentName)"
}
else
{
	Write-Output "Application Service Environment Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appServiceEnvironmentResourceId']))
{
	Write-Output "Application Service Environment ResourceId: $($appServiceEnvironmentResourceId)"
}
else
{
	Write-Output "Application Service Environment ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appServiceEnvironmentResourceGroup']))
{
	Write-Output "Application Service Environment Resource Group: $($appServiceEnvironmentResourceGroup)"
}
else
{
	Write-Output "Application Service Environment Resource Group: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appServiceEnvironmentWebPortalURL']))
{
	Write-Output "Application Service Environment Web Portal URL: $($appServiceEnvironmentWebPortalURL)"
}
else
{
	Write-Output "Application Service Environment Web Portal URL: []"
}
#endregion