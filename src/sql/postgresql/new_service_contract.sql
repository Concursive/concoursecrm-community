/**
 *  PostgreSQL Table Creation
 *
 *@author       kbhoopal
 *@created      December 31, 2003
 *@version      $Id$
 */
 
CREATE TABLE lookup_asset_status(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_sc_category(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_sc_type(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_response_model(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_phone_model(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_onsite_model(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_email_model(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_hours_reason(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE SEQUENCE lookup_asset_manufactu_code_seq;
CREATE TABLE lookup_asset_manufacturer(
 code INTEGER DEFAULT nextval('lookup_asset_manufactu_code_seq') NOT NULL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE lookup_asset_vendor(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE service_contract (
  contract_id SERIAL PRIMARY KEY,
  contract_number VARCHAR(30),
  account_id INT NOT NULL REFERENCES organization(org_id),
  initial_start_date TIMESTAMP(3) NOT NULL,
  current_start_date TIMESTAMP(3),
  current_end_date TIMESTAMP(3),
  category INT REFERENCES lookup_sc_category(code),
  type INT REFERENCES lookup_sc_type(code),
  contact_id INT REFERENCES contact(contact_id),
  description TEXT,
  contract_billing_notes TEXT,
  response_time INT REFERENCES lookup_response_model(code),
  telephone_service_model INT REFERENCES lookup_phone_model(code),
  onsite_service_model INT REFERENCES lookup_onsite_model(code),
  email_service_model INT REFERENCES lookup_email_model(code),
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL REFERENCES access(user_id),
  modified TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL REFERENCES access(user_id),
  enabled boolean DEFAULT true,
  contract_value FLOAT,
  total_hours_remaining FLOAT,
  service_model_notes TEXT,
  initial_start_date_timezone VARCHAR(255),
  current_start_date_timezone VARCHAR(255),
  current_end_date_timezone VARCHAR(255),
  trashed_date TIMESTAMP(3)
  );

CREATE TABLE service_contract_hours (
  history_id SERIAL PRIMARY KEY,
  link_contract_id INT REFERENCES service_contract(contract_id),
  adjustment_hours FLOAT,
  adjustment_reason INT REFERENCES lookup_hours_reason(code),
  adjustment_notes TEXT,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL REFERENCES access(user_id),
  modified TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL REFERENCES access(user_id)
);

CREATE TABLE service_contract_products(
  id SERIAL PRIMARY KEY,
  link_contract_id INT REFERENCES service_contract(contract_id),
  link_product_id INT REFERENCES product_catalog(product_id)
);

CREATE TABLE asset_category ( 
  id serial PRIMARY KEY,
  cat_level int NOT NULL DEFAULT 0,
  parent_cat_code int NOT NULL DEFAULT 0,
  description VARCHAR(300) NOT NULL,
  full_description text NOT NULL DEFAULT '',
  default_item BOOLEAN DEFAULT false,
  level INTEGER DEFAULT 0,
  enabled BOOLEAN DEFAULT true,
  site_id INTEGER REFERENCES lookup_site_id(code)
);

CREATE TABLE asset_category_draft (
  id serial PRIMARY KEY,
  link_id INT DEFAULT -1,
  cat_level int NOT NULL DEFAULT 0,
  parent_cat_code int NOT NULL DEFAULT 0,
  description VARCHAR(300) NOT NULL,
  full_description text NOT NULL DEFAULT '',
  default_item BOOLEAN DEFAULT false,
  level INTEGER DEFAULT 0,
  enabled BOOLEAN DEFAULT true,
  site_id INTEGER REFERENCES lookup_site_id(code)
);

CREATE TABLE asset (
  asset_id SERIAL PRIMARY KEY,
  account_id INT REFERENCES organization(org_id),
  contract_id INT REFERENCES service_contract(contract_id),
  date_listed TIMESTAMP(3),
  asset_tag VARCHAR(30),
  status INT,
  location VARCHAR(256),
  level1 INT REFERENCES asset_category(id),
  level2 INT REFERENCES asset_category(id),
  level3 INT REFERENCES asset_category(id),
  serial_number VARCHAR(30),
  model_version VARCHAR(30),
  description TEXT,
  expiration_date TIMESTAMP(3),
  inclusions TEXT,
  exclusions TEXT,
  purchase_date TIMESTAMP(3),
  po_number VARCHAR(30),
  purchased_from VARCHAR(30),
  contact_id INT REFERENCES contact(contact_id),
  notes TEXT,
  response_time INT REFERENCES lookup_response_model(code),
  telephone_service_model INT REFERENCES lookup_phone_model(code),
  onsite_service_model INT REFERENCES lookup_onsite_model(code),
  email_service_model INT REFERENCES lookup_email_model(code),
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL REFERENCES access(user_id),
  modified TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL REFERENCES access(user_id),
  enabled boolean DEFAULT true,
  purchase_cost FLOAT,
  date_listed_timezone VARCHAR(255),
  expiration_date_timezone VARCHAR(255),
  purchase_date_timezone VARCHAR(255),
  trashed_date TIMESTAMP(3),
  parent_id INTEGER REFERENCES asset(asset_id),
  vendor_code INT REFERENCES lookup_asset_vendor(code),
  manufacturer_code INT REFERENCES lookup_asset_manufacturer(code)
);

CREATE TABLE lookup_asset_materials(
 code SERIAL PRIMARY KEY,
 description VARCHAR(300),
 default_item BOOLEAN DEFAULT FALSE,
 level INTEGER,
 enabled BOOLEAN DEFAULT TRUE
);

CREATE TABLE asset_materials_map (
  map_id SERIAL PRIMARY KEY,
  asset_id INTEGER NOT NULL REFERENCES asset(asset_id),
  code INTEGER NOT NULL REFERENCES lookup_asset_materials(code),
  quantity FLOAT,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP
);

