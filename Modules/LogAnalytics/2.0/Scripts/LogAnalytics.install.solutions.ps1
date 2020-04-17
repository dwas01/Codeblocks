<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		LogAnalytics.install.solutions.ps1

		Purpose:	Install Log Analytics Solutions Automation

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
		Log Analytics install solutions deployment Automation Script

	.DESCRIPTION
		Log Analytics install solutions deployment Automation Script

		Deployment steps of the script are outlined below.
		1) Install Log Analytics Solutions

	.PARAMETER logAnalyticsWorkspaceName
		Specify the Log Analytics Workspace Name parameter.

	.PARAMETER solutions
		Specify the Solutions parameter.

	.EXAMPLE
		Default:
		C:\PS>.\LogAnalytics.install.solutions.ps1
			-logAnalyticsWorkspaceName "$(logAnalyticsWorkspaceName)"
			-solutions<"solutions A","solutions B">
#>

#Requires -Version 5
#Requires -Module Az.OperationalInsights

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$logAnalyticsWorkspaceName,

	[Parameter(mandatory = $true)]
	[string[]]$solutions = @()
)

#region - Install Log Analytics Solutions
$paramGetAzResource = @{
	ResourceName = $logAnalyticsWorkspaceName
	ResourceType = "Microsoft.OperationalInsights/workspaces"
}
$workspaceName = Get-AzResource @paramGetAzResource

foreach ($solution in $solutions)
{
	$paraSetAzOperationalInsightsIntelligencePack = @{
		ResourceGroupName    = $workspaceName.ResourceGroupName
		WorkspaceName        = $workspaceName.Name
		IntelligencePackName = $solution
		Enabled              = $true
	}
	Set-AzOperationalInsightsIntelligencePack @paraSetAzOperationalInsightsIntelligencePack
}
#endregion