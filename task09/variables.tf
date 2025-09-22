variable "location" {
  description = "Azure region"
  type        = string
}

variable "resource_group_name" {
  description = "Existing RG name"
  type        = string
}

variable "vnet_name" {
  description = "Existing VNet name"
  type        = string
}

variable "aks_subnet_name" {
  description = "Existing AKS subnet name"
  type        = string
}

variable "fw_subnet_cidr" {
  description = "CIDR for AzureFirewallSubnet (must not overlap)"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "Public IP of AKS Load Balancer for DNAT"
  type        = string
}

variable "tags" {
  description = "Common tags"
  type        = map(string)
}

variable "app_rule_target_fqdns" {
  description = "List of FQDNs allowed by the application rule"
  type        = list(string)
}

variable "app_rule_protocols" {
  description = "Protocols for the application rule"
  type = list(object({
    proto = string # Http / Https
    port  = number # 80 / 443
  }))
}

variable "net_rule_protocols" {
  description = "Protocols for the network rule (DNS)"
  type        = list(string)
}

variable "nat_dnat_ports" {
  description = "Map of DNAT rules => destination/translated port"
  type        = map(number)
}
