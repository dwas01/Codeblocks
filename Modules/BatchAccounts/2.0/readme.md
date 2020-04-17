# Batch Accounts

This module deploys Batch Accounts

## Resources

The following resources are deployed.

+ **Microsoft.Batch/batchAccounts**
+ **Microsoft.Batch/batchAccounts/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `batchAccountName` || **Required** | Name of the Azure Batch Account
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `batchAccountName` |Azure Batch Account Name output parameter
| `batchAccountResourceId` | Azure Batch Account ResourceId output parameter
| `batchAccountResourceGroup` | Azure Batch Account Resource Group output parameter
| `batchAccountPrimaryKey` | Azure Batch Account Primary Key

## Scripts

| Name | Description |
| :-   | :-          |
| `BatchAccounts.akv.get.secrets.ps1` | Get Azure Batch Account KeyVault Secrets as Azure DevOps variables
| `BatchAccounts.akv.set.secrets.ps1` | Set Azure Batch Account KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Azure Batch documentation](https://docs.microsoft.com/en-us/azure/batch/)
+ [Microsoft Batch template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.batch/allversions)
+ [Batch metrics, alerts, and logs for diagnostic evaluation and monitoring](https://docs.microsoft.com/en-us/azure/batch/batch-diagnostics)
