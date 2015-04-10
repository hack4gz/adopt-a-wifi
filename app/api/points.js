var express = require('express');
var Point = require('../models/point');
var app = express();

app.get('/', function(req, res) {
  Point.getAllPoints(function(err, points) {
    if (err)  {
      res.status(500).json({message: err});
      return
    }

    res.status(200).json(points);
  });
});

module.exports = app;
