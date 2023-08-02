param parentStorageAccountName string
param name string

resource existStorageAccount 'Microsoft.Storage/storageAccounts@2022-09-01' existing = {
  scope: resourceGroup()
  name: parentStorageAccountName
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2022-09-01' = {
  name: name
  parent: existStorageAccount
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2022-09-01' = {
  name: 'default'
  parent: blobService
  properties: {
    publicAccess: 'None'
  }
}

output id string = blobService.id
