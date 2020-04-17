# Azure Container Registries

This module deploys Azure Container Registries.
Azure Container Registry is a PaaS offer for creating your own Docker image registry.

## Resources

The following Resources are deployed.

+ **Microsoft.ContainerRegistry/registries**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `containerRegistryName` || **Required** | Name of the Container Registry
| `containerRegistryAdminUserEnabled` | false | **Optional** | Enable admin user that have push / pull permission to the registry
| `containerRegistrySku` | Standard | **Optional** | Tier of your Container Registry
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 |**Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `location` || **Optional** | Location for all Resources
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `containerRegistryName` |  Container Registries Name output parameter
| `containerRegistryResourceId` | Container Registries ResourceId output parameter
| `containerRegistryResourceGroup` | Container Registries Resource Group output parameter
| `containerRegistryLoginServer` | Container Registries Login Server

## Scripts

| Name | Description |
| :-   | :-          |
| `ContainerRegistries.akv.get.secrets.ps1` | Get Container Registries KeyVault Secrets as Azure DevOps variables
| `ContainerRegistries.akv.set.secrets.ps1` | Set Container Registries KeyVault Secrets

## Considerations

+ There is no deployment considerations for this Module

## Additional resources

+ [Azure Container Registry Documentation](https://docs.microsoft.com/en-us/azure/container-registry/)
+ [Microsoft Container Registry template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.containerregistry/allversions)
