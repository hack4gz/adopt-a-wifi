var pool = require('../pool');
var emailReg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;

exports.insertApplication = function(post, cb) {
  if (!emailReg.test(post.email)) {
    return;
  }
  if (!post.adopter || !post.wifi || !post.location) {
    return;
  }
  var sql = "insert into applications set ?";
  pool.getConnection(function(err, connection) {
    if (err) { console.log(err); return; }
    connection.query(sql, post, function(err, application) {
      connection.release();
      cb(err, application);
    });
  });
};

exports.getAllApplications = function(cb) {
  var sql = "select * from applications";

  pool.getConnection(function(err, connection){
    if (err) { console.log(err); return; }
    connection.query(sql, function(err, applications) {
      connection.release();
      cb(err, applications);
    });
  });
};
