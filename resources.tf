###################################
# Azure Resources
###################################
resource "azurerm_resource_group" "rg" {
  name     = var.azure_resource_group
  location = var.azure_location
}


resource "azurerm_key_vault" "vault" {
  name                = var.key_vault_name
  location            = azurerm_resource_group.rg.location
  resource_group_name = azurerm_resource_group.rg.name
  sku_name            = "standard"
  tenant_id           = var.AZURE_TENANT_ID
  purge_protection_enabled = false
  
   access_policy {
    tenant_id = var.AZURE_TENANT_ID
    object_id = var.AZURE_CLIENT_OBJECT_ID
    key_permissions = [
      "Get",
      "List",
      "Create",
      "Update",
      "Delete",
      "Recover",
      "Backup",
      "Restore",
      "Import",
      "Encrypt",
      "Decrypt",
      "Purge",
      "Sign",
      "Verify",
      "WrapKey",
      "UnwrapKey",
      "GetRotationPolicy",
      "SetRotationPolicy",     # optionally if you plan to set rotation policies
      "Rotate"                # optionally if you need to rotate keys
    ]
    secret_permissions = [
      "Get",
      "List",
      "Set",
      "Delete",
      "Purge",
      "Recover",
      "Backup"
    ]
#   access_policy {
#     tenant_id = var.AZURE_TENANT_ID
#     object_id = var.AZURE_CLIENT_OBJECT_ID
#     secret_permissions = ["Get", "Set", "List"]
#      # If you're creating or updating keys, also add key_permissions:
#     key_permissions = [
#       "Get",
#       "List",
#       "Create",
#       "Update"
#     ]
  }
}



###################################
# GitHub Repository
###################################
resource "github_repository" "new_repo" {
  name        = var.github_repo_name
  description = "Migrated from GitLab ${var.gitlab_repo}"
  visibility  = "public"
}




# resource "null_resource" "migrate_gitlab_to_github" {
#   depends_on = [github_repository.new_repo]

#   # Force re-run each time for testing
#   triggers = {
#     run_id = timestamp()
#   }

#   provisioner "local-exec" {
#     interpreter = ["cmd", "/c"]
#     command = "migrate.bat"
#     environment = {
#       GITLAB_REPO  = var.gitlab_repo
#       GITHUB_TOKEN = var.github_token
#       GITHUB_OWNER = var.github_owner
#       GITHUB_REPO  = var.github_repo_name
#     }
#   }
# }

###################################
# Null resource for bash script   #
#  execution                      #
###################################

resources.tf
resource "null_resource" "migrate_gitlab_to_github" {
  depends_on = [github_repository.new_repo]

  # Force re-run each time for testing
  triggers = {
    run_id = timestamp()
  }

  provisioner "local-exec" {
    interpreter = ["bash", "-c"]
    command     = "./migrate.bash"  # Assumes migrate.bash is in the root of the repo
    environment = {
      GITLAB_REPO  = var.gitlab_repo
      GITHUB_TOKEN = var.github_token
      GITHUB_OWNER = var.github_owner
      GITHUB_REPO  = var.github_repo_name
    }
  }
}