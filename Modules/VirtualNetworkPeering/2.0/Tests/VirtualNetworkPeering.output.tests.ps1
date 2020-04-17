<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		VirtualNetworkPeering.output.tests.ps1

		Purpose:	Test - Virtual Network Peering ARM Template Output Variables

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
		This script contains functionality used to test Virtual Network Peering ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Virtual Network Peering ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER vNetPeeringName
		Specify the Virtual Network Peering Name output parameter.

	.PARAMETER vNetPeeringResourceId
		Specify the Virtual Network Peering ResourceId output parameter.

	.PARAMETER vNetPeeringResourceGroup
		Specify the Virtual Network Peering ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\VirtualNetworkPeering.output.tests.ps1
			-vNetPeeringName "$(vNetPeeringName)"
			-vNetPeeringResourceId "$(vNetPeeringResourceId)"
			-vNetPeeringResourceGroup "$(vNetPeeringResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$vNetPeeringName,

	[Parameter(Mandatory = $false)]
	[string]$vNetPeeringResourceId,

	[Parameter(Mandatory = $false)]
	[string]$vNetPeeringResourceGroup
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['vNetPeeringName']))
{
	Write-Output "Virtual Network Peering Name: $($vNetPeeringName)"
}
else
{
	Write-Output "Virtual Network Peering Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['vNetPeeringResourceId']))
{
	Write-Output "Virtual Network Peering ResourceId: $($vNetPeeringResourceId)"
}
else
{
	Write-Output "Virtual Network Peering ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['vNetPeeringResourceGroup']))
{
	Write-Output "Virtual Network Peering Resource Group: $($vNetPeeringResourceGroup)"
}
else
{
	Write-Output "Virtual Network Peering Resource Group: []"
}
#endregion