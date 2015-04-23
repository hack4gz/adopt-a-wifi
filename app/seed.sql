create database wifimap;
use wifimap;

create table wifis
(
  id int unsigned not null auto_increment,
  email varchar(255) not null,
  adopter varchar(255) not null,
  name varchar(255) not null,
  location varchar(255) not null,
  business varchar(255),
  passed_flag boolean not null default 0,
  latitude decimal(10, 7) not null default 0,
  longitude decimal(10, 7) not null default 0,

  primary key (id)
)
