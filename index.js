const express = require('express');
const app = express();
const port = 3000;

app.get('/', (req, res) => {
  res.send('NodeJS is running, infrastructure was built by Terraform. I am good...');
});

app.listen(port, () => {
  console.log(`App listening at http://localhost:${port}`);
});
