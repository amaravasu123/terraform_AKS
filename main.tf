provider "azurerm" {
  features {}
}

module "vnet" {
  source              = "./modules/vnet"
  vnet_name           = var.vnet_name
  vnet_address_space  = var.vnet_address_space
  subnet_name         = var.subnet_name
  subnet_address_prefixes = var.subnet_address_prefixes
  nsg_name            = var.nsg_name
  resource_group_name = var.resource_group_name
  location            = var.location
}

module "aks" {
  source              = "./modules/aks"
  aks_name            = var.aks_name
  location            = var.location
  resource_group_name = var.resource_group_name
  dns_prefix          = var.dns_prefix
  node_count          = var.node_count
  vm_size             = var.vm_size
  subnet_id           = module.vnet.subnet_id
}

module "ingress" {
  source = "./modules/ingress-nginx"
  namespace = "ingress-nginx"
}
