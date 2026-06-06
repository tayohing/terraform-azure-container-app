terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }

  backend "azurerm" {
    resource_group_name  = "rg-tfstate-containerapp"
    storage_account_name = "sttfstatecontainerapp"
    container_name       = "tfstate"
    key                  = "stage/python-api/terraform.tfstate"
  }
}

provider "azurerm" {
  features {
    
  }
}

resource "azurerm_resource_group" "main" {
  name     = var.resource_group_name
  location = var.location
}

resource "azurerm_container_registry" "acrcontainerapp" {
  name                = "acrcontainerapp"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
  sku                 = "Basic"
}

resource "azurerm_container_app_environment" "cae-containerapp-stage" {
  name                = "cae-containerapp-stage"
  resource_group_name = azurerm_resource_group.main.name
  location            = var.location
}

resource "azurerm_container_app" "ca-containerapp-stage" {
  name                         = "ca-containerapp-stage"
  resource_group_name          = azurerm_resource_group.main.name
  container_app_environment_id = azurerm_container_app_environment.cae-containerapp-stage.id
  revision_mode                = "Single"
  template {
    container {
      name   = "python-api"
      image  = "mcr.microsoft.com/azuredocs/containerapps-helloworld:latest"
      cpu    = 0.25
      memory = "0.5Gi"
    }
  }
}