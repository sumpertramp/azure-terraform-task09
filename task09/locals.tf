locals {
  prefix        = "cmtr-vf06h1cc-mod9"
  region        = var.location
  rg            = var.resource_group_name
  vnet_name     = var.vnet_name
  aks_snet_name = var.aks_subnet_name

  names = {
    pip         = "${local.prefix}-pip"
    firewall    = "${local.prefix}-afw"
    route_table = "${local.prefix}-rt"
  }
}
