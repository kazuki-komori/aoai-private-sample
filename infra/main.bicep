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

module storageAccount 'storage/storageAccount.bicep' = {
  name: 'sampleaccount20230802'
  scope: resourceGroup
  params: {
    location: resourceGroupLocation
    name: 'sampleaccount20230802'
  }
}

module blobServices 'storage/blobServices.bicep' = {
  name: 'default'
  scope: resourceGroup
  params: {
    parentStorageAccountName: storageAccount.outputs.name
    name: 'default'
  }
}

module privateEndopoint 'network/privateEndpoint.bicep' = {
  name: 'test-endpoint'
  scope: resourceGroup
  params: {
    location: resourceGroupLocation
    name: 'test-endpoint'
    subnetId: subnet.outputs.id
    privateLinkServiceId: storageAccount.outputs.id
    privateLinkServiceGroupIds: ['Blob']
  }
}
