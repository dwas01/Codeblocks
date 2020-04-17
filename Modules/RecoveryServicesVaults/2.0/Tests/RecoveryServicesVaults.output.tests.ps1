<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		RecoveryServicesVaults.output.tests.ps1

		Purpose:	Test - Recovery Services Vaults ARM Template Output Variables

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
		This script contains functionality used to test Recovery Services Vaults ARM Templates output variables.

	.DESCRIPTION
		This script contains functionality used to test Recovery Services Vaults ARM Templates output variables.

		Deployment steps of the script are outlined below.
			1) Outputs Variable Logic from pipeline

	.PARAMETER recoveryServicesVaultsName
		Specify the Recovery Services Vaults Name output parameter.

	.PARAMETER recoveryServicesVaultsResourceId
		Specify the Recovery Services Vaults ResourceId output parameter.

	.PARAMETER recoveryServicesVaultsResourceGroup
		Specify the Recovery Services Vaults ResourceGroup output parameter.

	.EXAMPLE
		Default:
		C:\PS>.\RecoveryServicesVaults.output.tests.ps1
			-recoveryServicesVaultsName "$(recoveryServicesVaultsName)"
			-recoveryServicesVaultsResourceId "$(recoveryServicesVaultsResourceId)"
			-recoveryServicesVaultsResourceGroup "$(recoveryServicesVaultsResourceGroup)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$recoveryServicesVaultsName,

	[Parameter(Mandatory = $false)]
	[string]$recoveryServicesVaultsResourceId,

	[Parameter(Mandatory = $false)]
	[string]$recoveryServicesVaultsResourceGroup
)

#region - Outputs
if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['recoveryServicesVaultsName']))
{
	Write-Output "Recovery Services Vaults Name: $($recoveryServicesVaultsName)"
}
else
{
	Write-Output "Recovery Services Vaults Name: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['recoveryServicesVaultsResourceId']))
{
	Write-Output "Recovery Services Vaults ResourceId: $($recoveryServicesVaultsResourceId)"
}
else
{
	Write-Output "Recovery Services Vaults ResourceId: []"
}

if (-not [string]::IsNullOrWhiteSpace($PSBoundParameters['recoveryServicesVaultsResourceGroup']))
{
	Write-Output "Recovery Services Vaults Resource Group: $($recoveryServicesVaultsResourceGroup)"
}
else
{
	Write-Output "Recovery Services Vaults Resource Group: []"
}
#endregion