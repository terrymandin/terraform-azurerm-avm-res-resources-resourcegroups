# Required variables
variable "enable_telemetry" {
  type        = bool
  default     = true
  description = <<DESCRIPTION
This variable controls whether or not telemetry is enabled for the module.
For more information see https://aka.ms/avm/telemetry.
If it is set to false, then no telemetry will be collected.
DESCRIPTION
}

variable "name" {
  type = string
  description = "The name of the Resource Group"
  validation {
    condition = can(regex("^[a-zA-Z][a-zA-Z0-9_-]{0,90}$", var.name))
    error_message = "The name of the Resource Group must start with a letter, use underscores, hyphens, periods, parentheses, and letters or digits, and be between 1 and 90 characters"
  }
}

variable "location" { 
  type = string
  description = "The Azure Region in which all resources in this example should be created."
  default = "eastus"
  validation {
    condition = contains(["eastus", "eastus2", "westus", "westus2"], var.location)
    error_message = "The location must be eastus, eastus2, westus, or westus2."
  }
}

variable "tags" {
  type        = map(any)
  description = "Map of tags to assign to the resources."
  default     = null
}

variable "lock" {
  type = object({
    name = optional(string, null)
    kind = optional(string, "None")
  })
  description = "The lock level to apply to the resources in this pattern. Default is `None`. Possible values are `None`, `CanNotDelete`, and `ReadOnly`."
  default     = {}
  nullable    = false
  validation {
    condition     = contains(["CanNotDelete", "ReadOnly", "None"], var.lock.kind)
    error_message = "The lock level must be one of: 'None', 'CanNotDelete', or 'ReadOnly'."
  }
}