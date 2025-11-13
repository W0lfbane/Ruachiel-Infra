# Ruachiel Infrastructure

This repository contains shared infrastructure resources for the Ruachiel project, managed via Terraform.

## Resources Managed

- **Artifact Registry**: Shared Docker repository (`ruachiel-repo`) with cleanup policies for:
  - `core-api` packages
  - `discord-bot` packages

## Usage

### Prerequisites

- Terraform >= 1.0
- Google Cloud credentials with appropriate permissions

### Deployment

```bash
cd terraform
terraform init
terraform plan
terraform apply
```

### Variables

| Variable | Description | Default |
|----------|-------------|---------|
| `project_id` | GCP project ID | - |
| `region` | GCP region | `us-west1` |
| `artifact_registry_location` | Artifact Registry location | `us-west1` |
| `google_credentials` | Service account JSON (sensitive) | - |

## Related Repositories

- [ruachiel-core-api](https://github.com/W0lfbane/ruachiel-core-api) - Core API service
- [ruachiel-discord-bot](https://github.com/W0lfbane/ruachiel-discord-bot) - Discord bot service
- [ruachiel-common](https://github.com/W0lfbane/ruachiel-common) - Shared Python packages

## Architecture

This repository manages shared infrastructure that multiple services depend on. Individual service repositories reference these resources via Terraform data sources rather than managing them directly.