locals {
  # Azure Firewall subnet MUST be named exactly 'AzureFirewallSubnet'
  firewall_subnet_name = "AzureFirewallSubnet"

  # Rule collection names & priorities
  rc = {
    app = { name = "app-allow-web", priority = 100 }
    net = { name = "net-allow-dns", priority = 110 }
    nat = { name = "nat-aks-http", priority = 120 }
  }

  common_tags = var.tags
}
