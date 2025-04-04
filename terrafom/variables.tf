variable "subscription_id" {
  type = string
  default = "de917971-3ca5-454f-9a61-16d7bab4eff2"
}
variable "resource_group_name" {
  description = "The name of the Azure Resource Group where resources will be deployed"
  type        = string
  default     = "rg-040425"
}

variable "location" {
  description = "The Azure region where resources will be created"
  type        = string
  default     = "Central US"
}

variable "app_service_plan_name" {
  description = "The name of the Azure App Service Plan"
  type        = string
  default     = "asp-jen-040425"
}

variable "app_service_name" {
  description = "The name of the Azure App Service"
  type        = string
  default     = "webapijenkins-040425"   //  Global Unique name for Azure App Service
}