output "firewall_public_ip" {
  value       = azurerm_public_ip.fw.ip_address
  description = "Azure Firewall Public IP"
}

output "firewall_private_ip" {
  value       = azurerm_firewall.this.ip_configuration[0].private_ip_address
  description = "Azure Firewall private IP"
}
