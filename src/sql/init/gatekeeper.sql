/*
	Data records for gatekeeper database
*/

DELETE FROM sites;

INSERT INTO sites 
(sitecode,vhost,dbhost,dbname,dbport,dbuser,dbpw,driver) 
VALUES 
('ds21',
 '127.0.0.1',
 'jdbc:postgresql://127.0.0.1:5432/cdb_ds21',
 'cdb_ds21',
 5432,
 'postgres','',
 'org.postgresql.Driver');

INSERT INTO sites 
(sitecode,vhost,dbhost,dbname,dbport,dbuser,dbpw,driver) 
VALUES 
('cfs2',
 '127.0.0.1',
 'jdbc:microsoft:sqlserver://127.0.0.1:1433;DatabaseName=cdb_cfs;SelectMethod=cursor',
 'cdb_cfs',
 1433,
 'postgres',
 'p0stgres',
 'com.microsoft.jdbc.sqlserver.SQLServerDriver');


