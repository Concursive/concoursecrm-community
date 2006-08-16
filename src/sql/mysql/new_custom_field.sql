-- ----------------------------------------------------------------------------
--  PostgreSQL Table Creation
--
--  @author     Andrei I. Holub
--  @created    August 2, 2006
--  @version    $Id:$
-- ----------------------------------------------------------------------------

/* The link between the field category & modules */
CREATE TABLE module_field_categorylink (
  id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  module_id INTEGER NOT NULL REFERENCES permission_category(category_id),
  category_id INT UNIQUE NOT NULL,
  level INTEGER DEFAULT 0,
  description TEXT,
  entered TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP
);
 
/* Each module can have multiple categories or folders of custom data */
CREATE TABLE custom_field_category (
  module_id INTEGER NOT NULL REFERENCES module_field_categorylink(category_id),
  category_id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  category_name VARCHAR(255) NOT NULL,
  level INTEGER DEFAULT 0,
  description TEXT,
  start_date TIMESTAMP NULL,
  end_date TIMESTAMP NULL,
  default_item BOOLEAN DEFAULT false,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enabled BOOLEAN DEFAULT true,
  multiple_records BOOLEAN DEFAULT false,
  read_only BOOLEAN DEFAULT false
);

CREATE INDEX `custom_field_cat_idx` USING btree ON `custom_field_category` (`module_id`);

/* Each category can have multiple groups of fields */
CREATE TABLE custom_field_group (
  category_id INTEGER NOT NULL REFERENCES custom_field_category(category_id),
  group_id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  group_name VARCHAR(255) NOT NULL,
  level INTEGER DEFAULT 0,
  description TEXT,
  start_date TIMESTAMP NULL,
  end_date TIMESTAMP NULL,
  entered TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enabled BOOLEAN DEFAULT true
);

CREATE INDEX `custom_field_grp_idx` USING btree ON `custom_field_group` (`category_id`);


/* Each folder has defined custom fields */
CREATE TABLE custom_field_info (
  group_id INTEGER NOT NULL REFERENCES custom_field_group(group_id),
  field_id INT AUTO_INCREMENT PRIMARY KEY,
  field_name VARCHAR(255) NOT NULL,
  level INTEGER DEFAULT 0,
  field_type INTEGER NOT NULL,
  validation_type INTEGER DEFAULT 0,
  required BOOLEAN DEFAULT false,
  parameters TEXT,
  start_date TIMESTAMP NULL,
  end_date TIMESTAMP NULL,
  entered TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
  enabled BOOLEAN DEFAULT true,
  additional_text VARCHAR(255)
);

CREATE INDEX `custom_field_inf_idx` USING btree ON `custom_field_info` (`group_id`);

/* List of values for type lookup table */
CREATE TABLE custom_field_lookup (
  field_id INTEGER NOT NULL REFERENCES custom_field_info(field_id),
  code INT AUTO_INCREMENT PRIMARY KEY,
  description VARCHAR(255) NOT NULL,
  default_item BOOLEAN DEFAULT false,
  level INTEGER DEFAULT 0,
  start_date TIMESTAMP NULL,
  end_date TIMESTAMP NULL,
  entered TIMESTAMP(3) DEFAULT CURRENT_TIMESTAMP,
  enabled BOOLEAN DEFAULT true
);

/* The saved records in a folder associated with each category_id */
CREATE TABLE custom_field_record (
  link_module_id INTEGER NOT NULL,
  link_item_id INTEGER NOT NULL,
  category_id INTEGER NOT NULL REFERENCES custom_field_category(category_id),
  record_id INTEGER AUTO_INCREMENT NOT NULL PRIMARY KEY,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL REFERENCES `access`(user_id),
  modified TIMESTAMP NULL,
  modifiedby INT NOT NULL REFERENCES `access`(user_id),
  enabled BOOLEAN DEFAULT true
);

CREATE INDEX `custom_field_rec_idx` USING btree ON `custom_field_record` (`link_module_id`, `link_item_id`, `category_id`);

/* The saved custom field data related to a record_id (link_id) */
CREATE TABLE custom_field_data (
  record_id INTEGER NOT NULL REFERENCES custom_field_record(record_id),
  field_id INTEGER NOT NULL REFERENCES custom_field_info(field_id),
  selected_item_id INTEGER DEFAULT 0,
  entered_value TEXT,
  entered_number INTEGER,
  entered_float FLOAT
);

CREATE INDEX `custom_field_dat_idx` USING btree ON `custom_field_data` (`record_id`, `field_id`);

