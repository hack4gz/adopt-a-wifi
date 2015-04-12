var express = require('express');
var Application = require('../models/application');
var app = express();

app.post('/', function(req, res) {
  Application.insertApplication(req.body, function(err, application) {
    if (err)  {
      res.status(500).json({message: err});
      return;
    }

    res.status(200);
  });
});

module.exports = app;
