# Azure Data Factories

This module deploys Azure Data Factories (V2).

## Resources

The following resources are deployed.

+ **Microsoft.DataFactory/factories**
+ **Microsoft.DataFactory/factories/providers/diagnosticsettings****

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `dataFactoryName` || **Required** | Name of the Azure Data Factory
| `location` || **Optional** | Location for all Resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `dataFactoryName` |  Azure Data Factories Name output parameter
| `dataFactoryResourceId` | Azure Data Factories ResourceId output parameter
| `dataFactoryResourceGroup` | Azure Data Factories Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `DataFactories.akv.get.secrets.ps1` | Get Azure Data Factories KeyVault Secrets as Azure DevOps variables
| `DataFactories.akv.set.secrets.ps1` | Set Azure Data Factories KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Data Factory documentation](https://docs.microsoft.com/en-us/azure/data-factory/)
+ [Microsoft Data Factory template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.datafactory/allversions)
+ [Alert and monitor data factories by using Azure Monitor](https://docs.microsoft.com/en-us/azure/data-factory/monitor-using-azure-monitor)
