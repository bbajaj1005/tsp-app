# Frontend Application

React-based frontend for the task management application.

## Local Development

1. Install dependencies: `npm install`
2. Copy `.env.example` to `.env` and configure API URL
3. Run: `npm start`
4. Open http://localhost:3000

## Build for Production

```bash
npm run build
```

## Deploy to Azure Web App

```bash
npm run build
cd build
zip -r ../frontend.zip .
az webapp deployment source config-zip \
  --resource-group <resource-group> \
  --name <webapp-name> \
  --src frontend.zip
```
