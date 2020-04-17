<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		Cosmosdb.firewall.ps1

		Purpose:	Config Cosmosdb Database Account Firewall Automation Script

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
		Config Cosmosdb Database Account Firewall Automation Script.

	.DESCRIPTION
		Config Cosmosdb Database Account Firewall Automation Script.

		Deployment steps of the script are outlined below.
			1) Config Cosmosdb Firewall

	.PARAMETER cosmosdbAccountName
		Specify the Cosmosdb Database Account Name parameter.

	.PARAMETER cosmosdbvNetResourceGroup
		Specify the Cosmosdb Database Account vNet Resource Group parameter.

	.PARAMETER cosmosdbvNetResourceName
		Specify the Cosmosdb Database Account vNet Resource Name parameter.

	.PARAMETER cosmosdbsubnetName
		Specify the Cosmosdb Database Account SubNet Name parameter.

	.PARAMETER cosmosdbResourceGroup
		Specify the Cosmosdb Database Account ResourceGroup parameter.

	.PARAMETER ipRangeFilter
		Specify the IP Address Filter Address Range parameter.

	.EXAMPLE
		Default:
		C:\PS>.\Cosmosdb.firewall.ps1
			-cosmosdbAccountName "$(cosmosdbAccountName)"
			-cosmosdbvNetResourceGroup "$(cosmosdbvNetResourceGroup)"
			-cosmosdbvNetResourceName "$(cosmosdbvNetResourceName)"
			-cosmosdbSubnetName "$(cosmosdbsubnetName)"
			-cosmosdbResourceGroup "$(cosmosdbResourceGroup)"
			-ipRangeFilter "$(ipRangeFilter)"
#>

#Requires -Version 5
#Requires -Module Az.Resources

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$cosmosdbAccountName,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbvNetResourceGroup,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbvnetResourceName,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbsubnetName,

	[Parameter(Mandatory = $true)]
	[string]$cosmosdbResourceGroup,

	[Parameter(Mandatory = $false)]
	$ipRangeFilter = "104.42.195.92,40.76.54.131,52.176.6.30,52.169.50.45,52.187.184.26"
)

#region - Config Cosmosdb Firewall
Write-Output "cosmosdb Account Name:            $cosmosdbAccountName"
Write-Output "cosmosdb vNet Resource Group:     $cosmosdbvNetResourceGroup"
Write-Output "cosmosdb vnet Resource Name:      $cosmosdbvnetResourceName"
Write-Output "cosmosdb Subnet Name:             $cosmosdbsubnetName"
Write-Output "cosmosdb Resource Group Name:     $cosmosdbResourceGroup"
Write-Output "IP Range Filter:                  $ipRangeFilter"

$paramGetAzResource = @{
	ResourceType      = "Microsoft.DocumentDB/databaseAccounts"
	ApiVersion        = "2015-04-08"
	ResourceName      = $cosmosdbAccountName
	ResourceGroupName = $cosmosdbResourceGroup
}
$cosmosdbConfiguration = Get-AzResource @paramGetAzResource

$paramGetAzVirtualNetwork = @{
	ResourceGroupName = $cosmosdbvNetResourceGroup
	Name              = $cosmosdbvNetResourceName
}
$vnProp = Get-AzVirtualNetwork @paramGetAzVirtualNetwork

$virtualNetworkRules = @(@{
	id = "$($vnProp.Id)/subnets/$cosmosdbsubnetName"
	ignoreMissingVNetServiceEndpoint = $true
})

$cosmosDBProperties = @{
	databaseAccountOfferType      = $cosmosdbConfiguration.Properties.databaseAccountOfferType
	consistencyPolicy             = $cosmosdbConfiguration.Properties.consistencyPolicy
	ipRangeFilter                 = $ipRangeFilter
	locations                     = $cosmosdbConfiguration.Properties.locations
	virtualNetworkRules           = $virtualNetworkRules
	isVirtualNetworkFilterEnabled = $true
}

$paramSetAzResource = @{
	ResourceType      = "Microsoft.DocumentDb/databaseAccounts"
	ApiVersion        = "2015-04-08"
	ResourceGroupName = $cosmosdbResourceGroup
	ResourceName      = $cosmosdbAccountName
	Properties        = $cosmosdbProperties
}
Set-AzResource @paramSetAzResource -Force
#endregion