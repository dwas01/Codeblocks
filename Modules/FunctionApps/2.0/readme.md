# Azure Functions

This module deploys Azure Functions.

## Resources

The following Resources are deployed.

+ **Microsoft.Storage/storageAccounts**
+ **Microsoft.Web/serverfarms**
+ **Microsoft.Web/sites**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `appName` || **Required** | The name of the function app that you wish to create
| `workerSize` | 0 | **Optional** |The instance size of the hosting plan (small, medium, or large)
| `storageAccountName` || **Required** | Specify Storage Account Name
| `storageAccountType` | Standard_GRS | **Optional** |Storage Account sku type
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

No deployment outputs

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Functions documentation](https://docs.microsoft.com/en-us/azure/azure-functions/)
+ [Microsoft Azure Functions template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.web/2018-02-01/sites/functions)
+ [Monitor Azure Functions](https://docs.microsoft.com/en-us/azure/azure-functions/functions-monitoring)
