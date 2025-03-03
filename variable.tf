variable "gitlab_repo" {
  description = "GitLab repository path (namespace/project)"
  type        = string
}

variable "github_repo_name" {
  description = "Name for the new GitHub repository"
  type        = string
}

variable "github_token" {
  description = "GitHub Personal Access Token"
  type        = string
  sensitive   = true
}

variable "gitlab_token" {
  description = "GitLab Personal Access Token (for API access to variables)"
  type        = string
  sensitive   = true
}

variable "github_owner" {
  description = "GitHub username or organization name where repo will be created"
  type        = string
}

variable "azure_location" {
  description = "Azure region for Key Vault"
  type        = string
  default     = "eastus"
}

variable "azure_resource_group" {
  description = "Name of Azure resource group to create"
  type        = string
  default     = "gitlab-migration-rg"
}


variable "key_vault_name" {
  description = "Name of Azure Key Vault to create"
  type        = string
}

variable "AZURE_TENANT_ID" {
  description = "Azure AD Tenant ID (for Key Vault access policy)"
  type        = string
}

variable "AZURE_CLIENT_OBJECT_ID" {
  description = "Object ID for Azure AD principal to grant Key Vault access"
  type        = string
}

variable "AZURE_CLIENT_ID" {
  type        = string
  description = "Azure AD Application client ID"
}

variable "AZURE_CLIENT_SECRET" {
  type        = string
  description = "Azure AD Application client secret"
  sensitive   = true
}

variable "AZURE_SUBSCRIPTION_ID" {
  type        = string
  description = "Azure subscription ID"
}

# variable "docker_password" {
#   description = "Docker registry password"
#   type        = string
#   sensitive   = true
  
# }
