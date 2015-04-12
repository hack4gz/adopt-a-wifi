var express = require('express');
var Application = require('../models/application');
var app = express();

app.get('/', function(req, res) {
  Application.getAllApplications(function(err, applications) {
    if (err)  {
      res.status(500).json({message: err});
      return;
    }

    res.status(200).json(applications);
  });
});

module.exports = app;
