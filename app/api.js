var express = require('express');
var wifisHandler = require('./api/wifis');
var applyHandler = require('./api/apply');
var applicationsHandler = require('./api/applications');

var app = express();
app.use('/wifis', wifisHandler);
app.use('/apply', applyHandler);
app.use('/applications', applicationsHandler);

module.exports = app;
