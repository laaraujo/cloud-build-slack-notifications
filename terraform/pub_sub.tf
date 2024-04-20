resource "google_pubsub_topic" "topic" {
  # "cloud-builds" isthe topic where all Cloud Build update messages are published to
  # https://cloud.google.com/build/docs/subscribe-build-notifications 
  name                       = "cloud-builds"
  message_retention_duration = "86400s" # 1 day
}

resource "google_pubsub_subscription" "subscription" {
  name  = "${var.app_name}_subscription"
  topic = google_pubsub_topic.topic.id

  push_config {
    push_endpoint = data.google_cloud_run_v2_service.instance.uri
    oidc_token {
      service_account_email = module.cloud_build_slack_notifications_service_account.email
    }
  }

  depends_on = [google_pubsub_topic.topic]
}



# gcloud pubsub subscriptions create {SUBSCRIPTION_NAME} \
#    --topic=cloud-builds \
#    --push-endpoint={CLOUD_BUILD_SERVICE_URL} \
#    --push-auth-service-account={INVOKER_SERVICE_ACCOUNT}@{PROJECT_ID}.iam.gserviceaccount.com
