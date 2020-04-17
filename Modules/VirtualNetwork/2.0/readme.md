# Virtual Network

This module deploys Virtual Network.

## Resources

The following Resources are deployed.

+ **Microsoft.Network/virtualNetworks**
+ **Microsoft.Network/virtualNetworks/providers/diagnosticSettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `vNetName` || **Required** | Virtual Network Name
| `vNetAddressPrefix` || **Required** | Address prefix
| `subnets` || **Required** | An Array of subnets to deploy to the Virual Network
| `location` | resourceGroup().location | **Optional** |Location for all resources
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

# Outputs

| Output Name | Description |
| :-          | :-          |
| `virtualNetworkName` | Virtual Network Name output parameter
| `virtualNetworkResourceId` | Virtual Network ResourceId output parameter
| `virtualNetworkResourceGroup` | Virtual Network Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `VirtualNetwork.akv.set.secrets.ps1` | Get Virtual Network Key Secrets as Azure DevOps variables
| `VirtualNetwork.akv.get.secrets.ps1` | Set Virtual Network Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Virtual Network documentation](https://docs.microsoft.com/en-us/azure/virtual-network/)
+ [Microsoft Network template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/allversions)
