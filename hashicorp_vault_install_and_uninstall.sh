resource "azurerm_linux_virtual_machine" "epra-gi-stg" {
  name                  = "epra-gi-stg-s1"
  resource_group_name   = "rg-self-stg-centralus"
  location              = "centralus"
  size                  = "Standard F32s v2"
  network_interface_ids = [azurerm_network_interface.example.id]

  os_disk {
    name = "epra-gi-stg-s1-disk"
    caching              = "ReadWrite"
    storage_account_type = "Premium_LRS"
    disk_size_gb         = 64
  }
}
