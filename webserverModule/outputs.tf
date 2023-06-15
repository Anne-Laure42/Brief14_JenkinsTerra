output "The_subnet_ID" {
 value = azurerm_subnet.anne_terraform_subnet.id
}

output "The_vnet_ID" {
 value = azurerm_virtual_network.anne_terraform_vnet.id
}

output "The_websrever_Private_ip" {
   value = azurerm_linux_virtual_machine.anne_terraform_vmnginx.private_ip_address
}

output "The_webserver_Public_ip" {
   value = azurerm_linux_virtual_machine.anne_terraform_vmnginx.public_ip_address
}

output "resource_group_name" {
  value = azurerm_resource_group.anne_terraform_rg.name
}

output "environment" {
  value = var.environment
}



