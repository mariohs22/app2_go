terraform {
  required_version = ">= 1.0"

  required_providers {
    google = ">= 3.77"
  }
}

provider "google" {
  project = var.project
  region  = var.gcr_region
  zone    = var.location
}

resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.location

  autogenerate_revision_name = "true"

  template {
    spec {
      containers {
        image = local.image_name
      }
    }
  }

  traffic {
    percent         = 100
    latest_revision = true
  }
}

# resource "google_cloud_run_service_iam_member" "allUsers" {
#   service  = google_cloud_run_service.service.name
#   location = google_cloud_run_service.service.location
#   role     = "roles/run.invoker"
#   member   = "allUsers"
# }

# data "google_iam_policy" "noauth" {
#   binding {
#     role = "roles/run.invoker"
#     members = [
#       "allUsers",
#     ]
#   }
# }

# resource "google_cloud_run_service_iam_policy" "noauth" {
#   location = google_cloud_run_service.service.location
#   project  = google_cloud_run_service.service.project
#   service  = google_cloud_run_service.service.name

#   policy_data = data.google_iam_policy.noauth.policy_data
# }

locals {
  image_name = var.image_name == "" ? "${var.gcr_region}.gcr.io/${var.project}/${var.service_name}" : var.image_name
}
