variable "location" {
  description = "Azure region for all resources (e.g., East US)."
  type        = string
}

variable "resource_group_name" {
  description = "Name of the existing Resource Group that hosts the VNet and AKS."
  type        = string
}

variable "vnet_id" {
  description = "Resource ID of the existing Virtual Network."
  type        = string
}

variable "aks_subnet_id" {
  description = "Resource ID of the existing AKS subnet to associate with the route table."
  type        = string
}

variable "firewall_name" {
  description = "Name for the Azure Firewall resource."
  type        = string
}

variable "firewall_pip_name" {
  description = "Name for the Public IP address assigned to the Azure Firewall."
  type        = string
}

variable "route_table_name" {
  description = "Name for the route table used to force egress through the firewall."
  type        = string
}
variable "fw_subnet_cidr" {
  description = "CIDR for AzureFirewallSubnet"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "AKS LB public IP (DNAT target)"
  type        = string
}

variable "tags" {
  description = "Tag"
  type = map(string)
}

variable "app_rule_target_fqdns" {
  description = "List of FQDNs allowed by the application rule"
  type        = list(string)
}

variable "app_rule_protocols" {
  description = "Protocols for the application rule"
  type = list(object({
    type = string
    port = number
  }))
  default = [
    { type = "Http", port = 80 },
    { type = "Https", port = 443 },
  ]
}

variable "net_rule_protocols" {
  description = "Protocols for the network rule (DNS)"
  type        = list(string)
}

variable "nat_dnat_ports" {
  description = "Map of DNAT rules => destination/translated port"
  type        = map(number)

}
