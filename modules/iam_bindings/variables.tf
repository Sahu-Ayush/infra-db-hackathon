variable "project_id" {
  type = string
}

variable "roles" {
  type        = list(string)
  description = "List of IAM roles to bind to the service account"
}

variable "service_account_email" {
  type        = string
  description = "Service account email to grant secret and API permissions"
}
