terraform {
  required_version = ">= 1.5.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 4.0"
    }
  }
}

provider "azurerm" {
  features {}
  use_oidc = true
}

# Resource Group
resource "azurerm_resource_group" "rg" {
  name     = var.resource_group
  location = var.location
}

# App Service Plan (Linux)
resource "azurerm_service_plan" "plan" {
  name                = var.app_service_plan
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "B1" # Use S1/P1v3 for production
}

# Linux Web App (Node 20 LTS)
resource "azurerm_linux_web_app" "app" {
  name                = var.webapp_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id
  https_only          = true

  site_config {
    application_stack {
      node_version = "20-lts"
    }
    always_on = true # keeps app warm on non-Free plans
  }

  app_settings = {
    # REQUIRED so your Node server binds to expected port
    WEBSITES_PORT = "8080"

    # Build with Oryx during Zip Deploy
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"

    # Run From Package (zip)
    WEBSITE_RUN_FROM_PACKAGE = "1"

    # Optional environment context
    NODE_ENV = "production"
    APP_ENV  = "production"
  }

  # Basic filesystem logs so Log Stream works
  logs {
    http_logs {
      file_system {
        retention_in_days = 7
        retention_in_mb   = 100
      }
    }
    application_logs {
      file_system_level = "Information"
    }
  }
}
