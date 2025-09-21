resource "azurerm_subnet" "fw_subnet" {
  name                 = var.fw_subnet_name # "AzureFirewallSubnet"
  resource_group_name  = var.rg_name        # << data.* yerine var.*
  virtual_network_name = var.vnet_name      # << data.* yerine var.*
  address_prefixes     = [var.fw_subnet_address_prefix]
}

module "firewall" {
  source = "./modules/firewall"

  rg_name  = var.rg_name
  location = var.location

  # vnet_name modülde zorunlu değilse göndermesen de olur; gönderiyorsan var'dan gönder:
  vnet_name = var.vnet_name

  fw_subnet_id = azurerm_subnet.fw_subnet.id

  fw_name     = var.fw_name
  fw_pip_name = var.fw_pip_name

  aks_loadbalancer_ip = var.aks_loadbalancer_ip
  nat_app_ports       = var.nat_app_ports
  aks_node_subnet_id  = var.aks_node_subnet_id

  aks_subnet_address_space = var.aks_subnet_address_space

  tags = var.tags
}


