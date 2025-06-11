    terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.75"
    }
  }
  required_version = ">= 1.4.0"
}

provider "azurerm" {
  features {}  
}

resource "azurerm_resource_group" "rg" {
  name     = "autoscaler-rg"
  location = "westeurope"
}

resource "azurerm_kubernetes_cluster" "aks" {
  name                = "autoscaler-aks"
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  dns_prefix          = "keda-autoscaler"
  identity {
    type = "SystemAssigned"
  }

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }
}

resource "azurerm_storage_account" "queue" {
  name                     = "autoscalesa"
  resource_group_name      = azurerm_resource_group.rg.name
  location                 = azurerm_resource_group.rg.location
  account_tier             = "Standard"
  account_replication_type = "LRS"
}

resource "azurerm_storage_queue" "orders" {
  name                 = "orders-queue"
  storage_account_name = azurerm_storage_account.queue.name
}
