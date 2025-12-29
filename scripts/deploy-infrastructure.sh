#!/bin/bash
set -e

echo "🚀 Deploying Azure Infrastructure..."

cd terraform

# Initialize Terraform
terraform init

# Validate configuration
terraform validate

# Plan deployment
terraform plan -out=tfplan

# Apply configuration
terraform apply tfplan

# Save outputs
terraform output -json > ../outputs.json

echo "✅ Infrastructure deployed successfully!"
echo "📋 Outputs saved to outputs.json"