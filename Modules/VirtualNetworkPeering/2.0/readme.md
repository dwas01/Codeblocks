# vNetPeering

This Module deploys Virtual Network Peering.

## Resources

The following Resources are deployed.

+ **Microsoft.Network/virtualNetworks/virtualNetworkPeerings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `localvNetName` || **Required** | The Name of the Virtual Network to add the peering to.
| `peeringName` || **Required** | The Name of the virtual network peering resource.
| `remoteVirtualNetworkId` || **Required** | The Resource Id of the remote virtual network. The remove virtual network can be in the same or different region
| `allowVirtualNetworkAccess` | `true` | **Optional** | Whether the VMs in the local virtual network space would be able to access the VMs in remote virtual network space
| `allowForwardedTraffic` || **Optional** | Whether the forwarded traffic from the VMs in the local virtual network will be allowed/disallowed in remote virtual network
| `allowGatewayTransit` || **Optional** | If gateway links can be used in remote virtual networking to link to this virtual network
| `useRemoteGateways` || **Optional** | If remote gateways can be used on this virtual network. If the flag is set to true, and allowGatewayTransit on remote peering is also true, virtual network will use gateways of remote virtual network for transit. Only one peering can have this flag set to true. This flag cannot be set if virtual network already has a gateway
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered

## Outputs

| Output Name | Description |
| :-          | :-          |
| `vNetPeeringName` |  Virtual Network Peering Name output parameter
| `vNetPeeringResourceId` | Virtual Network Peering ResourceId output parameter
| `vNetPeeringResourceGroup` | Virtual Network Peering Resource Group output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `VirtualNetworkPeering.akv.get.secrets.ps1` | Get Virtual Network Peering Key Secrets as Azure DevOps variables
| `VirtualNetworkPeering.akv.set.secrets.ps1` | Set Virtual Network Peering Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Microsoft Network Virtual Network Peerings template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-04-01/virtualnetworks/virtualnetworkpeerings)
