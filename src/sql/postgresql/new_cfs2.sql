/**
 *  PostgreSQL Table Creation
 *
 *@author     cprice
 *@created    March 19, 2002
 *@version    $Id$
 */

CREATE TABLE lookup_industry (
  code SERIAL PRIMARY KEY,
  order_id INT,
  description VARCHAR(50) NOT NULL,
  default_item BOOLEAN DEFAULT false,
  level INTEGER DEFAULT 0,
  enabled BOOLEAN DEFAULT true
);

insert into lookup_industry (description) values ('Automotive');
insert into lookup_industry (description) values ('Biotechnology');
insert into lookup_industry (description) values ('Broadcasting and Cable');
insert into lookup_industry (description) values ('Computer');
insert into lookup_industry (description) values ('Consulting');
insert into lookup_industry (description) values ('Defense');
insert into lookup_industry (description) values ('Energy');
insert into lookup_industry (description) values ('Financial Services');
insert into lookup_industry (description) values ('Food');
insert into lookup_industry (description) values ('Healthcare');
insert into lookup_industry (description) values ('Hospitality');
insert into lookup_industry (description) values ('Insurance');
insert into lookup_industry (description) values ('Internet');
insert into lookup_industry (description) values ('Law Firms');
insert into lookup_industry (description) values ('Media');
insert into lookup_industry (description) values ('Pharmaceuticals');
insert into lookup_industry (description) values ('Real Estate');
insert into lookup_industry (description) values ('Retail');
insert into lookup_industry (description) values ('Telecommunications');
insert into lookup_industry (description) values ('Transportation');


create table industry_temp (
	ind_id SERIAL,
  name VARCHAR(80),
  code SMALLINT
);

insert into industry_temp (name,code) values ('Automotive',2);
insert into industry_temp (name,code) values ('Biotechnology',3);
insert into industry_temp (name,code) values ('Broadcasting and Cable',4);
insert into industry_temp (name,code) values ('Computer',5);
insert into industry_temp (name,code) values ('Consulting',6);
insert into industry_temp (name,code) values ('Defense',7);
insert into industry_temp (name,code) values ('Energy',8);
insert into industry_temp (name,code) values ('Financial Services',9);
insert into industry_temp (name,code) values ('Food',10);
insert into industry_temp (name,code) values ('Hospitality',11);
insert into industry_temp (name,code) values ('Insurance',12);
insert into industry_temp (name,code) values ('Internet',13);
insert into industry_temp (name,code) values ('Law Firms',14);
insert into industry_temp (name,code) values ('Media',15);
insert into industry_temp (name,code) values ('Pharmaceuticals',16);
insert into industry_temp (name,code) values ('Real Estate',17);
insert into industry_temp (name,code) values ('Retail',18);
insert into industry_temp (name,code) values ('Telecommunications',19);
insert into industry_temp (name,code) values ('Transportation',20);
insert into industry_temp (name,code) values ('Healthcare',21);

