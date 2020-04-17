# ApplicationSecurityGroups

This module deploys Application Security Groups.

## Resources

+ **Microsoft.Network/applicationSecurityGroups**

## Parameters

| Parameter Name | Default Value | Description |
| :-             | :-            | :-          |
| `applicationSecurityGroupName` || **Required** | Name of the Application Security Group
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `applicationSecurityGroupName` | The Name of the Application Security Group deployed.
| `applicationSecurityGroupResourceId` | The Resource Ids of the Network Security Group deployed.
| `applicationSecurityGroupResourceGroup` | The name of the Resource Group the Application Security Groups were created in.

## Scripts

| Name | Description |
| :-   | :-          |
| `ApplicationSecurityGroups.akv.get.secrets.ps1` | Get Application Security Group KeyVault Secrets as Azure DevOps variables
| `ApplicationSecurityGroups.akv.set.secrets.ps1` | Set Application Security Group KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Microsoft Application Security Groups Documentation](https://docs.microsoft.com/en-us/azure/virtual-network/security-overview#application-security-groups)
+ [Microsoft Application Security Groups template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2018-08-01/applicationsecuritygroups)
