# KeyVault

This module deploys Key Vault.

## Resources

The following Resources are deployed.

+ **Microsoft.KeyVault/vaults**
+ **Microsoft.KeyVault/vaults/providers/diagnosticsettings**
+ **Microsoft.KeyVault/vaults/secrets**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `keyVaultName` || **Required** | Name of the Azure Key Vault
| `accessPolicies` || **Required** | Access policies object
| `secretsObject` || **Required** | All secrets wrapped in a secure object
| `enableSoftDelete` | false | **Optional** | Specifies if the vault soft delete feature is enabled
| `enableVaultForDeployment` | true | **Optional** | Specifies if the vault is enabled for deployment by script or compute
| `enableVaultForTemplateDeployment` | true | **Optional** | Specifies if the vault is enabled for a template deployment
| `enableVaultForDiskEncryption` | true | **Optional** | Specifies if the azure platform has access to the vault for enabling disk encryption scenarios
| `vaultSku` | Premium | **Optional** | Specifies the SKU for the vault
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Optional** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Optional** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `keyVaultName` |  Azure Key Vault Name output parameter
| `keyVaultResourceId` | Azure Key Vault ResourceId output parameter
| `keyVaultResourceGroup` | Azure Key Vault Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `KeyVault.akv.get.secrets.ps1.ps1` | Get Azure Key Vault KeyVault Secrets as Azure DevOps variables
| `KeyVault.akv.set.secrets.ps1` | Set Azure Key Vault KeyVault Secrets
| `KeyVault.backup.ps1` | Azure Key Vault Backup Script
| `KeyVault.restore.ps1` | Azure Key Vault Restore Script

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Key Vault documentation](https://docs.microsoft.com/en-us/azure/key-vault/)
+ [Microsoft Key Vault template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.keyvault/allversions)
+ [Azure Key Vault logging](https://docs.microsoft.com/en-us/azure/key-vault/key-vault-logging)
