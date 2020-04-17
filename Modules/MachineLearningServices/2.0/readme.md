# Machine Learning Services

This module deploys a Machine Learning Services Workspace.

## Resources

The following Resources are deployed.

+ **Microsoft.MachineLearningServices/workspaces**
+ **Microsoft.Storage/storageAccounts**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `workspaceName` || **Required** | T1he name of the Azure Machine Learning service workspace
| `storageAccountName` || **Required** | Storage Account Name
| `storageAccountSku` | Standard_GRS | **Optional** | Storage Account sku type
| `keyVaultResourceId` || **Required** | Resource identifier of the KeyVault
| `appInsightsResourceId` || **Required** | Resource identifier of the Application Insights
| `location` || **Optional** | Location for all resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `machinelearningServicesName` |  Machine Learning Services Name output parameter
| `machinelearningServicesResourceId` | Machine Learning Services ResourceId output parameter
| `machinelearningServicesResourceGroup` | Machine Learning Services ResourceGroup output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `MachineLearningServices.akv.get.secrets.ps1` | Get Machine Learning Services Key Secrets as Azure DevOps variables
| `MachineLearningServices.akv.set.secrets.ps1` | Set Machine Learning Services Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Machine Learning documentation](https://docs.microsoft.com/en-us/azure/machine-learning/)
+ [Microsoft Machine Learning Services template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.machinelearningservices/allversions)
