output "azure_firewall_public_ip" {
  value       = module.firewall.azure_firewall_public_ip
  description = "Azure Firewall Public IP address"
}

output "azure_firewall_private_ip" {
  value       = module.firewall.azure_firewall_private_ip
  description = "Azure Firewall Private IP address"
}