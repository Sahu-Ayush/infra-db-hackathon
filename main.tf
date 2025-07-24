terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
  required_version = ">= 1.5.0"
}

provider "google" {
  project = var.project_id
  region  = var.region
}

module "artifact_registry" {
  source = "./modules/artifact_registry"
  region = var.region
}

module "secret_manager" {
  source                = "./modules/secret_manager"
  project               = var.project_id
  secret_name           = "gemini-api-key"
  secret_value          = "dummy-not-required" # empty -> secret only, value to be uploaded manually
  service_account_email = module.service_account.service_account_email
}

module "storage" {
  source        = "./modules/storage"
  bucket_name   = var.feedback_bucket_name
  region        = var.region
}

# module "cloudrun" {
#   source          = "./modules/cloudrun"
#   image           = "${var.region}-docker.pkg.dev/${var.project_id}/${module.artifact_registry.repo_id}/finai-mitra:latest"
#   secret_name     = module.secret_manager.secret_id
#   feedback_bucket = module.storage.bucket_name
#   region          = var.region
# }


module "service_account" {
  source       = "./modules/service_account"
  project      = var.project_id
  account_id   = var.account_id
  display_name = var.display_name
}

module "cloudrun" {
  source                = "./modules/cloudrun"
  image                 = "us-central1-docker.pkg.dev/dev-env-ayush/finai-mitra/finai-mitra:latest"
  region                = var.region
  service_account_email = module.service_account.service_account_email
}

module "iam_bindings" {
  source                = "./modules/iam_bindings"
  project_id               = var.project_id
  service_account_email = module.service_account.service_account_email
  roles = [
    "roles/aiplatform.user",
    "roles/vision.user",
    "roles/texttospeech.user",
    "roles/storage.objectViewer",
    "roles/secretmanager.secretAccessor"
  ]
}
