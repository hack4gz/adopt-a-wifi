var pool = require('../pool');
var emailReg = /^([\w-]+(?:\.[\w-]+)*)@((?:[\w-]+\.)*\w[\w-]{0,66})\.([a-z]{2,6}(?:\.[a-z]{2})?)$/i;

exports.insertApplication = function(post, cb) {
  if (!emailReg.test(post.email)) {
    cb('email is invalid');
    return;
  }
  if (!post.adopter || !post.wifi || !post.location) {
    cb('adopter or wifi or location cannot be empty');
    return;
  }
  var sql = "insert into applications set ?";
  pool.getConnection(function(err, connection) {
    if (err) { console.log(err); cb(err); return; }
    connection.query(sql, post, function(err, application) {
      connection.release();
      cb(err, application);
    });
  });
};

exports.getAllApplications = function(cb) {
  var sql = "select * from applications order by id desc";

  pool.getConnection(function(err, connection){
    if (err) { console.log(err); cb(err); return; }
    connection.query(sql, function(err, applications) {
      connection.release();
      cb(err, applications);
    });
  });
};

exports.deleteApplication = function(id, cb) {
  var sql = "delete from applications where id = " + id;

  pool.getConnection(function(err, connection){
    if (err) { console.log(err); cb(err); return; }
    connection.query(sql, function(err, applications) {
      connection.release();
      cb(err, applications);
    });
  });
};
