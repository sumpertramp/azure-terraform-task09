location            = "East US"
resource_group_name = "cmtr-vf06h1cc-mod9-rg"
vnet_name           = "cmtr-vf06h1cc-mod9-vnet"
aks_subnet_name     = "aks-snet"

# FW alt ağı: çakışmasın
fw_subnet_cidr = "10.0.1.0/26"

# Görevde verilen AKS LB public IP:
aks_loadbalancer_ip = "52.170.173.158"

tags = {
  Creator = "sumeyye_unal@epam.com"
  Module  = "mod9"
}
