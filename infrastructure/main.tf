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

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A GOOGLE CLOUD SOURCE REPOSITORY
# ---------------------------------------------------------------------------------------------------------------------

# resource "google_sourcerepo_repository" "repo" {
#   name = var.repository_name
# }

# ---------------------------------------------------------------------------------------------------------------------
# DEPLOY A CLOUD RUN SERVICE
# ---------------------------------------------------------------------------------------------------------------------

resource "google_cloud_run_service" "service" {
  name     = var.service_name
  location = var.location

  template {
    metadata {
      annotations = {
        "client.knative.dev/user-image" = local.image_name
      }
    }

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

# ---------------------------------------------------------------------------------------------------------------------
# EXPOSE THE SERVICE PUBLICALLY
# We give all users the ability to invoke the service.
# ---------------------------------------------------------------------------------------------------------------------

# resource "google_cloud_run_service_iam_member" "allUsers" {
#   service  = google_cloud_run_service.service.name
#   location = google_cloud_run_service.service.location
#   role     = "roles/run.invoker"
#   member   = "allUsers"
# }

data "google_iam_policy" "noauth" {
  binding {
    role = "roles/run.invoker"
    members = [
      "allUsers",
    ]
  }
}

resource "google_cloud_run_service_iam_policy" "noauth" {
  location = google_cloud_run_service.service.location
  project  = google_cloud_run_service.service.project
  service  = google_cloud_run_service.service.name

  policy_data = data.google_iam_policy.noauth.policy_data
}

# ---------------------------------------------------------------------------------------------------------------------
# PREPARE LOCALS
# ---------------------------------------------------------------------------------------------------------------------

locals {
  image_name = var.image_name == "" ? "${var.gcr_region}.gcr.io/${var.project}/${var.service_name}" : var.image_name
}
