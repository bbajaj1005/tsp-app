#!/bin/bash
set -e

echo "🔨 Building and pushing backend Docker image..."

# Get ACR name from Terraform output
ACR_NAME=$(cat outputs.json | jq -r '.acr_name.value')

if [ -z "$ACR_NAME" ]; then
    echo "❌ ACR name not found. Deploy infrastructure first."
    exit 1
fi

# Login to ACR
az acr login --name $ACR_NAME

# Build and push
cd backend
az acr build \
    --registry $ACR_NAME \
    --image backend-api:latest \
    --image backend-api:$(git rev-parse --short HEAD) \
    --file Dockerfile \
    .

echo "✅ Backend image built and pushed successfully!"