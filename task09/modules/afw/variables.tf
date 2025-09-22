variable "location" { type = string }
variable "resource_group_name" { type = string }

variable "vnet_id" { type = string }
variable "aks_subnet_id" { type = string }

variable "firewall_name" { type = string }
variable "firewall_pip_name" { type = string }
variable "route_table_name" { type = string }

variable "fw_subnet_cidr" {
  description = "CIDR for AzureFirewallSubnet"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "AKS LB public IP (DNAT target)"
  type        = string
}

variable "tags" {
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
