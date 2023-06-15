resource "azurerm_virtual_network" "anne_terraform_vnet" {
   name                = "anne_brief13_vnet"
   address_space       = ["10.0.0.0/16"]
   location            = azurerm_resource_group.anne_terraform_rg.location
   resource_group_name = azurerm_resource_group.anne_terraform_rg.name
 }


 resource "azurerm_subnet" "anne_terraform_subnet" {
   name                 = "anne_brief13_subnet"
   resource_group_name  = azurerm_resource_group.anne_terraform_rg.name
   virtual_network_name = azurerm_virtual_network.anne_terraform_vnet.name
   address_prefixes     = ["10.0.2.0/24"]
}
