# Event-Driven Auto-Scaler

A cloud-agnostic autoscaling platform using KEDA that reacts to business-level events (e.g., queue depth, order rate) instead of infrastructure metrics like CPU.

## Architecture Highlights

- Azure Event Grid → Azure Function (custom metric publisher)
- Azure Queue → KEDA → AKS Horizontal Scaling
- GitOps-managed scaling definitions with ArgoCD
- CI/CD validation using GitHub Actions
- Terraform infrastructure provisioning
- Grafana dashboarding for observability
