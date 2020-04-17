# Kubernetes AKS Cluster

This module deploys Kubernetes AKS Cluster, and supports RBAC / POD Identity deployment

## Resources

The following Resources are deployed.

+ **Microsoft.ContainerService/managedClusters**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `aksClusterName` || **Required** | Kubernetes AKS Cluster Name
| `servicePrincipalId` || **Required** | App ID of the Service Principal
| `servicePrincipalSecret` || **Required** | The Service Principal Client Secret
| `location` || **Optional** | The location of AKS resource
| `vmSize` | Standard_D2_v2 | **Optional** | The size of the Virtual Machine|
| `osType` | Linux | **Optional** | The type of operating system [Linux\Windows]
| `nodeCount` | 2 | **Optional** |  The number of agent nodes for the cluster
| `maxPodCount` | 30 | **Optional** | The maximum number of pods pre node in the cluster
| `vNetResourceGroup` || **Required** | The resource group Name of the Virtual Network
| `vNetResourceName` || **Required** | The name of the Virtual Network
| `subnetName` || **Required** | Virtual Network subnet used for nodes and/or pods IP assignment
| `networkPlugin` | azure | **Optional** | Network plugin used for building Kubernetes network
| `serviceCIDR` || **Required** | A CIDR notation IP range from which to assign service cluster IPs
| `dnsServiceIP` || **Required** | Containers DNS server IP address
| `dockerBridgeCIDR` || **Required** | A CIDR notation IP for Docker bridge|
| `enableHttpApplicationRouting` | false | **Optional** | boolean flag to turn on and off of http application routing
| `enableRBAC` | true | **Optional** | boolean flag to enable Kubernetes Role-Based Access Control
| `rbacServerAppID` || **Required** | RBAC Application ID for the Server App Service Principal
| `rbacServerSecret` || **Required** | RBAC Service Principal Secret for the Client App Service Principal
| `rbacClientAppID` || **Required** | RBAC Application ID for the Client App Service
| `rbacTenantID` || **Required** | RBAC Azure AD Tenant where the cluster will reside
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `aksClusterName` | Kubernetes Cluster Name output parameter
| `aksClusterResourceId` |Kubernetes Cluster ResourceId output parameter
| `aksClusterResourceGroup` | Kubernetes Cluster Resource Group output parameter
| `aksClusterControlPlaneFQDN` | Kubernetes Cluster Control Plane FQDN
| `aksClusterSPNId` | Kubernetes Cluster Service Principal Name Id
| `aksClusterSubnetId` | Kubernetes Cluster Subnet Id

## Pipeline

| Pipeline Files | Description |
| :-          | :-          |
| `aadpodidentity.yaml` | Kubernetes Cluster POD Identity deployment
| `aadpodidentitybinding.yaml` | Kubernetes Cluster POD Identity configuration
| `deployment-rbac.yaml` | Kubernetes Cluster POD Identity RBAC configuration

| Name | Description |
| :-   | :-          |
| `KubernetesAKS.akv.get.secrets.ps1` | Get Kubernetes Cluster Key Secrets as Azure DevOps variables
| `KubernetesAKS.akv.set.secrets.ps1` | Set Kubernetes Cluster Key Secrets
| `KubernetesAKS.role.assignment.ps1` | Configures Kubernetes Cluster Service Principal Name (SPN) Network Contributor Access

## Considerations

+ There is no deployment considerations for this Module

## Additional Resources

+ [Microsoft Container Services Managed Cluster template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.containerservice/aks-allversions)
