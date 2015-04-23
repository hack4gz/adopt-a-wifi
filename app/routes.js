var index = require('./routes/index');
var wifis = require('./routes/wifis');
var apiServer = require('./api');
var auth = require('./auth');

module.exports = function(app) {
  app.use('/', index);
  app.use('/wifis', auth, wifis);
  app.use('/api', apiServer);
};
