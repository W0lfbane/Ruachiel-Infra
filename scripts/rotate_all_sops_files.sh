#!/usr/bin/env bash
set -euo pipefail

# Ensure the access token is set
export GOOGLE_OAUTH_ACCESS_TOKEN="$(gcloud auth print-access-token)"

# Find and re-encrypt all files containing ".sops" in their name
find . -type f -name "*.sops*" | while read -r file; do
    echo "Re-encrypting $file..."
    sops rotate -i "$file"
done

# Echo recommended commit message
echo
echo "Recommended git commit message:"
echo "Rotate SOPS secrets files [automated]"