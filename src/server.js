
const express = require('express');
const app = express();

// App Service provides the listening port via process.env.PORT
const port = process.env.PORT || 8080;

app.get('/healthz', (_req, res) => res.status(200).send('OK'));
app.get('/', (_req, res) => res.send('Hello from Azure App Service! 🚀'));

app.listen(port, () => console.log(`Listening on ${port} ...`));
