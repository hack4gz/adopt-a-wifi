var mysql = require('mysql');
var pool = mysql.createPool({
  database: 'wlan',
  host: 'localhost',
  user: 'root'
});

module.exports = pool;

