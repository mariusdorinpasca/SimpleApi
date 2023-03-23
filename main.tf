provider "azurerm" {
    version  = "3.48.0"
    features {}
}

terraform {
  backend "azurerm" {
    resource_group_name = "terraform_rg_blobstore"
    storage_account_name = "tfstorageaccountmdp"
    container_name = "tfstate"
    key = "terraform.tfstate"
  }
}

variable "imagebuild" {
  type = string
  description = "Latest Image Build"
}

resource "azurerm_resource_group" "tf_test" {
  name = "tfmainrg"
  location = "Australia East"
}

resource "azurerm_container_group" "tfcg_test" {
  name                   = "simpleapi"
  location               = azurerm_resource_group.tf_test.location
  resource_group_name    = azurerm_resource_group.tf_test.name
  ip_address_type        = "Public"
  dns_name_label         = "simpleapi"
  os_type                = "Linux"

  container {
     name = "simpleapi"
     image = "mariusdorin83/simpleapi:${var.imagebuild}"
     cpu = "1"
     memory = "1"
     ports {
       port = 80
       protocol = "TCP"
     }
  }
}