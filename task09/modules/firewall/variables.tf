variable "rg_name" {
  description = "Name of the Azure Resource Group where all resources will be created"
  type        = string
}

variable "location" {
  description = "Azure region in which resources will be deployed"
  type        = string
}

variable "vnet_name" {
  description = "Name of the Virtual Network to host subnets and resources"
  type        = string
}

variable "fw_subnet_id" {
  description = "Resource ID of the AzureFirewallSubnet within the Virtual Network"
  type        = string
}

variable "fw_name" {
  description = "Name of the Azure Firewall resource"
  type        = string
}

variable "fw_pip_name" {
  description = "Name of the Public IP resource assigned to the Azure Firewall"
  type        = string
}

variable "aks_loadbalancer_ip" {
  description = "Public IP address of the AKS Load Balancer (used for DNAT rules)"
  type        = string
}

variable "nat_app_ports" {
  description = "Set of application ports for DNAT forwarding to the AKS Load Balancer"
  type        = set(number)
}

variable "aks_node_subnet_id" {
  description = "Resource ID of the subnet where AKS worker nodes are deployed"
  type        = string
}

variable "tags" {
  description = "A mapping of tags to assign to all resources for identification and cost tracking"
  type        = map(string)
}
