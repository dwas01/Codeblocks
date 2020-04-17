# Azure Logic Apps

This module deploys Azure Logic Apps.

## Resources

The following resources are deployed.

+ **Microsoft.Logic/workflows**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `logicAppName` || **Required** | The name of the Azure Logic Apps to create
| `testUri` | <http://azure.microsoft.com/en-us/status/feed/> | **Optional** | A test URI
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `logicAppsName` |  Azure Logic Apps Name output parameter
| `logicAppsResourceId` | Azure Logic Apps ResourceId output parameter
| `logicAppsResourceGroup` | Azure Logic Apps Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `LogicApps.akv.get.secrets.ps1` | Get Azure Logic Apps Key Secrets as Azure DevOps variables
| `LogicApps.akv.set.secrets.ps1` | Set Azure Logic Apps Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Logic Apps documentation](https://docs.microsoft.com/en-us/azure/logic-apps/)
+ [Microsoft Logic template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.logic/allversions)
