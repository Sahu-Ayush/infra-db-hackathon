output "url" {
  value = google_cloud_run_service.finai.status[0].url
}
