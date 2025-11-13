resource "google_project_service" "artifact_registry" {
  project            = var.project_id
  service            = "artifactregistry.googleapis.com"
  disable_on_destroy = false
}

resource "google_artifact_registry_repository" "docker_repo" {
  provider      = google
  project       = var.project_id
  location      = var.artifact_registry_location
  repository_id = "ruachiel-docker-repo"
  format        = "DOCKER"
  description   = "Docker images for Ruachiel services (core-api, discord-bot)"

  cleanup_policy_dry_run = false # Set to true to prevent deletion
  cleanup_policies {
    id     = "keep-5-recent-core-api"
    action = "KEEP"
    most_recent_versions {
      package_name_prefixes = ["core-api"]
      keep_count            = 5
    }
  }
  cleanup_policies {
    id     = "keep-5-recent-discord-bot"
    action = "KEEP"
    most_recent_versions {
      package_name_prefixes = ["discord-bot"]
      keep_count            = 5
    }
  }
  cleanup_policies {
    id     = "delete-old-core-api"
    action = "DELETE"
    condition {
      package_name_prefixes = ["core-api"]
      older_than            = "30d"
    }
  }
  cleanup_policies {
    id     = "delete-old-discord-bot"
    action = "DELETE"
    condition {
      package_name_prefixes = ["discord-bot"]
      older_than            = "30d"
    }
  }

  depends_on = [
    google_project_service.artifact_registry
  ]
}

resource "google_artifact_registry_repository" "python_repo" {
  provider      = google
  project       = var.project_id
  location      = var.artifact_registry_location
  repository_id = "ruachiel-python-repo"
  format        = "PYTHON"
  description   = "Python packages for Ruachiel common library"

  depends_on = [
    google_project_service.artifact_registry
  ]
}
