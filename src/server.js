const express = require('express');
const app = express();

app.get('/', (req, res) => {
  res.status(200).json({ msg: 'Hello World' });
});

app.listen(4549, () => {
  console.log('Server listening on port 4549');
});
