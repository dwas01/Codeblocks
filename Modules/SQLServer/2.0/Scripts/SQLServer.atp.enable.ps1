<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		Microsoft Consulting Services - CodeBlocks (v2.0)

		File:		SQLServer.atp.enable.ps1

		Purpose:	Set Advanced Threat Protection for SQL Server Automation Script

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
		Set Advanced Threat Protection for SQL Server Automation Script

	.DESCRIPTION
		Set Advanced Threat Protection for SQL Server Automation Script

		Deployment steps of the script are outlined below.
		1) Turn on Advanced Threat Protection on the server
		2) Set up Vulnerability Assessment for all databases on that server.

	.PARAMETER resourceGroupName
	    Specify the Azure Resource Group for the SQL Server parameter.

	.PARAMETER sqlServerName
		Specify the SQL Server Name parameter.

	.PARAMETER sqldbName
		Specify the SQL database Name parameter.

	.PARAMETER storageAccount
		Specify the Storage Account Name parameter.

	.EXAMPLE
		Default:
		C:\PS>.\SQLServer.atp.enable.ps1
			-resourceGroupName "$(resourceGroupName)"
			-sqlServerName "$(sqlServerName)"
			-sqldbName "$(sqldbName)"
			-storageAccount "$(storageAccount)"
#>

#Requires -Version 5

[CmdletBinding()]
param
(
	[Parameter(Mandatory = $false)]
	[string]$resourceGroupName,

	[Parameter(Mandatory = $false)]
	[string]$sqlServerName,

	[Parameter(Mandatory = $false)]
	[string]$sqldbName,

	[Parameter(Mandatory = $false)]
	[string]$storageAccount
)

#region - Turn on Advanced Threat Protection
$paramEnableAzureRmSqlServerAdvancedThreatProtection = @{
	ResourceGroupName = $resourceGroupName
	ServerName        = $sqlServerName
}
Enable-AzureRmSqlServerAdvancedThreatProtection @paramEnableAzureRmSqlServerAdvancedThreatProtection

#endregion

#region - Set Vulnerability Assessment storage settings for all the databases in the server
$paramGetAzureRmSqlDatabase = @{
	ResourceGroupName = $resourceGroupName
	ServerName        = $sqlServerName
}

$paramUpdateAzureRmSqlDatabaseVulnerabilityAssessmentSettings = @{
	StorageAccountName = $storageAccount
}

Get-AzureRmSqlDatabase @paramGetAzureRmSqlDatabase | Where-Object { $psitem.DatabaseName -ne "master" } `
	| Update-AzureRmSqlDatabaseVulnerabilityAssessmentSettings @paramUpdateAzureRmSqlDatabaseVulnerabilityAssessmentSettings
#endregion

