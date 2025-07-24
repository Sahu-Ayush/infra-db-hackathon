variable "project_id" {
  description = "The GCP project ID"
  type        = string
  default     = "dev-env-ayush"
}

variable "region" {
  description = "The GCP region"
  type        = string
  default     = "us-central1"
}

variable "feedback_bucket_name" {
  description = "Cloud Storage bucket name for feedback"
  type        = string
  default     = "finai-feedback"
}

variable "account_id" {
  description = "Service account ID"
  type        = string
  default     = "cloudrun-finai"
}

variable "display_name" {
  description = "Service account display name"
  type        = string
  default     = "Cloud Run Service Account for FinAI Mitra"
}