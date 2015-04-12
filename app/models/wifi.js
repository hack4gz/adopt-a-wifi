var pool = require('../pool');

exports.getAllWifis = function(cb) {
  var sql = "select * from wifis";
  pool.getConnection(function(err, connection) {
    if (err) { console.log(err); return; }
    connection.query(sql, function(err, wifis) {
       connection.release();
       cb(err, wifis);
    });
  });
};

