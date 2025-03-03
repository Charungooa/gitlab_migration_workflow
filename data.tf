# variable "gitlab_repo" {
#   type = string
# }

data "gitlab_project_variables" "secrets" {
  project = var.gitlab_repo  # Project path or ID
}

locals {
  secrets_list = [for var in data.gitlab_project_variables.secrets.variables : {
    key   = var.key
    value = var.value
  }]
}

resource "azurerm_key_vault_secret" "gitlab_secret" {
  for_each     = { for secret in local.secrets_list : secret.key => secret.value }
  name         = replace(each.key, "_", "-")  # Replace underscores with hyphens
  value        = each.value
  key_vault_id = azurerm_key_vault.vault.id
}

resource "github_actions_secret" "migrated_secrets" {
  for_each        = { for secret in local.secrets_list : secret.key => secret.value }
  repository      = "github_myapp_financeapp"
  secret_name     = each.key
  plaintext_value = each.value

}