data "azurerm_shared_image_version" "rhel9_latest" {
  name                = "latest"
  image_name          = "RHEL_9"
  gallery_name        = "prod_goldern_image_azu_gallery"
  resource_group_name = "rg-of-image-gallery"   # Replace with actual RG
}


az sig image-version list \
  --gallery-name prod_goldern_image_azu_gallery \
  --gallery-image-definition RHEL_9 \
  --resource-group <gallery-rg> \
  --query "[].{Name:name, Published:publishingProfile.publishedDate}" --output table

resource "azurerm_linux_virtual_machine" "epra-gi-stg" {
  name                = "epra-gi-stg-s1"
  resource_group_name = azurerm_resource_group.example.name
  location            = azurerm_resource_group.example.location
  size                = "Standard_F32s_v2"
  admin_username      = "awxadmin"
  network_interface_ids = [azurerm_network_interface.example.id]

  admin_ssh_key {
    username   = "awxadmin"
    public_key = file("~/.ssh/id_rsa.pub")
  }

  os_disk {
    name                 = "epra-gi-stg-s1-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }

  source_image_id = data.azurerm_shared_image_version.rhel9_latest.id

  disable_password_authentication = true

  identity {
    type = "SystemAssigned"
  }
}
