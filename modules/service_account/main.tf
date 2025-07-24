resource "google_service_account" "this" {
  account_id   = var.account_id
  display_name = var.display_name
}

resource "google_project_iam_binding" "secret_accessor" {
  project = var.project
  role    = "roles/secretmanager.secretAccessor"
  members = [
    "serviceAccount:${google_service_account.this.email}"
  ]
}


