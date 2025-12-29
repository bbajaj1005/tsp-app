#!/bin/bash
set -e

echo "🎨 Deploying frontend to Azure Web App..."

# Get values from Terraform output
RESOURCE_GROUP=$(cat outputs.json | jq -r '.resource_group_name.value')
WEBAPP_NAME=$(cat outputs.json | jq -r '.webapp_name.value')

# Get backend IP
BACKEND_IP=$(kubectl get svc backend-api-service -n three-tier-app \
    -o jsonpath='{.status.loadBalancer.ingress[0].ip}')

# Build frontend
cd frontend
export REACT_APP_API_URL="http://${BACKEND_IP}"
npm install
npm run build

# Deploy to Web App
cd build
zip -r ../frontend.zip .
cd ..

az webapp deployment source config-zip \
    --resource-group $RESOURCE_GROUP \
    --name $WEBAPP_NAME \
    --src frontend.zip

echo "✅ Frontend deployed successfully!"
echo "🌐 URL: https://${WEBAPP_NAME}.azurewebsites.net"