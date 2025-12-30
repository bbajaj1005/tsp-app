const express = require('express');
const path = require('path');
const fs = require('fs');
const http = require('http');
const app = express();

// Backend API URL - can be set via environment variable
const BACKEND_API_URL = process.env.BACKEND_API_URL || 'http://52.160.32.57:80';

// Log startup information
console.log('Starting Express server...');
console.log(`Current directory: ${__dirname}`);
console.log(`Port: ${process.env.PORT || 8080}`);
console.log(`Backend API URL: ${BACKEND_API_URL}`);

// Parse JSON bodies (needs to be before routes)
app.use(express.json());

// Check if index.html exists
const indexPath = path.join(__dirname, 'index.html');
if (!fs.existsSync(indexPath)) {
  console.error(`ERROR: index.html not found at ${indexPath}`);
  console.log('Files in directory:', fs.readdirSync(__dirname));
}

// Proxy API requests to backend (avoids CORS and mixed content issues)
app.use('/api', (req, res) => {
  const backendUrl = new URL(BACKEND_API_URL);
  const queryString = Object.keys(req.query).length > 0 ? '?' + new URLSearchParams(req.query).toString() : '';
  const targetPath = req.path + queryString;
  
  console.log(`Proxying ${req.method} ${req.path} to ${BACKEND_API_URL}${targetPath}`);
  
  const options = {
    hostname: backendUrl.hostname,
    port: backendUrl.port || 80,
    path: targetPath,
    method: req.method,
    headers: {
      'Content-Type': 'application/json',
      'Accept': 'application/json'
    }
  };
  
  // Remove host header to avoid issues
  delete options.headers.host;
  
  const proxyReq = http.request(options, (proxyRes) => {
    // Set CORS headers
    res.setHeader('Access-Control-Allow-Origin', '*');
    res.setHeader('Access-Control-Allow-Methods', 'GET, POST, PUT, DELETE, OPTIONS');
    res.writeHead(proxyRes.statusCode, proxyRes.headers);
    proxyRes.pipe(res);
  });
  
  proxyReq.on('error', (err) => {
    console.error('Proxy error:', err);
    res.status(502).json({ error: 'Backend service unavailable', message: err.message, backendUrl: BACKEND_API_URL });
  });
  
  // Handle request body
  if (req.body && Object.keys(req.body).length > 0) {
    const bodyData = JSON.stringify(req.body);
    proxyReq.setHeader('Content-Length', Buffer.byteLength(bodyData));
    proxyReq.write(bodyData);
  }
  
  proxyReq.end();
});

// Health check endpoint that also checks backend
app.get('/health', async (req, res) => {
  try {
    const http = require('http');
    const backendUrl = new URL(`${BACKEND_API_URL}/health`);
    const options = {
      hostname: backendUrl.hostname,
      port: backendUrl.port || 80,
      path: backendUrl.pathname,
      method: 'GET',
      timeout: 5000
    };
    
    const backendReq = http.request(options, (backendRes) => {
      let data = '';
      backendRes.on('data', (chunk) => { data += chunk; });
      backendRes.on('end', () => {
        res.json({
          status: 'healthy',
          frontend: 'ok',
          backend: JSON.parse(data),
          backendUrl: BACKEND_API_URL
        });
      });
    });
    
    backendReq.on('error', (err) => {
      res.status(503).json({
        status: 'degraded',
        frontend: 'ok',
        backend: 'unreachable',
        error: err.message,
        backendUrl: BACKEND_API_URL
      });
    });
    
    backendReq.on('timeout', () => {
      backendReq.destroy();
      res.status(504).json({
        status: 'timeout',
        frontend: 'ok',
        backend: 'timeout',
        backendUrl: BACKEND_API_URL
      });
    });
    
    backendReq.setTimeout(5000);
    backendReq.end();
  } catch (err) {
    res.status(500).json({ error: err.message });
  }
});

// Serve static files from the current directory (server.js is in the build directory)
app.use(express.static(__dirname));

// Handle React routing, return all requests to React app
app.get('*', (req, res) => {
  const filePath = path.join(__dirname, 'index.html');
  if (fs.existsSync(filePath)) {
    res.sendFile(filePath);
  } else {
    res.status(404).send('index.html not found');
  }
});

// Error handling
app.use((err, req, res, next) => {
  console.error('Error:', err);
  res.status(500).send('Internal Server Error');
});

const port = process.env.PORT || 8080;
app.listen(port, '0.0.0.0', () => {
  console.log(`✅ Server is running on port ${port}`);
  console.log(`📁 Serving files from: ${__dirname}`);
  console.log(`🌐 Application is ready!`);
});

