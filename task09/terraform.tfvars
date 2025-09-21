rg_name                  = "cmtr-vf06h1cc-mod9-rg"
location                 = "eastus"
vnet_name                = "cmtr-vf06h1cc-mod9-vnet"
vnet_address_space       = "10.0.0.0/16"
aks_subnet_name          = "aks-snet"
aks_subnet_address_space = "10.0.0.0/24"
aks_cluster_name         = "cmtr-vf06h1cc-mod9-aks"

fw_name     = "cmtr-vf06h1cc-mod9-fw"
fw_pip_name = "cmtr-vf06h1cc-mod9-pip"

# Task parametresindeki AKS LB Public IP
aks_loadbalancer_ip = "20.75.233.174"

# Bu ID’yi kendi ortamında az CLI ile alacaksın:
# az network vnet subnet show -g <aks_rg> -n aks-snet --vnet-name cmtr-vf06h1cc-mod9-vnet --query id -o tsv

aks_node_subnet_id = "/subscriptions/xxxx/resourceGroups/cmtr-vf06h1cc-mod9-rg/providers/Microsoft.Network/virtualNetworks/cmtr-vf06h1cc-mod9-vnet/subnets/aks-snet"

nat_app_ports = [80]

tags = {
  Creator = "sumeyye_unal@epam.com"
  Module  = "9"
}
