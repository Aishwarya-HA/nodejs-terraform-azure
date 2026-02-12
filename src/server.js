const express = require('express');
const app = express();

const port = process.env.PORT || 8080;

// Simple health check
app.get('/healthz', (_req, res) => res.status(200).send('OK'));

// Home page
app.get('/', (_req, res) => res.send('Hello from Azure App Service! 🚀'));

// IMPORTANT: bind to 0.0.0.0 so Azure’s front end can reach the app
app.listen(port, '0.0.0.0', () => console.log(`Listening on ${port} ...`));
