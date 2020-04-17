# Storage Accounts

This module deploys Storage Accounts.

## Resources

The following Resources are deployed.

+ **Microsoft.Storage/storageAccounts**

## Parameters

 Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `storageAccountName` || **Required** | Storage Account name
| `storageAccountKind` | StorageV2 | **Optional** | Storage Account storage kind
| `storageAccountSku` | Standard_GRS | **Optional** | Storage Account sku type
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `storageAccountName` | The Storage Account Resource Name
| `storageAccountResourceId` | The Storage Account ResourceId
| `storageAccountResourceGroup` | The Storage Account Resource Group name
| `storageAccountAccessKey` | The Storage Account Access Key

## Scripts

| Name | Description |
| :-   | :-          |
| `StorageAccounts.akv.get.secrects.ps1` | Get Storage Accounts Key Secrets as Azure DevOps variables
| `StorageAccounts.akv.set.secrects.ps1` | Set Storage Accounts Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Azure Storage Documentation](https://docs.microsoft.com/en-us/azure/storage/)
+ [Microsoft Storage template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/allversions)
