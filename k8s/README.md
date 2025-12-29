# Kubernetes Manifests

Deploy backend API to AKS.

## Quick Deploy
```bash
kubectl apply -f namespace.yaml
kubectl apply -f secret.yaml
kubectl apply -f configmap.yaml
kubectl apply -f deployment.yaml
kubectl apply -f service.yaml
kubectl apply -f hpa.yaml
```

## Verify Deployment
```bash
kubectl get all -n three-tier-app
kubectl logs -n three-tier-app -l app=backend-api
```