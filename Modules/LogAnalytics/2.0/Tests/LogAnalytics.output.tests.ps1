<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		LogAnalytics.output.tests.ps1

		Purpose:	Test - Log Analytics ARM Template Output Variables

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
		This script contains functionality used to test Log Analytics ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Log Analytics ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER logAnalyticsName
		Specify the Log Analytics Workspace Name Id output parameter.

	.PARAMETER logAnalyticsResourceId
		Specify the Log Analytics Resource Id output parameter.

	.PARAMETER logAnalyticsResourceGroup
		Specify the Log Analytics Workspace Resource Group output parameter.

	.PARAMETER logAnalyticsWorkspaceId
		Specify the Log Analytics Workspace Id output parameter.

	.PARAMETER logAnalyticsPrimarySharedKey
		Specify the Log Analytics Primary Shared Key output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\LogAnalytics.output.tests.ps1
			-logAnalyticsName "$(logAnalyticsName)"
			-logAnalyticsResourceId "$(logAnalyticsResourceId)"
			-logAnalyticsResourceGroup "$(logAnalyticsResourceGroup)"
			-logAnalyticsWorkspaceId "$(logAnalyticsWorkspaceId)"
			-logAnalyticsPrimarySharedKey "$(logAnalyticsPrimarySharedKey)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[parameter(Mandatory = $false)]
	[string]$logAnalyticsName,

	[parameter(Mandatory = $false)]
	[string]$logAnalyticsResourceId,

	[parameter(Mandatory = $false)]
	[string]$logAnalyticsResourceGroup,

	[parameter(Mandatory = $false)]
	[string]$logAnalyticsWorkspaceId,

	[parameter(Mandatory = $false)]
	[string]$logAnalyticsPrimarySharedKey
)

#region - Output
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['logAnalyticsName']))
{
	Write-Output "Log Analytics Workspace Name: $($logAnalyticsName)"
}
else
{
	Write-Output "Log Analytics Workspace Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['logAnalyticsResourceId']))
{
	Write-Output "Log Analytics Resource Id: $($logAnalyticsResourceId)"
}
else
{
	Write-Output "Log Analytics Resource Id Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['logAnalyticsResourceGroup']))
{
	Write-Output "Log Analytics Workspace Resource Group: $($logAnalyticsResourceGroup)"
}
else
{
	Write-Output "Log Analytics Workspace Resource Group : []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['logAnalyticsWorkspaceId']))
{
	Write-Output "Log Analytics Workspace Id: $($logAnalyticsWorkspaceId)"
}
else
{
	Write-Output "Log Analytics Workspace Id: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['logAnalyticsPrimarySharedKey']))
{
	Write-Output "Log Analytics Primary Shared Key: $($logAnalyticsPrimarySharedKey)"
}
else
{
	Write-Output "Log Analytics Primary Shared Key: []"
}
#endregion