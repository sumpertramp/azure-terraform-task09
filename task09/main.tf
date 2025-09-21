data "azurerm_resource_group" "rg" {
  name = var.rg_name
}

data "azurerm_virtual_network" "vnet" {
  name                = var.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

resource "azurerm_subnet" "fw_subnet" {
  name                 = var.fw_subnet_name # AzureFirewallSubnet olmalı
  resource_group_name  = data.azurerm_resource_group.rg.name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  address_prefixes     = [var.fw_subnet_address_prefix]
}

module "firewall" {
  source = "./modules/firewall"

  rg_name  = data.azurerm_resource_group.rg.name
  location = var.location

  vnet_name    = data.azurerm_virtual_network.vnet.name
  fw_subnet_id = azurerm_subnet.fw_subnet.id # ← data.* yerine resource id

  fw_name     = var.fw_name
  fw_pip_name = var.fw_pip_name

  aks_loadbalancer_ip = var.aks_loadbalancer_ip
  nat_app_ports       = var.nat_app_ports

  aks_node_subnet_id = var.aks_node_subnet_id
  tags               = var.tags
}


