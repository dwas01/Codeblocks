# Public IP Addresses

This module deploys Public IP Addresses.

## Resources

The following resources are deployed.

+ **"Microsoft.Network/publicIPAddressess**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `publicIPAddressesName` || **Required** | The name of the Public IP Address to create
| `skuName` | Basic | **Optional** | Public IP Address sku Name
| `skuTier` | Regional | **Optional** | Public IP Addres pricing tier
| `location` || **Optional** | Location for all resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `publicIpAddressName` |  Public IP Address Name output parameter
| `publicIpAddressResourceId` | Public IP Address ResourceId output parameter
| `publicIpAddressResourceGroup` | Public IP Address Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `PublicIPAddresses.akv.get.secrets.ps1` | Get Public IP Address Key Secrets as Azure DevOps variables
| `PublicIPAddresses.akv.set.secrets.ps1` | Set Public IP Address Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Microsoft Network template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/allversions)
