<#
	.NOTES
		==============================================================================================
		Copyright(c) Microsoft Corporation. All rights reserved.

		File:		SQLServerDB.set.storageaccount.secrects.ps1

		Purpose:	Set Key Vault Secrets Automation Script for Storage account keys and SAS Token

		Version: 	1.0.0.3 - 24th September 2019 - BUMA Build Release Deployment Team
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
		Set Key Vault Secrets Automation Script for Storeage account keys

	.DESCRIPTION
		Set Key Vault Secrets Automation Script for Storeage account keys

        Deployment steps of the script are outlined below.
        1) Get azure Storeage account key.
		2) Create Azure KeyVault Secret

	.PARAMETER keyVaultName
		Specify the Azure KeyVault Name parameter.

	.PARAMETER resourceGroupName
		Specify the resourceGroupName output parameter.

	.PARAMETER storageAccountName
        Specify the storageAccountName output parameter.
        
	.PARAMETER sqlServerdbName
		Specify the sqlServerdbName output parameter.        

	.EXAMPLE
		Default:
        C:\PS>.\SQLServerDB.set.storageaccount.secrects.ps1
            -keyVaultName "$(keyVaultName)"
			-resourceGroupName "$(resourceGroupName)"
            -storageAccountName "$(storageAccountName)"
            -sqlServerdbName "$(sqlServerdbName)"
#>

#Requires -Version 5
#Requires -Module AzureRM.KeyVault

[CmdletBinding()]
param
(
    [Parameter(Mandatory = $false)]
    [string]$keyVaultName,

    [Parameter(Mandatory = $false)]
    [string]$resourceGroupName,

    [Parameter(Mandatory = $false)]
    [string]$storageAccountName,

    [Parameter(Mandatory = $false)]
    [string]$sqlServerdbName    
)

#region - Key Vault Parameters
if (-not [string]::IsNullOrWhiteSpace($keyVaultName))
{
	Write-Output "Key Vault Name : $keyVaultName"
    $kVSecretParameters = @{ }

	#region - Get Storage Account Key
	$getAzureRmStorageAccountKey = @{
		ResourceGroupName = $resourceGroupName
		Name              = $storageAccountName
		Verbose           = $true
	}
	$storageAccountKey = Get-AzureRmStorageAccountKey @getAzureRmStorageAccountKey
	$saKey = $storageAccountKey.value[0]
	#endregion

    #region - Virtual Machine Parameters
    if (-not [string]::IsNullOrWhiteSpace($saKey))
	{
        Write-Output "Storage account key is: $saKey"
        $kVSecretParameters.Add("sql--diag--key--$($sqlServerdbName)", $($saKey))
    }
    else
	{
        Write-Output "Storage account key is : []"
        exit -1
    }
    #endregion

    #region - Set Azure KeyVault Secret
    $kVSecretParameters.Keys | ForEach-Object {
        $key = $psitem
        $value = $kVSecretParameters.Item($psitem)

        if (-not [string]::IsNullOrWhiteSpace($value))
		{
            Write-Output "Key Vault Secret : $key : $value"
            $value = $kVSecretParameters.Item($psitem)

            Write-Output "Setting Secret for $key"
            $paramSetAzureKeyVaultSecret = @{
                VaultName   = $keyVaultName
                Name        = $key
                SecretValue = (ConvertTo-SecureString $value -AsPlainText -Force)
                Verbose     = $true
                ErrorAction = 'SilentlyContinue'
            }
            Set-AzureKeyVaultSecret @paramSetAzureKeyVaultSecret
        }
        else
		{
           Write-Output "Key Vault Secret : []"
        }
    }
    #endregion
}
else
{
    Write-Output "Key Vault Name : []"
}
#endregion