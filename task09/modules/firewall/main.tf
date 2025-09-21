locals {
  # Örnek “function” kullanımları: format, toset, join
  dnats_display = format("DNAT to %s ports %s",
    var.aks_loadbalancer_ip,
    join(",", [for p in toset(var.nat_app_ports) : tostring(p)])
  )
}

resource "azurerm_public_ip" "fw_pip" {
  name                = var.fw_pip_name
  location            = var.location
  resource_group_name = var.rg_name
  allocation_method   = "Static"
  sku                 = "Standard"
  tags                = var.tags

  lifecycle {
    # GÖREV ŞARTI
    create_before_destroy = true
  }
}

resource "azurerm_firewall" "fw" {
  name                = var.fw_name
  location            = var.location
  resource_group_name = var.rg_name
  sku_name            = "AZFW_VNet"
  sku_tier            = "Standard"
  tags                = merge(var.tags, { Note = local.dnats_display })

  ip_configuration {
    name                 = "configuration"
    subnet_id            = var.fw_subnet_id
    public_ip_address_id = azurerm_public_ip.fw_pip.id
  }
}

# NAT Rule Collection (tek koleksiyon; dynamic rules)
resource "azurerm_firewall_nat_rule_collection" "dnat" {
  name                = "dnat-to-aks"
  azure_firewall_name = azurerm_firewall.fw.name
  resource_group_name = var.rg_name
  priority            = 200
  action              = "Dnat"

  dynamic "rule" {
    # for_each ile portlara göre kural üret
    for_each = var.nat_app_ports
    content {
      name = format("nginx-%d", rule.value)

      source_addresses      = ["*"]
      destination_addresses = [azurerm_public_ip.fw_pip.ip_address]
      destination_ports     = [tostring(rule.value)]
      protocols             = ["TCP", "UDP"]

      # DNAT hedefi: AKS LB public IP’si
      translated_address = var.aks_loadbalancer_ip
      translated_port    = tostring(rule.value)
    }
  }

  depends_on = [azurerm_firewall.fw]
}

# Egress kontrolü için: UDR (0.0.0.0/0 next hop = FW private IP)
resource "azurerm_route_table" "aks_egress" {
  name                = "aks-egress-via-fw-rt"
  location            = var.location
  resource_group_name = var.rg_name
  tags                = var.tags
}

resource "azurerm_route" "default_inet" {
  name                   = "default-to-fw"
  resource_group_name    = var.rg_name
  route_table_name       = azurerm_route_table.aks_egress.name
  address_prefix         = "0.0.0.0/0"
  next_hop_type          = "VirtualAppliance"
  next_hop_in_ip_address = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  depends_on             = [azurerm_firewall.fw]
}

# AKS node subnet’e RT association
resource "azurerm_subnet_route_table_association" "aks_assoc" {
  subnet_id      = var.aks_node_subnet_id
  route_table_id = azurerm_route_table.aks_egress.id
}
