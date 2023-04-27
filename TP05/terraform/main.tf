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

resource "azurerm_resource_group" "rg-b3-mumble" {
  name     = "b3-mumble"
  location = "eastus"
}

resource "azurerm_virtual_network" "vn-b3-mumble" {
  name                = "b3-mumble"
  address_space       = ["10.0.0.0/16"]
  location            = azurerm_resource_group.rg-b3-mumble.location
  resource_group_name = azurerm_resource_group.rg-b3-mumble.name
}

resource "azurerm_subnet" "s-b3-mumble" {
  name                 = "internal"
  resource_group_name  = azurerm_resource_group.rg-b3-mumble.name
  virtual_network_name = azurerm_virtual_network.vn-b3-mumble.name
  address_prefixes     = ["10.0.2.0/24"]
}

resource "azurerm_public_ip" "public-b3-mumble" {
  name                = "public"
  location            = azurerm_resource_group.rg-b3-mumble.location
  resource_group_name = azurerm_resource_group.rg-b3-mumble.name  
  allocation_method   = "Dynamic"
  
}

resource "azurerm_network_interface" "nic-b3-mumble" {
  name                = "mumble-nic"
  location            = azurerm_resource_group.rg-b3-mumble.location
  resource_group_name = azurerm_resource_group.rg-b3-mumble.name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = azurerm_subnet.s-b3-mumble.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id          = azurerm_public_ip.public-b3-mumble.id
  }
}

resource "azurerm_linux_virtual_machine" "vm-b3-mumble" {
  name                = "b3-mumble"
  resource_group_name = azurerm_resource_group.rg-b3-mumble.name
  location            = azurerm_resource_group.rg-b3-mumble.location
  size                = "Standard_B1s"
  admin_username      = "Sarvagon"
  network_interface_ids = [
    azurerm_network_interface.nic-b3-mumble.id,
  ]

  admin_ssh_key {
    username   = "Sarvagon"
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
}

