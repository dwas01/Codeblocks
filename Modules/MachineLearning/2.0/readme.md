# Machine Learning

This module deploys a Machine Learning Workspace Plans.

## Resources

The following Resources are deployed.

+ **Microsoft.MachineLearning/workspaces**
+ **Microsoft.MachineLearning/commitmentPlans**
+ **Microsoft.Storage/storageAccounts**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `workspaceName` || **Required** | T1he name of the Azure Machine Learning service workspace
| `planName` || **Required** | The name of the Machine Learning Plan
| `ownerEmail` || **Required** | The Email address of the business owner for the Machine Learning Plan
| `skuName` || **Optional** | Machine Learning Plan sku name
| `skuTier` || **Optional** | Machine Learning Plan account tier
| `skuCapacity` || **Optional** | Machine Learning Plan scale-out capacity of the resource
| `location` || **Optional** | Location for all resources
| `storageAccountName` || **Required** | Storage Account Name
| `storageAccountSku` | Standard_GRS | **Optional** | Storage Account sku type
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `machinelearningName` |  Machine Learning Name output parameter
| `machinelearningResourceId` | Machine Learning ResourceId output parameter
| `machinelearningResourceGroup` | Machine Learning ResourceGroup output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `MachineLearning.akv.get.secrets.ps1` | Get Machine Learning Key Secrets as Azure DevOps variables
| `MachineLearning.akv.set.secrets.ps1` | Set Machine Learning Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Machine Learning documentation](https://docs.microsoft.com/en-us/azure/machine-learning/)
+ [Microsoft Machine Learning template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.machinelearning/allversions)
