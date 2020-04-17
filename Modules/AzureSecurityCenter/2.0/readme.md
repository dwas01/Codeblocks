# Azure Security Center

This module enables Azure Security Center.

## Resources

+ **Microsoft.Security/pricings**
+ **Microsoft.Security/workspaceSettings**
+ **Microsoft.Security/autoProvisioningSettings**

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `autoProvisioning` | On | **Optional** | Turns automatic deployment of a Log Analytics workspace
| `pricingTier` | standard | **Optional** | The pricing tier value
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered

## Outputs

No deployment outputs

## Additional resources

+ [Azure Security Center documentation](https://docs.microsoft.com/en-us/azure/security-center/)
+ [Microsoft Security template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.security/allversions)
