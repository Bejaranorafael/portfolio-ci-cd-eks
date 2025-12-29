const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send(' Esto es mi portfolio DevOps con CI/CD en EKS.');
});

app.listen(port, () => {
  console.log(`App corriendo en http://localhost:${port}`);
});
