var mysql = require('mysql');
var pool = mysql.createPool(
  process.env.DATABASE_URL ||
  {
    database: 'wifimap',
    host: 'localhost',
    user: 'root'
  });

module.exports = pool;

