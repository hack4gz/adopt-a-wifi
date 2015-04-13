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

app.post('/', function(req, res) {
  Application.insertApplication(req.body, function(err, application) {
    if (err)  {
      res.status(500).json({message: err});
      return;
    }

    res.status(200).json(application);
  });
});

app.delete('/', function(req, res) {
  Application.deleteApplication(req.body.id, function(err, application) {
    if (err) {
      res.status(500).json({message: err});
      return;
    }

    res.status(200).json(application);
  });
});

module.exports = app;
