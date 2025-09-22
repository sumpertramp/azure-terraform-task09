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

app_rule_target_fqdns = [
  "*.microsoft.com",
  "*.azure.com",
  "*.github.com",
  "*.docker.com",
  "*.ubuntu.com"
]

app_rule_protocols = [
  { type = "Http", port = 80 },
  { type = "Https", port = 443 },
]

net_rule_protocols = ["UDP", "TCP"]

nat_dnat_ports = { http = 80, https = 443 }