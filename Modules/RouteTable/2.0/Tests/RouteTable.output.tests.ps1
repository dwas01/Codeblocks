<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		RouteTable.output.tests.ps1

		Purpose:	Test - Route Table ARM Template Output Variables

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
		All coded passwords or secrets supplied from input files must be created and provided by the customer.
		Ensure all passwords used by any script are generated and provided by the customer
		==============================================================================================

	.SYNOPSIS
		This script contains functionality used to test Route Table ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Route Table ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER routeTableName
		Specify the Route Table Name output parameter.

	.PARAMETER routeTableResourceId
		Specify the Route Table ResourceId output parameter.

	.PARAMETER routeTableResourceGroup
		Specify the Route Table ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\RouteTable.output.tests.ps1
			-routeTableName "$(routeTableName)"
			-routeTableResourceId "$(routeTableResourceId)"
			-routeTableResourceGroup "$(routeTableResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$routeTableName,

	[Parameter(Mandatory = $false)]
	[string]$routeTableResourceId,

	[Parameter(Mandatory = $false)]
	[string]$routeTableResourceGroup
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['routeTableName']))
{
	Write-Output "Route Table Name: $($routeTableName)"
}
else
{
	Write-Output "Route Table Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['routeTableResourceId']))
{
	Write-Output "Route Table ResourceId: $($routeTableResourceId)"
}
else
{
	Write-Output "Route Table ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['routeTableResourceGroup']))
{
	Write-Output "Route Table Resource Group: $($routeTableResourceGroup)"
}
else
{
	Write-Output "Route Table Resource Group: []"
}
#endregion