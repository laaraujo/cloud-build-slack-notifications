resource "google_secret_manager_secret" "webook_url" {
  secret_id = "${var.app_name}_webhook_url"

  replication {
    auto {}
  }

  depends_on = [time_sleep.wait_activate_apis]
}

resource "google_secret_manager_secret_version" "webhook_url_version" {
  secret      = google_secret_manager_secret.webook_url.id
  secret_data = var.slack_app_webhook_url
}
