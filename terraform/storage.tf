data "template_file" "config" {
  template = file("${path.module}/../files/config.yml")
  vars = {
    notif_template_url    = "gs://${google_storage_bucket.files.name}/${google_storage_bucket_object.template.name}"
    slack_app_webhook_url = google_secret_manager_secret_version.webhook_url_version.id
  }

  depends_on = [
    google_storage_bucket_object.template,
    google_secret_manager_secret_version.webhook_url_version
  ]
}

resource "google_storage_bucket" "files" {
  name                        = "${var.app_name}_files"
  location                    = "US"
  uniform_bucket_level_access = true
  public_access_prevention    = "enforced"

  depends_on = [time_sleep.wait_activate_apis]
}

resource "google_storage_bucket_object" "config" {
  name    = "config.yml"
  content = data.template_file.config.rendered
  bucket  = google_storage_bucket.files.name
}

resource "google_storage_bucket_object" "template" {
  name   = "template.json"
  source = "${path.module}/../files/template.json"
  bucket = google_storage_bucket.files.name
}
