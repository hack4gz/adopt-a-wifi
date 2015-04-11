create database wifimap;
use wifimap;

create table wifis
(
  id int unsigned NOT NULL auto_increment,
  name varchar(255) NOT NULL,
  owner varchar(255) NOT NULL,
  latitude decimal(10, 7) NOT NULL,
  longitude decimal(10, 7) NOT NULL,

  primary key (id)
)
