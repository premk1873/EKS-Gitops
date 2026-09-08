# CloudNotes — EKS Deployment with Terraform & ArgoCD

A cloud infrastructure project where I provisioned an AWS EKS cluster and set up a full GitOps deployment pipeline for a containerized Node.js app.

## Tools & Technologies

- **Terraform** — infrastructure as code, using community modules, with remote state stored in S3 and locked via DynamoDB
- **AWS** — EKS, VPC, EBS, Elastic Load Balancing
- **Kubernetes** — Deployments, Services, ConfigMaps, Secrets, PersistentVolumeClaims, StorageClasses, Horizontal Pod Autoscaling
- **ArgoCD** — GitOps-based continuous deployment, with automated sync and self-healing
- **Docker** — containerizing the application
- **GitHub Actions** — CI pipeline for building and publishing the app image

## What I Built

- Provisioned an EKS cluster and its networking (VPC across multiple availability zones) using Terraform
- Deployed the app and a MySQL database inside the cluster, with the database's storage automatically provisioned via a StorageClass
- Set up ArgoCD to watch a Git repository and automatically keep the cluster's state in sync with it
- Configured autoscaling so the app scales up or down based on CPU usage
- Built a CI pipeline that builds a new Docker image on every push, tags it with the Git commit hash, and updates the deployment
- Set up Terraform's state to be stored remotely (S3) with locking (DynamoDB), instead of keeping it only on a local machine

## Project Structure

```
terraform/        # EKS cluster, VPC, ArgoCD install
tf-state-lock/     # Remote state backend (S3 + DynamoDB)
k8s/               # Application Kubernetes manifests
argocd/            # ArgoCD Application definition
.github/workflows/ # CI pipeline
```