resource "google_secret_manager_secret" "secret" {
  secret_id  = "gemini-api-key"
  replication {
    automatic = true
  }
}

resource "google_secret_manager_secret_version" "secret_version" {
  secret      = google_secret_manager_secret.secret.id
  secret_data = "YOUR-SECRET-VALUE"
}

# Vertex AI IAM Role
resource "google_project_iam_binding" "vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  members = ["serviceAccount:${var.service_account_email}"]
}

# Vision API IAM Role
resource "google_project_iam_binding" "vision_user" {
  project = var.project_id
  role    = "roles/visionai.user"
  members = ["serviceAccount:${var.service_account_email}"]
}

# Text-to-Speech IAM Role
resource "google_project_iam_binding" "tts_user" {
  project = var.project_id
  role    = "roles/texttospeech.user"
  members = ["serviceAccount:${var.service_account_email}"]
}

# Cloud Storage Object Viewer
resource "google_project_iam_binding" "storage_object_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  members = ["serviceAccount:${var.service_account_email}"]
}
