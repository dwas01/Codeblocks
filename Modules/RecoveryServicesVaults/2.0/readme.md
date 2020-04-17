# Recovery Services Vaults

This module deploys Recovery Services Vaults. (Azure Backup)

## Resources

The following Resources are deployed.

+ **Microsoft.RecoveryServices/vaults**
+ **Microsoft.RecoveryServices/vaults/providers/diagnosticSettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `vaultName` || **Required** | Name of the Azure Recovery Services
| `skuName` | RS0 | **Optional** | Azure Recovery Services Vault sku Name
| `skuTier` | Standard | **Optional** | Azure Recovery Services Vault pricing tier
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for; a value of 0 will retain data indefinitely
| `location` || **Optional** | Location for all resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `recoveryServicesVaultsName` |  Recovery Services Vaults Name output parameter
| `recoveryServicesVaultsResourceId` | Recovery Services Vaults ResourceId output parameter
| `recoveryServicesVaultsResourceGroup` |Recovery Services Vaults Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `RecoveryServicesVaults.akv.get.secrets.ps1` | Get Analysis Services Key Secrets as Azure DevOps variables
| `RecoveryServicesVaults.akv.set.secrets.ps1` | Set Analysis Services Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Documentation for the Azure Backup service](https://docs.microsoft.com/en-us/azure/backup/)
+ [Microsoft Recovery Services template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.recoveryservices/allversions)
