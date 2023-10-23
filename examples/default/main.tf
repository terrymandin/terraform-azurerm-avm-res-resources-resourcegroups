terraform {
  required_version = ">= 1.0.0"
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = ">= 3.7.0, < 4.0.0"
    }
  }
}

variable "enable_telemetry" {
  type        = bool
  default     = false
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see https://aka.ms/avm/telemetryinfo.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

# This ensures we have unique CAF compliant names for our resources.
module "naming" {
  source  = "Azure/naming/azurerm"
  version = "0.3.0"
}

# This is required for resource modules
#resource "azurerm_resource_group" "this" {
#  name     = module.naming.resource_group.name_unique
#  location = "MYLOCATION"
#}

# This is the module call
module "terraform-azurerm-avm-res-resources-resourcegroups" { 
  source = "../../"
  enable_telemetry = var.enable_telemetry 
  name = module.naming.resource_group.name_unique
  location = "eastus"
  tags = {
    environment = "dev"
    costcenter  = "it"
  }
}

output "resource_group_name" {
  value = module.terraform-azurerm-avm-res-resources-resourcegroups.resource_group_name
}

output "resource_group_id" {
  value = module.terraform-azurerm-avm-res-resources-resourcegroups.resource_id
}