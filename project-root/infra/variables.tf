variable "resource_group" {
  type        = string
  description = "Azure Resource Group name"
}

variable "location" {
  type        = string
  description = "Azure location"
}

variable "app_service_plan" {
  type        = string
  description = "App Service Plan name"
}

variable "webapp_name" {
  type        = string
  description = "Linux Web App name"
}
