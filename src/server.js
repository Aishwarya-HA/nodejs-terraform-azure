
// server.js
const express = require('express');
const app = express();

// Azure App Service provides the port in process.env.PORT
const port = process.env.PORT || 8080;

// Simple health endpoint (useful for monitoring)
app.get('/healthz', (_req, res) => res.status(200).send('OK'));

// Root handler
app.get('/', (_req, res) => {
  res.send('Hello from Azure App Service without containers! 🚀');
});

app.listen(port, () => {
  console.log(`Server listening on port ${port}`);
});
``
