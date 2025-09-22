location            = "East US"
resource_group_name = "cmtr-vf06h1cc-mod9-rg"
vnet_name           = "cmtr-vf06h1cc-mod9-vnet"
aks_subnet_name     = "aks-snet"
name_prefix         = "cmtr-vf06h1cc-mod9"

# FW alt ağı: çakışmasın
fw_subnet_cidr = "10.0.1.0/26"

# Görevde verilen AKS LB public IP:
aks_loadbalancer_ip = "172.212.61.200"

tags = {
  Creator = "sumeyye_unal@epam.com"
  Module  = "mod9"
}

app_rule_collection_name = "cmtr-vf06h1cc-mod9-app"
net_rule_collection_name = "cmtr-vf06h1cc-mod9-net"
nat_rule_collection_name = "cmtr-vf06h1cc-mod9-nat"

app_rule_target_fqdns = [
  "*.microsoft.com",
  "*.azure.com",
  "*.github.com",
  "*.docker.com",
  "*.ubuntu.com"
]

app_rule_protocols = [
  { proto = "Http", port = 80 },
  { proto = "Https", port = 443 },
]

net_rule_protocols = ["UDP", "TCP"]

nat_dnat_ports = { http = 80, https = 443 }

aks_backend_private_ip = ""