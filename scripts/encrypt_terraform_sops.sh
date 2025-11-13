#!/usr/bin/env bash
set -euo pipefail

# Directory containing this script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Terraform directory
TF_DIR="$SCRIPT_DIR/../terraform"

# Ensure token is set
export GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud auth print-access-token)"

# Files to encrypt (add both HCL and JSON variants)
files=("terraform.tfvars" "terraform.tfstate")

for file in "${files[@]}"; do
  src="$TF_DIR/$file"
  dest="$TF_DIR/$file.sops"

  if [[ -f "$src" ]]; then
    echo "Encrypting $src → $dest"
    sops -e \
      --gcp-kms "projects/striped-fulcrum-472606-p9/locations/us-west1/keyRings/ruachiel-infra-keyring/cryptoKeys/ruachiel-infra-key" \
      "$src" > "$dest"
  else
    echo "WARNING: $src does not exist, skipping"
  fi
done

# Echo recommended commit message
echo
echo "Recommended git commit message:"
echo "Encrypt latest terraform files [automated]"
