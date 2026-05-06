resource "azurerm_public_ip" "pip" {
  count               = var.enable_public_ip ? 1 : 0
  name                = "${var.vm_name}-pip"
  location            = var.location
  resource_group_name = var.resource_group_name

  allocation_method = "Static"
  sku               = "Standard"

  tags = var.tags
}

resource "azurerm_network_interface" "nic" {
  name                = "${var.vm_name}-nic"
  location            = var.location
  resource_group_name = var.resource_group_name

  ip_configuration {
    name                          = "internal"
    subnet_id                     = var.subnet_id
    private_ip_address_allocation = "Dynamic"

    public_ip_address_id = var.enable_public_ip ? azurerm_public_ip.pip[0].id : null
  }

  tags = var.tags
}

resource "azurerm_linux_virtual_machine" "vm" {
  name                = var.vm_name
  location            = var.location
  resource_group_name = var.resource_group_name
  size                = var.vm_size

  admin_username = var.admin_username
  admin_password = var.admin_password   # ✅ Added

  network_interface_ids = [
    azurerm_network_interface.nic.id
  ]

  # ✅ Enable password login
  disable_password_authentication = false

  # ❌ REMOVE THIS BLOCK (not needed for password login)
  # admin_ssh_key {
  #   username   = var.admin_username
  #   public_key = var.ssh_public_key
  # }

  os_disk {
    name                 = "${var.vm_name}-osdisk"
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
    disk_size_gb         = var.os_disk_size_gb
  }

  source_image_reference {
    publisher = var.image_publisher
    offer     = var.image_offer
    sku       = var.image_sku
    version   = var.image_version
  }

  tags = var.tags

  # 🔥 Install Ansible automatically
  provisioner "remote-exec" {
    inline = [
      "sudo apt update -y",
      "sudo apt install software-properties-common -y",
      "sudo apt-add-repository --yes --update ppa:ansible/ansible",
      "sudo apt install ansible -y",
      "ansible --version"
    ]

    connection {
      type     = "ssh"
      user     = var.admin_username
      password = var.admin_password   # ✅ Use password instead of key
      host     = var.enable_public_ip ? azurerm_public_ip.pip[0].ip_address : null
    }
  }
}