var express = require('express');
var Wifi = require('../models/wifi');
var app = express();

app.get('/', function(req, res) {
  Wifi.getAllWifis(function(err, wifis) {
    if (err)  {
      res.status(500).json({message: err});
      return;
    }

    res.status(200).json(wifis);
  });
});

module.exports = app;
