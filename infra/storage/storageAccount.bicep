param name string
param location string = resourceGroup().location
param kind string = 'StorageV2'
param sku object = {
  name: 'Standard_LRS'
}

resource storageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' = {
  name: name
  location: location
  kind: kind
  sku: sku
}

output name string = storageAccount.name
output id string = storageAccount.id
