<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		ApplicationInsights.output.tests.ps1

		Purpose:	Test - Application Insights ARM Template Output Variables

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
		This script contains functionality used to test Application Insights ARM Template Output Variables.

	.DESCRIPTION
		This script contains functionality used to test Application Insights ARM Template Output Variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER appInsightsName
		Specify the Application Insights Name output parameter.

	.PARAMETER appInsightsResourceId
		Specify the Application Insights Resource Id output parameter.

	.PARAMETER appInsightsResourceGroup
		Specify the Application Insights ResourceGroup output parameter.

	.PARAMETER appInsightsKey
		Specify the Application Insights Instrumentation Key output parameter.

	.PARAMETER appInsightsAppId
		Specify the Application Insights AppId output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\ApplicationInsights.output.tests.ps1
			-appInsightsName "$(appInsightsName)"
			-appInsightsResourceId "$(appInsightsResourceId)"
			-appInsightsResourceGroup "$(appInsightsResourceGroup)"
			-appInsightsKey "$(appInsightsKey)"
			-appInsightsAppId "$(appInsightsAppId)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$appInsightsName,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsResourceId,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsResourceGroup,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsKey,

	[Parameter(Mandatory = $false)]
	[string]$appInsightsAppId
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsName']))
{
	Write-Output "Application Insights Name: $($appInsightsName)"
}
else
{
	Write-Output "Application Insights Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsResourceId']))
{
	Write-Output "Application Insights ResourceId: $($appInsightsResourceId)"
}
else
{
	Write-Output "Application Insights Resource Id: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsResourceGroup']))
{
	Write-Output "Application Insights ResourceGroup: $($appInsightsResourceGroup)"
}
else
{
	Write-Output "Application Insights ResourceGroup: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsKey']))
{
	Write-Output "Application Insights Instrumentation Key: $($appInsightsKey)"
}
else
{
	Write-Output "Application Insights Instrumentation Key: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['appInsightsAppId']))
{
	Write-Output "Application Insights AppId: $($appInsightsAppId)"
}
else
{
	Write-Output "Application Insights AppId: []"
}
#endregion