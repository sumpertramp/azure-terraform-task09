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
  default     = {}
}
