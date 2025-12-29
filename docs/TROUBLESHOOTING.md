# Troubleshooting Guide

## Common Issues

### Backend pods not starting
```bash
kubectl describe pod <pod-name> -n three-tier-app
kubectl logs <pod-name> -n three-tier-app
```

### Cannot connect to database
- Verify SQL private endpoint IP
- Check network connectivity
- Verify credentials in secret

### Frontend cannot reach backend
- Check backend service IP
- Verify VNet integration
- Check CORS settings

## Debug Commands
[Include useful debug commands]