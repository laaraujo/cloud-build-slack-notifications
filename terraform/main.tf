provider "google" {
  project = var.project_id
  region  = var.region
  zone    = var.zone
}

resource "google_project_service" "activate_apis" {
  for_each = toset(var.activate_apis)

  service = each.value
  disable_on_destroy = false
}

resource "time_sleep" "wait_activate_apis" {
  create_duration = "120s"
  depends_on = [google_project_service.activate_apis]
}

locals {
    cloud_run_service_name = replace(var.app_name, "_", "-") # Cloud Run does not allow service names with underscores
    service_account_name = substr(local.cloud_run_service_name, 0, 28) # SA name limit of 28 chars
}
