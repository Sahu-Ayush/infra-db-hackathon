resource "google_secret_manager_secret" "secret" {
  project   = var.project_id
  secret_id = var.secret_name

  replication {
    auto {}
    # user_managed {}
  }
}

# Optional secret version (if secret_value provided)
resource "google_secret_manager_secret_version" "version" {
  count       = var.secret_value != "" ? 1 : 0
  secret      = google_secret_manager_secret.secret.id
  secret_data = var.secret_value
}

# Grant Secret Accessor to Cloud Run SA
resource "google_secret_manager_secret_iam_binding" "accessor" {
  secret_id = google_secret_manager_secret.secret.id
  role      = "roles/secretmanager.secretAccessor"
  members   = ["serviceAccount:${var.service_account_email}"]
}

# Additional roles
resource "google_project_iam_binding" "vertex_ai_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  members = ["serviceAccount:${var.service_account_email}"]
}

resource "google_project_iam_binding" "vision_user" {
  project = var.project_id
  role    = "roles/aiplatform.user"
  members = ["serviceAccount:${var.service_account_email}"]
}

resource "google_project_iam_binding" "tts_user" {
  project = var.project_id
  role    = "roles/cloudtranslate.user"
  members = ["serviceAccount:${var.service_account_email}"]
}

resource "google_project_iam_binding" "storage_object_viewer" {
  project = var.project_id
  role    = "roles/storage.objectViewer"
  members = ["serviceAccount:${var.service_account_email}"]
}
