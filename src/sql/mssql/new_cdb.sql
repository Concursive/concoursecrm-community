/**
 *  MSSQL Table Creation
 *
 *@author     mrajkowski
 *@created    March 19, 2002
 *@version    $Id$
 */

CREATE TABLE access (
  user_id INT IDENTITY PRIMARY KEY,
  username VARCHAR(80) NOT NULL, 
  password VARCHAR(80),
  contact_id INT DEFAULT -1,
  role_id INT DEFAULT -1,
  manager_id INT DEFAULT -1,
  startofday INTEGER DEFAULT 8,
  endofday INTEGER DEFAULT 18,
  locale VARCHAR(255),
  timezone VARCHAR(255) DEFAULT 'America/New_York',
  last_ip VARCHAR(15),
  last_login DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL,
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL,
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  expires DATETIME DEFAULT NULL,
  alias INT DEFAULT -1,
  assistant INT DEFAULT -1,
  enabled BIT NOT NULL DEFAULT 1
);

CREATE TABLE lookup_industry (
  code INT IDENTITY PRIMARY KEY,
  order_id INT,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
);

CREATE TABLE access_log (
  id INT IDENTITY PRIMARY KEY,
  user_id INT NOT REFERENCES access(user_id),
  username VARCHAR(80) NOT NULL,
  ip VARCHAR(15),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  browser VARCHAR(255)
);


CREATE TABLE system_prefs (
  pref_id INT IDENTITY PRIMARY KEY,
  category VARCHAR(255) NOT NULL,
  data TEXT DEFAULT '' NOT NULL,
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id),
  enabled BIT NOT NULL DEFAULT 1
);

CREATE TABLE usage_log (
  usage_id INT IDENTITY PRIMARY KEY,
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NULL,
  action INT NOT NULL,
  record_id INT NULL,
  record_size INT NULL
);

CREATE TABLE lookup_contact_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1,
  user_id INT references access(user_id),
  category INT NOT NULL DEFAULT 0
);

CREATE TABLE lookup_account_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
);

CREATE TABLE state (
  state_code CHAR(2) PRIMARY KEY NOT NULL,
  state VARCHAR(80) NOT NULL
);


CREATE TABLE lookup_department (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
);

CREATE TABLE lookup_orgaddress_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
);

CREATE TABLE lookup_orgemail_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE lookup_orgphone_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE lookup_instantmessenger_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE lookup_employment_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
);

CREATE TABLE lookup_locale (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
);

CREATE TABLE lookup_contactaddress_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE lookup_contactemail_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE lookup_contactphone_types (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE organization (
  org_id INT IDENTITY PRIMARY KEY,
  name VARCHAR(80) NOT NULL,
  account_number VARCHAR(50),
  account_group INT,
  url TEXT,
  revenue FLOAT,
  employees INT,
  notes TEXT,
  sic_code VARCHAR(40),
  ticker_symbol VARCHAR(10) DEFAULT NULL,
  taxid CHAR(80),
  lead VARCHAR(40),
  sales_rep int NOT NULL DEFAULT 0, 
  miner_only BIT NOT NULL DEFAULT 0,
  defaultlocale INT,
  fiscalmonth INT,
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id),
  enabled BIT DEFAULT 1,
  industry_temp_code SMALLINT,
  owner INT references access(user_id),
  duplicate_id int default -1,
  custom1 int default -1,
  custom2 int default -1,
  contract_end DATETIME default null,
  alertdate DATETIME default null,
  alert varchar(100) default null,
  custom_data TEXT,
  namesalutation varchar(80),
  namelast varchar(80),
  namefirst varchar(80),
  namemiddle varchar(80),
  namesuffix varchar(80)
);

CREATE TABLE contact (
  contact_id INT IDENTITY PRIMARY KEY,
  user_id INT references access(user_id),
  org_id int REFERENCES organization(org_id),
  company VARCHAR(255),
  title VARCHAR(80),
  department INT references lookup_department(code),
  super INT REFERENCES contact,
  nameSalutation varchar(80),
  nameLast VARCHAR(80) NOT NULL,
  nameFirst VARCHAR(80) NOT NULL,
  nameMiddle VARCHAR(80),
  nameSuffix VARCHAR(80),
  assistant INT REFERENCES contact,
  birthdate DATETIME,
  type_id INT REFERENCES lookup_contact_types,
  notes TEXT,
  site INT,
  imName VARCHAR(30),
  imService INT,
  locale INT,
  employee_id varchar(80),
  employmenttype INT,
  startofday VARCHAR(10),
  endofday VARCHAR(10),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL REFERENCES access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL REFERENCES access(user_id),
  enabled BIT DEFAULT 1,
  owner INT REFERENCES access(user_id),
  custom1 int default -1,
  custom2 int default -1,
  custom_data TEXT,
  url VARCHAR(100),
  primary_contact BIT DEFAULT 0
);

CREATE INDEX "contact_user_id_idx" ON "contact" ("user_id");

CREATE TABLE role (
  role_id INT IDENTITY PRIMARY KEY,
  role VARCHAR(80) NOT NULL,
  description VARCHAR(255) NOT NULL DEFAULT '',
  enteredby INT NOT NULL REFERENCES access(user_id),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL REFERENCES access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enabled BIT NOT NULL DEFAULT 1
);

CREATE TABLE permission_category (
  category_id INT IDENTITY PRIMARY KEY,
  category VARCHAR(80),
  description VARCHAR(255),
  level INT NOT NULL DEFAULT 0,
  enabled BIT NOT NULL DEFAULT 1,
  active BIT NOT NULL DEFAULT 1,
  folders BIT NOT NULL DEFAULT 0,
  lookups BIT NOT NULL DEFAULT 0
);

CREATE TABLE permission (
  permission_id INT IDENTITY PRIMARY KEY,
  category_id INT NOT NULL REFERENCES permission_category,
  permission VARCHAR(80) NOT NULL,
  permission_view BIT NOT NULL DEFAULT 0,
  permission_add BIT NOT NULL DEFAULT 0,
  permission_edit BIT NOT NULL DEFAULT 0,
  permission_delete BIT NOT NULL DEFAULT 0,
  description VARCHAR(255) NOT NULL DEFAULT '',
  level INT NOT NULL DEFAULT 0,
  enabled BIT NOT NULL DEFAULT 1,
  active BIT NOT NULL DEFAULT 1
);

CREATE TABLE role_permission (
  id INT IDENTITY PRIMARY KEY,
  role_id INT NOT NULL REFERENCES role(role_id),
  permission_id INT NOT NULL REFERENCES permission(permission_id),
  role_view BIT NOT NULL DEFAULT 0,
  role_add BIT NOT NULL DEFAULT 0,
  role_edit BIT NOT NULL DEFAULT 0,
  role_delete BIT NOT NULL DEFAULT 0
);


CREATE TABLE lookup_stage (
  code INT IDENTITY PRIMARY KEY,
  order_id INT,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE lookup_delivery_options (
  code INT IDENTITY PRIMARY KEY,
  description VARCHAR(50) NOT NULL,
  default_item BIT DEFAULT 0,
  level INTEGER DEFAULT 0,
  enabled BIT DEFAULT 1
)
;

CREATE TABLE news (
  rec_id INT IDENTITY PRIMARY KEY,
  org_id INT references organization(org_id),
  url TEXT,
  base TEXT,
  headline TEXT,
  body TEXT,
  dateEntered DATETIME,
  type CHAR(1),
  created DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE organization_address (
  address_id INT IDENTITY PRIMARY KEY,
  org_id INT REFERENCES organization(org_id),
  address_type INT references lookup_orgaddress_types(code),
  addrline1 VARCHAR(80),
  addrline2 VARCHAR(80),
  city VARCHAR(80),
  state VARCHAR(80),
  country VARCHAR(80),
  postalcode VARCHAR(12),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id)
)
;

CREATE TABLE organization_emailaddress (
  emailaddress_id INT IDENTITY PRIMARY KEY,
  org_id INT REFERENCES organization(org_id),
  emailaddress_type INT references lookup_orgemail_types(code),
  email VARCHAR(256),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id)
)
;

CREATE TABLE organization_phone (
  phone_id INT IDENTITY PRIMARY KEY,
  org_id INT REFERENCES organization(org_id),
  phone_type INT references lookup_orgphone_types(code),
  number VARCHAR(30),
  extension VARCHAR(10),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id)
)
;

CREATE TABLE contact_address (
  address_id INT IDENTITY PRIMARY KEY,
  contact_id INT REFERENCES contact(contact_id),
  address_type INT references lookup_contactaddress_types(code),
  addrline1 VARCHAR(80),
  addrline2 VARCHAR(80),
  city VARCHAR(80),
  state VARCHAR(80),
  country VARCHAR(80),
  postalcode VARCHAR(12),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id)
)
;

CREATE TABLE contact_emailaddress (
  emailaddress_id INT IDENTITY PRIMARY KEY,
  contact_id INT REFERENCES contact(contact_id),
  emailaddress_type INT references lookup_contactemail_types(code),
  email VARCHAR(256),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id)
)
;

CREATE TABLE contact_phone (
  phone_id INT IDENTITY PRIMARY KEY,
  contact_id INT REFERENCES contact(contact_id),
  phone_type INT references lookup_contactphone_types(code),
  number VARCHAR(30),
  extension VARCHAR(10),
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enteredby INT NOT NULL references access(user_id),
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL references access(user_id)
)
;

CREATE TABLE notification (
  notification_id INT IDENTITY PRIMARY KEY,
  notify_user INT NOT NULL,
  module VARCHAR(255) NOT NULL,
  item_id INT NOT NULL,
  item_modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  attempt DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  notify_type VARCHAR(30),
  subject TEXT,
  message TEXT,
  result INT NOT NULL,
  errorMessage TEXT
);

CREATE TABLE cfsinbox_message (
  id INT IDENTITY PRIMARY KEY,
  subject VARCHAR(255) DEFAULT NULL,
  body TEXT NOT NULL,
  reply_id INT NOT NULL,
  enteredby INT NOT NULL REFERENCES access(user_id),
  sent DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  type int not null default -1,
  modifiedby INT NOT NULL REFERENCES access(user_id),
  delete_flag BIT default 0
);

CREATE TABLE cfsinbox_messagelink (
  id INT NOT NULL REFERENCES cfsinbox_message(id),
  sent_to INT NOT NULL REFERENCES contact(contact_id),
  status INT NOT NULL DEFAULT 0,
  viewed DATETIME DEFAULT NULL,
  enabled BIT NOT NULL DEFAULT 1,
  sent_from INT NOT NULL REFERENCES access(user_id)
);
  
CREATE TABLE account_type_levels (
  org_id INT NOT NULL REFERENCES organization(org_id),
  type_id INT NOT NULL REFERENCES lookup_account_types(code),
  level INTEGER not null,
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE contact_type_levels (
  contact_id INT NOT NULL REFERENCES contact(contact_id),
  type_id INT NOT NULL REFERENCES lookup_contact_types(code),
  level INTEGER not null,
  entered DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modified DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE lookup_lists_lookup(
  id INT IDENTITY PRIMARY KEY,
  module_id INTEGER NOT NULL REFERENCES permission_category(category_id),
  lookup_id INT NOT NULL,
  class_name VARCHAR(20),
  table_name VARCHAR(60),
  level INTEGER DEFAULT 0,
  description TEXT,
  entered DATETIME DEFAULT CURRENT_TIMESTAMP
);
