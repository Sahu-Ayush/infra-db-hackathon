resource "google_artifact_registry_repository" "repo" {
  location      = var.region
  repository_id = "finai-mitra"
  format        = "DOCKER"
  description   = "Docker images for FinAI Mitra app"
}
