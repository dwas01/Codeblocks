# Cognitve Services

This module deploys Cognitve Services Translation API.

## Resources

The following Resources are deployed.

+ **Microsoft.CognitiveServices/accounts**
+ **Microsoft.CognitiveServices/accounts/providers/diagnosticsettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `accountName` || **Required** |The name of Text Translation API account
| `sku` | S0| **Optional** | sku for Text Translation API
| `location` || **Optional** | Location of the Azure Analysis Services server
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `cognitiveServicesName` |  Cognitive Services Name output parameter
| `cognitiveServicesResourceId` | Cognitive Services ResourceId output parameter
| `cognitiveServicesResourceGroup` | Cognitive Services ResourceGroup output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `CognitiveServices.akv.get.secrets.ps1` | Get Cognitive Services KeyVault Secrets as Azure DevOps variables
| `CognitiveServices.akv.set.secrets.ps1` | Set Cognitive Services KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [What are Azure Cognitive Services](https://docs.microsoft.com/en-us/azure/cognitive-services/welcome)
+ [Microsoft Cognitve Services template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.cognitiveservices/allversions)
+ [Enable diagnostic logging for Azure Cognitive Services](https://docs.microsoft.com/en-us/azure/cognitive-services/diagnostic-logging)
