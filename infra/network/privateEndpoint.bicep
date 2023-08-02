param location string = resourceGroup().location
param subnetId string
param privateLinkServiceId string
param privateEndpointName string
param privateLinkServiceGroupId string[]

resource privateEndpoint 'Microsoft.Network/privateEndpoints@2023-02-01' = {
  name: privateEndpointName
  location: location
  properties: {
    subnet: {
      id: subnetId
    }
    privateLinkServiceConnections: [
      {
        name: '${privateEndpointName}Connection}'
        properties: {
          privateLinkServiceId: privateLinkServiceId
          groupIds: privateLinkServiceGroupId
        }
      }
    ]
  }
}

output privateEndpointId string = privateEndpoint.id
output privateEndpointName string = privateEndpoint.name
