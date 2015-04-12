var index = require('./routes/index');
var application = require('./routes/applications');
var apiServer = require('./api');

module.exports = function(app) {
  app.use('/', index);
  app.use('/applications', application);
  app.use('/api', apiServer);
};
