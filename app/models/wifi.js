var pool = require('../pool');

var Wifi = {
  getAllWifis: function(cb) {
    var sql = "select * from wifis";
    pool.getConnection(function(err, connection) {
      if (err) { console.log(err); cb(err); return; }
      connection.query(sql, function(err, wifis) {
        connection.release();
        cb(err, wifis);
      });
    });
  },

  insertWifi: function(post, cb) {
    var sql = "insert into wifis set ?";
    pool.getConnection(function(err, connection) {
      if (err) { console.log(err); cb(err); return; }
      connection.query(sql, post, function(err, wifi) {
        connection.release();
        cb(err, wifi);
      });
    });
  },

  updateWifi: function(wifi, cb) {
    var sql = "update wifis set ? where id = ?";
    pool.getConnection(function(err, connection) {
      if (err) { console.log(err); cb(err); return; }
      connection.query(sql, [wifi, wifi.id], function(err, wifi) {
        connection.release();
        cb(err, wifi);
      });
    });
  },

  deleteWifi: function(id, cb) {
    var sql = "delete from wifis where id = " + id;

    pool.getConnection(function(err, connection){
      if (err) { console.log(err); cb(err); return; }
      connection.query(sql, function(err, applications) {
        connection.release();
        cb(err, applications);
      });
    });
  }
};

module.exports = Wifi;
