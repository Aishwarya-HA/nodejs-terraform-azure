variable "resource_group" {
  type        = string
  description = "Existing Azure Resource Group name (must already exist)"
}

variable "location" {
  type        = string
  description = "Azure location (kept for compatibility if you reference it elsewhere)"
}

variable "app_service_plan" {
  type        = string
  description = "App Service Plan name"
}

variable "webapp_name" {
  type        = string
  description = "Linux Web App name"
}
