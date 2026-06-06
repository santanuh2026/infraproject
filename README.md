# Terraform Azure CI/CD

This repository deploys Azure infrastructure with Terraform through a multi-environment GitHub Actions pipeline.

## Environments

Environment-specific values live in `env/*.tfvars`:

- `dev`
- `stage`
- `prod`

Each environment has a matching backend file at `backend/backend-<environment>.conf`. Update the `storage_account_name` placeholder before running CI/CD.

## Required GitHub Secrets

Create these repository or environment secrets in GitHub:

- `ARM_CLIENT_ID`
- `ARM_SUBSCRIPTION_ID`
- `ARM_TENANT_ID`

The workflows use GitHub OIDC (`ARM_USE_OIDC=true`) instead of storing a client secret. Configure a federated credential on the Azure application for your repository and target branch or environment.

For enterprise approvals, create GitHub Environments named `dev`, `stage`, and `prod`. Add required reviewers for `stage` and `prod` so applies are gated.

## Remote State

Create an Azure Storage Account and container for Terraform state, then update:

```hcl
resource_group_name  = "rg-tfstate"
storage_account_name = "REPLACE_WITH_TFSTATE_STORAGE_ACCOUNT"
container_name       = "tfstate"
```

## Pipeline Behavior

- `terraform-ci.yml` runs on pull requests and main branch changes.
- CI checks `terraform fmt`, `terraform init -backend=false`, `terraform validate`, TFLint, and Checkov.
- Pull requests also run real environment plans using Azure credentials and remote state.
- `terraform-cd.yml` deploys `dev` automatically only after `Terraform CI` completes successfully on `main`.
- Manual deployments can target `dev`, `stage`, or `prod` and can run either `apply` or `destroy`.

## Local Commands

```powershell
terraform fmt -recursive
terraform init -backend=false
terraform validate
terraform plan -refresh=false -lock=false -var-file="env/dev.tfvars"
```
