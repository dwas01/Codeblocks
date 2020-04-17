# Network Security Groups (NSG)

This module deploys Network Security Groups.

## Resources

The following Resources are deployed.

+ **Microsoft.Network/networkSecurityGroups**
+ **Microsoft.Network/networkSecurityGroups/providers/diagnosticSettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `networkSecurityGroupName` || **Required** | The name of the Network Security Group
| `networkSecurityGroupSecurityRules` || **Required** | Required. Array of Security Rules to deploy to the Network Security Group
| `location` || **Optional** | Location of the Network Security Group
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `networkSecurityGroupsName` | The Network Security Group Name
| `networkSecurityGroupsResourceId` | The Network Security Group Resource Id
| `networkSecurityGroupsResourceGroup` | The Network Security Group Resource Group Name

## Scripts

| Name | Description |
| :-   | :-          |
| `NetworkSecurityGroups.akv.get.secrets.ps1` | Get Network Security Group Key Secrets as Azure DevOps variables
| `NetworkSecurityGroups.akv.set.secrets.ps1` | Set Network Security Group Key Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Microsoft Network template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/allversions)
