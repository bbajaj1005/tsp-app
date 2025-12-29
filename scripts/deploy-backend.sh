#!/bin/bash
set -e

echo "🚢 Deploying backend to AKS..."

# Get values from Terraform output
RESOURCE_GROUP=$(cat outputs.json | jq -r '.resource_group_name.value')
AKS_NAME=$(cat outputs.json | jq -r '.aks_cluster_name.value')
SQL_IP=$(cat outputs.json | jq -r '.sql_private_endpoint_ip.value')

# Get AKS credentials
az aks get-credentials \
    --resource-group $RESOURCE_GROUP \
    --name $AKS_NAME \
    --overwrite-existing

# Update secret with SQL IP
kubectl create secret generic sql-secret \
    --from-literal=SQL_SERVER=$SQL_IP \
    --from-literal=SQL_USER=sqladmin \
    --from-literal=SQL_PASSWORD=$SQL_PASSWORD \
    --from-literal=SQL_DATABASE=sqldb-3tier \
    --namespace=three-tier-app \
    --dry-run=client -o yaml | kubectl apply -f -

# Deploy application
kubectl apply -f k8s/

# Wait for deployment
kubectl rollout status deployment/backend-api -n three-tier-app

echo "✅ Backend deployed successfully!"
kubectl get svc -n three-tier-app