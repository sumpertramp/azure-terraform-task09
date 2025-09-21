# ---- Required core ----
variable "location" {
  description = "Resources location"
  type        = string
}

variable "rg_name" {
  description = "Existing resource group where firewall and related resources will be deployed."
  type        = string
}

variable "vnet_name" {
  description = "Existing VNet name containing AzureFirewallSubnet."
  type        = string
}

variable "vnet_address_space" {
  description = "Existing VNet address space (CIDR)"
  type        = string
}

variable "aks_subnet_name" {
  description = "Existing AKS subnet name"
  type        = string
}

variable "aks_subnet_address_space" {
  description = "Existing AKS subnet address space (CIDR)"
  type        = string
}

variable "aks_cluster_name" {
  description = "Existing AKS cluster name"
  type        = string
}

# ---- Firewall & routing ----
variable "fw_subnet_name" {
  description = "Firewall dedicated subnet name. Must be AzureFirewallSubnet."
  type        = string
}

variable "fw_subnet_address_prefix" {
  description = "CIDR for AzureFirewallSubnet (must be at least /26)"
  type        = string
}

variable "fw_name" {
  description = "Azure Firewall name."
  type        = string
}

variable "fw_pip_name" {
  description = "Firewall Public IP name."
  type        = string
}

variable "aks_node_subnet_id" {
  description = "AKS node subnet ID to attach UDR for egress via firewall."
  type        = string
}

# ---- Traffic / DNAT ----
variable "aks_loadbalancer_ip" {
  description = "AKS NGINX Load Balancer public IP (from task parameters)."
  type        = string
}

variable "nat_app_ports" {
  description = "Ports to expose via DNAT from Firewall PIP to AKS LB."
  type        = set(number)
}

# ---- Tags ----
variable "tags" {
  description = "Common tags."
  type        = map(string)
}

# (Opsiyonel ama faydalı) Basit doğrulamalar
variable "cmtr_prefix" {
  description = "Naming should start with cmtr-vf06h1cc-mod9"
  type        = string
}

