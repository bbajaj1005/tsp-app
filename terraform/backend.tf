
terraform {
  backend "azurerm" {
    resource_group_name  = "avnet-backend"         # Replace with your RG name
    storage_account_name = "saavnetbackend"    # Your storage account name
    container_name       = "infra"             # The blob container for state
    key                  = "terraform.tfstate" # Path/key for the state file
  }
}
