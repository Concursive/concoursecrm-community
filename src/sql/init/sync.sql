/*	
  sync init
	
  The synchronization process requires that the system be registered so that
  objects can be mapped to requests.
*/

INSERT INTO sync_system (application_name) VALUES ('Vport Telemarketing');
INSERT INTO sync_system (application_name) VALUES ('Land Mark: Auto Guide PocketPC');
INSERT INTO sync_system (application_name) VALUES ('Street Smart Speakers: Web Portal');

/* VPORT */

INSERT INTO sync_table (system_id, element_name, mapped_class_name)
 VALUES (1, 'ticket', 'com.darkhorseventures.cfsbase.Ticket');

/* AUTO GUIDE */

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id)
 VALUES (2, 'syncClient', 'com.darkhorseventures.cfsbase.SyncClient', 10);
 
INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id)
 VALUES (2, 'user', 'com.darkhorseventures.cfsbase.User', 20);

 
INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'tableList', 'com.darkhorseventures.cfsbase.SyncTableList', 30,
'CREATE TABLE sync_table (
       table_id             int NOT NULL,
       table_name           nvarchar(20) NULL,
       order_id             int NULL,
       create_statement     nvarchar(255) NULL,
       sync_item            int NULL,
       PRIMARY KEY (table_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'status_master', null, 40,
'CREATE TABLE status_master (
       record_status_id     int NOT NULL,
       record_status_name   nchar varying(20) NULL,
       PRIMARY KEY (record_status_id)
)'
);
 
INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, sync_item, create_statement)
 VALUES (2, 'makeList', 'com.darkhorseventures.autoguide.base.MakeList', 50, true, 
'CREATE TABLE make (
       make_id              int NOT NULL,
       make_name            nvarchar(20) NULL,
       record_status_id     int NULL,
       modified             datetime NULL,
       enteredby            int NULL,
       modifiedby           int NULL,
       PRIMARY KEY (make_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF2make', null, 60,
'CREATE INDEX XIF2make ON make
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'system', null, 70,
'CREATE TABLE system (
       pda_id               int NOT NULL,
       version              datetime NULL,
       state                int NULL,
       sync_anchor          datetime NULL,
       PRIMARY KEY (pda_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, sync_item, create_statement)
 VALUES (2, 'modelList', 'com.darkhorseventures.autoguide.base.ModelList', 80, true, 
'CREATE TABLE model (
       model_id             int NOT NULL,
       make_id              int NULL,
       record_status_id     int NULL,
       model_name           nvarchar(40) NULL,
       modified             datetime NULL,
       enteredby            int NULL,
       modifiedby           int NULL,
       PRIMARY KEY (model_id), 
       FOREIGN KEY (make_id)
                             REFERENCES make (make_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF3model', null, 90,
'CREATE INDEX XIF3model ON model
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF5model', null, 100,
'CREATE INDEX XIF5model ON model
(
       make_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, sync_item, create_statement)
 VALUES (2, 'vehicleList', 'com.darkhorseventures.autoguide.base.VehicleList', 110, true, 
'CREATE TABLE vehicle (
       year                 nvarchar(4) NOT NULL,
       vehicle_id           int NOT NULL,
       model_id             int NULL,
       make_id              int NULL,
       record_status_id     int NULL,
       modified             datetime NULL,
       enteredby            int NULL,
       modifiedby           int NULL,
       PRIMARY KEY (vehicle_id), 
       FOREIGN KEY (model_id)
                             REFERENCES model (model_id), 
       FOREIGN KEY (make_id)
                             REFERENCES make (make_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF30vehicle', null, 120,
'CREATE INDEX XIF30vehicle ON vehicle
(
       make_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF31vehicle', null, 130,
'CREATE INDEX XIF31vehicle ON vehicle
(
       model_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF4vehicle', null, 140,
'CREATE INDEX XIF4vehicle ON vehicle
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'accountList', null, 150,
'CREATE TABLE account (
       account_id           int NOT NULL,
       account_name         nvarchar(20) NULL,
       record_status_id     int NULL,
       address              nvarchar(80) NULL,
       modified             datetime NULL,
       city                 nvarchar(80) NULL,
       state                nvarchar(2) NULL,
       notes                nvarchar(255) NULL,
       zip                  nvarchar(11) NULL,
       phone                nvarchar(20) NULL,
       contact              nvarchar(20) NULL,
       entered              datetime NULL,
       enteredby            int NULL,
       modifiedby           int NULL,
       PRIMARY KEY (account_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF16account', null, 160,
'CREATE INDEX XIF16account ON account
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, sync_item, create_statement)
 VALUES (2, 'userList', 'com.darkhorseventures.cfsbase.UserList', 170, true, 
'CREATE TABLE users (
       user_id              int NOT NULL,
       record_status_id     int NULL,
       user_name            nvarchar(20) NULL,
       pin                  nvarchar(20) NULL,
       modified             datetime NULL,
       PRIMARY KEY (user_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF18users', null, 180,
'CREATE INDEX XIF18users ON users
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'accountInventoryList', null, 190,
'CREATE TABLE account_inventory (
       inventory_id         int NOT NULL,
       vin                  nvarchar(20) NULL,
       vehicle_id           int NULL,
       account_id           int NULL,
       adtype               nvarchar(20) NULL,
       mileage              nvarchar(20) NULL,
       enteredby            int NULL,
       new                  bit,
       condition            nvarchar(20) NULL,
       comments             nvarchar(255) NULL,
       stock_no             nvarchar(20) NULL,
       ext_color            nvarchar(20) NULL,
       int_color            nvarchar(20) NULL,
       invoice_price        money NULL,
       selling_price        money NULL,
       modified             datetime NULL,
       status               nvarchar(20) NULL,
       modifiedby           int NULL,
       record_status_id     int NULL,
       entered              datetime NULL,
       PRIMARY KEY (inventory_id), 
       FOREIGN KEY (vehicle_id)
                             REFERENCES vehicle (vehicle_id), 
       FOREIGN KEY (account_id)
                             REFERENCES account (account_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF10account_inventory', null, 200,
'CREATE INDEX XIF10account_inventory ON account_inventory
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF19account_inventory', null, 220,
'CREATE INDEX XIF19account_inventory ON account_inventory
(
       account_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF35account_inventory', null, 230,
'CREATE INDEX XIF35account_inventory ON account_inventory
(
       vehicle_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'options', null, 330,
'CREATE TABLE options (
       option_id            int NOT NULL,
       option_name          nvarchar(20) NULL,
       record_status_id     int NULL,
       record_status_date   datetime NULL,
       PRIMARY KEY (option_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF24options', null, 340,
'CREATE INDEX XIF24options ON options
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'inventory_options', null, 350,
'CREATE TABLE inventory_options (
       inventory_id         int NOT NULL,
       option_id            int NOT NULL,
       record_status_id     int NULL,
       modified             datetime NULL,
       PRIMARY KEY (option_id, inventory_id), 
       FOREIGN KEY (inventory_id)
                             REFERENCES account_inventory (inventory_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id), 
       FOREIGN KEY (option_id)
                             REFERENCES options (option_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF25inventory_options', null, 360,
'CREATE INDEX XIF25inventory_options ON inventory_options
(
       option_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF27inventory_options', null, 370,
'CREATE INDEX XIF27inventory_options ON inventory_options
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF33inventory_options', null, 380,
'CREATE INDEX XIF33inventory_options ON inventory_options
(
       inventory_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'ad_run', null, 310,
'CREATE TABLE ad_run (
       inventory_id         int NOT NULL,
       record_status_id     int NULL,
       start_date           datetime NULL,
       end_date             datetime NULL,
       modified             datetime NULL,
       entered              datetime NULL,
       modifiedby           int NULL,
       enteredby            int NULL,
       PRIMARY KEY (inventory_id), 
       FOREIGN KEY (inventory_id)
                             REFERENCES account_inventory (inventory_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF22ad_run', null, 320,
'CREATE INDEX XIF22ad_run ON ad_run
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'inventory_picture', null, 280,
'CREATE TABLE inventory_picture (
       picture_name         nvarchar(20) NOT NULL,
       inventory_id         int NOT NULL,
       record_status_id     int NULL,
       entered              datetime NULL,
       modified             datetime NULL,
       modifiedby           int NULL,
       enteredby            int NULL,
       PRIMARY KEY (pitcure_name, inventory_id), 
       FOREIGN KEY (inventory_id)
                             REFERENCES account_inventory (inventory_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF23inventory_picture', null, 290,
'CREATE INDEX XIF23inventory_picture ON inventory_picture
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF32inventory_picture', null, 300,
'CREATE INDEX XIF32inventory_picture ON inventory_picture
(
       inventory_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'preferences', null, 390,
'CREATE TABLE preferences (
       user_id              int NOT NULL,
       record_status_id     int NULL,
       modified             datetime NULL,
       PRIMARY KEY (user_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id), 
       FOREIGN KEY (user_id)
                             REFERENCES users (user_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF29preferences', null, 400,
'CREATE INDEX XIF29preferences ON preferences
(
       record_status_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'user_account', null, 240,
'CREATE TABLE user_account (
       user_id              int NOT NULL,
       account_id           int NOT NULL,
       record_status_id     int NULL,
       modified             datetime NULL,
       PRIMARY KEY (user_id, account_id), 
       FOREIGN KEY (record_status_id)
                             REFERENCES status_master (record_status_id), 
       FOREIGN KEY (account_id)
                             REFERENCES account (account_id), 
       FOREIGN KEY (user_id)
                             REFERENCES users (user_id)
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF14user_account', null, 250,
'CREATE INDEX XIF14user_account ON user_account
(
       user_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF15user_account', null, 260,
'CREATE INDEX XIF15user_account ON user_account
(
       account_id
)'
);

INSERT INTO sync_table (system_id, element_name, mapped_class_name, order_id, create_statement)
 VALUES (2, 'XIF17user_account', null, 270,
'CREATE INDEX XIF17user_account ON user_account
(
       record_status_id
)'
);
