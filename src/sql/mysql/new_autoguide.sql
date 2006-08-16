-- ----------------------------------------------------------------------------
--  PostgreSQL Table Creation
--
--  @author     Andrei I. Holub
--  @created    August 2, 2006
--  @version    $Id:$
-- ----------------------------------------------------------------------------
 
CREATE TABLE autoguide_make (
  make_id INT AUTO_INCREMENT PRIMARY KEY,
  make_name VARCHAR(30),
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL,
  modified TIMESTAMP NULL,
  modifiedby INT NOT NULL
);

CREATE TABLE autoguide_model (
  model_id INT AUTO_INCREMENT PRIMARY KEY,
  make_id INTEGER NOT NULL REFERENCES autoguide_make(make_id),
  model_name VARCHAR(50),
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL,
  modified TIMESTAMP NULL,
  modifiedby INT NOT NULL
);

CREATE TABLE autoguide_vehicle (
  vehicle_id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  year VARCHAR(4) NOT NULL,
  make_id INTEGER NOT NULL REFERENCES autoguide_make(make_id),
  model_id INTEGER NOT NULL REFERENCES autoguide_model(model_id),
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL,
  modified TIMESTAMP NULL,
  modifiedby INT NOT NULL
);

CREATE TABLE autoguide_inventory (
  inventory_id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  vehicle_id INTEGER NOT NULL REFERENCES autoguide_vehicle(vehicle_id),
  account_id INTEGER REFERENCES organization(org_id),
  vin VARCHAR(20),
  mileage VARCHAR(20) NULL,
  is_new BOOLEAN DEFAULT false,
  `condition` VARCHAR(20) NULL,
  comments VARCHAR(255) NULL,
  stock_no VARCHAR(20) NULL,
  ext_color VARCHAR(20) NULL,
  int_color VARCHAR(20) NULL,
	style VARCHAR(40) NULL,
  invoice_price FLOAT NULL,
  selling_price FLOAT NULL,
	selling_price_text VARCHAR(100) NULL,
  sold BOOLEAN DEFAULT false,
  `status` VARCHAR(20) NULL,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL,
  modified TIMESTAMP NULL,
  modifiedby INT NOT NULL
);

CREATE TABLE autoguide_options (
  option_id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  option_name VARCHAR(20) NOT NULL,
  default_item BOOLEAN DEFAULT false,
  level INTEGER DEFAULT 0,
  enabled BOOLEAN DEFAULT true,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified TIMESTAMP NULL
);

CREATE TABLE autoguide_inventory_options (
  inventory_id INTEGER NOT NULL REFERENCES autoguide_inventory(inventory_id),
  option_id INTEGER NOT NULL
);

CREATE UNIQUE INDEX idx_autog_inv_opt ON autoguide_inventory_options (inventory_id, option_id);

CREATE TABLE autoguide_ad_run (
  ad_run_id INT AUTO_INCREMENT PRIMARY KEY,
  inventory_id INTEGER NOT NULL REFERENCES autoguide_inventory(inventory_id),
  run_date TIMESTAMP NULL,
  ad_type VARCHAR(20) NULL,
  include_photo BOOLEAN DEFAULT false,
  complete_date TIMESTAMP(3) NULL,
  completedby INT DEFAULT -1,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL,
  modified TIMESTAMP NULL,
  modifiedby INT NOT NULL
);

CREATE TABLE autoguide_ad_run_types (
  code INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  description VARCHAR(20) NOT NULL,
  default_item BOOLEAN DEFAULT false,
  level INTEGER DEFAULT 0,
  enabled BOOLEAN DEFAULT false,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified TIMESTAMP NULL
);
