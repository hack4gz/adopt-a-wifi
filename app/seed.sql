create database wifimap;
use wifimap;

create table wifis
(
  id int unsigned NOT NULL auto_increment,
  adopter varchar(255) NOT NULL,
  name varchar(255) NOT NULL,
  latitude decimal(10, 7) NOT NULL,
  longitude decimal(10, 7) NOT NULL,
  business varchar(255), 

  primary key (id)
)

create table applications
(
  id int unsigned NOT NULL auto_increment,
  email varchar(255) NOT NULL,
  adopter varchar(255) NOT NULL,
  wifi varchar(255) NOT NULL,
  location varchar(255) NOT NULL,
  business varchar(255),

  primary key (id)
)
