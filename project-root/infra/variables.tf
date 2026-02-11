variable "location" {
  description = "Azure region for all resources"
  type        = string
  default     = "Central India"
}

variable "resource_group" {
  description = "Resource group name"
  type        = string
  default     = "rg-nodejs-app"
}

variable "app_service_plan" {
  description = "Linux App Service Plan name"
  type        = string
  default     = "asp-nodejs-linux"
}

variable "webapp_name" {
  description = "Linux Web App name (must be globally unique)"
  type        = string
  default     = "nodejs-app-aishwarya-tf"  
}
