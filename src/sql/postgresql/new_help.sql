/**
 *  PostgreSQL Table Creation
 *
 *@author     mrajkowski
 *@created    March 19, 2002
 *@version    $Id$
 */
 
CREATE TABLE help_contents (
  help_id SERIAL PRIMARY KEY,
  module VARCHAR(255) NOT NULL,
  section VARCHAR(255),
  subsection VARCHAR(255),
  description TEXT,
  enteredby INT NOT NULL REFERENCES access,
  entered TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  modifiedby INT NOT NULL REFERENCES access,
  modified TIMESTAMP(3) NOT NULL DEFAULT CURRENT_TIMESTAMP,
  enabled BOOLEAN DEFAULT true
);
