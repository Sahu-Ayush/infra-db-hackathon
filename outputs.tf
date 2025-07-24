output "cloud_run_url" {
  value = module.cloudrun.url
}

output "artifact_registry_repo" {
  value = module.artifact_registry.repo_id
}

output "feedback_bucket" {
  value = module.storage.bucket_name
}

output "service_account_email" {
  description = "Email of the Cloud Run service account"
  value       = module.service_account.service_account_email
}