var home = require('./routes/home');
var wifis = require('./routes/wifis');
var apiServer = require('./api');
var auth = require('./auth');

module.exports = function(app) {
  app.use('/', home);
  app.use('/wifis', auth, wifis);
  app.use('/api', apiServer);
};
