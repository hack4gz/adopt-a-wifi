var index = require('./routes/index');
var application = require('./routes/applications');
var apiServer = require('./api');
var basicAuth = require('basic-auth');

module.exports = function(app) {
  var auth = function (req, res, next) {
    function unauthorized(res) {
      res.set('WWW-Authenticate', 'Basic realm=Authorization Required');
      return res.send(401);
    }
    var user = basicAuth(req);

    if (!user || !user.name || !user.pass) {
      return unauthorized(res);
    }

    if (user.name === 'wifimap' && user.pass === '1234567') {
      return next();
    } else {
      return unauthorized(res);
    }
  };
  app.use('/', index);
  app.use('/applications', auth, application);
  app.use('/api', apiServer);
};
