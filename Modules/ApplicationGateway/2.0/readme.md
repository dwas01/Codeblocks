# Application Gateway 2.0

[Azure Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/overview) is a web traffic load balancer that enables you to manage traffic to your web applications. Traditional load balancers operate at the transport layer (OSI layer 4 - TCP and UDP) and route traffic based on source IP address and port, to a destination IP address and port.

With Application Gateway, you can make routing decisions based on additional attributes of an HTTP request, such as URI path or host headers. For example, you can route traffic based on the incoming URL. This type of routing is known as application layer (OSI layer 7) load balancing. Azure Application Gateway can do URL-based routing and more.

## Resources

The following Resource Providers will be deployed:

+ **Microsoft.Network/publicIPAddresses**
+ **Microsoft.Network/applicationGateways**
+ **Microsoft.Network/applicationGateways/providers/diagnosticsettings**

## Prerequisites

### Azure virtual network dedicated subnet

A [dedicated subnet](https://docs.microsoft.com/en-us/azure/application-gateway/configuration-overview#azure-virtual-network-and-dedicated-subnet) is required for the application gateway

The identity deploying the module must have the following [RBAC actions](https://docs.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations#microsoftnetwork) allowed on this subnet:

```json
"Actions": [
    Microsoft.Network/virtualNetworks/subnets/join/action
]
```

### Certificate for SSL termination

An [SSL certificate](https://docs.microsoft.com/en-us/azure/application-gateway/ssl-overview#ssl-termination) is required to be added to the HTTPS listener to enable the application gateway to derive a symmetric key as per SSL protocol specification. The symmetric key is then used to encrypt and decrypt the traffic sent to the gateway. For this service, **the SSL certificate needs to be in base64 format**.

For the SSL connection to work, you need to ensure that the SSL certificate meets the following conditions:

+ That the current date and time is within the "Valid from" and "Valid to" date range on the certificate.
+ That the certificate's "Common Name" (CN) matches the host header in the request. For example, if the client is making a request to `https://www.contoso.com/`, then the CN must be `www.contoso.com`.

Application gateway supports the following types of certificates:

+ **CA (Certificate Authority) certificate**: A CA certificate is a digital certificate issued by a certificate authority (CA)
+ **EV (Extended Validation) certificate**: An EV certificate is an industry standard certificate guidelines. This will turn the browser locator bar green and publish company name as well.
+ **Wildcard Certificate**: This certificate supports any number of subdomains based on *.site.com, where your subdomain would replace the *. It doesn’t, however, support site.com, so in case the users are accessing your website without typing the leading "www", the wildcard certificate will not cover that.
+ **Self-Signed certificates**: Client browsers do not trust these certificates and will warn the user that the virtual service’s certificate is not part of a trust chain. Self-signed certificates are good for testing or environments where administrators control the clients and can safely bypass the browser’s security alerts. Production workloads should never use self-signed certificates.

You can create a self-signed certificate in base64 that can be used in Application Gateway by using PowerShell:

```PowerShell
# This Script requires the PowerShell module "pkiclient" - which is not compatible with PowerShell Core - and administrator privileges

$certStoreLocation = "cert:\LocalMachine\My"
$pwd = ConvertTo-SecureString -String "1234" -Force -AsPlainText
$pfxFilePath = "C:\mypfx.pfx"

#Create a self-signed SSL server certificate in the computer MY store with the subject alternative name set to www.fabrikam.com, www.contoso.com and Subject and Issuer name set to www.fabrikam.com expiring in 120 months (10 years)
$thumbprint = (New-SelfSignedCertificate -DnsName "www.fabrikam.com", "www.contoso.com" -CertStoreLocation $certStoreLocation -NotAfter (Get-Date).AddMonths(120)).Thumbprint

$cerPath = Join-Path $certStoreLocation $thumbprint
Get-ChildItem -Path $cerPath | Export-PfxCertificate -FilePath $pfxFilePath -Password $pwd | Out-null

$bytesCert = Get-Content $pfxFilePath -Encoding Byte
$base64Cert = [System.Convert]::ToBase64String($bytesCert)
```

### Log Analytics workspace

A [log analytics workspace](https://docs.microsoft.com/en-us/azure/azure-monitor/insights/azure-networking-analytics#azure-application-gateway-and-network-security-group-analytics) where [Diagnostics Logs](https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-diagnostics#diagnostic-logging) and [Metrics](https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-diagnostics#metrics) will be sent.

The identity deploying the module must have the following [RBAC actions](https://docs.microsoft.com/en-us/azure/role-based-access-control/resource-provider-operations#microsoftoperationalinsights) allowed on this resource:

```json
"Actions": [
    "Microsoft.OperationalInsights/workspaces/sharedKeys/read",
    "Microsoft.OperationalInsights/workspaces/sharedKeys/action",
    "Microsoft.OperationalInsights/workspaces/read"
]
```

## Parameters

| Parameter Name | Default Value | Required | Description |
| :-             | :-            | :-       |:-           |
| `applicationGatewayName` || **Required** | The name to be used for the Application Gateway
| `sku` | WAF_Medium | **Optional** | The name of the SKU for the Application Gateway
| `capacity` | 2 | **Optional** | The number of Application instances to be configured
| `http2Enabled"` | true | **Optional** |  Enables HTTP/2 support
| `publicIPAllocationIdleTimeoutInMinutes` | 10 | **Optional** | The maximum allowed idle time in minutes for Public IP allocation
| `vNetName` || **Required** | The name of the Virtual Network where the Application Gateway will be deployed
| `subnetName` || **Required** | The name of Gateway Subnet Name where the Application Gateway will be deployed
| `vNetResourceGroup` || **Optional** | The name of the Virtual Network Resource Group where the Application Gateway will be deployed
| `vNetSubscriptionId` || **Optional** | The Subscription Id of the Virtual Network where the Application Gateway will be deployed
| `frontendPrivateIPAddress` || **Optional** | The private IP within the Application Gateway subent to be used as frontend private address
| `sslBase64CertificateData` || **Required** | The SSL base64-coded Certificate that will be used to configure the HTTPS listeners
| `sslCertificatePassword` || **Required** | The password of the SSL base64-coded Certificate that will be used to configure the HTTPS listeners
| `backendPools`  | **Required** | The backend pools to be configured
| `backendHttpConfigurations` || **Required** | The backend HTTP settings to be configured. These HTTP settings will be used to rewrite the incoming HTTP requests for the backend pools
| `frontendHttpsListeners` || **Required** | The frontend https listeners to be configured
| `frontendHttpRedirects` || **Required** | The http redirects to be configured. Each redirect will route http traffic to a pre-defined frontEnd https listener
| `routingRules` || **Required** | The routing rules to be configured. These rules will be used to route requests from frontend listeners to backend pools using a backend HTTP configuration
| `location` || **Optional** | Location for all Resources"
| `diagnosticStorageAccountId` || **Required** | Resource identifier of the Diagnostic Storage Account
| `logAnalyticsWorkspaceId` || **Required** | Resource identifier of Log Analytics Workspace
| `logsRetentionInDays` | 30 | **Optional** | Specifies the number of days that logs will be kept for, a value of 0 will retain data indefinitely
| `cuaId` || **Optional** | Customer Usage Attribution Id (GUID). This GUID must be previously registered
| `tagValues` || **Optional** | Optional. Azure Resource Tags object

## Outputs

| Output Name | Description |
| :-          | :-          |
| `applicationGatewayName` |  Application Gateway Name output parameter
| `applicationGatewayResourceId` | Application Gateway ResourceId output parameter
| `applicationGatewayResourceGroup` | Application Gateway ResourceGroup output parameter

## Scripts

| Name | Description |
| :-   | :-          |
| `ApplicationGateway.akv.get.secrets` | Get Application Gateway KeyVault Secrets as Azure DevOps variables
| `ApplicationGateway.akv.set.secrets.ps1` | Set Application Gateway KeyVault Secrets

## Considerations

+ This module will deploy the Application Gateway version 1 resource
+ Only HTTPS frontend Listeners will be configured. An option to redirect HTTP traffic to HTTPS listeners is offered as an option

## Additional resources

+ [What is Azure Application Gateway?](https://docs.microsoft.com/en-us/azure/application-gateway/overview)
+ [Application Gateway pricing](https://azure.microsoft.com/en-us/pricing/details/application-gateway/)
+ [Azure virtual network and dedicated subnet](https://docs.microsoft.com/en-us/azure/application-gateway/configuration-overview#azure-virtual-network-and-dedicated-subnet)
+ [Overview of SSL termination and end to end SSL with Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/ssl-overview)
+ [Configure SSL termination with Key Vault certificates by using Azure PowerShell](https://docs.microsoft.com/en-us/azure/application-gateway/configure-keyvault-ps)
+ [Application Gateway configuration overview](https://docs.microsoft.com/en-us/azure/application-gateway/configuration-overview)
+ [Back-end health, diagnostic logs, and metrics for Application Gateway](https://docs.microsoft.com/en-us/azure/application-gateway/application-gateway-diagnostics)

+ [Microsoft Application Gateway template reference](https://docs.microsoft.com/en-us/azure/templates/microsoft.network/2019-04-01/applicationgateways)
