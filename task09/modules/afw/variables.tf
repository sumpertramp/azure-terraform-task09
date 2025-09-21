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
  type    = map(string)
  default = {}
}
