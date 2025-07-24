# variable "region" {
#   type = string
# }
# variable "image" {
#   type = string
# }
# variable "secret_name" {
#   type = string
# }
# variable "feedback_bucket" {
#   type = string
# }

variable "image" {
  description = "Container image for Cloud Run"
  type        = string
}

variable "region" {
  description = "GCP region to deploy Cloud Run"
  type        = string
}

variable "service_account_email" {
  description = "Service account email to attach to Cloud Run"
  type        = string
}
