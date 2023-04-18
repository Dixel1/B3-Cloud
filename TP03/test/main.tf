terraform {
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">=3.0.0"
    }
  }
}

provider "azurerm" {
  features {}
}

resource "azurerm_resource_group" "rg-b3-node" {
  name     = "b3-node"
  location = "eastus"
}

resource "azurerm_virtual_network" "vn-b3-node" {
  name                = "b3-node"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-b3-node.location
  resource_group_name = azurerm_resource_group.rg-b3-node.name
}

resource "azurerm_subnet" "s-b3-node1" {
  name                 = "internal"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = azurerm_resource_group.rg-b3-node.name
  virtual_network_name = azurerm_virtual_network.vn-b3-node.name
}

resource "azurerm_subnet" "s-b3-node2" {
  name                 = "internal"
  address_prefixes     = ["10.0.1.0/24"]
  resource_group_name  = azurerm_resource_group.rg-b3-node.name
  virtual_network_name = azurerm_virtual_network.vn-b3-node.name
}

resource "azurerm_public_ip" "public-b3-node1" {
  name                = "public"
  location            = azurerm_resource_group.rg-b3-node.location
  resource_group_name = azurerm_resource_group.rg-b3-node.name  
  allocation_method   = "Dynamic"
  
}

resource "azurerm_network_interface" "nic-b3-node1" {
  name                = "example-nic-1"
  location            = azurerm_resource_group.rg-b3-node.location
  resource_group_name = azurerm_resource_group.rg-b3-node.name
  
  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.s-b3-node1.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-b3-node1.id
  }
}

resource "azurerm_network_interface" "nic-b3-node2" {
  name                = "example-nic-2"
  location            = azurerm_resource_group.rg-b3-node.location
  resource_group_name = azurerm_resource_group.rg-b3-node.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.s-b3-node2.id
    private_ip_address_allocation = "Dynamic"
  }
}

resource "azurerm_linux_virtual_machine" "node1" {
  name                = "b3-node1"
  location            = azurerm_resource_group.rg-b3-node.location
  resource_group_name = azurerm_resource_group.rg-b3-node.name
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic-b3-node1.id,
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/Users/schaf/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Canonical"
    offer     = "0001-com-ubuntu-server-jammy"
    sku       = "22_04-lts-gen2"
    version   = "latest"
  }
}

resource "azurerm_linux_virtual_machine" "node2" {
  name                = "b3-node2"
  location            = azurerm_resource_group.rg-b3-node.location
  resource_group_name = azurerm_resource_group.rg-b3-node.name
  size                = "Standard_B1s"
  admin_username      = "adminuser"
  network_interface_ids = [
    azurerm_network_interface.nic-b3-node2.id
  ]

  admin_ssh_key {
    username   = "adminuser"
    public_key = file("C:/Users/schaf/.ssh/id_rsa.pub")
  }

  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }

  source_image_reference {
    publisher = "Debian"
    offer     = "Debian-10"
    sku       = "10"
    version   = "latest"
  }
  
/*Autre source_image_reference pour tests
  source_image_reference {
    publisher = "erockyenterprisesoftwarefoundationinc1653071250513"
    offer     = "rockylinux-9"
    sku       = "rockylinux-9"
    version   = "9.1.20230215"
  }

  plan {
    publisher = "erockyenterprisesoftwarefoundationinc1653071250513"
    name      = "rockylinux-9"
    product   = "rockylinux-9"
  }*/
}