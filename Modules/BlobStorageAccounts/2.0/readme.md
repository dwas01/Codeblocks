# Blob Storage Accounts

This module deploys Storage Accounts (Blob).

## Resources

The following Resources are deployed.

+ **Microsoft.Storage/storageAccounts**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `storageAccountName` || **Required** |  Blob Storage Account name
| `storageAccountKind` | StorageV2 | **Optional** | Storage Account kind
| `storageAccountSku` | Standard_GRS | **Optional** | Storage Account sku type
| `encryptionEnabled` | true | **Optional** | Storage Account Encryption Enabled true/false
| `accessTier` | cool | **Optional** | Storage Account Access Tier Hot/Cold
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `blobstorageName` |  Blob Storage Account Name output parameter
| `blobstorageResourceId` | Blob Storage Account ResourceId output parameter
| `blobstorageResourceGroup` | Blob Storage Account Resource Group output parameter
| `blobstorageConnectionString` | Blob Storage Account Connection string

## Scripts

| Name | Description |
| :-   | :-          |
| `BlobStorageAccounts.akv.get.secrets.ps1` | Get Blob Storage Account KeyVault Secrets as Azure DevOps variables
| `BlobStorageAccounts.akv.set.secrets.ps1` | Set Blob Storage Account KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Microsoft Storage template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.storage/allversions)
