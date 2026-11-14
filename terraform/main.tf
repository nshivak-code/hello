provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg" {
  name     = "spring-rg"
  location = "Central India"
}

resource "azurerm_service_plan" "plan" {
  name                = "spring-plan"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  os_type             = "Linux"
  sku_name            = "F1"
}

resource "azurerm_linux_web_app" "app" {
  name                = "nshivak-spring-demo-2026"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  service_plan_id     = azurerm_service_plan.plan.id

  site_config {
      always_on = false
    application_stack {
      java_version        = "17"
      java_server         = "JAVA"
      java_server_version = "17"
    }
  }

  app_settings = {
    WEBSITES_PORT = "8080"
  }
}