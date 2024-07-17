terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0 "
    }
  }
}

#define qual o provider
provider "azurerm" {
  features {}
  
}

resource "azurerm_resource_group" "challenge_backend_rg" {
  name = "challenge_backend_rg"
  location = var.resource_location
}

resource "azurerm_storage_account" "challenge_storage_account" {
  name = "challengestoragea"
  resource_group_name = azurerm_resource_group.challenge_backend_rg.name
  location = azurerm_resource_group.challenge_backend_rg.location
  account_tier = "Standard"
  account_replication_type = "LRS" 
}

resource "azurerm_storage_container" "challenge_storage_container" {
  name = "challenge-container"
  storage_account_name = azurerm_storage_account.challenge_storage_account.name
  container_access_type = "private"
}