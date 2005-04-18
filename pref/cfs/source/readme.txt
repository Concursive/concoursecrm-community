Centric CRM Open Source Edition; build: @BUILD.NUMBER@; @BUILD.DATE@
$Id$

Centric CRM 3.0

----------------------------------------------------------------------------
| LEGAL                                                                    |
----------------------------------------------------------------------------

This software is licensed under the Centric Public License (CPL).  
You should have received a copy of the CPL with this source code package in
the LICENSE file. If you did not receive a copy of the CPL, you may download
it from http://www.centriccrm.com. Compiling or using this software
signifies your acceptance of the  Centric Public License.

Copyright(c) 2004-2005 Dark Horse Ventures LLC (http://www.centriccrm.com/) All
rights reserved. This material cannot be distributed without written
permission from Dark Horse Ventures LLC. Permission to use, copy, and modify
this material for internal use is hereby granted, provided that the above
copyright notice and this permission notice appear in all copies. DARK HORSE
VENTURES LLC MAKES NO REPRESENTATIONS AND EXTENDS NO WARRANTIES, EXPRESS OR
IMPLIED, WITH RESPECT TO THE SOFTWARE, INCLUDING, BUT NOT LIMITED TO, THE
IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR ANY PARTICULAR
PURPOSE, AND THE WARRANTY AGAINST INFRINGEMENT OF PATENTS OR OTHER
INTELLECTUAL PROPERTY RIGHTS. THE SOFTWARE IS PROVIDED "AS IS", AND IN NO
EVENT SHALL DARK HORSE VENTURES LLC OR ANY OF ITS AFFILIATES BE LIABLE FOR
ANY DAMAGES, INCLUDING ANY LOST PROFITS OR OTHER INCIDENTAL OR CONSEQUENTIAL
DAMAGES RELATING TO THE SOFTWARE.


----------------------------------------------------------------------------
| INTRODUCTION                                                             |
----------------------------------------------------------------------------

Welcome to Centric CRM!

The installation and configuration of Centric CRM is intended to be as
simple as possible.

PLEASE READ ALL INSTRUCTIONS TO AVOID ANY PROBLEMS.

If you are going to be developing Centric CRM, please make sure to read the
developer information at http://www.centriccrm.com/Portal.do?key=community,
you can also find information about installing, configuring, and using
Centric CRM there.

----------------------------------------------------------------------------
| REQUIREMENTS                                                             |
----------------------------------------------------------------------------

You will need to have the following software installed in order to compile:

  Sun J2SE SDK 1.4 or 1.5
  http://java.sun.com

  Apache Ant 1.6
  http://ant.apache.org

  Apache Tomcat 5.0 (j2se 1.4) or 5.5 (j2se 1.5)
  http://jakarta.apache.org/tomcat

You will also need a database server installed.  The following are supported:

  Postgresql 7.4 or 8.0
  http://www.postgresql.org

  Microsoft SQL Server 2000

You will need the required Centric CRM 3rd party libraries, these are 
distributed separately and include:

  PDFBox-0.6.7.jar
  activation.jar
  batik-all.jar
  bcprov-jdk14-121.jar
  bsh.jar
  commons-beanutils.jar
  commons-collections.jar
  commons-digester.jar
  commons-logging-api.jar
  commons-logging.jar
  iText.jar
  jasperreports-0.6.4.jar
  jcommon-0.9.6.jar
  jfreechart-0.9.21.jar
  jtds-1.0.1.jar
  log4j-1.2.9.jar
  lucene-1.4.2.jar
  mail.jar
  nekohtml.jar
  poi-2.5-final-20040302.jar
  poi-scratchpad-2.5-final-20040302.jar
  postgresql-8.0-310.jdbc3.jar
  tm-extractors-0.4.jar
  xercesMinimal.jar
  
  See below for the specific license information.


----------------------------------------------------------------------------
| SYSTEM SETTINGS                                                          |
----------------------------------------------------------------------------

-> Linux, MacOSX, and Unix use "export VARIABLE=text"
-> Windows use the "My Computer-> Properties -> Environment Variables GUI"

* You must have the JAVA_HOME environment variable properly set to the
location of your Java SDK installation directory. On MacOSX, this path is:
/System/Library/Frameworks/JavaVM.framework/Home

  $ export JAVA_HOME=/usr/local/java/j2sdk1.4

* You must have Ant installed and ANT_HOME defined in your environment as
well as ANT_HOME/bin in your PATH.  You must also increase the JVM memory for
Ant by defining ANT_OPTS.

  $ export ANT_HOME=/usr/local/ant
  $ export ANT_OPTS="-Xmx192m -Xms192m"


* You must have Tomcat installed and CATALINA_HOME defined in your envionment
which points to the tomcat directory.  Also specify the environment variable
CATALINA_OPTS=-Djava.awt.headless=true on Linux/Unix.

  $ export CATALINA_HOME=/usr/local/tomcat
  $ export CATALINA_OPTS=-Djava.awt.headless=true

----------------------------------------------------------------------------
| BUILD PROCESS                                                            |
----------------------------------------------------------------------------

Begin by executing "ant" from the command line.  You will be presented with
the available ant commands.

To verify that you have all settings in place, and to attempt to create
a .war from the source code, execute:

  $ ant deploy
  
A new file will be created in the current directory, which must be edited
with your custom settings.  Ant will notify you that you must make changes
to:

  build.properties

Once changes have been made, you can try ant again:

  $ ant deploy
  
This time you should end up with a .war file.

Before using the .war file, you must install the database using ant.  All of
the source SQL scripts have been included.  Make sure you either create a
database in PostgreSQL or MS SQL, configure the build.properties file
accordingly, then execute ant with:

  $ ant installdb

Ant will ask for the database name, and use the URL and driver from the
build.properties file.  The database will be fully created.

Now you can drop the Tomcat .war in place and begin the web-based 
configuration steps of Centric CRM.


----------------------------------------------------------------------------
| ABOUT THIS SOFTWARE                                                      |
----------------------------------------------------------------------------

Centric CRM licenses libraries and code from the following projects, some 
are proprietary in which Dark Horse Ventures has been granted a license
to redistribute with Centric CRM, some are Open Source and are used 
according to the project license:

Project Name                      License
--------------------------------  -----------------------------------------
Batik                             Apache Software License
Bean Shell                        LGPL
Bouncy Castle Crypto API          Bouncy Castle Open Source License
gnu.regexp                        LGPL
HTMLArea                          BSD style
HTTPMultiPartParser               iSavvix Public License
iText                             LGPL
JFreeChart                        LGPL
Jakarta Commons                   Apache Software License
Jasper Reports                    LGPL
Java Activitation Framework       Sun License
Java Mail                         Sun License
Jcrontab                          LGPL
jTDS                              LGPL
Kafenio                           LGPL
Log4J                             Apache Software License
Lucene                            Apache Software License
NekoHTML                          Apache style
PDFBox                            BSD
POI                               Apache Software License
Team Elements Project Management  Team Elements, LLC Commercial License
TMExtractors                      Apache style
Xerces                            Apache Software License
Ximian Icons                      LGPL
ypSlideOutMenu                    Creative Commons Attribution 2.0 license


