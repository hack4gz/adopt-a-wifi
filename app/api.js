var express = require('express');
var pointsHandler = require('./api/points');

var app = express();
app.use('/points', pointsHandler);

module.exports = app;
