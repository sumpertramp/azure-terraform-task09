locals {
  # Azure Firewall subnet MUST be named exactly 'AzureFirewallSubnet'
  firewall_subnet_name = "AzureFirewallSubnet"

  # Rule collection priorities (smaller = higher precedence)
  rc_priority = {
    app = 100
    net = 110
    nat = 120
  }

  common_tags = var.tags
}
