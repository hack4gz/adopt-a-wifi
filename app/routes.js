var index = require('./routes/index');
var application = require('./routes/applications');
var apiServer = require('./api');
var auth = require('./auth');

module.exports = function(app) {
  app.use('/', index);
  app.use('/applications', auth, application);
  app.use('/api', apiServer);
};
