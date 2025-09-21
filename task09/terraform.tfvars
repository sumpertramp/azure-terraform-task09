# terraform.tfvars  (LOCAL — push etme)

location  = "eastus"
rg_name   = "cmtr-vf06h1cc-mod9-rg"
vnet_name = "cmtr-vf06h1cc-mod9-vnet"

# Firewall subnet (plan’da resource olarak oluşturuyoruz)
fw_subnet_name           = "AzureFirewallSubnet"
fw_subnet_address_prefix = "10.0.1.0/16"

# AKS bilgileri
aks_subnet_name          = "aks-snet"
aks_subnet_address_space = "10.0.0.0/24"
aks_cluster_name         = "cmtr-vf06h1cc-mod9-aks"
aks_loadbalancer_ip      = "52.147.215.112"

# AKS node subnet ID — kendi ortamından aldığın ID
aks_node_subnet_id = "/subscriptions/5f2c249d-8f0b-4f9c-98be-959a6658cb67/resourceGroups/cmtr-vf06h1cc-mod9-rg/providers/Microsoft.Network/virtualNetworks/cmtr-vf06h1cc-mod9-vnet/subnets/aks-snet"

# Firewall kaynak adları (naming convention’e uygun)
fw_name     = "cmtr-vf06h1cc-mod9-fw"
fw_pip_name = "cmtr-vf06h1cc-mod9-pip"

# DNAT portları
nat_app_ports = [80]

tags = {
  Creator = "sumeyye_unal@epam.com"
  Module  = "9"
}
