<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		applicationSecurityGroup.output.tests.ps1

		Purpose:	Test - Application Security Groups ARM Template Output Variables

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
		This script contains functionality used to test Application Security Groups ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Application Security Groups ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER applicationSecurityGroupName
		Specify the Application Security Group Name output parameter.

	.PARAMETER applicationSecurityGroupResourceId
		Specify the Application Security Group ResourceId output parameter.

	.PARAMETER applicationSecurityGroupResourceGroup
		Specify the Application Security Group ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\applicationSecurityGroup.output.tests.ps1
			-applicationSecurityGroupName "$(applicationSecurityGroupName)"
			-applicationSecurityGroupResourceId "$(applicationSecurityGroupResourceId)"
			-applicationSecurityGroupResourceGroup "$(applicationSecurityGroupResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$applicationSecurityGroupName,

	[Parameter(Mandatory = $false)]
	[string]$applicationSecurityGroupResourceId,

	[Parameter(Mandatory = $false)]
	[string]$applicationSecurityGroupResourceGroup
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['applicationSecurityGroupName']))
{
	Write-Output "Application Security Group Name: $($applicationSecurityGroupName)"
}
else
{
	Write-Output "Application Security Group Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['applicationSecurityGroupResourceId']))
{
	Write-Output "Application Security Group ResourceId: $($applicationSecurityGroupResourceId)"
}
else
{
	Write-Output "Application Security Group ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['applicationSecurityGroupResourceGroup']))
{
	Write-Output "Application Security Group Resource Group: $($applicationSecurityGroupResourceGroup)"
}
else
{
	Write-Output "Application Security Group Resource Group: []"
}
#endregion