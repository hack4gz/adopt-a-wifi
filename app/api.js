var express = require('express');
var wifisHandler = require('./api/wifis');
var auth = require('./auth');

var app = express();
app.use('/wifis', wifisHandler);

module.exports = app;
