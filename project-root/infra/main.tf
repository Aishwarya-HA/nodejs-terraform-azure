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

# ───────────────────────────────────────────────────────────────
# Use an EXISTING Resource Group (no creation, no import needed)
# ───────────────────────────────────────────────────────────────
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
    always_on = true
    # If you want to set startup command at infra level (same as Portal's Startup Command):
    app_command_line = "npm start"
  }

  app_settings = {
    # Build with Oryx during deployment (so npm install runs on Kudu)
    SCM_DO_BUILD_DURING_DEPLOYMENT = "true"

    # Optional: If you deploy a ZIP (Run From Package). Safe to keep; Kudu will handle.
    WEBSITE_RUN_FROM_PACKAGE = "1"

    # Optional for Node/Express demos; Oryx/PORT usually suffice
    WEBSITES_PORT = "8080"

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
