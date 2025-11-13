# Non-Sensitive variables for Terraform deployment
variable "project_id" {
  description = "GCP project id"
  type        = string
}

variable "region" {
  description = "GCP region (e.g. us-west1)"
  type        = string
  default     = "us-west1"
}

variable "artifact_registry_location" {
  description = "Artifact Registry location (region)"
  type        = string
  default     = "us-west1"
}

# Sensitive variables for Terraform deployment
variable "google_credentials" {
  type        = string
  description = "Contents of the service account JSON file"
  sensitive   = true
}

variable "key_ring_name" {
  description = "Name of the KMS key ring"
  type        = string
  default     = "ruachiel-infra-keyring"
}

variable "crypto_key_name" {
  description = "Name of the KMS crypto key"
  type        = string
  default     = "ruachiel-infra-key"
}
