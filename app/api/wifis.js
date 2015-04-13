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

app.post('/', function(req, res) {
  Wifi.insertWifi(req.body, function(err, wifi) {
    if (err)  {
      res.status(500).json({message: err});
      return;
    }

    res.status(200).json(wifi);
  });
});

module.exports = app;
