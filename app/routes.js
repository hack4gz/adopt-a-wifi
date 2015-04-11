var index = require('./routes/index');
var apiServer = require('./api');

module.exports = function(app) {
  app.get('/', index);

  app.use('/api', apiServer);
};
