variable "location" {
  description = "Azure region to deploy resources"
  default     = "uksouth"
}

variable "resource_group_name" {
  description = "Azure resource group to deploy"
  default     = "rg-containerapp-stage"
}