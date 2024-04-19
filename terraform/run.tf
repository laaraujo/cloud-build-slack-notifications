resource "google_cloud_run_v2_service" "instance" {
  name     = local.cloud_run_service_name
  location = var.region
  ingress = "INGRESS_TRAFFIC_INTERNAL_ONLY"

  template {
    service_account = module.cloud_build_slack_notifications_service_account.email
    containers {
      image = var.slack_notifier_img
      env {
        name = "CONFIG_PATH"
        value = "gs://${google_storage_bucket.files.name}/${google_storage_bucket_object.config.name}"
      }
      env {
        name = "PROJECT_ID"
        value = var.project_id
      }
    }
  }

  depends_on = [
    time_sleep.wait_activate_apis,
    google_storage_bucket_object.template,
    module.cloud_build_slack_notifications_service_account
  ]
}

data "google_cloud_run_v2_service" "instance" {
  name     = google_cloud_run_v2_service.instance.name
  location = var.region
}
