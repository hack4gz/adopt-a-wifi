var pool = require('../pool');

exports.getAllWifis = function(cb) {
  var sql = "select * from wifis";
  pool.getConnection(function(err, connection) {
    if (err) { console.log(err); cb(err); return; }
    connection.query(sql, function(err, wifis) {
       connection.release();
       cb(err, wifis);
    });
  });
};

exports.insertWifi = function(post, cb) {
  if (!post.latitude || !post.longitude) {
    cb("latitude or longitude cannot be empty");
    return;
  }
  var sql = "insert into wifis set ?";
  pool.getConnection(function(err, connection) {
    if (err) { console.log(err); cb(err); return; }
    connection.query(sql, post, function(err, wifi) {
      connection.release();
      cb(err, wifi);
    });
  });
};
