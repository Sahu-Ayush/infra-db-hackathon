variable "project_id" {
  type = string
}

variable "secret_name" {
  type = string
}

variable "secret_value" {
  type    = string
  default = ""
}

variable "service_account_email" {
  type = string
}
