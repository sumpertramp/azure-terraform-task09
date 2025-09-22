# 10.1: FW Subnet (existing VNet içinde)
resource "azurerm_subnet" "afw" {
  name                 = local.firewall_subnet_name
  resource_group_name  = var.resource_group_name
  virtual_network_name = split("/virtualNetworks/", var.vnet_id)[1]
  # vnet_id'den isim çıkarma: /.../virtualNetworks/<NAME>
  address_prefixes = [var.fw_subnet_cidr]
}

# 10.2: Public IP (FW için) - create_before_destroy şartı
resource "azurerm_public_ip" "fw" {
  name                = var.firewall_pip_name
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  lifecycle {
    create_before_destroy = true
  }

  tags = local.common_tags
}

# 10.3: Azure Firewall
resource "azurerm_firewall" "this" {
  name                = var.firewall_name
  location            = var.location
  resource_group_name = var.resource_group_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  threat_intel_mode   = "Alert"

  ip_configuration {
    name                 = "configuration"
    subnet_id            = azurerm_subnet.afw.id
    public_ip_address_id = azurerm_public_ip.fw.id
  }

  tags = local.common_tags
}

# 10.4: Route Table (0.0.0.0/0 -> Firewall private IP via Virtual Appliance)
resource "azurerm_route_table" "egress" {
  name                          = var.route_table_name
  location                      = var.location
  resource_group_name           = var.resource_group_name
  bgp_route_propagation_enabled = true

  route {
    name                   = "default-to-fw"
    address_prefix         = "0.0.0.0/0"
    next_hop_type          = "VirtualAppliance"
    next_hop_in_ip_address = azurerm_firewall.this.ip_configuration[0].private_ip_address
  }

  tags = local.common_tags
}

# 10.5: RT association with AKS subnet
resource "azurerm_subnet_route_table_association" "aks" {
  subnet_id      = var.aks_subnet_id
  route_table_id = azurerm_route_table.egress.id
}

# 10.6: Application Rule Collection (HTTP/HTTPS allow to internet)
resource "azurerm_firewall_application_rule_collection" "app" {
  name                = local.rc.app.name
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = var.resource_group_name
  priority            = local.rc.app.priority
  action              = "Allow"

  rule {
    name             = "allow-http-https"
    source_addresses = ["10.0.0.0/16"]
    target_fqdns     = var.app_rule_target_fqdns

    dynamic "protocol" {
      for_each = var.app_rule_protocols
      content {
        type = protocol.value.proto
        port = protocol.value.port
      }
    }
  }
}


# 10.7: Network Rule Collection (DNS allow)
resource "azurerm_firewall_network_rule_collection" "net" {
  name                = local.rc.net.name
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = var.resource_group_name
  priority            = local.rc.net.priority
  action              = "Allow"

  rule {
    name                  = "allow-dns"
    source_addresses      = ["10.0.0.0/16"]
    destination_addresses = ["*"]
    destination_ports     = ["53"]
    protocols             = ["UDP", "TCP"]
  }
}

# 10.8: NAT Rule Collection (DNAT 80/443 -> AKS LB)
resource "azurerm_firewall_nat_rule_collection" "nat" {
  name                = local.rc.nat.name
  azure_firewall_name = azurerm_firewall.this.name
  resource_group_name = var.resource_group_name
  priority            = local.rc.nat.priority
  action              = "Dnat"

  dynamic "rule" {
    for_each = var.nat_dnat_ports
    content {
      name                  = "${rule.key}-to-aks"
      source_addresses      = ["*"]
      destination_addresses = [azurerm_public_ip.fw.ip_address]
      destination_ports     = [tostring(rule.value)]
      protocols             = ["TCP"]
      translated_address    = var.aks_loadbalancer_ip
      translated_port       = rule.value
    }
  }
}
