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