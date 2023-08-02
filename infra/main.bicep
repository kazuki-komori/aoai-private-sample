targetScope = 'subscription'

// ===================== params =====================
// resource group params
param resourceGroupName string
param resourceGroupLocation string


resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: resourceGroupLocation
}

module vnet 'network/vnet.bicep' = {
  name: 'test-vnet'
  scope: resourceGroup
  params: {
    name: 'test-vnet'
    location: resourceGroupLocation
    addressPrefixes: ['10.0.0.0/16']
  }
}

module subnet 'network/subnet.bicep' = {
  name: 'test-subnet'
  scope: resourceGroup
  params: {
    existVnetName: vnet.outputs.name
    name: 'test-subnet'
    addressPrefix: '10.0.0.0/24'
  }
}

// module privateEndopoint 'network/privateEndpoint.bicep' = {
//   name: 'test-endpoint'
//   scope: resourceGroup
//   params: {
//     subnetId: subnet.outputs.id
//     private
//   }
// }
