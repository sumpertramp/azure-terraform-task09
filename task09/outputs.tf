output "azure_firewall_public_ip" {
  description = "Azure Firewall PIP"
  value       = module.afw.firewall_public_ip
}

output "azure_firewall_private_ip" {
  description = "Azure Firewall private IP"
  value       = module.afw.firewall_private_ip
}
