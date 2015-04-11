var mysql = require('mysql');
var pool = mysql.createPool({
  database: 'wifimap',
  host: 'localhost',
  user: 'root'
});

module.exports = pool;

