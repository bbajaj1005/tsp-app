#!/bin/bash
set -e

echo "🧹 Cleaning up Azure resources..."

read -p "Are you sure you want to destroy all resources? (yes/no): " confirm

if [ "$confirm" != "yes" ]; then
    echo "Cleanup cancelled."
    exit 0
fi

cd terraform
terraform destroy -auto-approve

echo "✅ All resources cleaned up!"