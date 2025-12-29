# Azure 3-Tier Application

Production-ready 3-tier application deployed on Azure with private endpoints.

## Quick Start
1. Deploy infrastructure: `cd terraform && terraform apply`
2. Build backend: `./scripts/build-and-push-backend.sh`
3. Deploy backend: `./scripts/deploy-backend.sh`
4. Deploy frontend: `./scripts/deploy-frontend.sh`

See [docs/DEPLOYMENT.md](docs/DEPLOYMENT.md) for detailed instructions.