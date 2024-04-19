variable "app_name" {
    type = string
    description = "App name and prefix for all resource names"
    default = "cloud_build_slack_notifications"
}

variable "sa_name" {
    type = string
    description = "Service Account name (for the service account 28 char limit and regex)"
    default = "cloud-build-slack-notif"
}

variable "project_id" {
    type = string
    description = "GCP Project ID"
}
variable "region" {
    type = string
    description = "GCP Region"
}
variable "zone" {
    type = string
    description = "GCP Zone"
}

variable "slack_app_webhook_url" {
    type = string
    description = "Slack App's secret webhook URL"
}

variable "activate_apis" {
  type        = list(string)
  description = "The list of APIs & services to activate within the project."
  default = [
    "run.googleapis.com",
    "storage.googleapis.com",
    "secretmanager.googleapis.com",
    "cloudbuild.googleapis.com",
  ]
}

variable "slack_notifier_img" {
    type = string
    description = "Image URL of GCP's Cloud Build Notifier (SLACK)"
    default = "us-east1-docker.pkg.dev/gcb-release/cloud-build-notifiers/slack:latest"
}
