<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		KubernetesAKS.role.assignment.ps1

		Purpose:	Configures Kubernetes Cluster Service Principal Name (SPN) Network Contributor access

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
		This script configures the Kubernetes Cluster Service Principal Name (SPN) Network Contributor access.

	.DESCRIPTION
		This script configures the Kubernetes Cluster Service Principal Name (SPN) Network Contributor access to the vNet
		containing the Kubernets Cluster
	
	.PARAMETER aksClusterSPNId
		Specify the Kubernetes Cluster Service Principal Name Id output parameter.
		
	.PARAMETER aksClustervNetName
		Specify the Kubernetes Virtual Network Resource Name.

	.EXAMPLE
		Default:
		C:\PS>.\KubernetesAKS.role.assignment.ps1
			-aksClusterSPNId "$(aksClusterSPNId)"
			-aksClustervNetName "$(aksClustervNetName)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $true)]
	[string]$aksClusterSPNId,
	
	[Parameter(Mandatory = $true)]
	[string]$aksClustervNetName
)

#region - Set Kubernetes Role Assignment
Write-Output "AKS Cluster SPN Id: $aksClusterSPNId"
Write-Output "AKS Cluster Subnet Id: $aksClustervNetName"

# Get the Service Principal Object Id to assignment permissions to
$aksClusterSPNObjectId = (Get-AzADServicePrincipal -ApplicationId $aksClusterSPNId).id

# Get the Resource Id as scope for the assignment
$aksvNetId = (Get-AzVirtualNetwork -Name "$aksClustervNetName").Id

# Check if Assignment exists
$paramGetAzRoleAssignment = @{
	ObjectId           = $aksClusterSPNObjectId
	RoleDefinitionName = "Network Contributor"
	Scope              = $aksvNetId
	ErrorAction        = 'SilentlyContinue'
}
if (Get-AzRoleAssignment @paramGetAzRoleAssignment)
{
	Write-Output "Role Assignment already exists - skipping..."
}
else
{
	Write-Output "Creating New Role Assignment"
	$paramNewAzRoleAssignment = @{
		ObjectId           = $aksClusterSPNObjectId
		RoleDefinitionName = "Network Contributor"
		Scope              = $aksvNetId
	}
	New-AzRoleAssignment @paramNewAzRoleAssignment
	
	if (Get-AzRoleAssignment @paramGetAzRoleAssignment)
	{
		Write-Output "Created New Role Assignment"
	}
	else
	{
		Write-Output "Failed to creat New Role Assignment"
	}
}
#endregion