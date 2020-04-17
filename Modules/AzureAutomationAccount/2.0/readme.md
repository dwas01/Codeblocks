# Azure Automation Account

This module deploys Azure Automation Account

## Resources

The following Resources are deployed.

+ **Microsoft.Automation/automationAccounts**
+ **Microsoft.Automation/automationAccounts/providers/diagnosticsettings**
+ **Microsoft.Automation/automationAccounts/credentials**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `automationAccountName` || **Required** | The name of the Azure Automation account to create
| `location` || **Optional** | Location of the Azure Automation account.
| `credentialsName` || **Required** | The Credetial account name which will be created inside the Azure Automation Account.
| `userName` || **Required** | The User name that will be created as a part of the credetial object
| `password` || **Required** | The User password that will be created as a part of the credetial object
| `skuName` | Basic | **Optional** | Provide the SKU name for the Azure Automation Account.
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `automationAccountName` | Azure Automation Account Name output parameter
| `automationAccountResourceId` | Azure Automation Account resource ID output parameter
| `automationAccountResourceGroup` | Azure Automation Account ResourceGroup output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `AzureAutomationAccount.akv.get.secrets.ps1` | Get Azure Automation Account KeyVault Secrets as Azure DevOps variables
| `AzureAutomationAccount.akv.set.secrets.ps1` | Set Azure Automation Account KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Azure Automation documentation](https://docs.microsoft.com/en-us/azure/automation/)
+ [Microsoft Azure Automation Account template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.automation/allversions)
