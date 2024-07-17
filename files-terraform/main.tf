# Azure Provider source and version being used
terraform {
  backend "azurerm" {
    resource_group_name = "challenge_backend_rg"
    storage_account_name = "challengestoragea"
    container_name = "challenge-container"
    key = "terraform.tfstate"
  }
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
  }
}


#define qual o provider
provider "azurerm" {
  features {}

}

# o que é /     qual tipo é       /     nome
resource "azurerm_resource_group" "challenge_rg_devops" {
  name     = "challenge_rg"
  location = var.resource_location
}


#Criação uma rede virtual
resource "azurerm_virtual_network" "challenge_vnetwork" {
  name                = "challenge_vnet"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.challenge_rg_devops.location
  resource_group_name = azurerm_resource_group.challenge_rg_devops.name
}

#Criação de sub-rede 1
resource "azurerm_subnet" "challenge_subnet_1" {
  name                 = "challenge_subnet_1"
  resource_group_name  = azurerm_resource_group.challenge_rg_devops.name
  virtual_network_name = azurerm_virtual_network.challenge_vnetwork.name
  address_prefixes     = ["10.0.0.0/24"]
}

#Criação de sub-rede 2
resource "azurerm_subnet" "challenge_subnet_2" {
  name                 = "challenge_subnet_2"
  resource_group_name  = azurerm_resource_group.challenge_rg_devops.name
  virtual_network_name = azurerm_virtual_network.challenge_vnetwork.name
  address_prefixes     = ["10.0.1.0/24"]
}

#criação do cluster k8s
resource "azurerm_kubernetes_cluster" "challenge_kubernetes_cluster" {
  name = "challenge_cluster"

  #aqui nós setamos com o grupo de recurso que nós criamos e acessamos as propriedades
  location            = azurerm_resource_group.challenge_rg_devops.location
  resource_group_name = azurerm_resource_group.challenge_rg_devops.name

  dns_prefix = "challenge-cluster"

  default_node_pool {
    name       = "default"
    node_count = 2
    vm_size    = "Standard_DS2_v2"
  }
  #tipo de gerenciamento de credenciais/segurança
  identity {
    type = "SystemAssigned"
  }
  tags = {
    Environment = "Development"
  }
}