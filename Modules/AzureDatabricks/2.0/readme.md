# Azure Databricks

This module deploys Azure Databricks

## Resources

The following resources are deployed.

+ **Microsoft.Databricks/workspaces**
+ **Microsoft.Databricks/workspaces/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `workspaceName` || **Required** | The name of the Azure Databricks workspace to create
| `pricingTier` | premium | **Optional** | The pricing tier of workspace
| `location` || **Optional** | Location for all resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

 Outputs

| Output Name | Description |
| :-          | :-          |
| `databrickName` |  Azure Databricks Name output parameter
| `databrickResourceId` | Azure Databricks ResourceId output parameter
| `databrickResourceGroup` | Azure Databricks Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `AzureDatabricks.akv.get.secrets.ps1` | Get Azure Databricks KeyVault Secrets as Azure DevOps variables
| `AzureDatabricks.akv.set.secrets.ps1` | Set Azure Databricks KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Azure Databricks documentation](https://docs.microsoft.com/en-us/azure/azure-databricks/)
+ [Microsoft Databricks template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.databricks/allversions)
