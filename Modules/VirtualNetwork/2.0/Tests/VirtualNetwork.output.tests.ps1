<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		VirtualNetwork.output.tests.ps1

		Purpose:	Test - Virtual Network ARM Template Output Variables

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
		This script contains functionality used to test Virtual Network ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Virtual Network ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER virtualNetworkName
		Specify the Virtual Network Name output parameter.

	.PARAMETER virtualNetworkResourceId
		Specify the Virtual Network ResourceId output parameter.

	.PARAMETER virtualNetworkResourceGroup
		Specify the Virtual Network ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\VirtualNetwork.output.tests.ps1
			-virtualNetworkName "$(virtualNetworkName)"
			-virtualNetworkResourceId "$(virtualNetworkResourceId)"
			-virtualNetworkResourceGroup "$(virtualNetworkResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$virtualNetworkName,

	[Parameter(Mandatory = $false)]
	[string]$virtualNetworkResourceId,

	[Parameter(Mandatory = $false)]
	[string]$virtualNetworkResourceGroup
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['virtualNetworkName']))
{
	Write-Output "Virtual Network Name: $($virtualNetworkName)"
}
else
{
	Write-Output "Virtual Network Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['virtualNetworkResourceId']))
{
	Write-Output "Virtual Network ResourceId: $($virtualNetworkResourceId)"
}
else
{
	Write-Output "Virtual Network ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['virtualNetworkResourceGroup']))
{
	Write-Output "Virtual Network Resource Group: $($virtualNetworkResourceGroup)"
}
else
{
	Write-Output "Virtual Network Resource Group: []"
}
#endregion