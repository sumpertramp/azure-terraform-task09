data "azurerm_resource_group" "rg" {
  name = local.rg
}

data "azurerm_virtual_network" "vnet" {
  name                = local.vnet_name
  resource_group_name = data.azurerm_resource_group.rg.name
}

data "azurerm_subnet" "aks" {
  name                 = local.aks_snet_name
  virtual_network_name = data.azurerm_virtual_network.vnet.name
  resource_group_name  = data.azurerm_resource_group.rg.name
}

module "afw" {
  source = "./modules/afw"

  location            = local.region
  resource_group_name = data.azurerm_resource_group.rg.name

  vnet_id       = data.azurerm_virtual_network.vnet.id
  aks_subnet_id = data.azurerm_subnet.aks.id

  firewall_name     = local.names.firewall
  firewall_pip_name = local.names.pip
  route_table_name  = local.names.route_table

  app_rule_collection_name = var.app_rule_collection_name
  net_rule_collection_name = var.net_rule_collection_name
  nat_rule_collection_name = var.nat_rule_collection_name

  fw_subnet_cidr      = var.fw_subnet_cidr
  aks_loadbalancer_ip = var.aks_loadbalancer_ip

  # ✅ Modülün zorunlu beklediği parametreler
  app_rule_target_fqdns = var.app_rule_target_fqdns
  app_rule_protocols    = var.app_rule_protocols
  net_rule_protocols    = var.net_rule_protocols
  nat_dnat_ports        = var.nat_dnat_ports

  aks_backend_private_ip = var.aks_backend_private_ip

  tags = var.tags
}
