$ErrorActionPreference = "Stop"

# --- Variables ---
$location = "uksouth"
$subscriptionId = "23e7547b-442a-4d96-b13f-f400f2e72b04"
$resourceGroupName = "rg-tfstate-containerapp"
$storageAccountName = "sttfstatecontainerapp"
$containerName = "tfstate"

# --- Login check ---
$account = az account show 2>$null
if ($null -eq $account) {
    Write-Error "Not logged in to Azure. Run 'az login' first."
    exit 1
}

Write-Host "Logged in successfully."

Write-Host "Setting Azure subscription: $subscriptionId..."
az account set --subscription $subscriptionId

Write-Host "Registering Microsoft.Storage provider..."
az provider register --namespace Microsoft.Storage

Write-Host "Creating resource group: $resourceGroupName..."
az group create --name $resourceGroupName --location $location

Write-Host "Creating storage account: $storageAccountName..."
az storage account create --name $storageAccountName --location $location --resource-group $resourceGroupName --sku Standard_LRS

Write-Host "Creating blob container: $containerName..."
az storage container create --name $containerName --account-name $storageAccountName --auth-mode login

Write-Host ""
Write-Host "Bootstrap completed. Use the following values in TF backend config"
Write-Host "resource_group_name = $resourceGroupName"
Write-Host "storage_account_name = $storageAccountName"
Write-Host "container_name = $containerName"