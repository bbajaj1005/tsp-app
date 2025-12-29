# Architecture Documentation

## Overview
[Include architecture diagram]

## Components

### Frontend (Azure Web App)
- React single-page application
- Deployed on Linux App Service Plan (P1v2)
- VNet integrated for private backend access

### Backend (AKS)
- Node.js REST API
- Runs in private AKS cluster
- 2-10 replicas with horizontal autoscaling
- Internal load balancer

### Database (Azure SQL)
- SQL Database (S0 tier)
- Private endpoint only
- Automatic backup enabled

## Network Flow
1. User → Web App (HTTPS)
2. Web App → Backend API (Private VNet)
3. Backend API → SQL Database (Private Endpoint)

## Security
- All communication over private network
- No public database access
- Managed identities for authentication
- Network Security Groups