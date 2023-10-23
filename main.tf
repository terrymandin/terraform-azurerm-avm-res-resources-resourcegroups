resource "azurerm_resource_group" "this" {
    name     = var.name
    location = var.location
    tags     = var.tags 
}

resource "azurerm_management_lock" "lb_lock" {
  count      = var.lock.kind != "None" ? 1 : 0
  name       = coalesce(var.lock.name, "lock-${var.name}")
  scope      = azurerm_resource_group.this.id
  lock_level = var.lock.kind
}