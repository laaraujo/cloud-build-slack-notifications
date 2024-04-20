provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

locals {
  apis_to_enable = [
    "run.googleapis.com",
    "storage.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudbuild.googleapis.com",
    "pubsub.googleapis.com",
  ]
  cloud_run_service_name = replace(var.app_name, "_", "-")             # Cloud Run does not allow service names with underscores
  service_account_name   = substr(local.cloud_run_service_name, 0, 28) # SA name limit of 28 chars
}

resource "google_project_service" "activate_apis" {
  for_each = toset(local.apis_to_enable)

  service            = each.value
  disable_on_destroy = false
}

resource "time_sleep" "wait_activate_apis" {
  create_duration = "120s"
  depends_on      = [google_project_service.activate_apis]
}
