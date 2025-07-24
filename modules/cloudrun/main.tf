# 
resource "google_cloud_run_service" "finai" {
  name     = "finai-mitra"
  location = var.region

  template {
    spec {
      service_account_name = var.service_account_email
      containers {
        image = var.image
        ports {
          container_port = 8080
        }
        resources {
          limits = {
            memory = "512Mi"
            cpu    = "1000m"
          }
        }
        env {
          name = "PORT"
          value = "8080"
        }
        # env {
        #   name = "GEMINI_API_KEY"
        #   value_from {
        #     secret_key_ref {
        #       name = "gemini-api-key"
        #       key  = "latest"
        #     }
        #   }
        # }
      }
      timeout_seconds = 300  # <-- increase for streamlit cold start
    }
  }
  traffic {
    percent         = 100
    latest_revision = true
  }
}

resource "google_cloud_run_service_iam_member" "all_users" {
  service  = google_cloud_run_service.finai.name
  location = google_cloud_run_service.finai.location
  role     = "roles/run.invoker"
  member   = "allUsers"
}

