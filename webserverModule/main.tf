resource "azurerm_resource_group" "anne_terraform_rg" {
   name = "anne_brief14_jenkinsterraform${var.environment}"
   location = var.location
}


resource "azurerm_network_security_group" "allowedports" {
   name = "allowedports"
   resource_group_name = azurerm_resource_group.anne_terraform_rg.name
   location = azurerm_resource_group.anne_terraform_rg.location

   security_rule {
       name = "http"
       priority = 100
       direction = "Inbound"
       access = "Allow"
       protocol = "Tcp"
       source_port_range = "*"
       destination_port_range = "8080"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }

   security_rule {
       name = "https"
       priority = 200
       direction = "Inbound"
       access = "Allow"
       protocol = "Tcp"
       source_port_range = "*"
       destination_port_range = "443"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }

   security_rule {
       name = "ssh"
       priority = 300
       direction = "Inbound"
       access = "Allow"
       protocol = "Tcp"
       source_port_range = "*"
       destination_port_range = "22"
       source_address_prefix = "*"
       destination_address_prefix = "*"
   }
}

resource "azurerm_public_ip" "anne_terraform_public_ip" {
   name = "anne_brief14_public_ip"
   location = var.location
   resource_group_name = azurerm_resource_group.anne_terraform_rg.name
   allocation_method = "Dynamic"

   tags = {
       environment = var.environment
       costcenter = "it"
   }

   depends_on = [azurerm_resource_group.anne_terraform_rg]
}

resource "azurerm_network_interface" "anne_terraform_ni" {
   name = "anne_brief14-interface"
   location = azurerm_resource_group.anne_terraform_rg.location
   resource_group_name = azurerm_resource_group.anne_terraform_rg.name

   ip_configuration {
       name = "internal"
       private_ip_address_allocation = "Dynamic"
       subnet_id = azurerm_subnet.anne_terraform_subnet.id
       public_ip_address_id = azurerm_public_ip.anne_terraform_public_ip.id
   }

   depends_on = [azurerm_resource_group.anne_terraform_rg]
}

resource "azurerm_linux_virtual_machine" "anne_terraform_vmnginx" {
   size = var.instance_size
   name = "anne_brief14_jenkinsterraform"
   resource_group_name = azurerm_resource_group.anne_terraform_rg.name
   location = azurerm_resource_group.anne_terraform_rg.location
   custom_data = base64encode(file("init-script.sh"))
   network_interface_ids = [
       azurerm_network_interface.anne_terraform_ni.id,
   ]

   source_image_reference {
       publisher = "Canonical"
       offer = "UbuntuServer"
       sku = "18.04-LTS"
       version = "latest"
   }

   computer_name = "pythonapp"
   admin_username = "adminuser"
   admin_password = "kingpin42330@"
   disable_password_authentication = false

   os_disk {
       name = "nginxdisk01"
       caching = "ReadWrite"
       #create_option = "FromImage"
       storage_account_type = "Standard_LRS"
   }

   tags = {
       environment = var.environment
       costcenter = "it"
   }

   depends_on = [azurerm_resource_group.anne_terraform_rg]
}
