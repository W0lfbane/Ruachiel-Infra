# Service account for GitHub CI
resource "google_service_account" "github_ci" {
  account_id   = "ruachiel-infra-ci"
  display_name = "GitHub CI service account for Ruachiel Infra"
  project      = var.project_id
}

resource "google_service_account_key" "github_ci_key" {
  service_account_id = google_service_account.github_ci.name
  keepers = {
    project_id = var.project_id
    account_id = google_service_account.github_ci.account_id
  }
}

# KMS permissions for SOPS decryption
resource "google_kms_crypto_key_iam_member" "github_ci_kms_encrypter_decrypter" {
  crypto_key_id = google_kms_crypto_key.kms_key.id
  role          = "roles/cloudkms.cryptoKeyEncrypterDecrypter"
  member        = "serviceAccount:${google_service_account.github_ci.email}"
}

# Outputs
output "github_ci_service_account_email" {
  description = "Service account email to use in GitHub Actions"
  value       = google_service_account.github_ci.email
}

output "github_ci_service_account_key" {
  description = "Private key for the GitHub CI service account (sensitive). Save this JSON locally and add it to GitHub Secrets as GCP_SA_KEY"
  value       = google_service_account_key.github_ci_key.private_key
  sensitive   = true
}
