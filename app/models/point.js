var pool = require('../pool');

exports.getAllPoints = function(cb) {
  var sql = "select * from points";
  pool.getConnection(function(err, connection) {
    if (err) { console.log(err); return; }
    connection.query(sql, function(err, results) {
       connection.release();
       cb(err, results);
    });
  });
};

