module "cloud_build_slack_notifications_service_account" {
  source  = "terraform-google-modules/service-accounts/google"
  version = "4.2.3"

  project_id = var.project_id
  names      = [local.service_account_name]
  project_roles = [
    "${var.project_id}=>roles/storage.admin",
    "${var.project_id}=>roles/run.invoker",
    "${var.project_id}=>roles/secretmanager.secretAccessor",
  ]
}
