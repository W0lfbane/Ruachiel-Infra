resource "google_kms_key_ring" "kms_keyring" {
  name     = var.key_ring_name
  project  = var.project_id
  location = var.region
}

resource "google_kms_crypto_key" "kms_key" {
  name            = var.crypto_key_name
  key_ring        = google_kms_key_ring.kms_keyring.id
  purpose         = "ENCRYPT_DECRYPT"
  rotation_period = "2592000s" // 30 days in seconds
}
