var express = require('express');
var wifisHandler = require('./api/wifis');
var applicationsHandler = require('./api/applications');

var app = express();
app.use('/wifis', wifisHandler);
app.use('/applications', applicationsHandler);

module.exports = app;
