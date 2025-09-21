output "azure_firewall_public_ip" {
  value       = azurerm_public_ip.fw_pip.ip_address
  description = "Azure Firewall Public IP address"
}

output "azure_firewall_private_ip" {
  value       = azurerm_firewall.fw.ip_configuration[0].private_ip_address
  description = "Azure Firewall Private IP address"
}
