 
-- Insert default ticket_priority
SET NOCOUNT ON
SET IDENTITY_INSERT [ticket_priority] ON
GO
INSERT [ticket_priority] VALUES(1,'As Scheduled','background-color:lightgreen;color:black;',1,0,1)
INSERT [ticket_priority] VALUES(2,'Urgent','background-color:yellow;color:black;',0,1,1)
INSERT [ticket_priority] VALUES(3,'Critical','background-color:red;color:black;font-weight:bold;',0,2,1)

SET IDENTITY_INSERT [ticket_priority] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_project_issues
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_project_issues] ON
GO
INSERT [lookup_project_issues] VALUES(1,'Status Update',0,0,1,0)
INSERT [lookup_project_issues] VALUES(2,'Bug Report',0,0,1,0)
INSERT [lookup_project_issues] VALUES(3,'Network',0,0,1,0)
INSERT [lookup_project_issues] VALUES(4,'Hardware',0,0,1,0)
INSERT [lookup_project_issues] VALUES(5,'Permissions',0,0,1,0)
INSERT [lookup_project_issues] VALUES(6,'User',0,0,1,0)
INSERT [lookup_project_issues] VALUES(7,'Documentation',0,0,1,0)
INSERT [lookup_project_issues] VALUES(8,'Feature',0,0,1,0)
INSERT [lookup_project_issues] VALUES(9,'Procedure',0,0,1,0)
INSERT [lookup_project_issues] VALUES(10,'Training',0,0,1,0)
INSERT [lookup_project_issues] VALUES(11,'3rd-Party Software',0,0,1,0)
INSERT [lookup_project_issues] VALUES(12,'Database',0,0,1,0)
INSERT [lookup_project_issues] VALUES(13,'Information',0,0,1,0)
INSERT [lookup_project_issues] VALUES(14,'Testing',0,0,1,0)
INSERT [lookup_project_issues] VALUES(15,'Security',0,0,1,0)

SET IDENTITY_INSERT [lookup_project_issues] OFF
GO
SET NOCOUNT OFF
 
-- Insert default permission
SET NOCOUNT ON
SET IDENTITY_INSERT [permission] ON
GO
INSERT [permission] VALUES(1,1,'accounts',1,0,0,0,'Access to Accounts module',10,1,1,0)
INSERT [permission] VALUES(2,1,'accounts-accounts',1,1,1,1,'Account Records',20,1,1,0)
INSERT [permission] VALUES(3,1,'accounts-accounts-folders',1,1,1,1,'Folders',30,1,1,0)
INSERT [permission] VALUES(4,1,'accounts-accounts-contacts',1,1,1,1,'Contacts',40,1,1,0)
INSERT [permission] VALUES(5,1,'accounts-accounts-contacts-opportunities',1,1,1,1,'Contact Opportunities',50,1,1,0)
INSERT [permission] VALUES(6,1,'accounts-accounts-contacts-calls',1,1,1,1,'Contact Calls',60,1,1,0)
INSERT [permission] VALUES(7,1,'accounts-accounts-contacts-messages',1,1,1,1,'Contact Messages',70,1,1,0)
INSERT [permission] VALUES(8,1,'accounts-accounts-opportunities',1,1,1,1,'Opportunities',80,1,1,0)
INSERT [permission] VALUES(9,1,'accounts-accounts-tickets',1,1,1,1,'Tickets',90,1,1,0)
INSERT [permission] VALUES(10,1,'accounts-accounts-tickets-tasks',1,1,1,1,'Ticket Tasks',100,1,1,0)
INSERT [permission] VALUES(11,1,'accounts-accounts-tickets-folders',1,1,1,1,'Ticket Folders',110,1,1,0)
INSERT [permission] VALUES(12,1,'accounts-accounts-tickets-documents',1,1,1,1,'Ticket Documents',120,1,1,0)
INSERT [permission] VALUES(13,1,'accounts-accounts-documents',1,1,1,1,'Documents',130,1,1,0)
INSERT [permission] VALUES(14,1,'accounts-accounts-reports',1,1,0,1,'Export Account Data',140,1,1,0)
INSERT [permission] VALUES(15,1,'accounts-dashboard',1,0,0,0,'Dashboard',150,1,1,0)
INSERT [permission] VALUES(16,1,'accounts-accounts-revenue',1,1,1,1,'Revenue',160,0,0,0)
INSERT [permission] VALUES(17,1,'accounts-autoguide-inventory',1,1,1,1,'Auto Guide Vehicle Inventory',170,0,0,0)
INSERT [permission] VALUES(18,1,'accounts-service-contracts',1,1,1,1,'Service Contracts',180,1,1,0)
INSERT [permission] VALUES(19,1,'accounts-assets',1,1,1,1,'Assets',190,1,1,0)
INSERT [permission] VALUES(20,1,'accounts-accounts-tickets-maintenance-report',1,1,1,1,'Ticket Maintenance Notes',200,1,1,0)
INSERT [permission] VALUES(21,1,'accounts-accounts-tickets-activity-log',1,1,1,1,'Ticket Activities',210,1,1,0)
INSERT [permission] VALUES(22,1,'portal-user',1,1,1,1,'Customer Portal User',220,1,1,0)
INSERT [permission] VALUES(23,1,'accounts-quotes',1,1,1,1,'Quotes',230,0,0,0)
INSERT [permission] VALUES(24,1,'accounts-orders',1,1,1,1,'Orders',240,0,0,0)
INSERT [permission] VALUES(25,1,'accounts-products',1,1,1,1,'Products and Services',250,0,0,0)
INSERT [permission] VALUES(26,2,'contacts',1,0,0,0,'Access to Contacts module',10,1,1,0)
INSERT [permission] VALUES(27,2,'contacts-external_contacts',1,1,1,1,'General Contact Records',20,1,1,0)
INSERT [permission] VALUES(28,2,'contacts-external_contacts-reports',1,1,0,1,'Export Contact Data',30,1,1,0)
INSERT [permission] VALUES(29,2,'contacts-external_contacts-folders',1,1,1,1,'Folders',40,1,1,0)
INSERT [permission] VALUES(30,2,'contacts-external_contacts-calls',1,1,1,1,'Calls',50,1,1,0)
INSERT [permission] VALUES(31,2,'contacts-external_contacts-messages',1,0,0,0,'Messages',60,1,1,0)
INSERT [permission] VALUES(32,2,'contacts-external_contacts-opportunities',1,1,1,1,'Opportunities',70,1,1,0)
INSERT [permission] VALUES(33,2,'contacts-external_contacts-imports',1,1,1,1,'Imports',80,1,1,0)
INSERT [permission] VALUES(34,3,'autoguide',1,0,0,0,'Access to the Auto Guide module',10,1,1,0)
INSERT [permission] VALUES(35,3,'autoguide-adruns',0,0,1,0,'Ad Run complete status',20,1,1,0)
INSERT [permission] VALUES(36,4,'pipeline',1,0,0,0,'Access to Pipeline module',10,1,1,1)
INSERT [permission] VALUES(37,4,'pipeline-opportunities',1,1,1,1,'Opportunity Records',20,1,1,0)
INSERT [permission] VALUES(38,4,'pipeline-dashboard',1,0,0,0,'Dashboard',30,1,1,0)
INSERT [permission] VALUES(39,4,'pipeline-reports',1,1,0,1,'Export Opportunity Data',40,1,1,0)
INSERT [permission] VALUES(40,4,'pipeline-opportunities-calls',1,1,1,1,'Calls',50,1,1,0)
INSERT [permission] VALUES(41,4,'pipeline-opportunities-documents',1,1,1,1,'Documents',60,1,1,0)
INSERT [permission] VALUES(42,5,'demo',1,1,1,1,'Access to Demo/Non-working features',10,1,1,0)
INSERT [permission] VALUES(43,6,'campaign',1,0,0,0,'Access to Communications module',10,1,1,0)
INSERT [permission] VALUES(44,6,'campaign-dashboard',1,0,0,0,'Dashboard',20,1,1,0)
INSERT [permission] VALUES(45,6,'campaign-campaigns',1,1,1,1,'Campaign Records',30,1,1,0)
INSERT [permission] VALUES(46,6,'campaign-campaigns-groups',1,1,1,1,'Group Records',40,1,1,0)
INSERT [permission] VALUES(47,6,'campaign-campaigns-messages',1,1,1,1,'Message Records',50,1,1,0)
INSERT [permission] VALUES(48,6,'campaign-campaigns-surveys',1,1,1,1,'Survey Records',60,1,1,0)
INSERT [permission] VALUES(49,7,'projects',1,0,0,0,'Access to Project Management module',10,1,1,0)
INSERT [permission] VALUES(50,7,'projects-personal',1,0,0,0,'Personal View',20,1,1,0)
INSERT [permission] VALUES(51,7,'projects-enterprise',1,0,0,0,'Enterprise View',30,1,1,0)
INSERT [permission] VALUES(52,7,'projects-projects',1,1,1,1,'Project Records',40,1,1,0)
INSERT [permission] VALUES(53,8,'tickets',1,0,0,0,'Access to Help Desk module',10,1,1,0)
INSERT [permission] VALUES(54,8,'tickets-tickets',1,1,1,1,'Ticket Records',20,1,1,0)
INSERT [permission] VALUES(55,8,'tickets-reports',1,1,1,1,'Export Ticket Data',30,1,1,0)
INSERT [permission] VALUES(56,8,'tickets-tickets-tasks',1,1,1,1,'Tasks',40,1,1,0)
INSERT [permission] VALUES(57,8,'tickets-maintenance-report',1,1,1,1,'Maintenance Notes',50,1,1,0)
INSERT [permission] VALUES(58,8,'tickets-activity-log',1,1,1,1,'Activities',60,1,1,0)
INSERT [permission] VALUES(59,9,'admin',1,0,0,0,'Access to Admin module',10,1,1,0)
INSERT [permission] VALUES(60,9,'admin-users',1,1,1,1,'Users',20,1,1,0)
INSERT [permission] VALUES(61,9,'admin-roles',1,1,1,1,'Roles',30,1,1,0)
INSERT [permission] VALUES(62,9,'admin-usage',1,0,0,0,'System Usage',40,1,1,0)
INSERT [permission] VALUES(63,9,'admin-sysconfig',1,0,1,0,'System Configuration',50,1,1,0)
INSERT [permission] VALUES(64,9,'admin-sysconfig-lists',1,0,1,0,'Configure Lookup Lists',60,1,1,0)
INSERT [permission] VALUES(65,9,'admin-sysconfig-folders',1,1,1,1,'Configure Custom Folders & Fields',70,1,1,0)
INSERT [permission] VALUES(66,9,'admin-object-workflow',1,1,1,1,'Configure Object Workflow',80,1,1,0)
INSERT [permission] VALUES(67,9,'admin-sysconfig-categories',1,1,1,1,'Categories',90,1,1,0)
INSERT [permission] VALUES(68,10,'help',1,0,0,0,'Access to Help System',10,1,1,0)
INSERT [permission] VALUES(69,11,'globalitems-search',1,0,0,0,'Access to Global Search',10,1,1,0)
INSERT [permission] VALUES(70,11,'globalitems-myitems',1,0,0,0,'Access to My Items',20,1,1,0)
INSERT [permission] VALUES(71,11,'globalitems-recentitems',1,0,0,0,'Access to Recent Items',30,1,1,0)
INSERT [permission] VALUES(72,12,'myhomepage',1,0,0,0,'Access to My Home Page module',10,1,1,0)
INSERT [permission] VALUES(73,12,'myhomepage-dashboard',1,0,0,0,'View Performance Dashboard',20,1,1,0)
INSERT [permission] VALUES(74,12,'myhomepage-miner',1,1,0,1,'Industry News records',30,0,0,0)
INSERT [permission] VALUES(75,12,'myhomepage-inbox',1,0,0,0,'Mailbox',40,1,1,0)
INSERT [permission] VALUES(76,12,'myhomepage-tasks',1,1,1,1,'Tasks',50,1,1,0)
INSERT [permission] VALUES(77,12,'myhomepage-reassign',1,0,1,0,'Re-assign Items',60,1,1,0)
INSERT [permission] VALUES(78,12,'myhomepage-profile',1,0,0,0,'Profile',70,1,1,0)
INSERT [permission] VALUES(79,12,'myhomepage-profile-personal',1,0,1,0,'Personal Information',80,1,1,0)
INSERT [permission] VALUES(80,12,'myhomepage-profile-settings',1,0,1,0,'Settings',90,0,0,0)
INSERT [permission] VALUES(81,12,'myhomepage-profile-password',0,0,1,0,'Password',100,1,1,0)
INSERT [permission] VALUES(82,12,'myhomepage-action-lists',1,1,1,1,'Action Lists',110,1,1,0)
INSERT [permission] VALUES(83,13,'qa',1,1,1,1,'Access to QA Tool',10,1,1,0)
INSERT [permission] VALUES(84,14,'reports',1,0,0,0,'Access to Reports module',10,1,1,0)
INSERT [permission] VALUES(85,17,'product-catalog',1,0,0,0,'Access to Product Catalog module',10,1,1,0)
INSERT [permission] VALUES(86,17,'product-catalog-product',1,1,1,1,'Products',20,1,1,0)
INSERT [permission] VALUES(87,18,'products',1,0,0,0,'Access to Products and Services module',10,1,1,0)
INSERT [permission] VALUES(88,19,'quotes',1,1,1,1,'Access to Quotes module',10,1,1,0)
INSERT [permission] VALUES(89,20,'orders',1,1,1,1,'Access to Orders module',10,1,1,0)
INSERT [permission] VALUES(90,21,'employees',1,0,0,0,'Access to Employee module',10,1,1,0)
INSERT [permission] VALUES(91,21,'contacts-internal_contacts',1,1,1,1,'Employees',20,1,1,0)

SET IDENTITY_INSERT [permission] OFF
GO
SET NOCOUNT OFF
 
-- Insert default help_tableof_contents
SET NOCOUNT ON
SET IDENTITY_INSERT [help_tableof_contents] ON
GO
INSERT [help_tableof_contents] VALUES(1,'Modules',NULL,NULL,NULL,NULL,1,5,0,'May 28 2004 10:25:54:273AM',0,'May 28 2004 10:25:54:273AM',1)
INSERT [help_tableof_contents] VALUES(2,'My Home Page',NULL,NULL,1,12,2,5,0,'May 28 2004 10:25:54:293AM',0,'May 28 2004 10:25:54:293AM',1)
INSERT [help_tableof_contents] VALUES(3,'Overview',NULL,NULL,2,12,3,5,0,'May 28 2004 10:25:54:293AM',0,'May 28 2004 10:25:54:293AM',1)
INSERT [help_tableof_contents] VALUES(4,'Mailbox',NULL,NULL,2,12,3,10,0,'May 28 2004 10:25:54:313AM',0,'May 28 2004 10:25:54:313AM',1)
INSERT [help_tableof_contents] VALUES(5,'Message Details',NULL,NULL,4,12,4,15,0,'May 28 2004 10:25:54:323AM',0,'May 28 2004 10:25:54:323AM',1)
INSERT [help_tableof_contents] VALUES(6,'New Message',NULL,NULL,4,12,4,20,0,'May 28 2004 10:25:54:323AM',0,'May 28 2004 10:25:54:323AM',1)
INSERT [help_tableof_contents] VALUES(7,'Reply Message',NULL,NULL,4,12,4,25,0,'May 28 2004 10:25:54:333AM',0,'May 28 2004 10:25:54:333AM',1)
INSERT [help_tableof_contents] VALUES(8,'SendMessage',NULL,NULL,4,12,4,30,0,'May 28 2004 10:25:54:343AM',0,'May 28 2004 10:25:54:343AM',1)
INSERT [help_tableof_contents] VALUES(9,'Forward message',NULL,NULL,4,12,4,35,0,'May 28 2004 10:25:54:353AM',0,'May 28 2004 10:25:54:353AM',1)
INSERT [help_tableof_contents] VALUES(10,'Tasks',NULL,NULL,2,12,3,40,0,'May 28 2004 10:25:54:363AM',0,'May 28 2004 10:25:54:363AM',1)
INSERT [help_tableof_contents] VALUES(11,'Advanced Task',NULL,NULL,10,12,4,45,0,'May 28 2004 10:25:54:363AM',0,'May 28 2004 10:25:54:363AM',1)
INSERT [help_tableof_contents] VALUES(12,'Forwarding a Task',NULL,NULL,10,12,4,50,0,'May 28 2004 10:25:54:373AM',0,'May 28 2004 10:25:54:373AM',1)
INSERT [help_tableof_contents] VALUES(13,'Modify task',NULL,NULL,10,12,4,55,0,'May 28 2004 10:25:54:383AM',0,'May 28 2004 10:25:54:383AM',1)
INSERT [help_tableof_contents] VALUES(14,'Action Lists',NULL,NULL,2,12,3,60,0,'May 28 2004 10:25:54:393AM',0,'May 28 2004 10:25:54:393AM',1)
INSERT [help_tableof_contents] VALUES(15,'Action Contacts',NULL,NULL,14,12,4,65,0,'May 28 2004 10:25:54:403AM',0,'May 28 2004 10:25:54:403AM',1)
INSERT [help_tableof_contents] VALUES(16,'Add Action List',NULL,NULL,14,12,4,70,0,'May 28 2004 10:25:54:403AM',0,'May 28 2004 10:25:54:403AM',1)
INSERT [help_tableof_contents] VALUES(17,'Modify Action',NULL,NULL,14,12,4,75,0,'May 28 2004 10:25:54:413AM',0,'May 28 2004 10:25:54:413AM',1)
INSERT [help_tableof_contents] VALUES(18,'Re-assignments',NULL,NULL,2,12,3,80,0,'May 28 2004 10:25:54:423AM',0,'May 28 2004 10:25:54:423AM',1)
INSERT [help_tableof_contents] VALUES(19,'My Settings',NULL,NULL,2,12,3,85,0,'May 28 2004 10:25:54:433AM',0,'May 28 2004 10:25:54:433AM',1)
INSERT [help_tableof_contents] VALUES(20,'Personal Information',NULL,NULL,19,12,4,90,0,'May 28 2004 10:25:54:443AM',0,'May 28 2004 10:25:54:443AM',1)
INSERT [help_tableof_contents] VALUES(21,'Location Settings',NULL,NULL,19,12,4,95,0,'May 28 2004 10:25:54:443AM',0,'May 28 2004 10:25:54:443AM',1)
INSERT [help_tableof_contents] VALUES(22,'Update password',NULL,NULL,19,12,4,100,0,'May 28 2004 10:25:54:453AM',0,'May 28 2004 10:25:54:453AM',1)
INSERT [help_tableof_contents] VALUES(23,'Contacts',NULL,NULL,1,2,2,10,0,'May 28 2004 10:25:54:463AM',0,'May 28 2004 10:25:54:463AM',1)
INSERT [help_tableof_contents] VALUES(24,'Add a Contact',NULL,NULL,23,2,3,5,0,'May 28 2004 10:25:54:503AM',0,'May 28 2004 10:25:54:503AM',1)
INSERT [help_tableof_contents] VALUES(25,'Search Contacts',NULL,NULL,23,2,3,10,0,'May 28 2004 10:25:54:503AM',0,'May 28 2004 10:25:54:503AM',1)
INSERT [help_tableof_contents] VALUES(26,'Export Data',NULL,NULL,23,2,3,15,0,'May 28 2004 10:25:54:513AM',0,'May 28 2004 10:25:54:513AM',1)
INSERT [help_tableof_contents] VALUES(27,'Exporting data',NULL,NULL,23,2,3,20,0,'May 28 2004 10:25:54:617AM',0,'May 28 2004 10:25:54:617AM',1)
INSERT [help_tableof_contents] VALUES(28,'Pipeline',NULL,NULL,1,4,2,15,0,'May 28 2004 10:25:54:627AM',0,'May 28 2004 10:25:54:627AM',1)
INSERT [help_tableof_contents] VALUES(29,'Overview',NULL,NULL,28,4,3,5,0,'May 28 2004 10:25:54:637AM',0,'May 28 2004 10:25:54:637AM',1)
INSERT [help_tableof_contents] VALUES(30,'Add a Opportunity',NULL,NULL,28,4,3,10,0,'May 28 2004 10:25:54:637AM',0,'May 28 2004 10:25:54:637AM',1)
INSERT [help_tableof_contents] VALUES(31,'Search Opportunities',NULL,NULL,28,4,3,15,0,'May 28 2004 10:25:54:647AM',0,'May 28 2004 10:25:54:647AM',1)
INSERT [help_tableof_contents] VALUES(32,'Export Data',NULL,NULL,28,4,3,20,0,'May 28 2004 10:25:54:657AM',0,'May 28 2004 10:25:54:657AM',1)
INSERT [help_tableof_contents] VALUES(33,'Accounts',NULL,NULL,1,1,2,20,0,'May 28 2004 10:25:54:657AM',0,'May 28 2004 10:25:54:657AM',1)
INSERT [help_tableof_contents] VALUES(34,'Overview',NULL,NULL,33,1,3,5,0,'May 28 2004 10:25:54:667AM',0,'May 28 2004 10:25:54:667AM',1)
INSERT [help_tableof_contents] VALUES(35,'Add an Account',NULL,NULL,33,1,3,10,0,'May 28 2004 10:25:54:677AM',0,'May 28 2004 10:25:54:677AM',1)
INSERT [help_tableof_contents] VALUES(36,'Modify Account',NULL,NULL,33,1,3,15,0,'May 28 2004 10:25:54:687AM',0,'May 28 2004 10:25:54:687AM',1)
INSERT [help_tableof_contents] VALUES(37,'Contact Details',NULL,NULL,36,1,4,20,0,'May 28 2004 10:25:54:697AM',0,'May 28 2004 10:25:54:697AM',1)
INSERT [help_tableof_contents] VALUES(38,'Folder Record Details',NULL,NULL,36,1,4,25,0,'May 28 2004 10:25:54:697AM',0,'May 28 2004 10:25:54:697AM',1)
INSERT [help_tableof_contents] VALUES(39,'Opportunity Details',NULL,NULL,36,1,4,30,0,'May 28 2004 10:25:54:707AM',0,'May 28 2004 10:25:54:707AM',1)
INSERT [help_tableof_contents] VALUES(40,'Revenue Details',NULL,NULL,36,1,4,35,0,'May 28 2004 10:25:54:717AM',0,'May 28 2004 10:25:54:717AM',1)
INSERT [help_tableof_contents] VALUES(41,'Revenue Details',NULL,NULL,40,1,5,40,0,'May 28 2004 10:25:54:727AM',0,'May 28 2004 10:25:54:727AM',1)
INSERT [help_tableof_contents] VALUES(42,'Add Revenue',NULL,NULL,40,1,5,45,0,'May 28 2004 10:25:54:737AM',0,'May 28 2004 10:25:54:737AM',1)
INSERT [help_tableof_contents] VALUES(43,'Modify Revenue',NULL,NULL,40,1,5,50,0,'May 28 2004 10:25:54:737AM',0,'May 28 2004 10:25:54:737AM',1)
INSERT [help_tableof_contents] VALUES(44,'Ticket Details',NULL,NULL,36,1,4,55,0,'May 28 2004 10:25:54:747AM',0,'May 28 2004 10:25:54:747AM',1)
INSERT [help_tableof_contents] VALUES(45,'Document Details',NULL,NULL,36,1,4,60,0,'May 28 2004 10:25:54:757AM',0,'May 28 2004 10:25:54:757AM',1)
INSERT [help_tableof_contents] VALUES(46,'Search Accounts',NULL,NULL,33,1,3,65,0,'May 28 2004 10:25:54:757AM',0,'May 28 2004 10:25:54:757AM',1)
INSERT [help_tableof_contents] VALUES(47,'Account Details',NULL,NULL,33,1,3,70,0,'May 28 2004 10:25:54:767AM',0,'May 28 2004 10:25:54:767AM',1)
INSERT [help_tableof_contents] VALUES(48,'Revenue Dashboard',NULL,NULL,33,1,3,75,0,'May 28 2004 10:25:54:787AM',0,'May 28 2004 10:25:54:787AM',1)
INSERT [help_tableof_contents] VALUES(49,'Export Data',NULL,NULL,33,1,3,80,0,'May 28 2004 10:25:54:787AM',0,'May 28 2004 10:25:54:787AM',1)
INSERT [help_tableof_contents] VALUES(50,'Communications',NULL,NULL,1,6,2,25,0,'May 28 2004 10:25:54:797AM',0,'May 28 2004 10:25:54:797AM',1)
INSERT [help_tableof_contents] VALUES(51,'Communications Dashboard',NULL,NULL,50,6,3,5,0,'May 28 2004 10:25:54:797AM',0,'May 28 2004 10:25:54:797AM',1)
INSERT [help_tableof_contents] VALUES(52,'Add a campaign',NULL,NULL,50,6,3,10,0,'May 28 2004 10:25:54:807AM',0,'May 28 2004 10:25:54:807AM',1)
INSERT [help_tableof_contents] VALUES(53,'Campaign List',NULL,NULL,50,6,3,15,0,'May 28 2004 10:25:54:907AM',0,'May 28 2004 10:25:54:907AM',1)
INSERT [help_tableof_contents] VALUES(54,'View Groups',NULL,NULL,50,6,3,20,0,'May 28 2004 10:25:54:917AM',0,'May 28 2004 10:25:54:917AM',1)
INSERT [help_tableof_contents] VALUES(55,'Add a Group',NULL,NULL,50,6,3,25,0,'May 28 2004 10:25:54:927AM',0,'May 28 2004 10:25:54:927AM',1)
INSERT [help_tableof_contents] VALUES(56,'Message List',NULL,NULL,50,6,3,30,0,'May 28 2004 10:25:54:937AM',0,'May 28 2004 10:25:54:937AM',1)
INSERT [help_tableof_contents] VALUES(57,'Adding a Message',NULL,NULL,50,6,3,35,0,'May 28 2004 10:25:54:947AM',0,'May 28 2004 10:25:54:947AM',1)
INSERT [help_tableof_contents] VALUES(58,'Create Attachments',NULL,NULL,50,6,3,40,0,'May 28 2004 10:25:54:987AM',0,'May 28 2004 10:25:54:987AM',1)
INSERT [help_tableof_contents] VALUES(59,'Help Desk',NULL,NULL,1,8,2,30,0,'May 28 2004 10:25:54:997AM',0,'May 28 2004 10:25:54:997AM',1)
INSERT [help_tableof_contents] VALUES(60,'Ticket Details',NULL,NULL,59,8,3,5,0,'May 28 2004 10:25:55:007AM',0,'May 28 2004 10:25:55:007AM',1)
INSERT [help_tableof_contents] VALUES(61,'Add a Ticket',NULL,NULL,59,8,3,10,0,'May 28 2004 10:25:55:017AM',0,'May 28 2004 10:25:55:017AM',1)
INSERT [help_tableof_contents] VALUES(62,'Search Existing Tickets',NULL,NULL,59,8,3,15,0,'May 28 2004 10:25:55:017AM',0,'May 28 2004 10:25:55:017AM',1)
INSERT [help_tableof_contents] VALUES(63,'Export Data',NULL,NULL,59,8,3,20,0,'May 28 2004 10:25:55:027AM',0,'May 28 2004 10:25:55:027AM',1)
INSERT [help_tableof_contents] VALUES(64,'Modify Ticket Details',NULL,NULL,59,8,3,25,0,'May 28 2004 10:25:55:037AM',0,'May 28 2004 10:25:55:037AM',1)
INSERT [help_tableof_contents] VALUES(65,'Modify Ticket Details',NULL,NULL,64,8,4,30,0,'May 28 2004 10:25:55:037AM',0,'May 28 2004 10:25:55:037AM',1)
INSERT [help_tableof_contents] VALUES(66,'List of Tasks',NULL,NULL,64,8,4,35,0,'May 28 2004 10:25:55:047AM',0,'May 28 2004 10:25:55:047AM',1)
INSERT [help_tableof_contents] VALUES(67,'List of Documents',NULL,NULL,64,8,4,40,0,'May 28 2004 10:25:55:057AM',0,'May 28 2004 10:25:55:057AM',1)
INSERT [help_tableof_contents] VALUES(68,'List of Folder Records',NULL,NULL,64,8,4,45,0,'May 28 2004 10:25:55:067AM',0,'May 28 2004 10:25:55:067AM',1)
INSERT [help_tableof_contents] VALUES(69,'Add Folder Record',NULL,NULL,64,8,4,50,0,'May 28 2004 10:25:55:077AM',0,'May 28 2004 10:25:55:077AM',1)
INSERT [help_tableof_contents] VALUES(70,'Ticket Log History',NULL,NULL,64,8,4,55,0,'May 28 2004 10:25:55:077AM',0,'May 28 2004 10:25:55:077AM',1)
INSERT [help_tableof_contents] VALUES(71,'Employees',NULL,NULL,1,21,2,35,0,'May 28 2004 10:25:55:087AM',0,'May 28 2004 10:25:55:087AM',1)
INSERT [help_tableof_contents] VALUES(72,'Overview',NULL,NULL,71,21,3,5,0,'May 28 2004 10:25:55:087AM',0,'May 28 2004 10:25:55:087AM',1)
INSERT [help_tableof_contents] VALUES(73,'Employee Details',NULL,NULL,71,21,3,10,0,'May 28 2004 10:25:55:107AM',0,'May 28 2004 10:25:55:107AM',1)
INSERT [help_tableof_contents] VALUES(74,'Add an Employee',NULL,NULL,71,21,3,15,0,'May 28 2004 10:25:55:107AM',0,'May 28 2004 10:25:55:107AM',1)
INSERT [help_tableof_contents] VALUES(75,'Modify Employee Details',NULL,NULL,71,21,3,20,0,'May 28 2004 10:25:55:117AM',0,'May 28 2004 10:25:55:117AM',1)
INSERT [help_tableof_contents] VALUES(76,'Reports',NULL,NULL,1,14,2,40,0,'May 28 2004 10:25:55:127AM',0,'May 28 2004 10:25:55:127AM',1)
INSERT [help_tableof_contents] VALUES(77,'Overview',NULL,NULL,76,14,3,5,0,'May 28 2004 10:25:55:127AM',0,'May 28 2004 10:25:55:127AM',1)
INSERT [help_tableof_contents] VALUES(78,'List of Modules',NULL,NULL,76,14,3,10,0,'May 28 2004 10:25:55:137AM',0,'May 28 2004 10:25:55:137AM',1)
INSERT [help_tableof_contents] VALUES(79,'Admin',NULL,NULL,1,9,2,45,0,'May 28 2004 10:25:55:147AM',0,'May 28 2004 10:25:55:147AM',1)
INSERT [help_tableof_contents] VALUES(80,'List of Users',NULL,NULL,79,9,3,5,0,'May 28 2004 10:25:55:247AM',0,'May 28 2004 10:25:55:247AM',1)
INSERT [help_tableof_contents] VALUES(81,'Adding a New User',NULL,NULL,80,9,4,10,0,'May 28 2004 10:25:55:247AM',0,'May 28 2004 10:25:55:247AM',1)
INSERT [help_tableof_contents] VALUES(82,'Modify User Details',NULL,NULL,80,9,4,15,0,'May 28 2004 10:25:55:257AM',0,'May 28 2004 10:25:55:257AM',1)
INSERT [help_tableof_contents] VALUES(83,'User Login History',NULL,NULL,80,9,4,20,0,'May 28 2004 10:25:55:267AM',0,'May 28 2004 10:25:55:267AM',1)
INSERT [help_tableof_contents] VALUES(84,'Viewpoints of User',NULL,NULL,80,9,4,25,0,'May 28 2004 10:25:55:267AM',0,'May 28 2004 10:25:55:267AM',1)
INSERT [help_tableof_contents] VALUES(85,'Add Viewpoint',NULL,NULL,84,9,5,30,0,'May 28 2004 10:25:55:277AM',0,'May 28 2004 10:25:55:277AM',1)
INSERT [help_tableof_contents] VALUES(86,'Update Viewpoint',NULL,NULL,84,9,5,35,0,'May 28 2004 10:25:55:287AM',0,'May 28 2004 10:25:55:287AM',1)
INSERT [help_tableof_contents] VALUES(87,'List of Roles',NULL,NULL,79,9,3,40,0,'May 28 2004 10:25:55:297AM',0,'May 28 2004 10:25:55:297AM',1)
INSERT [help_tableof_contents] VALUES(88,'Add a New Role',NULL,NULL,87,9,4,45,0,'May 28 2004 10:25:55:307AM',0,'May 28 2004 10:25:55:307AM',1)
INSERT [help_tableof_contents] VALUES(89,'Update Role',NULL,NULL,87,9,4,50,0,'May 28 2004 10:25:55:307AM',0,'May 28 2004 10:25:55:307AM',1)
INSERT [help_tableof_contents] VALUES(90,'Configure Modules',NULL,NULL,79,9,3,55,0,'May 28 2004 10:25:55:317AM',0,'May 28 2004 10:25:55:317AM',1)
INSERT [help_tableof_contents] VALUES(91,'Configuration Options',NULL,NULL,90,9,4,60,0,'May 28 2004 10:25:55:327AM',0,'May 28 2004 10:25:55:327AM',1)
INSERT [help_tableof_contents] VALUES(92,'Edit Lookup List',NULL,NULL,91,9,5,65,0,'May 28 2004 10:25:55:327AM',0,'May 28 2004 10:25:55:327AM',1)
INSERT [help_tableof_contents] VALUES(93,'Adding a New Folder',NULL,NULL,91,9,5,70,0,'May 28 2004 10:25:55:337AM',0,'May 28 2004 10:25:55:337AM',1)
INSERT [help_tableof_contents] VALUES(94,'Modify Existing Folder',NULL,NULL,91,9,5,75,0,'May 28 2004 10:25:55:347AM',0,'May 28 2004 10:25:55:347AM',1)
INSERT [help_tableof_contents] VALUES(95,'Configure System',NULL,NULL,79,9,3,80,0,'May 28 2004 10:25:55:357AM',0,'May 28 2004 10:25:55:357AM',1)
INSERT [help_tableof_contents] VALUES(96,'Modify Timeout',NULL,NULL,95,9,4,85,0,'May 28 2004 10:25:55:357AM',0,'May 28 2004 10:25:55:357AM',1)
INSERT [help_tableof_contents] VALUES(97,'Resource Usage Details',NULL,NULL,79,9,3,90,0,'May 28 2004 10:25:55:367AM',0,'May 28 2004 10:25:55:367AM',1)

SET IDENTITY_INSERT [help_tableof_contents] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_industry
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_industry] ON
GO
INSERT [lookup_industry] VALUES(1,NULL,'Automotive',0,0,1)
INSERT [lookup_industry] VALUES(2,NULL,'Biotechnology',0,0,1)
INSERT [lookup_industry] VALUES(3,NULL,'Broadcasting and Cable',0,0,1)
INSERT [lookup_industry] VALUES(4,NULL,'Computer',0,0,1)
INSERT [lookup_industry] VALUES(5,NULL,'Consulting',0,0,1)
INSERT [lookup_industry] VALUES(6,NULL,'Defense',0,0,1)
INSERT [lookup_industry] VALUES(7,NULL,'Energy',0,0,1)
INSERT [lookup_industry] VALUES(8,NULL,'Financial Services',0,0,1)
INSERT [lookup_industry] VALUES(9,NULL,'Food',0,0,1)
INSERT [lookup_industry] VALUES(10,NULL,'Healthcare',0,0,1)
INSERT [lookup_industry] VALUES(11,NULL,'Hospitality',0,0,1)
INSERT [lookup_industry] VALUES(12,NULL,'Insurance',0,0,1)
INSERT [lookup_industry] VALUES(13,NULL,'Internet',0,0,1)
INSERT [lookup_industry] VALUES(14,NULL,'Law Firms',0,0,1)
INSERT [lookup_industry] VALUES(15,NULL,'Media',0,0,1)
INSERT [lookup_industry] VALUES(16,NULL,'Pharmaceuticals',0,0,1)
INSERT [lookup_industry] VALUES(17,NULL,'Real Estate',0,0,1)
INSERT [lookup_industry] VALUES(18,NULL,'Retail',0,0,1)
INSERT [lookup_industry] VALUES(19,NULL,'Telecommunications',0,0,1)
INSERT [lookup_industry] VALUES(20,NULL,'Transportation',0,0,1)

SET IDENTITY_INSERT [lookup_industry] OFF
GO
SET NOCOUNT OFF
 
-- Insert default ticket_category
SET NOCOUNT ON
SET IDENTITY_INSERT [ticket_category] ON
GO
INSERT [ticket_category] VALUES(1,0,0,'Sales',' ',0,1,1)
INSERT [ticket_category] VALUES(2,0,0,'Billing',' ',0,2,1)
INSERT [ticket_category] VALUES(3,0,0,'Technical',' ',0,3,1)
INSERT [ticket_category] VALUES(4,0,0,'Order',' ',0,4,1)
INSERT [ticket_category] VALUES(5,0,0,'Other',' ',0,5,1)

SET IDENTITY_INSERT [ticket_category] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_project_status
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_project_status] ON
GO
INSERT [lookup_project_status] VALUES(1,'Not Started',0,1,1,0,'box.gif',1)
INSERT [lookup_project_status] VALUES(2,'In Progress',0,2,1,0,'box.gif',2)
INSERT [lookup_project_status] VALUES(3,'On Hold',0,5,1,0,'box-hold.gif',5)
INSERT [lookup_project_status] VALUES(4,'Waiting on Reqs',0,6,1,0,'box-hold.gif',5)
INSERT [lookup_project_status] VALUES(5,'Complete',0,3,1,0,'box-checked.gif',3)
INSERT [lookup_project_status] VALUES(6,'Closed',0,4,1,0,'box-checked.gif',4)

SET IDENTITY_INSERT [lookup_project_status] OFF
GO
SET NOCOUNT OFF
 
-- Insert default autoguide_options
SET NOCOUNT ON
SET IDENTITY_INSERT [autoguide_options] ON
GO
INSERT [autoguide_options] VALUES(1,'A/T',0,10,0,'May 28 2004 10:25:34:547AM','May 28 2004 10:25:34:547AM')
INSERT [autoguide_options] VALUES(2,'4-CYL',0,20,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(3,'6-CYL',0,30,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(4,'V-8',0,40,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(5,'CRUISE',0,50,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(6,'5-SPD',0,60,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(7,'4X4',0,70,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(8,'2-DOOR',0,80,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(9,'4-DOOR',0,90,0,'May 28 2004 10:25:34:557AM','May 28 2004 10:25:34:557AM')
INSERT [autoguide_options] VALUES(10,'LEATHER',0,100,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(11,'P/DL',0,110,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(12,'T/W',0,120,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(13,'P/SEATS',0,130,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(14,'P/WIND',0,140,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(15,'P/S',0,150,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(16,'BEDLINE',0,160,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(17,'LOW MILES',0,170,0,'May 28 2004 10:25:34:567AM','May 28 2004 10:25:34:567AM')
INSERT [autoguide_options] VALUES(18,'EX CLEAN',0,180,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(19,'LOADED',0,190,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(20,'A/C',0,200,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(21,'SUNROOF',0,210,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(22,'AM/FM ST',0,220,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(23,'CASS',0,225,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(24,'CD PLYR',0,230,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(25,'ABS',0,240,0,'May 28 2004 10:25:34:577AM','May 28 2004 10:25:34:577AM')
INSERT [autoguide_options] VALUES(26,'ALARM',0,250,0,'May 28 2004 10:25:34:587AM','May 28 2004 10:25:34:587AM')
INSERT [autoguide_options] VALUES(27,'SLD R. WIN',0,260,0,'May 28 2004 10:25:34:587AM','May 28 2004 10:25:34:587AM')
INSERT [autoguide_options] VALUES(28,'AIRBAG',0,270,0,'May 28 2004 10:25:34:587AM','May 28 2004 10:25:34:587AM')
INSERT [autoguide_options] VALUES(29,'1 OWNER',0,280,0,'May 28 2004 10:25:34:587AM','May 28 2004 10:25:34:587AM')
INSERT [autoguide_options] VALUES(30,'ALLOY WH',0,290,0,'May 28 2004 10:25:34:587AM','May 28 2004 10:25:34:587AM')

SET IDENTITY_INSERT [autoguide_options] OFF
GO
SET NOCOUNT OFF
 
-- Insert default report
SET NOCOUNT ON
SET IDENTITY_INSERT [report] ON
GO
INSERT [report] VALUES(1,1,NULL,'accounts_type.xml',1,'Accounts by Type','What are my accounts by type?','May 28 2004 10:25:37:730AM',0,'May 28 2004 10:25:37:730AM',0,1,0)
INSERT [report] VALUES(2,1,NULL,'accounts_recent.xml',1,'Accounts by Date Added','What are my recent accounts?','May 28 2004 10:25:37:740AM',0,'May 28 2004 10:25:37:740AM',0,1,0)
INSERT [report] VALUES(3,1,NULL,'accounts_expire.xml',1,'Accounts by Contract End Date','Which accounts are expiring?','May 28 2004 10:25:37:740AM',0,'May 28 2004 10:25:37:740AM',0,1,0)
INSERT [report] VALUES(4,1,NULL,'accounts_current.xml',1,'Current Accounts','What are my current accounts?','May 28 2004 10:25:37:750AM',0,'May 28 2004 10:25:37:750AM',0,1,0)
INSERT [report] VALUES(5,1,NULL,'accounts_contacts.xml',1,'Account Contacts','Who are the contacts in each account?','May 28 2004 10:25:37:760AM',0,'May 28 2004 10:25:37:760AM',0,1,0)
INSERT [report] VALUES(6,1,NULL,'folder_accounts.xml',1,'Account Folders','What is the folder data for each account?','May 28 2004 10:25:37:760AM',0,'May 28 2004 10:25:37:760AM',0,1,0)
INSERT [report] VALUES(7,2,NULL,'contacts_user.xml',1,'Contacts','Who are my contacts?','May 28 2004 10:25:37:870AM',0,'May 28 2004 10:25:37:870AM',0,1,0)
INSERT [report] VALUES(8,4,NULL,'opportunity_pipeline.xml',1,'Opportunities by Stage','What are my upcoming opportunities by stage?','May 28 2004 10:25:38:070AM',0,'May 28 2004 10:25:38:070AM',0,1,0)
INSERT [report] VALUES(9,4,NULL,'opportunity_account.xml',1,'Opportunities by Account','What are all the accounts associated with my opportunities?','May 28 2004 10:25:38:070AM',0,'May 28 2004 10:25:38:070AM',0,1,0)
INSERT [report] VALUES(10,4,NULL,'opportunity_owner.xml',1,'Opportunities by Owner','What are all the opportunities based on ownership?','May 28 2004 10:25:38:080AM',0,'May 28 2004 10:25:38:080AM',0,1,0)
INSERT [report] VALUES(11,4,NULL,'opportunity_contact.xml',1,'Opportunity Contacts','Who are the contacts of my opportunities?','May 28 2004 10:25:38:080AM',0,'May 28 2004 10:25:38:080AM',0,1,0)
INSERT [report] VALUES(12,6,NULL,'campaign.xml',1,'Campaigns by date','What are my active campaigns?','May 28 2004 10:25:38:190AM',0,'May 28 2004 10:25:38:190AM',0,1,0)
INSERT [report] VALUES(13,8,NULL,'tickets_department.xml',1,'Tickets by Department','What tickets are there in each department?','May 28 2004 10:25:38:450AM',0,'May 28 2004 10:25:38:450AM',0,1,0)
INSERT [report] VALUES(14,8,NULL,'ticket_summary_date.xml',1,'Ticket counts by Department','How many tickets are there in the system on a particular date?','May 28 2004 10:25:38:450AM',0,'May 28 2004 10:25:38:450AM',0,1,0)
INSERT [report] VALUES(15,8,NULL,'ticket_summary_range.xml',1,'Ticket activity by Department','How many tickets exist within a date range?','May 28 2004 10:25:38:450AM',0,'May 28 2004 10:25:38:450AM',0,1,0)
INSERT [report] VALUES(16,8,NULL,'open_calls_report.xml',1,'Open Calls','Which tickets are open?','May 28 2004 10:25:38:460AM',0,'May 28 2004 10:25:38:460AM',0,1,0)
INSERT [report] VALUES(17,8,NULL,'contract_review_report.xml',1,'Contract Review','What is the expiration date for each contract?','May 28 2004 10:25:38:460AM',0,'May 28 2004 10:25:38:460AM',0,1,0)
INSERT [report] VALUES(18,8,NULL,'call_history_report.xml',1,'Call History','How have tickets been resolved?','May 28 2004 10:25:38:470AM',0,'May 28 2004 10:25:38:470AM',0,1,0)
INSERT [report] VALUES(19,8,NULL,'assets_under_contract_report.xml',1,'Assets Under Contract','Which assets are covered by contracts?','May 28 2004 10:25:38:470AM',0,'May 28 2004 10:25:38:470AM',0,1,0)
INSERT [report] VALUES(20,8,NULL,'activity_log_report.xml',1,'Contract Activity Summary','What is the hourly summary for each contract?','May 28 2004 10:25:38:470AM',0,'May 28 2004 10:25:38:470AM',0,1,0)
INSERT [report] VALUES(21,8,NULL,'callvolume_day_assignee.xml',1,'Call Volume by Assignee per Day','How many tickets are there by assignee per day?','May 28 2004 10:25:38:480AM',0,'May 28 2004 10:25:38:480AM',0,1,0)
INSERT [report] VALUES(22,8,NULL,'callvolume_month_assignee.xml',1,'Call Volume by Assignee per Month','How many tickets are there by assignee per month?','May 28 2004 10:25:38:480AM',0,'May 28 2004 10:25:38:480AM',0,1,0)
INSERT [report] VALUES(23,8,NULL,'callvolume_day_cat.xml',1,'Call Volume by Category per Day','How many tickets are there by category per day?','May 28 2004 10:25:38:480AM',0,'May 28 2004 10:25:38:480AM',0,1,0)
INSERT [report] VALUES(24,8,NULL,'callvolume_month_cat.xml',1,'Call Volume by Category per Month','How many tickets are there by category per month?','May 28 2004 10:25:38:480AM',0,'May 28 2004 10:25:38:480AM',0,1,0)
INSERT [report] VALUES(25,8,NULL,'callvolume_day_enteredby.xml',1,'Call Volume by User Entered per Day','How many tickets are there by user who entered the ticket per day?','May 28 2004 10:25:38:490AM',0,'May 28 2004 10:25:38:490AM',0,1,0)
INSERT [report] VALUES(26,8,NULL,'callvolume_month_ent.xml',1,'Call Volume by User Entered per Month','How many tickets are there by user who entered the ticket per month?','May 28 2004 10:25:38:490AM',0,'May 28 2004 10:25:38:490AM',0,1,0)
INSERT [report] VALUES(27,9,NULL,'users.xml',1,'System Users','Who are all the users of the system?','May 28 2004 10:25:38:713AM',0,'May 28 2004 10:25:38:713AM',0,1,0)
INSERT [report] VALUES(28,12,NULL,'task_date.xml',1,'Task list by due date','What are the tasks due withing a date range?','May 28 2004 10:25:38:893AM',0,'May 28 2004 10:25:38:893AM',0,1,0)
INSERT [report] VALUES(29,12,NULL,'task_nodate.xml',1,'Task list','What are all the tasks in the system?','May 28 2004 10:25:38:893AM',0,'May 28 2004 10:25:38:893AM',0,1,0)
INSERT [report] VALUES(30,21,NULL,'employees.xml',1,'Employees','Who are the employees in my organization?','May 28 2004 10:25:39:243AM',0,'May 28 2004 10:25:39:243AM',0,1,0)

SET IDENTITY_INSERT [report] OFF
GO
SET NOCOUNT OFF
 
-- Insert default help_tableofcontentitem_links
SET NOCOUNT ON
SET IDENTITY_INSERT [help_tableofcontentitem_links] ON
GO
INSERT [help_tableofcontentitem_links] VALUES(1,3,1,0,'May 28 2004 10:25:54:303AM',0,'May 28 2004 10:25:54:303AM',1)
INSERT [help_tableofcontentitem_links] VALUES(2,4,2,0,'May 28 2004 10:25:54:313AM',0,'May 28 2004 10:25:54:313AM',1)
INSERT [help_tableofcontentitem_links] VALUES(3,5,3,0,'May 28 2004 10:25:54:323AM',0,'May 28 2004 10:25:54:323AM',1)
INSERT [help_tableofcontentitem_links] VALUES(4,6,4,0,'May 28 2004 10:25:54:333AM',0,'May 28 2004 10:25:54:333AM',1)
INSERT [help_tableofcontentitem_links] VALUES(5,7,5,0,'May 28 2004 10:25:54:343AM',0,'May 28 2004 10:25:54:343AM',1)
INSERT [help_tableofcontentitem_links] VALUES(6,8,6,0,'May 28 2004 10:25:54:353AM',0,'May 28 2004 10:25:54:353AM',1)
INSERT [help_tableofcontentitem_links] VALUES(7,9,7,0,'May 28 2004 10:25:54:353AM',0,'May 28 2004 10:25:54:353AM',1)
INSERT [help_tableofcontentitem_links] VALUES(8,10,8,0,'May 28 2004 10:25:54:363AM',0,'May 28 2004 10:25:54:363AM',1)
INSERT [help_tableofcontentitem_links] VALUES(9,11,9,0,'May 28 2004 10:25:54:373AM',0,'May 28 2004 10:25:54:373AM',1)
INSERT [help_tableofcontentitem_links] VALUES(10,12,10,0,'May 28 2004 10:25:54:383AM',0,'May 28 2004 10:25:54:383AM',1)
INSERT [help_tableofcontentitem_links] VALUES(11,13,11,0,'May 28 2004 10:25:54:393AM',0,'May 28 2004 10:25:54:393AM',1)
INSERT [help_tableofcontentitem_links] VALUES(12,14,12,0,'May 28 2004 10:25:54:403AM',0,'May 28 2004 10:25:54:403AM',1)
INSERT [help_tableofcontentitem_links] VALUES(13,15,13,0,'May 28 2004 10:25:54:403AM',0,'May 28 2004 10:25:54:403AM',1)
INSERT [help_tableofcontentitem_links] VALUES(14,16,14,0,'May 28 2004 10:25:54:413AM',0,'May 28 2004 10:25:54:413AM',1)
INSERT [help_tableofcontentitem_links] VALUES(15,17,15,0,'May 28 2004 10:25:54:423AM',0,'May 28 2004 10:25:54:423AM',1)
INSERT [help_tableofcontentitem_links] VALUES(16,18,16,0,'May 28 2004 10:25:54:423AM',0,'May 28 2004 10:25:54:423AM',1)
INSERT [help_tableofcontentitem_links] VALUES(17,19,17,0,'May 28 2004 10:25:54:433AM',0,'May 28 2004 10:25:54:433AM',1)
INSERT [help_tableofcontentitem_links] VALUES(18,20,18,0,'May 28 2004 10:25:54:443AM',0,'May 28 2004 10:25:54:443AM',1)
INSERT [help_tableofcontentitem_links] VALUES(19,21,19,0,'May 28 2004 10:25:54:453AM',0,'May 28 2004 10:25:54:453AM',1)
INSERT [help_tableofcontentitem_links] VALUES(20,22,20,0,'May 28 2004 10:25:54:463AM',0,'May 28 2004 10:25:54:463AM',1)
INSERT [help_tableofcontentitem_links] VALUES(21,24,34,0,'May 28 2004 10:25:54:503AM',0,'May 28 2004 10:25:54:503AM',1)
INSERT [help_tableofcontentitem_links] VALUES(22,25,35,0,'May 28 2004 10:25:54:513AM',0,'May 28 2004 10:25:54:513AM',1)
INSERT [help_tableofcontentitem_links] VALUES(23,26,36,0,'May 28 2004 10:25:54:523AM',0,'May 28 2004 10:25:54:523AM',1)
INSERT [help_tableofcontentitem_links] VALUES(24,27,37,0,'May 28 2004 10:25:54:627AM',0,'May 28 2004 10:25:54:627AM',1)
INSERT [help_tableofcontentitem_links] VALUES(25,29,79,0,'May 28 2004 10:25:54:637AM',0,'May 28 2004 10:25:54:637AM',1)
INSERT [help_tableofcontentitem_links] VALUES(26,30,80,0,'May 28 2004 10:25:54:647AM',0,'May 28 2004 10:25:54:647AM',1)
INSERT [help_tableofcontentitem_links] VALUES(27,31,81,0,'May 28 2004 10:25:54:657AM',0,'May 28 2004 10:25:54:657AM',1)
INSERT [help_tableofcontentitem_links] VALUES(28,32,82,0,'May 28 2004 10:25:54:657AM',0,'May 28 2004 10:25:54:657AM',1)
INSERT [help_tableofcontentitem_links] VALUES(29,34,112,0,'May 28 2004 10:25:54:677AM',0,'May 28 2004 10:25:54:677AM',1)
INSERT [help_tableofcontentitem_links] VALUES(30,35,113,0,'May 28 2004 10:25:54:687AM',0,'May 28 2004 10:25:54:687AM',1)
INSERT [help_tableofcontentitem_links] VALUES(31,36,114,0,'May 28 2004 10:25:54:687AM',0,'May 28 2004 10:25:54:687AM',1)
INSERT [help_tableofcontentitem_links] VALUES(32,37,115,0,'May 28 2004 10:25:54:697AM',0,'May 28 2004 10:25:54:697AM',1)
INSERT [help_tableofcontentitem_links] VALUES(33,38,116,0,'May 28 2004 10:25:54:707AM',0,'May 28 2004 10:25:54:707AM',1)
INSERT [help_tableofcontentitem_links] VALUES(34,39,117,0,'May 28 2004 10:25:54:707AM',0,'May 28 2004 10:25:54:707AM',1)
INSERT [help_tableofcontentitem_links] VALUES(35,40,118,0,'May 28 2004 10:25:54:727AM',0,'May 28 2004 10:25:54:727AM',1)
INSERT [help_tableofcontentitem_links] VALUES(36,41,119,0,'May 28 2004 10:25:54:727AM',0,'May 28 2004 10:25:54:727AM',1)
INSERT [help_tableofcontentitem_links] VALUES(37,42,120,0,'May 28 2004 10:25:54:737AM',0,'May 28 2004 10:25:54:737AM',1)
INSERT [help_tableofcontentitem_links] VALUES(38,43,121,0,'May 28 2004 10:25:54:747AM',0,'May 28 2004 10:25:54:747AM',1)
INSERT [help_tableofcontentitem_links] VALUES(39,44,122,0,'May 28 2004 10:25:54:747AM',0,'May 28 2004 10:25:54:747AM',1)
INSERT [help_tableofcontentitem_links] VALUES(40,45,123,0,'May 28 2004 10:25:54:757AM',0,'May 28 2004 10:25:54:757AM',1)
INSERT [help_tableofcontentitem_links] VALUES(41,46,124,0,'May 28 2004 10:25:54:767AM',0,'May 28 2004 10:25:54:767AM',1)
INSERT [help_tableofcontentitem_links] VALUES(42,47,125,0,'May 28 2004 10:25:54:777AM',0,'May 28 2004 10:25:54:777AM',1)
INSERT [help_tableofcontentitem_links] VALUES(43,48,126,0,'May 28 2004 10:25:54:787AM',0,'May 28 2004 10:25:54:787AM',1)
INSERT [help_tableofcontentitem_links] VALUES(44,49,127,0,'May 28 2004 10:25:54:797AM',0,'May 28 2004 10:25:54:797AM',1)
INSERT [help_tableofcontentitem_links] VALUES(45,51,190,0,'May 28 2004 10:25:54:807AM',0,'May 28 2004 10:25:54:807AM',1)
INSERT [help_tableofcontentitem_links] VALUES(46,52,191,0,'May 28 2004 10:25:54:817AM',0,'May 28 2004 10:25:54:817AM',1)
INSERT [help_tableofcontentitem_links] VALUES(47,53,192,0,'May 28 2004 10:25:54:917AM',0,'May 28 2004 10:25:54:917AM',1)
INSERT [help_tableofcontentitem_links] VALUES(48,54,193,0,'May 28 2004 10:25:54:917AM',0,'May 28 2004 10:25:54:917AM',1)
INSERT [help_tableofcontentitem_links] VALUES(49,55,194,0,'May 28 2004 10:25:54:927AM',0,'May 28 2004 10:25:54:927AM',1)
INSERT [help_tableofcontentitem_links] VALUES(50,56,195,0,'May 28 2004 10:25:54:937AM',0,'May 28 2004 10:25:54:937AM',1)
INSERT [help_tableofcontentitem_links] VALUES(51,57,196,0,'May 28 2004 10:25:54:987AM',0,'May 28 2004 10:25:54:987AM',1)
INSERT [help_tableofcontentitem_links] VALUES(52,58,197,0,'May 28 2004 10:25:54:997AM',0,'May 28 2004 10:25:54:997AM',1)
INSERT [help_tableofcontentitem_links] VALUES(53,60,240,0,'May 28 2004 10:25:55:007AM',0,'May 28 2004 10:25:55:007AM',1)
INSERT [help_tableofcontentitem_links] VALUES(54,61,241,0,'May 28 2004 10:25:55:017AM',0,'May 28 2004 10:25:55:017AM',1)
INSERT [help_tableofcontentitem_links] VALUES(55,62,242,0,'May 28 2004 10:25:55:027AM',0,'May 28 2004 10:25:55:027AM',1)
INSERT [help_tableofcontentitem_links] VALUES(56,63,243,0,'May 28 2004 10:25:55:027AM',0,'May 28 2004 10:25:55:027AM',1)
INSERT [help_tableofcontentitem_links] VALUES(57,64,244,0,'May 28 2004 10:25:55:037AM',0,'May 28 2004 10:25:55:037AM',1)
INSERT [help_tableofcontentitem_links] VALUES(58,65,245,0,'May 28 2004 10:25:55:047AM',0,'May 28 2004 10:25:55:047AM',1)
INSERT [help_tableofcontentitem_links] VALUES(59,66,246,0,'May 28 2004 10:25:55:057AM',0,'May 28 2004 10:25:55:057AM',1)
INSERT [help_tableofcontentitem_links] VALUES(60,67,247,0,'May 28 2004 10:25:55:067AM',0,'May 28 2004 10:25:55:067AM',1)
INSERT [help_tableofcontentitem_links] VALUES(61,68,248,0,'May 28 2004 10:25:55:067AM',0,'May 28 2004 10:25:55:067AM',1)
INSERT [help_tableofcontentitem_links] VALUES(62,69,249,0,'May 28 2004 10:25:55:077AM',0,'May 28 2004 10:25:55:077AM',1)
INSERT [help_tableofcontentitem_links] VALUES(63,70,250,0,'May 28 2004 10:25:55:087AM',0,'May 28 2004 10:25:55:087AM',1)
INSERT [help_tableofcontentitem_links] VALUES(64,72,274,0,'May 28 2004 10:25:55:097AM',0,'May 28 2004 10:25:55:097AM',1)
INSERT [help_tableofcontentitem_links] VALUES(65,73,275,0,'May 28 2004 10:25:55:107AM',0,'May 28 2004 10:25:55:107AM',1)
INSERT [help_tableofcontentitem_links] VALUES(66,74,276,0,'May 28 2004 10:25:55:117AM',0,'May 28 2004 10:25:55:117AM',1)
INSERT [help_tableofcontentitem_links] VALUES(67,75,277,0,'May 28 2004 10:25:55:117AM',0,'May 28 2004 10:25:55:117AM',1)
INSERT [help_tableofcontentitem_links] VALUES(68,77,279,0,'May 28 2004 10:25:55:137AM',0,'May 28 2004 10:25:55:137AM',1)
INSERT [help_tableofcontentitem_links] VALUES(69,78,280,0,'May 28 2004 10:25:55:137AM',0,'May 28 2004 10:25:55:137AM',1)
INSERT [help_tableofcontentitem_links] VALUES(70,80,288,0,'May 28 2004 10:25:55:247AM',0,'May 28 2004 10:25:55:247AM',1)
INSERT [help_tableofcontentitem_links] VALUES(71,81,289,0,'May 28 2004 10:25:55:257AM',0,'May 28 2004 10:25:55:257AM',1)
INSERT [help_tableofcontentitem_links] VALUES(72,82,290,0,'May 28 2004 10:25:55:257AM',0,'May 28 2004 10:25:55:257AM',1)
INSERT [help_tableofcontentitem_links] VALUES(73,83,291,0,'May 28 2004 10:25:55:267AM',0,'May 28 2004 10:25:55:267AM',1)
INSERT [help_tableofcontentitem_links] VALUES(74,84,292,0,'May 28 2004 10:25:55:277AM',0,'May 28 2004 10:25:55:277AM',1)
INSERT [help_tableofcontentitem_links] VALUES(75,85,293,0,'May 28 2004 10:25:55:277AM',0,'May 28 2004 10:25:55:277AM',1)
INSERT [help_tableofcontentitem_links] VALUES(76,86,294,0,'May 28 2004 10:25:55:297AM',0,'May 28 2004 10:25:55:297AM',1)
INSERT [help_tableofcontentitem_links] VALUES(77,87,295,0,'May 28 2004 10:25:55:297AM',0,'May 28 2004 10:25:55:297AM',1)
INSERT [help_tableofcontentitem_links] VALUES(78,88,296,0,'May 28 2004 10:25:55:307AM',0,'May 28 2004 10:25:55:307AM',1)
INSERT [help_tableofcontentitem_links] VALUES(79,89,297,0,'May 28 2004 10:25:55:317AM',0,'May 28 2004 10:25:55:317AM',1)
INSERT [help_tableofcontentitem_links] VALUES(80,90,298,0,'May 28 2004 10:25:55:317AM',0,'May 28 2004 10:25:55:317AM',1)
INSERT [help_tableofcontentitem_links] VALUES(81,91,299,0,'May 28 2004 10:25:55:327AM',0,'May 28 2004 10:25:55:327AM',1)
INSERT [help_tableofcontentitem_links] VALUES(82,92,300,0,'May 28 2004 10:25:55:337AM',0,'May 28 2004 10:25:55:337AM',1)
INSERT [help_tableofcontentitem_links] VALUES(83,93,301,0,'May 28 2004 10:25:55:347AM',0,'May 28 2004 10:25:55:347AM',1)
INSERT [help_tableofcontentitem_links] VALUES(84,94,302,0,'May 28 2004 10:25:55:357AM',0,'May 28 2004 10:25:55:357AM',1)
INSERT [help_tableofcontentitem_links] VALUES(85,95,303,0,'May 28 2004 10:25:55:357AM',0,'May 28 2004 10:25:55:357AM',1)
INSERT [help_tableofcontentitem_links] VALUES(86,96,304,0,'May 28 2004 10:25:55:367AM',0,'May 28 2004 10:25:55:367AM',1)
INSERT [help_tableofcontentitem_links] VALUES(87,97,305,0,'May 28 2004 10:25:55:377AM',0,'May 28 2004 10:25:55:377AM',1)

SET IDENTITY_INSERT [help_tableofcontentitem_links] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_project_loe
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_project_loe] ON
GO
INSERT [lookup_project_loe] VALUES(1,'Minute(s)',60,0,1,1,0)
INSERT [lookup_project_loe] VALUES(2,'Hour(s)',3600,1,1,1,0)
INSERT [lookup_project_loe] VALUES(3,'Day(s)',86400,0,1,1,0)
INSERT [lookup_project_loe] VALUES(4,'Week(s)',604800,0,1,1,0)
INSERT [lookup_project_loe] VALUES(5,'Month(s)',18144000,0,1,1,0)

SET IDENTITY_INSERT [lookup_project_loe] OFF
GO
SET NOCOUNT OFF
 
-- Insert default role_permission
SET NOCOUNT ON
SET IDENTITY_INSERT [role_permission] ON
GO
INSERT [role_permission] VALUES(1,1,72,1,0,0,0)
INSERT [role_permission] VALUES(2,1,73,1,0,0,0)
INSERT [role_permission] VALUES(3,1,74,1,1,0,1)
INSERT [role_permission] VALUES(4,1,75,1,0,0,0)
INSERT [role_permission] VALUES(5,1,76,1,1,1,1)
INSERT [role_permission] VALUES(6,1,78,1,0,0,0)
INSERT [role_permission] VALUES(7,1,79,1,0,1,0)
INSERT [role_permission] VALUES(8,1,80,1,0,1,0)
INSERT [role_permission] VALUES(9,1,81,0,0,1,0)
INSERT [role_permission] VALUES(10,1,77,1,0,1,0)
INSERT [role_permission] VALUES(11,1,26,1,0,0,0)
INSERT [role_permission] VALUES(12,1,27,1,1,1,1)
INSERT [role_permission] VALUES(13,1,1,1,0,0,0)
INSERT [role_permission] VALUES(14,1,2,1,1,1,1)
INSERT [role_permission] VALUES(15,1,3,1,1,1,1)
INSERT [role_permission] VALUES(16,1,4,1,1,1,1)
INSERT [role_permission] VALUES(17,1,5,1,1,1,1)
INSERT [role_permission] VALUES(18,1,6,1,1,1,1)
INSERT [role_permission] VALUES(19,1,7,1,1,1,1)
INSERT [role_permission] VALUES(20,1,8,1,1,1,1)
INSERT [role_permission] VALUES(21,1,9,1,1,1,1)
INSERT [role_permission] VALUES(22,1,10,1,1,1,1)
INSERT [role_permission] VALUES(23,1,11,1,1,1,1)
INSERT [role_permission] VALUES(24,1,12,1,1,1,1)
INSERT [role_permission] VALUES(25,1,13,1,1,1,1)
INSERT [role_permission] VALUES(26,1,14,1,1,0,1)
INSERT [role_permission] VALUES(27,1,18,1,1,1,1)
INSERT [role_permission] VALUES(28,1,19,1,1,1,1)
INSERT [role_permission] VALUES(29,1,20,1,1,1,1)
INSERT [role_permission] VALUES(30,1,21,1,1,1,1)
INSERT [role_permission] VALUES(31,1,22,1,1,1,1)
INSERT [role_permission] VALUES(32,1,43,1,0,0,0)
INSERT [role_permission] VALUES(33,1,44,1,0,0,0)
INSERT [role_permission] VALUES(34,1,45,1,1,1,1)
INSERT [role_permission] VALUES(35,1,46,1,1,1,1)
INSERT [role_permission] VALUES(36,1,47,1,1,1,1)
INSERT [role_permission] VALUES(37,1,48,1,1,1,1)
INSERT [role_permission] VALUES(38,1,53,1,0,0,0)
INSERT [role_permission] VALUES(39,1,54,1,1,1,1)
INSERT [role_permission] VALUES(40,1,55,1,1,1,1)
INSERT [role_permission] VALUES(41,1,56,1,1,1,1)
INSERT [role_permission] VALUES(42,1,57,1,1,1,1)
INSERT [role_permission] VALUES(43,1,58,1,1,1,1)
INSERT [role_permission] VALUES(44,1,90,1,1,1,0)
INSERT [role_permission] VALUES(45,1,91,1,1,1,1)
INSERT [role_permission] VALUES(46,1,84,1,0,0,0)
INSERT [role_permission] VALUES(47,1,59,1,0,0,0)
INSERT [role_permission] VALUES(48,1,60,1,1,1,1)
INSERT [role_permission] VALUES(49,1,61,1,1,1,1)
INSERT [role_permission] VALUES(50,1,63,1,0,1,0)
INSERT [role_permission] VALUES(51,1,62,1,0,0,0)
INSERT [role_permission] VALUES(52,1,64,1,0,1,0)
INSERT [role_permission] VALUES(53,1,65,1,1,1,1)
INSERT [role_permission] VALUES(54,1,66,1,1,1,1)
INSERT [role_permission] VALUES(55,1,67,1,1,1,1)
INSERT [role_permission] VALUES(56,1,68,1,0,0,0)
INSERT [role_permission] VALUES(57,1,69,1,0,0,0)
INSERT [role_permission] VALUES(58,1,70,1,0,0,0)
INSERT [role_permission] VALUES(59,1,71,1,0,0,0)
INSERT [role_permission] VALUES(60,2,72,1,0,0,0)
INSERT [role_permission] VALUES(61,2,73,1,0,0,0)
INSERT [role_permission] VALUES(62,2,75,1,0,0,0)
INSERT [role_permission] VALUES(63,2,76,1,1,1,1)
INSERT [role_permission] VALUES(64,2,77,1,0,1,0)
INSERT [role_permission] VALUES(65,2,78,1,0,0,0)
INSERT [role_permission] VALUES(66,2,79,1,0,1,0)
INSERT [role_permission] VALUES(67,2,80,1,0,1,0)
INSERT [role_permission] VALUES(68,2,81,0,0,1,0)
INSERT [role_permission] VALUES(69,2,82,1,1,1,1)
INSERT [role_permission] VALUES(70,2,26,1,0,0,0)
INSERT [role_permission] VALUES(71,2,27,1,1,1,1)
INSERT [role_permission] VALUES(72,2,28,1,1,0,1)
INSERT [role_permission] VALUES(73,2,29,1,1,1,1)
INSERT [role_permission] VALUES(74,2,30,1,1,1,1)
INSERT [role_permission] VALUES(75,2,31,1,0,0,0)
INSERT [role_permission] VALUES(76,2,32,1,1,1,1)
INSERT [role_permission] VALUES(77,2,36,1,0,0,0)
INSERT [role_permission] VALUES(78,2,37,1,1,1,1)
INSERT [role_permission] VALUES(79,2,38,1,0,0,0)
INSERT [role_permission] VALUES(80,2,39,1,1,0,1)
INSERT [role_permission] VALUES(81,2,40,1,1,1,1)
INSERT [role_permission] VALUES(82,2,41,1,1,1,1)
INSERT [role_permission] VALUES(83,2,1,1,0,0,0)
INSERT [role_permission] VALUES(84,2,2,1,1,1,1)
INSERT [role_permission] VALUES(85,2,3,1,1,1,0)
INSERT [role_permission] VALUES(86,2,4,1,1,1,1)
INSERT [role_permission] VALUES(87,2,5,1,1,1,1)
INSERT [role_permission] VALUES(88,2,6,1,1,1,1)
INSERT [role_permission] VALUES(89,2,7,1,1,1,1)
INSERT [role_permission] VALUES(90,2,8,1,1,1,1)
INSERT [role_permission] VALUES(91,2,9,1,1,1,1)
INSERT [role_permission] VALUES(92,2,13,1,1,1,1)
INSERT [role_permission] VALUES(93,2,14,1,1,0,1)
INSERT [role_permission] VALUES(94,2,16,1,1,1,1)
INSERT [role_permission] VALUES(95,2,12,1,1,1,1)
INSERT [role_permission] VALUES(96,2,11,1,1,1,1)
INSERT [role_permission] VALUES(97,2,10,1,1,1,1)
INSERT [role_permission] VALUES(98,2,18,1,1,1,1)
INSERT [role_permission] VALUES(99,2,19,1,1,1,1)
INSERT [role_permission] VALUES(100,2,20,1,1,1,0)
INSERT [role_permission] VALUES(101,2,21,1,1,1,0)
INSERT [role_permission] VALUES(102,2,43,1,0,0,0)
INSERT [role_permission] VALUES(103,2,44,1,0,0,0)
INSERT [role_permission] VALUES(104,2,45,1,1,1,1)
INSERT [role_permission] VALUES(105,2,46,1,1,1,1)
INSERT [role_permission] VALUES(106,2,47,1,1,1,1)
INSERT [role_permission] VALUES(107,2,48,1,1,1,1)
INSERT [role_permission] VALUES(108,2,53,1,0,0,0)
INSERT [role_permission] VALUES(109,2,54,1,1,1,0)
INSERT [role_permission] VALUES(110,2,55,1,1,1,1)
INSERT [role_permission] VALUES(111,2,56,1,1,1,0)
INSERT [role_permission] VALUES(112,2,57,1,1,1,0)
INSERT [role_permission] VALUES(113,2,58,1,1,1,0)
INSERT [role_permission] VALUES(114,2,90,1,0,0,0)
INSERT [role_permission] VALUES(115,2,91,1,0,0,0)
INSERT [role_permission] VALUES(116,2,84,1,0,0,0)
INSERT [role_permission] VALUES(117,2,68,1,0,0,0)
INSERT [role_permission] VALUES(118,2,69,1,0,0,0)
INSERT [role_permission] VALUES(119,2,70,1,0,0,0)
INSERT [role_permission] VALUES(120,2,71,1,0,0,0)
INSERT [role_permission] VALUES(121,3,72,1,0,0,0)
INSERT [role_permission] VALUES(122,3,73,1,0,0,0)
INSERT [role_permission] VALUES(123,3,75,1,0,0,0)
INSERT [role_permission] VALUES(124,3,76,1,1,1,1)
INSERT [role_permission] VALUES(125,3,77,1,0,1,0)
INSERT [role_permission] VALUES(126,3,78,1,0,0,0)
INSERT [role_permission] VALUES(127,3,79,1,0,1,0)
INSERT [role_permission] VALUES(128,3,80,1,0,1,0)
INSERT [role_permission] VALUES(129,3,81,0,0,1,0)
INSERT [role_permission] VALUES(130,3,82,1,1,1,1)
INSERT [role_permission] VALUES(131,3,26,1,0,0,0)
INSERT [role_permission] VALUES(132,3,27,1,1,1,1)
INSERT [role_permission] VALUES(133,3,28,1,1,0,1)
INSERT [role_permission] VALUES(134,3,29,1,1,1,1)
INSERT [role_permission] VALUES(135,3,30,1,1,1,1)
INSERT [role_permission] VALUES(136,3,31,1,0,0,0)
INSERT [role_permission] VALUES(137,3,32,1,1,1,1)
INSERT [role_permission] VALUES(138,3,36,1,0,0,0)
INSERT [role_permission] VALUES(139,3,37,1,1,1,1)
INSERT [role_permission] VALUES(140,3,38,1,0,0,0)
INSERT [role_permission] VALUES(141,3,39,1,1,0,1)
INSERT [role_permission] VALUES(142,3,40,1,1,1,1)
INSERT [role_permission] VALUES(143,3,41,1,1,1,1)
INSERT [role_permission] VALUES(144,3,1,1,0,0,0)
INSERT [role_permission] VALUES(145,3,2,1,1,1,1)
INSERT [role_permission] VALUES(146,3,3,1,1,1,0)
INSERT [role_permission] VALUES(147,3,4,1,1,1,1)
INSERT [role_permission] VALUES(148,3,5,1,1,1,1)
INSERT [role_permission] VALUES(149,3,6,1,1,1,1)
INSERT [role_permission] VALUES(150,3,7,1,1,1,1)
INSERT [role_permission] VALUES(151,3,8,1,1,1,1)
INSERT [role_permission] VALUES(152,3,9,1,1,1,0)
INSERT [role_permission] VALUES(153,3,13,1,1,1,1)
INSERT [role_permission] VALUES(154,3,14,1,1,0,1)
INSERT [role_permission] VALUES(155,3,15,1,0,0,0)
INSERT [role_permission] VALUES(156,3,16,1,1,1,1)
INSERT [role_permission] VALUES(157,3,12,1,1,1,0)
INSERT [role_permission] VALUES(158,3,11,1,1,1,0)
INSERT [role_permission] VALUES(159,3,10,1,1,1,0)
INSERT [role_permission] VALUES(160,3,18,1,1,1,0)
INSERT [role_permission] VALUES(161,3,19,1,1,1,0)
INSERT [role_permission] VALUES(162,3,20,1,0,0,0)
INSERT [role_permission] VALUES(163,3,21,1,0,0,0)
INSERT [role_permission] VALUES(164,3,43,1,0,0,0)
INSERT [role_permission] VALUES(165,3,44,1,0,0,0)
INSERT [role_permission] VALUES(166,3,45,1,1,1,1)
INSERT [role_permission] VALUES(167,3,46,1,1,1,1)
INSERT [role_permission] VALUES(168,3,47,1,1,1,1)
INSERT [role_permission] VALUES(169,3,48,1,1,1,1)
INSERT [role_permission] VALUES(170,3,53,1,0,0,0)
INSERT [role_permission] VALUES(171,3,54,1,1,1,0)
INSERT [role_permission] VALUES(172,3,55,1,1,1,1)
INSERT [role_permission] VALUES(173,3,56,1,1,1,0)
INSERT [role_permission] VALUES(174,3,57,1,0,0,0)
INSERT [role_permission] VALUES(175,3,58,1,0,0,0)
INSERT [role_permission] VALUES(176,3,90,1,0,0,0)
INSERT [role_permission] VALUES(177,3,91,1,0,0,0)
INSERT [role_permission] VALUES(178,3,84,1,0,0,0)
INSERT [role_permission] VALUES(179,3,68,1,0,0,0)
INSERT [role_permission] VALUES(180,3,69,1,0,0,0)
INSERT [role_permission] VALUES(181,3,70,1,0,0,0)
INSERT [role_permission] VALUES(182,3,71,1,0,0,0)
INSERT [role_permission] VALUES(183,4,72,1,0,0,0)
INSERT [role_permission] VALUES(184,4,73,1,0,0,0)
INSERT [role_permission] VALUES(185,4,75,1,0,0,0)
INSERT [role_permission] VALUES(186,4,76,1,1,1,1)
INSERT [role_permission] VALUES(187,4,78,1,0,0,0)
INSERT [role_permission] VALUES(188,4,79,1,0,1,0)
INSERT [role_permission] VALUES(189,4,80,1,0,1,0)
INSERT [role_permission] VALUES(190,4,81,0,0,1,0)
INSERT [role_permission] VALUES(191,4,82,1,1,1,1)
INSERT [role_permission] VALUES(192,4,26,1,0,0,0)
INSERT [role_permission] VALUES(193,4,27,1,1,1,1)
INSERT [role_permission] VALUES(194,4,28,1,1,0,1)
INSERT [role_permission] VALUES(195,4,30,1,1,1,1)
INSERT [role_permission] VALUES(196,4,31,1,1,1,1)
INSERT [role_permission] VALUES(197,4,32,1,0,0,0)
INSERT [role_permission] VALUES(198,4,36,1,0,0,0)
INSERT [role_permission] VALUES(199,4,37,1,1,1,0)
INSERT [role_permission] VALUES(200,4,38,1,0,0,0)
INSERT [role_permission] VALUES(201,4,39,1,1,0,1)
INSERT [role_permission] VALUES(202,4,40,1,1,1,1)
INSERT [role_permission] VALUES(203,4,41,1,1,1,1)
INSERT [role_permission] VALUES(204,4,1,1,0,0,0)
INSERT [role_permission] VALUES(205,4,2,1,1,1,0)
INSERT [role_permission] VALUES(206,4,3,1,1,1,0)
INSERT [role_permission] VALUES(207,4,4,1,1,1,0)
INSERT [role_permission] VALUES(208,4,5,1,1,1,0)
INSERT [role_permission] VALUES(209,4,6,1,1,1,0)
INSERT [role_permission] VALUES(210,4,7,1,1,1,0)
INSERT [role_permission] VALUES(211,4,8,1,1,1,0)
INSERT [role_permission] VALUES(212,4,9,1,1,1,0)
INSERT [role_permission] VALUES(213,4,13,1,1,1,0)
INSERT [role_permission] VALUES(214,4,14,1,1,0,1)
INSERT [role_permission] VALUES(215,4,15,1,0,0,0)
INSERT [role_permission] VALUES(216,4,16,1,1,1,0)
INSERT [role_permission] VALUES(217,4,12,1,1,1,0)
INSERT [role_permission] VALUES(218,4,11,1,1,1,0)
INSERT [role_permission] VALUES(219,4,10,1,1,1,0)
INSERT [role_permission] VALUES(220,4,18,1,0,0,0)
INSERT [role_permission] VALUES(221,4,19,1,0,0,0)
INSERT [role_permission] VALUES(222,4,20,1,0,0,0)
INSERT [role_permission] VALUES(223,4,21,1,0,0,0)
INSERT [role_permission] VALUES(224,4,43,1,0,0,0)
INSERT [role_permission] VALUES(225,4,44,1,0,0,0)
INSERT [role_permission] VALUES(226,4,45,1,1,1,1)
INSERT [role_permission] VALUES(227,4,46,1,1,1,1)
INSERT [role_permission] VALUES(228,4,47,1,1,1,1)
INSERT [role_permission] VALUES(229,4,48,1,1,1,1)
INSERT [role_permission] VALUES(230,4,53,1,0,0,0)
INSERT [role_permission] VALUES(231,4,54,1,1,1,0)
INSERT [role_permission] VALUES(232,4,55,1,1,0,1)
INSERT [role_permission] VALUES(233,4,56,1,1,1,0)
INSERT [role_permission] VALUES(234,4,57,1,0,0,0)
INSERT [role_permission] VALUES(235,4,58,1,0,0,0)
INSERT [role_permission] VALUES(236,4,90,1,0,0,0)
INSERT [role_permission] VALUES(237,4,91,1,0,0,0)
INSERT [role_permission] VALUES(238,4,84,1,0,0,0)
INSERT [role_permission] VALUES(239,4,68,1,0,0,0)
INSERT [role_permission] VALUES(240,4,69,1,0,0,0)
INSERT [role_permission] VALUES(241,4,70,1,0,0,0)
INSERT [role_permission] VALUES(242,4,71,1,0,0,0)
INSERT [role_permission] VALUES(243,5,72,1,0,0,0)
INSERT [role_permission] VALUES(244,5,73,1,0,0,0)
INSERT [role_permission] VALUES(245,5,75,1,0,0,0)
INSERT [role_permission] VALUES(246,5,76,1,1,1,1)
INSERT [role_permission] VALUES(247,5,77,1,0,1,0)
INSERT [role_permission] VALUES(248,5,78,1,0,0,0)
INSERT [role_permission] VALUES(249,5,79,1,0,1,0)
INSERT [role_permission] VALUES(250,5,80,1,0,1,0)
INSERT [role_permission] VALUES(251,5,81,0,0,1,0)
INSERT [role_permission] VALUES(252,5,1,1,0,0,0)
INSERT [role_permission] VALUES(253,5,2,1,1,1,0)
INSERT [role_permission] VALUES(254,5,3,1,1,1,0)
INSERT [role_permission] VALUES(255,5,4,1,1,1,0)
INSERT [role_permission] VALUES(256,5,6,1,1,1,0)
INSERT [role_permission] VALUES(257,5,7,1,1,1,0)
INSERT [role_permission] VALUES(258,5,9,1,1,1,1)
INSERT [role_permission] VALUES(259,5,13,1,1,1,0)
INSERT [role_permission] VALUES(260,5,14,1,1,0,1)
INSERT [role_permission] VALUES(261,5,12,1,1,1,1)
INSERT [role_permission] VALUES(262,5,11,1,1,1,1)
INSERT [role_permission] VALUES(263,5,10,1,1,1,1)
INSERT [role_permission] VALUES(264,5,18,1,1,1,1)
INSERT [role_permission] VALUES(265,5,19,1,1,1,1)
INSERT [role_permission] VALUES(266,5,20,1,1,1,1)
INSERT [role_permission] VALUES(267,5,21,1,1,1,1)
INSERT [role_permission] VALUES(268,5,43,1,0,0,0)
INSERT [role_permission] VALUES(269,5,44,1,0,0,0)
INSERT [role_permission] VALUES(270,5,45,1,1,1,1)
INSERT [role_permission] VALUES(271,5,46,1,1,1,1)
INSERT [role_permission] VALUES(272,5,47,1,1,1,1)
INSERT [role_permission] VALUES(273,5,48,1,1,1,1)
INSERT [role_permission] VALUES(274,5,53,1,0,0,0)
INSERT [role_permission] VALUES(275,5,54,1,1,1,1)
INSERT [role_permission] VALUES(276,5,55,1,1,1,1)
INSERT [role_permission] VALUES(277,5,56,1,1,1,1)
INSERT [role_permission] VALUES(278,5,57,1,1,1,1)
INSERT [role_permission] VALUES(279,5,58,1,1,1,1)
INSERT [role_permission] VALUES(280,5,90,1,0,0,0)
INSERT [role_permission] VALUES(281,5,91,1,0,0,0)
INSERT [role_permission] VALUES(282,5,84,1,0,0,0)
INSERT [role_permission] VALUES(283,5,68,1,0,0,0)
INSERT [role_permission] VALUES(284,5,69,1,0,0,0)
INSERT [role_permission] VALUES(285,5,70,1,0,0,0)
INSERT [role_permission] VALUES(286,5,71,1,0,0,0)
INSERT [role_permission] VALUES(287,6,72,1,0,0,0)
INSERT [role_permission] VALUES(288,6,73,1,0,0,0)
INSERT [role_permission] VALUES(289,6,75,1,0,0,0)
INSERT [role_permission] VALUES(290,6,76,1,1,1,1)
INSERT [role_permission] VALUES(291,6,77,1,0,1,0)
INSERT [role_permission] VALUES(292,6,78,1,0,0,0)
INSERT [role_permission] VALUES(293,6,79,1,0,1,0)
INSERT [role_permission] VALUES(294,6,80,1,0,1,0)
INSERT [role_permission] VALUES(295,6,81,0,0,1,0)
INSERT [role_permission] VALUES(296,6,1,1,0,0,0)
INSERT [role_permission] VALUES(297,6,2,1,1,1,0)
INSERT [role_permission] VALUES(298,6,3,1,1,1,0)
INSERT [role_permission] VALUES(299,6,4,1,1,1,0)
INSERT [role_permission] VALUES(300,6,6,1,1,1,0)
INSERT [role_permission] VALUES(301,6,7,1,1,1,0)
INSERT [role_permission] VALUES(302,6,9,1,1,1,0)
INSERT [role_permission] VALUES(303,6,13,1,1,1,0)
INSERT [role_permission] VALUES(304,6,14,1,1,0,1)
INSERT [role_permission] VALUES(305,6,12,1,1,1,0)
INSERT [role_permission] VALUES(306,6,11,1,1,1,0)
INSERT [role_permission] VALUES(307,6,10,1,1,1,0)
INSERT [role_permission] VALUES(308,6,18,1,1,1,0)
INSERT [role_permission] VALUES(309,6,19,1,1,1,0)
INSERT [role_permission] VALUES(310,6,20,1,1,1,0)
INSERT [role_permission] VALUES(311,6,21,1,1,1,0)
INSERT [role_permission] VALUES(312,6,43,1,0,0,0)
INSERT [role_permission] VALUES(313,6,44,1,0,0,0)
INSERT [role_permission] VALUES(314,6,45,1,1,1,1)
INSERT [role_permission] VALUES(315,6,46,1,1,1,1)
INSERT [role_permission] VALUES(316,6,47,1,1,1,1)
INSERT [role_permission] VALUES(317,6,48,1,1,1,1)
INSERT [role_permission] VALUES(318,6,53,1,0,0,0)
INSERT [role_permission] VALUES(319,6,54,1,1,1,0)
INSERT [role_permission] VALUES(320,6,55,1,1,1,0)
INSERT [role_permission] VALUES(321,6,56,1,1,1,0)
INSERT [role_permission] VALUES(322,6,57,1,1,1,0)
INSERT [role_permission] VALUES(323,6,58,1,1,1,0)
INSERT [role_permission] VALUES(324,6,90,1,0,0,0)
INSERT [role_permission] VALUES(325,6,91,1,0,0,0)
INSERT [role_permission] VALUES(326,6,84,1,0,0,0)
INSERT [role_permission] VALUES(327,6,68,1,0,0,0)
INSERT [role_permission] VALUES(328,6,69,1,0,0,0)
INSERT [role_permission] VALUES(329,6,70,1,0,0,0)
INSERT [role_permission] VALUES(330,6,71,1,0,0,0)
INSERT [role_permission] VALUES(331,7,72,1,0,0,0)
INSERT [role_permission] VALUES(332,7,73,1,0,0,0)
INSERT [role_permission] VALUES(333,7,75,1,0,0,0)
INSERT [role_permission] VALUES(334,7,76,1,1,1,1)
INSERT [role_permission] VALUES(335,7,77,1,0,1,0)
INSERT [role_permission] VALUES(336,7,78,1,0,0,0)
INSERT [role_permission] VALUES(337,7,79,1,0,1,0)
INSERT [role_permission] VALUES(338,7,80,1,0,1,0)
INSERT [role_permission] VALUES(339,7,81,0,0,1,0)
INSERT [role_permission] VALUES(340,7,82,1,1,1,1)
INSERT [role_permission] VALUES(341,7,26,1,0,0,0)
INSERT [role_permission] VALUES(342,7,27,1,1,1,1)
INSERT [role_permission] VALUES(343,7,28,1,1,0,1)
INSERT [role_permission] VALUES(344,7,29,1,1,1,1)
INSERT [role_permission] VALUES(345,7,30,1,1,1,1)
INSERT [role_permission] VALUES(346,7,31,1,0,0,0)
INSERT [role_permission] VALUES(347,7,32,1,1,1,1)
INSERT [role_permission] VALUES(348,7,36,1,0,0,0)
INSERT [role_permission] VALUES(349,7,37,1,1,1,1)
INSERT [role_permission] VALUES(350,7,38,1,0,0,0)
INSERT [role_permission] VALUES(351,7,39,1,1,0,1)
INSERT [role_permission] VALUES(352,7,40,1,1,1,1)
INSERT [role_permission] VALUES(353,7,41,1,1,1,1)
INSERT [role_permission] VALUES(354,7,1,1,0,0,0)
INSERT [role_permission] VALUES(355,7,2,1,1,1,0)
INSERT [role_permission] VALUES(356,7,3,1,1,1,0)
INSERT [role_permission] VALUES(357,7,4,1,1,1,0)
INSERT [role_permission] VALUES(358,7,5,1,1,1,0)
INSERT [role_permission] VALUES(359,7,6,1,1,1,0)
INSERT [role_permission] VALUES(360,7,7,1,1,1,0)
INSERT [role_permission] VALUES(361,7,8,1,1,1,0)
INSERT [role_permission] VALUES(362,7,9,1,1,1,0)
INSERT [role_permission] VALUES(363,7,13,1,1,1,0)
INSERT [role_permission] VALUES(364,7,14,1,1,0,1)
INSERT [role_permission] VALUES(365,7,15,1,0,0,0)
INSERT [role_permission] VALUES(366,7,16,1,1,1,0)
INSERT [role_permission] VALUES(367,7,12,1,1,1,0)
INSERT [role_permission] VALUES(368,7,11,1,1,1,0)
INSERT [role_permission] VALUES(369,7,10,1,1,1,0)
INSERT [role_permission] VALUES(370,7,18,1,0,0,0)
INSERT [role_permission] VALUES(371,7,19,1,0,0,0)
INSERT [role_permission] VALUES(372,7,20,1,0,0,0)
INSERT [role_permission] VALUES(373,7,21,1,0,0,0)
INSERT [role_permission] VALUES(374,7,43,1,0,0,0)
INSERT [role_permission] VALUES(375,7,44,1,0,0,0)
INSERT [role_permission] VALUES(376,7,45,1,1,1,1)
INSERT [role_permission] VALUES(377,7,46,1,1,1,1)
INSERT [role_permission] VALUES(378,7,47,1,1,1,1)
INSERT [role_permission] VALUES(379,7,48,1,1,1,1)
INSERT [role_permission] VALUES(380,7,53,1,0,0,0)
INSERT [role_permission] VALUES(381,7,54,1,1,1,0)
INSERT [role_permission] VALUES(382,7,55,1,1,1,0)
INSERT [role_permission] VALUES(383,7,56,1,1,1,0)
INSERT [role_permission] VALUES(384,7,57,1,0,0,0)
INSERT [role_permission] VALUES(385,7,58,1,0,0,0)
INSERT [role_permission] VALUES(386,7,90,1,0,0,0)
INSERT [role_permission] VALUES(387,7,91,1,0,0,0)
INSERT [role_permission] VALUES(388,7,84,1,0,0,0)
INSERT [role_permission] VALUES(389,7,68,1,0,0,0)
INSERT [role_permission] VALUES(390,7,69,1,0,0,0)
INSERT [role_permission] VALUES(391,7,70,1,0,0,0)
INSERT [role_permission] VALUES(392,7,71,1,0,0,0)
INSERT [role_permission] VALUES(393,8,72,1,0,0,0)
INSERT [role_permission] VALUES(394,8,73,1,0,0,0)
INSERT [role_permission] VALUES(395,8,75,1,0,0,0)
INSERT [role_permission] VALUES(396,8,76,1,1,1,1)
INSERT [role_permission] VALUES(397,8,77,1,0,1,0)
INSERT [role_permission] VALUES(398,8,78,1,0,0,0)
INSERT [role_permission] VALUES(399,8,79,1,0,1,0)
INSERT [role_permission] VALUES(400,8,80,1,0,1,0)
INSERT [role_permission] VALUES(401,8,81,0,0,1,0)
INSERT [role_permission] VALUES(402,8,26,1,0,0,0)
INSERT [role_permission] VALUES(403,8,27,1,1,1,1)
INSERT [role_permission] VALUES(404,8,28,1,1,0,1)
INSERT [role_permission] VALUES(405,8,29,1,1,1,1)
INSERT [role_permission] VALUES(406,8,30,1,1,1,1)
INSERT [role_permission] VALUES(407,8,31,1,0,0,0)
INSERT [role_permission] VALUES(408,8,32,1,1,1,1)
INSERT [role_permission] VALUES(409,8,36,1,0,0,0)
INSERT [role_permission] VALUES(410,8,37,1,0,0,0)
INSERT [role_permission] VALUES(411,8,38,1,0,0,0)
INSERT [role_permission] VALUES(412,8,39,1,1,0,1)
INSERT [role_permission] VALUES(413,8,40,1,0,0,0)
INSERT [role_permission] VALUES(414,8,41,1,0,0,0)
INSERT [role_permission] VALUES(415,8,1,1,0,0,0)
INSERT [role_permission] VALUES(416,8,2,1,1,1,1)
INSERT [role_permission] VALUES(417,8,3,1,1,1,0)
INSERT [role_permission] VALUES(418,8,4,1,1,1,1)
INSERT [role_permission] VALUES(419,8,6,1,0,0,0)
INSERT [role_permission] VALUES(420,8,7,1,0,0,0)
INSERT [role_permission] VALUES(421,8,8,1,0,0,0)
INSERT [role_permission] VALUES(422,8,9,1,0,0,0)
INSERT [role_permission] VALUES(423,8,13,1,0,0,0)
INSERT [role_permission] VALUES(424,8,14,1,1,0,1)
INSERT [role_permission] VALUES(425,8,16,1,1,1,1)
INSERT [role_permission] VALUES(426,8,12,1,0,0,0)
INSERT [role_permission] VALUES(427,8,11,1,0,0,0)
INSERT [role_permission] VALUES(428,8,10,1,0,0,0)
INSERT [role_permission] VALUES(429,8,18,1,0,0,0)
INSERT [role_permission] VALUES(430,8,19,1,0,0,0)
INSERT [role_permission] VALUES(431,8,20,1,0,0,0)
INSERT [role_permission] VALUES(432,8,21,1,0,0,0)
INSERT [role_permission] VALUES(433,8,43,1,0,0,0)
INSERT [role_permission] VALUES(434,8,44,1,0,0,0)
INSERT [role_permission] VALUES(435,8,45,1,1,1,1)
INSERT [role_permission] VALUES(436,8,46,1,1,1,1)
INSERT [role_permission] VALUES(437,8,47,1,1,1,1)
INSERT [role_permission] VALUES(438,8,48,1,1,1,1)
INSERT [role_permission] VALUES(439,8,53,1,0,0,0)
INSERT [role_permission] VALUES(440,8,54,1,0,0,0)
INSERT [role_permission] VALUES(441,8,55,1,1,1,1)
INSERT [role_permission] VALUES(442,8,56,1,0,0,0)
INSERT [role_permission] VALUES(443,8,57,1,0,0,0)
INSERT [role_permission] VALUES(444,8,58,1,0,0,0)
INSERT [role_permission] VALUES(445,8,90,1,0,0,0)
INSERT [role_permission] VALUES(446,8,91,1,0,0,0)
INSERT [role_permission] VALUES(447,8,84,1,0,0,0)
INSERT [role_permission] VALUES(448,8,68,1,0,0,0)
INSERT [role_permission] VALUES(449,8,69,1,0,0,0)
INSERT [role_permission] VALUES(450,8,70,1,0,0,0)
INSERT [role_permission] VALUES(451,8,71,1,0,0,0)
INSERT [role_permission] VALUES(452,9,72,1,0,0,0)
INSERT [role_permission] VALUES(453,9,73,1,0,0,0)
INSERT [role_permission] VALUES(454,9,75,1,0,0,0)
INSERT [role_permission] VALUES(455,9,76,1,1,1,1)
INSERT [role_permission] VALUES(456,9,77,1,0,1,0)
INSERT [role_permission] VALUES(457,9,78,1,0,0,0)
INSERT [role_permission] VALUES(458,9,79,1,0,1,0)
INSERT [role_permission] VALUES(459,9,80,1,0,1,0)
INSERT [role_permission] VALUES(460,9,81,0,0,1,0)
INSERT [role_permission] VALUES(461,9,43,1,0,0,0)
INSERT [role_permission] VALUES(462,9,44,1,0,0,0)
INSERT [role_permission] VALUES(463,9,45,1,1,1,1)
INSERT [role_permission] VALUES(464,9,46,1,1,1,1)
INSERT [role_permission] VALUES(465,9,47,1,1,1,1)
INSERT [role_permission] VALUES(466,9,48,1,1,1,1)
INSERT [role_permission] VALUES(467,9,90,1,1,1,1)
INSERT [role_permission] VALUES(468,9,91,1,1,1,1)
INSERT [role_permission] VALUES(469,9,84,1,0,0,0)
INSERT [role_permission] VALUES(470,9,68,1,0,0,0)
INSERT [role_permission] VALUES(471,9,69,1,0,0,0)
INSERT [role_permission] VALUES(472,9,70,1,0,0,0)
INSERT [role_permission] VALUES(473,9,71,1,0,0,0)
INSERT [role_permission] VALUES(474,10,1,1,0,0,0)
INSERT [role_permission] VALUES(475,10,2,1,0,0,0)
INSERT [role_permission] VALUES(476,10,4,1,0,0,0)
INSERT [role_permission] VALUES(477,10,18,1,0,0,0)
INSERT [role_permission] VALUES(478,10,19,1,0,0,0)
INSERT [role_permission] VALUES(479,10,20,1,0,0,0)
INSERT [role_permission] VALUES(480,10,21,1,0,0,0)
INSERT [role_permission] VALUES(481,10,4,1,0,0,0)
INSERT [role_permission] VALUES(482,10,9,1,1,0,0)
INSERT [role_permission] VALUES(483,11,72,1,0,0,0)
INSERT [role_permission] VALUES(484,11,73,1,0,0,0)
INSERT [role_permission] VALUES(485,11,87,1,0,0,0)

SET IDENTITY_INSERT [role_permission] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_contact_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_contact_types] ON
GO
INSERT [lookup_contact_types] VALUES(1,'Acquaintance',0,0,1,NULL,0)
INSERT [lookup_contact_types] VALUES(2,'Competitor',0,0,1,NULL,0)
INSERT [lookup_contact_types] VALUES(3,'Customer',0,0,1,NULL,0)
INSERT [lookup_contact_types] VALUES(4,'Friend',0,0,1,NULL,0)
INSERT [lookup_contact_types] VALUES(5,'Prospect',0,0,1,NULL,0)
INSERT [lookup_contact_types] VALUES(6,'Shareholder',0,0,1,NULL,0)
INSERT [lookup_contact_types] VALUES(7,'Vendor',0,0,1,NULL,0)
INSERT [lookup_contact_types] VALUES(8,'Accounting',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(9,'Administrative',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(10,'Business Development',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(11,'Customer Service',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(12,'Engineering',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(13,'Executive',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(14,'Finance',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(15,'Marketing',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(16,'Operations',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(17,'Procurement',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(18,'Sales',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(19,'Shipping/Receiving',0,0,1,NULL,1)
INSERT [lookup_contact_types] VALUES(20,'Technology',0,0,1,NULL,1)

SET IDENTITY_INSERT [lookup_contact_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_survey_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_survey_types] ON
GO
INSERT [lookup_survey_types] VALUES(1,'Open-Ended',0,0,1)
INSERT [lookup_survey_types] VALUES(2,'Quantitative (no comments)',0,0,1)
INSERT [lookup_survey_types] VALUES(3,'Quantitative (with comments)',0,0,1)
INSERT [lookup_survey_types] VALUES(4,'Item List',0,0,1)

SET IDENTITY_INSERT [lookup_survey_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_hook_library
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_hook_library] ON
GO
INSERT [business_process_hook_library] VALUES(1,8,'org.aspcfs.modules.troubletickets.base.Ticket',1)

SET IDENTITY_INSERT [business_process_hook_library] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_order_status
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_order_status] ON
GO
INSERT [lookup_order_status] VALUES(1,'Pending',0,0,1)
INSERT [lookup_order_status] VALUES(2,'In Progress',0,0,1)
INSERT [lookup_order_status] VALUES(3,'Cancelled',0,0,1)
INSERT [lookup_order_status] VALUES(4,'Rejected',0,0,1)
INSERT [lookup_order_status] VALUES(5,'Complete',0,0,1)
INSERT [lookup_order_status] VALUES(6,'Closed',0,0,1)

SET IDENTITY_INSERT [lookup_order_status] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_hook_triggers
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_hook_triggers] ON
GO
INSERT [business_process_hook_triggers] VALUES(1,2,1,1)
INSERT [business_process_hook_triggers] VALUES(2,1,1,1)

SET IDENTITY_INSERT [business_process_hook_triggers] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_account_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_account_types] ON
GO
INSERT [lookup_account_types] VALUES(1,'Small',0,10,1)
INSERT [lookup_account_types] VALUES(2,'Medium',0,20,1)
INSERT [lookup_account_types] VALUES(3,'Large',0,30,1)
INSERT [lookup_account_types] VALUES(4,'Contract',0,40,1)
INSERT [lookup_account_types] VALUES(5,'Territory 1: Northeast',0,50,1)
INSERT [lookup_account_types] VALUES(6,'Territory 2: Southeast',0,60,1)
INSERT [lookup_account_types] VALUES(7,'Territory 3: Midwest',0,70,1)
INSERT [lookup_account_types] VALUES(8,'Territory 4: Northwest',0,80,1)
INSERT [lookup_account_types] VALUES(9,'Territory 5: Southwest',0,90,1)

SET IDENTITY_INSERT [lookup_account_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_stage
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_stage] ON
GO
INSERT [lookup_stage] VALUES(1,1,'Prospecting',0,1,1)
INSERT [lookup_stage] VALUES(2,2,'Qualification',0,2,1)
INSERT [lookup_stage] VALUES(3,3,'Needs Analysis',0,3,1)
INSERT [lookup_stage] VALUES(4,4,'Value Proposition',0,4,1)
INSERT [lookup_stage] VALUES(5,5,'Perception Analysis',0,5,1)
INSERT [lookup_stage] VALUES(6,6,'Proposal/Price Quote',0,6,1)
INSERT [lookup_stage] VALUES(7,7,'Negotiation/Review',0,7,1)
INSERT [lookup_stage] VALUES(8,8,'Closed Won',0,8,1)
INSERT [lookup_stage] VALUES(9,9,'Closed Lost',0,9,1)

SET IDENTITY_INSERT [lookup_stage] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_order_type
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_order_type] ON
GO
INSERT [lookup_order_type] VALUES(1,'New',0,0,1)
INSERT [lookup_order_type] VALUES(2,'Change',0,0,1)
INSERT [lookup_order_type] VALUES(3,'Upgrade',0,0,1)
INSERT [lookup_order_type] VALUES(4,'Downgrade',0,0,1)
INSERT [lookup_order_type] VALUES(5,'Disconnect',0,0,1)
INSERT [lookup_order_type] VALUES(6,'Move',0,0,1)
INSERT [lookup_order_type] VALUES(7,'Return',0,0,1)
INSERT [lookup_order_type] VALUES(8,'Suspend',0,0,1)
INSERT [lookup_order_type] VALUES(9,'Unsuspend',0,0,1)

SET IDENTITY_INSERT [lookup_order_type] OFF
GO
SET NOCOUNT OFF
 
-- Insert default autoguide_ad_run_types
SET NOCOUNT ON
SET IDENTITY_INSERT [autoguide_ad_run_types] ON
GO
INSERT [autoguide_ad_run_types] VALUES(1,'In Column',0,1,1,'May 28 2004 10:25:34:587AM','May 28 2004 10:25:34:587AM')
INSERT [autoguide_ad_run_types] VALUES(2,'Display',0,2,1,'May 28 2004 10:25:34:597AM','May 28 2004 10:25:34:597AM')
INSERT [autoguide_ad_run_types] VALUES(3,'Both',0,3,1,'May 28 2004 10:25:34:597AM','May 28 2004 10:25:34:597AM')

SET IDENTITY_INSERT [autoguide_ad_run_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_asset_status
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_asset_status] ON
GO
INSERT [lookup_asset_status] VALUES(1,'In use',0,10,1)
INSERT [lookup_asset_status] VALUES(2,'Not in use',0,20,1)
INSERT [lookup_asset_status] VALUES(3,'Requires maintenance',0,30,1)
INSERT [lookup_asset_status] VALUES(4,'Retired',0,40,1)

SET IDENTITY_INSERT [lookup_asset_status] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_hook
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_hook] ON
GO
INSERT [business_process_hook] VALUES(1,1,1,1)
INSERT [business_process_hook] VALUES(2,2,1,1)

SET IDENTITY_INSERT [business_process_hook] OFF
GO
SET NOCOUNT OFF
 
-- Insert default state
SET NOCOUNT ON
INSERT [state] VALUES('AK','Alaska')
INSERT [state] VALUES('AL','Alabama')
INSERT [state] VALUES('AR','Arkansas')
INSERT [state] VALUES('AZ','Arizona')
INSERT [state] VALUES('CA','California')
INSERT [state] VALUES('CO','Colorado')
INSERT [state] VALUES('CT','Connecticut')
INSERT [state] VALUES('DC','Washington D.C.')
INSERT [state] VALUES('DE','Delaware')
INSERT [state] VALUES('FL','Florida')
INSERT [state] VALUES('GA','Georgia')
INSERT [state] VALUES('HI','Hawaii')
INSERT [state] VALUES('ID','Idaho')
INSERT [state] VALUES('IL','Illinois')
INSERT [state] VALUES('IN','Indiana')
INSERT [state] VALUES('KS','Kansas')
INSERT [state] VALUES('KY','Kentucky')
INSERT [state] VALUES('LA','Louisiana')
INSERT [state] VALUES('MA','Massachusetts')
INSERT [state] VALUES('MD','Maryland')
INSERT [state] VALUES('ME','Maine')
INSERT [state] VALUES('MI','Michigan')
INSERT [state] VALUES('MN','Minnesota')
INSERT [state] VALUES('MO','Mossouri')
INSERT [state] VALUES('MS','Mississippi')
INSERT [state] VALUES('MT','Montana')
INSERT [state] VALUES('NC','North Carolina')
INSERT [state] VALUES('ND','North Dakota')
INSERT [state] VALUES('NE','Nebraska')
INSERT [state] VALUES('NH','New Hampshire')
INSERT [state] VALUES('NJ','New Jersey')
INSERT [state] VALUES('NM','New Mexico')
INSERT [state] VALUES('NV','Nevada')
INSERT [state] VALUES('NY','New York')
INSERT [state] VALUES('OH','Ohio')
INSERT [state] VALUES('OK','Oklahoma')
INSERT [state] VALUES('OR','Oregon')
INSERT [state] VALUES('PA','Pennsylvania')
INSERT [state] VALUES('RI','Rhode Island')
INSERT [state] VALUES('SC','South Carolina')
INSERT [state] VALUES('SD','South Dakota')
INSERT [state] VALUES('TN','Tennessee')
INSERT [state] VALUES('TX','Texas')
INSERT [state] VALUES('UT','Utah')
INSERT [state] VALUES('VA','Virginia')
INSERT [state] VALUES('VT','Vermont')
INSERT [state] VALUES('WA','Washington')
INSERT [state] VALUES('WI','Wisconsin')
INSERT [state] VALUES('WV','West Virginia')
INSERT [state] VALUES('WY','Wyoming')

SET NOCOUNT OFF
 
-- Insert default lookup_delivery_options
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_delivery_options] ON
GO
INSERT [lookup_delivery_options] VALUES(1,'Email only',0,1,1)
INSERT [lookup_delivery_options] VALUES(2,'Fax only',0,2,1)
INSERT [lookup_delivery_options] VALUES(3,'Letter only',0,3,1)
INSERT [lookup_delivery_options] VALUES(4,'Email then Fax',0,4,1)
INSERT [lookup_delivery_options] VALUES(5,'Email then Letter',0,5,1)
INSERT [lookup_delivery_options] VALUES(6,'Email, Fax, then Letter',0,6,1)

SET IDENTITY_INSERT [lookup_delivery_options] OFF
GO
SET NOCOUNT OFF
 
-- Insert default help_features
SET NOCOUNT ON
SET IDENTITY_INSERT [help_features] ON
GO
INSERT [help_features] VALUES(1,1,NULL,'You can view the accounts that need attention',0,'May 28 2004 10:25:47:677AM',0,'May 28 2004 10:25:47:677AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(2,1,NULL,'You can make calls with the contact information readily accessible',0,'May 28 2004 10:25:47:687AM',0,'May 28 2004 10:25:47:687AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(3,1,NULL,'You can view the tasks assigned to you',0,'May 28 2004 10:25:47:697AM',0,'May 28 2004 10:25:47:697AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(4,1,NULL,'You can view the tickets assigned to you',0,'May 28 2004 10:25:47:697AM',0,'May 28 2004 10:25:47:697AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(5,2,NULL,'The select button can be used to view the details, reply, forward or delete a particular message.',0,'May 28 2004 10:25:47:747AM',0,'May 28 2004 10:25:47:747AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(6,2,NULL,'You can add a new message',0,'May 28 2004 10:25:47:747AM',0,'May 28 2004 10:25:47:747AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(7,2,NULL,'Clicking on the message will show the details of the message',0,'May 28 2004 10:25:47:757AM',0,'May 28 2004 10:25:47:757AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(8,2,NULL,'The drop down can be used to select the messages present in the inbox, sent messages, or archived ones',0,'May 28 2004 10:25:47:757AM',0,'May 28 2004 10:25:47:757AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(9,2,NULL,'Sort on one of the column headers by clicking on the column of your choice',0,'May 28 2004 10:25:47:757AM',0,'May 28 2004 10:25:47:757AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(10,3,NULL,'You can reply, archive, forward or delete each message by clicking the corresponding button',0,'May 28 2004 10:25:47:787AM',0,'May 28 2004 10:25:47:787AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(11,4,NULL,'A new message can be composed either to the contacts or the employees present in the recipients list. The options field can be checked to send a copy to the employees task list apart from sending the employee an email.',0,'May 28 2004 10:25:47:797AM',0,'May 28 2004 10:25:47:797AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(12,5,NULL,'You can send the email by clicking the send button',0,'May 28 2004 10:25:47:817AM',0,'May 28 2004 10:25:47:817AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(13,5,NULL,'You can add to the list of recipients by using the link "Add Recipients"',0,'May 28 2004 10:25:47:827AM',0,'May 28 2004 10:25:47:827AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(14,5,NULL,'You can click the check box to send an Internet email to the recipients',0,'May 28 2004 10:25:47:827AM',0,'May 28 2004 10:25:47:827AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(15,5,NULL,'Type directly in the Body test field to modify the message',0,'May 28 2004 10:25:47:827AM',0,'May 28 2004 10:25:47:827AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(16,7,NULL,'You can add the list of recipients by using the link "Add Recipients" and also click the check box which would send an email to the recipients',0,'May 28 2004 10:25:47:847AM',0,'May 28 2004 10:25:47:847AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(17,7,NULL,'You can send the email by clicking the send button',0,'May 28 2004 10:25:47:857AM',0,'May 28 2004 10:25:47:857AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(18,7,NULL,'You can edit the message by typing directly in the Body text area',0,'May 28 2004 10:25:47:947AM',0,'May 28 2004 10:25:47:947AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(19,8,NULL,'You can add a quick task. This task would have just the description and whether the task is personal or not',0,'May 28 2004 10:25:47:957AM',0,'May 28 2004 10:25:47:957AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(20,8,NULL,'For each of the existing tasks, you can view, modify, forward or delete the tasks by clicking on the Action button, and making a selection.',0,'May 28 2004 10:25:47:967AM',0,'May 28 2004 10:25:47:967AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(21,8,NULL,'You can select to view your tasks or tasks assigned by you to others working under you. Each can be viewed in three different modes. i.e. the completed tasks, uncompleted tasks or both.',0,'May 28 2004 10:25:47:977AM',0,'May 28 2004 10:25:47:977AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(22,8,NULL,'You can add a detailed (advanced) task, where you can set up the priority, status, whether the task is shared or not, task assignment, give the estimated time and add some detailed notes for it.',0,'May 28 2004 10:25:47:977AM',0,'May 28 2004 10:25:47:977AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(23,9,NULL,'Link this task to a contact and when you look at the task list, there will be a link to the contact record next to the task, allowing you to go directly to the contact.',0,'May 28 2004 10:25:47:997AM',0,'May 28 2004 10:25:47:997AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(24,9,NULL,'Filling in a Due Date will make ths task show up on that date in the Home Page calendar.',0,'May 28 2004 10:25:48:007AM',0,'May 28 2004 10:25:48:007AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(25,9,NULL,'Making the task personal will hide it from your hierarchy.',0,'May 28 2004 10:25:48:007AM',0,'May 28 2004 10:25:48:007AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(26,9,NULL,'You can assign a task to people lower than you in your hierarchy.',0,'May 28 2004 10:25:48:017AM',0,'May 28 2004 10:25:48:017AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(27,9,NULL,'Marking a task as complete will document the task as having been done, and immediately remove it from the Task List.',0,'May 28 2004 10:25:48:017AM',0,'May 28 2004 10:25:48:017AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(28,10,NULL,'Allows you to forward a task to one or more users of the system. Checking the options fields check box indicates that if the recipient is a user of the system, then a copy of the task is send to the recipient''s Internet email.',0,'May 28 2004 10:25:48:027AM',0,'May 28 2004 10:25:48:027AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(29,10,NULL,'The Subject line is mandatory',0,'May 28 2004 10:25:48:037AM',0,'May 28 2004 10:25:48:037AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(30,10,NULL,'You can add more text to the body of the message by typing directly in the Body text area',0,'May 28 2004 10:25:48:037AM',0,'May 28 2004 10:25:48:037AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(31,11,NULL,'Due dates will show on the Home Page calendar',0,'May 28 2004 10:25:48:047AM',0,'May 28 2004 10:25:48:047AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(32,11,NULL,'Completing a task will remove it from the task list',0,'May 28 2004 10:25:48:047AM',0,'May 28 2004 10:25:48:047AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(33,11,NULL,'You can assign a task to someone lower than you in your heirarchy',0,'May 28 2004 10:25:48:047AM',0,'May 28 2004 10:25:48:047AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(34,11,NULL,'You can Add or Change the contact that this task is linked to. When viewing the task, you will be able to view the contact information with one click.',0,'May 28 2004 10:25:48:057AM',0,'May 28 2004 10:25:48:057AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(35,12,NULL,'You can also view all the in progress Action Lists, completed lists, or both together.',0,'May 28 2004 10:25:48:067AM',0,'May 28 2004 10:25:48:067AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(36,12,NULL,'You can also keep track of the progress of your contacts. The number of them Completed and the Total are shown in the Progress Columns.',0,'May 28 2004 10:25:48:067AM',0,'May 28 2004 10:25:48:067AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(37,12,NULL,'You can add a new Action List with a description and status. You can select the contacts for this new Action List. For each of the contacts in the Action List, you can select a corresponding action with the Action Button: view details, modify contact, add contacts or delete the Action List.',0,'May 28 2004 10:25:48:067AM',0,'May 28 2004 10:25:48:067AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(38,13,NULL,'Clicking on the contact name will give you a pop up with more details about the contact and also about the related folders, calls, messages and opportunities.',0,'May 28 2004 10:25:48:077AM',0,'May 28 2004 10:25:48:077AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(39,13,NULL,'You can add contacts to the list and also Modify the List using "Add Contacts to list" and "Modify List" respectively.',0,'May 28 2004 10:25:48:087AM',0,'May 28 2004 10:25:48:087AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(40,13,NULL,'For the Action List you can also view all the in progress contacts, completed contacts or both.',0,'May 28 2004 10:25:48:087AM',0,'May 28 2004 10:25:48:087AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(41,13,NULL,'For each of the contacts you can add a call, opportunity, ticket, task or send a message, which would correspondingly appear in their respective tabs. For example, adding a ticket to the contact would be reflected in the Ticket tab.',0,'May 28 2004 10:25:48:097AM',0,'May 28 2004 10:25:48:097AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(42,14,NULL,'Select where the contacts will come from (General Contact, Account Contacts) in the From dropdown.',0,'May 28 2004 10:25:48:107AM',0,'May 28 2004 10:25:48:107AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(43,14,NULL,'Enter some search text, depending on the Operator you chose.',0,'May 28 2004 10:25:48:107AM',0,'May 28 2004 10:25:48:107AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(44,14,NULL,'Choose an Operator based on the Field you chose.',0,'May 28 2004 10:25:48:107AM',0,'May 28 2004 10:25:48:107AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(45,14,NULL,'Choose one of the many Field Names on which to base your query.',0,'May 28 2004 10:25:48:107AM',0,'May 28 2004 10:25:48:107AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(46,14,NULL,'You can Add or Remove contacts manually with the Add/Remove Contacts link.',0,'May 28 2004 10:25:48:117AM',0,'May 28 2004 10:25:48:117AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(47,14,NULL,'Add your query with the Add button at the bottom of the query frame. You can have multipe queries that make up the criteria for a group. You will get the result of all the queries.',0,'May 28 2004 10:25:48:117AM',0,'May 28 2004 10:25:48:117AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(48,14,NULL,'Save the Action List and generate the list of contacts by clicking the Save button at the bottom or top of the page.',0,'May 28 2004 10:25:48:117AM',0,'May 28 2004 10:25:48:117AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(49,15,NULL,'You can check the status checkbox to indicate that the New Action List is complete.',0,'May 28 2004 10:25:48:127AM',0,'May 28 2004 10:25:48:127AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(50,15,NULL,'The details of the New Action List can be saved by clicking the save button.',0,'May 28 2004 10:25:48:127AM',0,'May 28 2004 10:25:48:127AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(51,16,NULL,'Click Update at the bottom of the page to save your reassignment, Cancel to quit the page without saving, and Reset to reset all the fields to their defaults and start over.',0,'May 28 2004 10:25:48:147AM',0,'May 28 2004 10:25:48:147AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(52,16,NULL,'Choose a User to reassign data from in the top dropdown. Only users below you in your hierarchy will be present here.',0,'May 28 2004 10:25:48:147AM',0,'May 28 2004 10:25:48:147AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(53,16,NULL,'Select one or more To Users in the To User column to reassign the various assets to. The number of each type of asset available to be reassigned is shown in parentheses after the asset in the first column.',0,'May 28 2004 10:25:48:157AM',0,'May 28 2004 10:25:48:157AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(54,17,NULL,'The location of the employee can be changed, i.e. the time zone can be changed by clicking on "Configure my location."',0,'May 28 2004 10:25:48:167AM',0,'May 28 2004 10:25:48:167AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(55,17,NULL,'You can update your personal information by clicking on "Update my personal information."',0,'May 28 2004 10:25:48:167AM',0,'May 28 2004 10:25:48:167AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(56,17,NULL,'You can change your password by clicking on "Change my password."',0,'May 28 2004 10:25:48:167AM',0,'May 28 2004 10:25:48:167AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(57,18,NULL,'Save your changes by clicking the Update button at the top or bottom of the page. The Cancel button forgets the changes and quits the page. The Reset button resets all fields to their original values so you can start over.',0,'May 28 2004 10:25:48:177AM',0,'May 28 2004 10:25:48:177AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(58,18,NULL,'The only required field is your last name, but you should fill in as much as you can to make the system as useful as possible. Email address is particularly useful.',0,'May 28 2004 10:25:48:187AM',0,'May 28 2004 10:25:48:187AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(59,19,NULL,'The location settings can be changed by selecting the time zone from the drop down list and clicking the update button to update the settings.',0,'May 28 2004 10:25:48:197AM',0,'May 28 2004 10:25:48:197AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(60,20,NULL,'You can update your password by clicking on the update button.',0,'May 28 2004 10:25:48:287AM',0,'May 28 2004 10:25:48:287AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(61,21,NULL,'For each of the existing tasks, you can view, modify, forward or delete the tasks by clicking on the Action button',0,'May 28 2004 10:25:48:297AM',0,'May 28 2004 10:25:48:297AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(62,21,NULL,'You can add a quick task. This task would have just the description and whether the task is personal or not',0,'May 28 2004 10:25:48:297AM',0,'May 28 2004 10:25:48:297AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(63,21,NULL,'You can add or update a detailed task called advanced task, wherein you can set up the priority, the status, whether the task is shared or not, also is the task assigned to self or someone working under the owner of the tasks, give the estimated time and add some detailed notes in it.',0,'May 28 2004 10:25:48:307AM',0,'May 28 2004 10:25:48:307AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(64,21,NULL,'Checking the existing task''s check box indicates that the particular task is completed.',0,'May 28 2004 10:25:48:307AM',0,'May 28 2004 10:25:48:307AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(65,21,NULL,'You can select to view your tasks or tasks assigned by you to others. Each task can be viewed in three different modes i.e. the completed tasks, uncompleted tasks or all the tasks.',0,'May 28 2004 10:25:48:317AM',0,'May 28 2004 10:25:48:317AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(66,28,NULL,'You can add the new Action List here. Along with description and the status you need to select the contacts you want in this Action List. You can populate the list in two ways. The first is to use the Add/Remove contacts.',0,'May 28 2004 10:25:48:377AM',0,'May 28 2004 10:25:48:377AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(67,28,NULL,'The second is to define the criteria to generate the list. Once it''s generated we can add them to the selected criteria and contacts by using the add feature present.',0,'May 28 2004 10:25:48:377AM',0,'May 28 2004 10:25:48:377AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(68,31,NULL,'Check new contacts to add them to your list, uncheck existing contacts to remove them from your list.',0,'May 28 2004 10:25:48:397AM',0,'May 28 2004 10:25:48:397AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(69,31,NULL,'Select All Contact, My Contacts or Account Contacts from the dropdown at the top.',0,'May 28 2004 10:25:48:407AM',0,'May 28 2004 10:25:48:407AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(70,31,NULL,'Finish by clicking Done at the bottom of the page.',0,'May 28 2004 10:25:48:407AM',0,'May 28 2004 10:25:48:407AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(71,33,NULL,'You can add or update a detailed task called advanced task, wherein you can set up a priority, status, whether the task is shared or not, also is the task assigned to you or someone working under the owner of the tasks, give the estimated time and add some detailed notes to it.',0,'May 28 2004 10:25:48:437AM',0,'May 28 2004 10:25:48:437AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(72,34,NULL,'You can select the contact category using the radio button and if the contact category is someone permanently associated with an account, then you can select the contact using the "select" next to it.',0,'May 28 2004 10:25:48:457AM',0,'May 28 2004 10:25:48:457AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(73,34,NULL,'You can save the details about the employee using the "Save" button.',0,'May 28 2004 10:25:48:457AM',0,'May 28 2004 10:25:48:457AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(74,34,NULL,'The "Save & New" button saves the details of the employee and also opens up a blank form start another contact.',0,'May 28 2004 10:25:48:467AM',0,'May 28 2004 10:25:48:467AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(75,34,NULL,'The only mandatory field is the Last Name, however, it is important to fill in as much as possible. These fields can be used for various types of queries later.',0,'May 28 2004 10:25:48:467AM',0,'May 28 2004 10:25:48:467AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(76,34,NULL,'The contact type can be selected using the "select" link next to the contact type.',0,'May 28 2004 10:25:48:467AM',0,'May 28 2004 10:25:48:467AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(77,35,NULL,'If the contact already exists in the system, you can search for that contact by name, company, title, contact type or source.',0,'May 28 2004 10:25:48:477AM',0,'May 28 2004 10:25:48:477AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(78,36,NULL,'New export data can be generated by choosing the "Generate new export" link at the top of the page',0,'May 28 2004 10:25:48:497AM',0,'May 28 2004 10:25:48:497AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(79,36,NULL,'Use the dropdown to choose which data to display: the list of all the exported data in the system or only your own.',0,'May 28 2004 10:25:48:497AM',0,'May 28 2004 10:25:48:497AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(80,36,NULL,'The exported data can be viewed in html format by clicking on the report name. The exported data can also be downloaded in CSV format or deleted by clicking the Select button in the action field.',0,'May 28 2004 10:25:48:497AM',0,'May 28 2004 10:25:48:497AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(81,37,NULL,'You can add all the fields or add / delete single fields from the report by using the buttons in the middle of the page. First highlight a field on the left to add or a field on the right to delete.',0,'May 28 2004 10:25:48:507AM',0,'May 28 2004 10:25:48:507AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(82,37,NULL,'Use the Up and Down buttons on the right to sort the fields.',0,'May 28 2004 10:25:48:517AM',0,'May 28 2004 10:25:48:517AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(83,37,NULL,'The Subject is mandatory. Select which set of contacts the export will come from with Criteria. Select the Primary sort with the Sorting dropdown.',0,'May 28 2004 10:25:48:587AM',0,'May 28 2004 10:25:48:587AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(84,37,NULL,'Click the Generate button when you are ready to generate the exported report.',0,'May 28 2004 10:25:48:607AM',0,'May 28 2004 10:25:48:607AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(85,38,NULL,'You can update, cancel or reset the details of the contact using the corresponding buttons.',0,'May 28 2004 10:25:48:617AM',0,'May 28 2004 10:25:48:617AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(86,41,NULL,'You can also click on the select button under the action field to view, modify, forward or delete a call.',0,'May 28 2004 10:25:48:757AM',0,'May 28 2004 10:25:48:757AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(87,41,NULL,'Clicking on the subject of the call will give complete details about the call.',0,'May 28 2004 10:25:48:757AM',0,'May 28 2004 10:25:48:757AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(88,41,NULL,'You can add a call associated with a contact.',0,'May 28 2004 10:25:48:767AM',0,'May 28 2004 10:25:48:767AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(89,42,NULL,'The save button lets you create a new call which is associated with the call.',0,'May 28 2004 10:25:48:777AM',0,'May 28 2004 10:25:48:777AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(90,45,NULL,'You can click the select button under the action column for viewing, modifying and deleting an opportunity.',0,'May 28 2004 10:25:48:797AM',0,'May 28 2004 10:25:48:797AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(91,45,NULL,'Clicking on the name of the opportunity will show a detailed description of the opportunity.',0,'May 28 2004 10:25:48:797AM',0,'May 28 2004 10:25:48:797AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(92,45,NULL,'Choosing the different types of opportunities from the drop down can filter the display.',0,'May 28 2004 10:25:48:797AM',0,'May 28 2004 10:25:48:797AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(93,45,NULL,'Add an opportunity associated with a contact.',0,'May 28 2004 10:25:48:807AM',0,'May 28 2004 10:25:48:807AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(94,46,NULL,'You can modify, delete or forward each call using the corresponding buttons.',0,'May 28 2004 10:25:48:817AM',0,'May 28 2004 10:25:48:817AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(95,47,NULL,'The component type can be selected using the "select" button.',0,'May 28 2004 10:25:48:827AM',0,'May 28 2004 10:25:48:827AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(96,47,NULL,'You can assign the component to any of the employees present using the dropdown list present.',0,'May 28 2004 10:25:48:827AM',0,'May 28 2004 10:25:48:827AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(97,48,NULL,'An opportunity can be renamed or deleted using the buttons present at the bottom of the page.',0,'May 28 2004 10:25:48:837AM',0,'May 28 2004 10:25:48:837AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(98,48,NULL,'Clicking on the select button lets you view, modify or delete the details about a component.',0,'May 28 2004 10:25:48:847AM',0,'May 28 2004 10:25:48:847AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(99,48,NULL,'Clicking on the name of the component shows the details about that component.',0,'May 28 2004 10:25:48:847AM',0,'May 28 2004 10:25:48:847AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(100,48,NULL,'Add a new component associated with the contact.',0,'May 28 2004 10:25:48:847AM',0,'May 28 2004 10:25:48:847AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(101,49,NULL,'You can modify or delete the opportunity using the modify or delete button.',0,'May 28 2004 10:25:48:857AM',0,'May 28 2004 10:25:48:857AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(102,50,NULL,'The type of the call can be selected using the drop down list and all the other details related to the call are updated using the update button.',0,'May 28 2004 10:25:48:867AM',0,'May 28 2004 10:25:48:867AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(103,58,NULL,'You can click the attachments or the surveys link present along with the message text.',0,'May 28 2004 10:25:48:927AM',0,'May 28 2004 10:25:48:927AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(104,59,NULL,'You can modify or delete the opportunity using the modify or the delete button.',0,'May 28 2004 10:25:48:937AM',0,'May 28 2004 10:25:48:937AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(105,60,NULL,'You can also click the select button under the action field to view, modify, clone or delete a contact.',0,'May 28 2004 10:25:48:947AM',0,'May 28 2004 10:25:48:947AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(106,60,NULL,'Clicking the name of the contact will display additional details about the contact.',0,'May 28 2004 10:25:48:947AM',0,'May 28 2004 10:25:48:947AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(107,60,NULL,'Add a contact using the link "Add a Contact" at the top of the page',0,'May 28 2004 10:25:48:947AM',0,'May 28 2004 10:25:48:947AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(108,61,NULL,'You can also choose to display the list of all the exported data in the system or the exported data created by you.',0,'May 28 2004 10:25:48:957AM',0,'May 28 2004 10:25:48:957AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(109,61,NULL,'The exported data can be viewed as a .csv file or in html format. The exported data can also be deleted when the select button in the action field is clicked.',0,'May 28 2004 10:25:48:957AM',0,'May 28 2004 10:25:48:957AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(110,61,NULL,'New export data can be generated, which lets you choose from the contacts list.',0,'May 28 2004 10:25:48:967AM',0,'May 28 2004 10:25:48:967AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(111,62,NULL,'You can modify, clone, or delete the details of the contact.',0,'May 28 2004 10:25:49:057AM',0,'May 28 2004 10:25:49:057AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(112,63,NULL,'Clicking on the name of the message displays more details about the message.',0,'May 28 2004 10:25:49:067AM',0,'May 28 2004 10:25:49:067AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(113,63,NULL,'You can view the messages in two different views, i.e. all the messages present or the messages created/assigned by you.',0,'May 28 2004 10:25:49:067AM',0,'May 28 2004 10:25:49:067AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(114,64,NULL,'You can select the list of the recipients to whom you want to forward the particular call to by using the "Add Recipients" link.',0,'May 28 2004 10:25:49:077AM',0,'May 28 2004 10:25:49:077AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(115,66,NULL,'The component type can be selected using the "select" link.',0,'May 28 2004 10:25:49:097AM',0,'May 28 2004 10:25:49:097AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(116,66,NULL,'You can assign the component to any user using the dropdown list provided.',0,'May 28 2004 10:25:49:097AM',0,'May 28 2004 10:25:49:097AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(117,67,NULL,'You can update or cancel the information changed using the "update" or "cancel" button.',0,'May 28 2004 10:25:49:127AM',0,'May 28 2004 10:25:49:127AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(118,68,NULL,'The folders can be selected using the drop down list.',0,'May 28 2004 10:25:49:137AM',0,'May 28 2004 10:25:49:137AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(119,68,NULL,'You can click on the record name, to view the folder record details.',0,'May 28 2004 10:25:49:137AM',0,'May 28 2004 10:25:49:137AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(120,68,NULL,'You can view the details and modify them by clicking the select button under the action column.',0,'May 28 2004 10:25:49:137AM',0,'May 28 2004 10:25:49:137AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(121,68,NULL,'You can add a new record to a folder using the "Add a record to this folder" link.',0,'May 28 2004 10:25:49:147AM',0,'May 28 2004 10:25:49:147AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(122,68,NULL,'The folders can be selected using the drop down list.',0,'May 28 2004 10:25:49:147AM',0,'May 28 2004 10:25:49:147AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(123,69,NULL,'The changes made in the details of the folders can be updated or canceled using the "Update" or "Cancel" button.',0,'May 28 2004 10:25:49:157AM',0,'May 28 2004 10:25:49:157AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(124,70,NULL,'You can also click the select button under the action column for viewing, modifying and deleting an opportunity.',0,'May 28 2004 10:25:49:167AM',0,'May 28 2004 10:25:49:167AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(125,70,NULL,'Clicking on the name of the opportunity will display the details of the opportunity.',0,'May 28 2004 10:25:49:167AM',0,'May 28 2004 10:25:49:167AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(126,70,NULL,'Choosing the different types of opportunities from the drop down filters the display.',0,'May 28 2004 10:25:49:167AM',0,'May 28 2004 10:25:49:167AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(127,70,NULL,'Add an opportunity associated with a contact.',0,'May 28 2004 10:25:49:167AM',0,'May 28 2004 10:25:49:167AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(128,71,NULL,'You can filter the contact list in three different views. The views are all contacts, your contacts and Account contacts.',0,'May 28 2004 10:25:49:187AM',0,'May 28 2004 10:25:49:187AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(129,71,NULL,'Check any or all the contacts from the list you want to assign to your action List.',0,'May 28 2004 10:25:49:187AM',0,'May 28 2004 10:25:49:187AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(130,72,NULL,'You can also view, modify, clone or delete the contact by clicking the corresponding button.',0,'May 28 2004 10:25:49:197AM',0,'May 28 2004 10:25:49:197AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(131,72,NULL,'You can associate calls, messages and opportunities with each of the contacts already in the system.',0,'May 28 2004 10:25:49:197AM',0,'May 28 2004 10:25:49:197AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(132,73,NULL,'You can view all the messages related to the contact or only the messages owned by you. (My messages)',0,'May 28 2004 10:25:49:207AM',0,'May 28 2004 10:25:49:207AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(133,74,NULL,'This is for adding or updating a new detailed employee record into the system. The last name is the only mandatory field in creating an employee record, However it is important to add as much information as you can.',0,'May 28 2004 10:25:49:217AM',0,'May 28 2004 10:25:49:217AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(134,75,NULL,'If the contact already exists in the system, you can search for that contact by name, company, title, contact type or source, by typing the search term in the appropriate field, and clicking the Search button.',0,'May 28 2004 10:25:49:227AM',0,'May 28 2004 10:25:49:227AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(135,75,NULL,'You can filter, export, and display data in different formats by clicking the Export link at the top of the page.',0,'May 28 2004 10:25:49:257AM',0,'May 28 2004 10:25:49:257AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(136,75,NULL,'Click Add to add a new contact into the application.',0,'May 28 2004 10:25:49:267AM',0,'May 28 2004 10:25:49:267AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(137,75,NULL,'You may also import your existing contacts from microsoft outlook( or comparable cvs format) into the application.',0,'May 28 2004 10:25:49:267AM',0,'May 28 2004 10:25:49:267AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(138,77,NULL,'This page is four sections.',0,'May 28 2004 10:25:49:287AM',0,'May 28 2004 10:25:49:287AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(139,77,NULL,'The ''Import Properties" section displays the file that was imported and the Name provided to identify the import.',0,'May 28 2004 10:25:49:287AM',0,'May 28 2004 10:25:49:287AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(140,77,NULL,'The next section displays the heading of the import file and four records following it.',0,'May 28 2004 10:25:49:287AM',0,'May 28 2004 10:25:49:287AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(141,77,NULL,'The "general errors/warnings" section displays errors in the CVS file.',0,'May 28 2004 10:25:49:297AM',0,'May 28 2004 10:25:49:297AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(142,77,NULL,'The "Field Mappings" section lists all the columns in the file based on the heading and maps known columns in the file to the fields in the application.',0,'May 28 2004 10:25:49:297AM',0,'May 28 2004 10:25:49:297AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(143,77,NULL,'Against each listed column heading in the field mappings section is a drop list that displays the list of fields that exist to store contact information in the CRM application. Using this drop list you may modify automatically identified field mappings and map those that the application failed to automatically identify.',0,'May 28 2004 10:25:49:297AM',0,'May 28 2004 10:25:49:297AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(144,78,NULL,'An import goes though various stages before finally being approved and locked.',0,'May 28 2004 10:25:49:307AM',0,'May 28 2004 10:25:49:307AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(145,78,NULL,'The first stage of an import is the unprocessed stage. In this stage, an import file in cvs format is uploaded to the application. In this stage the import is tagged as ''Import Pending.''',0,'May 28 2004 10:25:49:307AM',0,'May 28 2004 10:25:49:307AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(146,78,NULL,'In the second stage, the unprocessed contacts file that was uploaded is queued to be processed. To do so, you need to map the various columns in the cvs file to the relevant contact fields(names, emails, telephones, etc) in the application. When the columns are mapped, the import is queued to be processed. Only one import is processed at a time, hence subsequent imports are queued until all previous imports are processed.',0,'May 28 2004 10:25:49:397AM',0,'May 28 2004 10:25:49:397AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(147,78,NULL,'When an import is being processed (or running) the CRM application reads the cvs file, and creates contacts in the application. After the entire file is processed, the contacts are tagged as ''Pending approval''.',0,'May 28 2004 10:25:49:397AM',0,'May 28 2004 10:25:49:397AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(148,78,NULL,'When the contacts are tagged as "Pending approval",  you may examine whether the import worked as it was expected, and decide whether the imported contacts can be used for the due course of business. If you find that the mappings you specified were erroneous or insufficient, you may delete the import (which also deletes all contacts of the import) and create another one.',0,'May 28 2004 10:25:49:407AM',0,'May 28 2004 10:25:49:407AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(149,78,NULL,'During the import process, some records in the cvs file may fail to import to the application. The failure is usually due to an incorrect specification of phone number, or very large names, etc. Such failed records are copied to an "error file" and available for you to examine. You may correct the information in the error file and run an import for this file alone, or you may add the records to the application manually.',0,'May 28 2004 10:25:49:407AM',0,'May 28 2004 10:25:49:407AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(150,78,NULL,'When an import is approved, the contacts of this import are visible in the contacts list view and these contacts are ready to be used in the application.',0,'May 28 2004 10:25:49:407AM',0,'May 28 2004 10:25:49:407AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(151,78,NULL,'When a import is approved, its results can only be viewed. The contacts of an approved import cannot be deleted en mass.',0,'May 28 2004 10:25:49:407AM',0,'May 28 2004 10:25:49:407AM',NULL,NULL,1,8)
INSERT [help_features] VALUES(152,79,NULL,'You can view the progress chart in different views for all the employees working under the owner or creator of the opportunity. The views can be selected from the drop down box present under the chart. The mouse over or a click on the break point on the progress chart will give the date and exact value associated with that point.',0,'May 28 2004 10:25:49:427AM',0,'May 28 2004 10:25:49:427AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(153,79,NULL,'The opportunities created are also shown, with their names and the probable gross revenue associated with that opportunity. Clicking on the opportunities shows a details page for the opportunity.',0,'May 28 2004 10:25:49:437AM',0,'May 28 2004 10:25:49:437AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(154,79,NULL,'The list of employees reporting to a particular employee/supervisor is also shown below the progress chart. Clicking on an employee shows the Opportunity page from that person''s point of view. You can then work your way back up the chain by clicking the Up One Level link.',0,'May 28 2004 10:25:49:437AM',0,'May 28 2004 10:25:49:437AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(155,80,NULL,'The probability of Close, Estimated Close Date, Best Guess Estimate (what will the gross revenue be for this component?), and Estimated Term (over what time period?), are mandatory fields.',0,'May 28 2004 10:25:49:447AM',0,'May 28 2004 10:25:49:447AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(156,80,NULL,'You can assign the component to yourself or one of the users in your hierarchy.',0,'May 28 2004 10:25:49:447AM',0,'May 28 2004 10:25:49:447AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(157,80,NULL,'The Component Description is a mandatory field. Be descriptive as you will be using this to search on later.',0,'May 28 2004 10:25:49:457AM',0,'May 28 2004 10:25:49:457AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(158,80,NULL,'Use the Save button to save your changes and exit, Cancel to cancel your changes and exit, and Reset to cancel your changes and start over.',0,'May 28 2004 10:25:49:457AM',0,'May 28 2004 10:25:49:457AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(159,80,NULL,'Enter an Alert Description and Date to remind yourself to follow up on this component at a later date.',0,'May 28 2004 10:25:49:467AM',0,'May 28 2004 10:25:49:467AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(160,80,NULL,'You must associate the component with either a Contact or an Account. Choose one of the radio buttons, then one of the Select links.',0,'May 28 2004 10:25:49:467AM',0,'May 28 2004 10:25:49:467AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(161,81,NULL,'Existing opportunities can be searched using this feature. Opportunities can be searched on description, account name, or contact name with whom the opportunity is associated. It can also be searched by current progress / stage of the opportunity or the closing date range.',0,'May 28 2004 10:25:49:477AM',0,'May 28 2004 10:25:49:477AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(162,82,NULL,'The exported data can be viewed or downloaded as a .csv file or in html format. The exported data can also be deleted when the select button in the action column is clicked.',0,'May 28 2004 10:25:49:487AM',0,'May 28 2004 10:25:49:487AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(163,82,NULL,'You can also choose to display the list of all the exported data in the system or the exported data created by you.',0,'May 28 2004 10:25:49:487AM',0,'May 28 2004 10:25:49:487AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(164,82,NULL,'New export data can be generated by choosing from the contacts list.',0,'May 28 2004 10:25:49:487AM',0,'May 28 2004 10:25:49:487AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(165,85,NULL,'Component Description is a mandatory field',0,'May 28 2004 10:25:49:517AM',0,'May 28 2004 10:25:49:517AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(166,85,NULL,'Use Update at the top or bottom to save your changes, Cancel to quit this page without saving, and Reset to reset all fields to default and start over.',0,'May 28 2004 10:25:49:517AM',0,'May 28 2004 10:25:49:517AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(167,85,NULL,'Add an Alert Description and Date to alert you via a CRM System Message to take a new action',0,'May 28 2004 10:25:49:517AM',0,'May 28 2004 10:25:49:517AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(168,85,NULL,'Probability of close, Estimated Close Date (when you will get the revenue), Best Guess Estimate (how much revenue you will get), and Estimated Term (what term the revenue will be realized over) are all the mandatory fields.',0,'May 28 2004 10:25:49:527AM',0,'May 28 2004 10:25:49:527AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(169,85,NULL,'You can select a Component Type from the dropdown. These component types are configurable by your System Administrator.',0,'May 28 2004 10:25:49:527AM',0,'May 28 2004 10:25:49:527AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(170,85,NULL,'You can assign the component to any User using the dropdown list present.',0,'May 28 2004 10:25:49:527AM',0,'May 28 2004 10:25:49:527AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(171,86,NULL,'The type of the call can be a phone, fax or in person. Some notes regarding the call can be noted. You can add an alert to remind you to follow up on this call.',0,'May 28 2004 10:25:49:537AM',0,'May 28 2004 10:25:49:537AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(172,86,NULL,'The Contact dropdown is automatically populated with the correct contacts for the company or account you are dealing with.',0,'May 28 2004 10:25:49:537AM',0,'May 28 2004 10:25:49:537AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(173,87,NULL,'You can update or cancel the information changed using the "update" or "cancel" button present.',0,'May 28 2004 10:25:49:547AM',0,'May 28 2004 10:25:49:547AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(174,89,NULL,'You can update the details of the documents using the update button.',0,'May 28 2004 10:25:49:567AM',0,'May 28 2004 10:25:49:567AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(175,93,NULL,'The component details are shown with additional options for modifying and deleting the component.',0,'May 28 2004 10:25:49:597AM',0,'May 28 2004 10:25:49:597AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(176,94,NULL,'The document can be uploaded using the upload button.',0,'May 28 2004 10:25:49:607AM',0,'May 28 2004 10:25:49:607AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(177,94,NULL,'The new version of the document can be selected from your local computer using the browse button.',0,'May 28 2004 10:25:49:607AM',0,'May 28 2004 10:25:49:607AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(178,95,NULL,'For each of the component you can view the details, modify the content or delete it completely using the select button in the Action column.',0,'May 28 2004 10:25:49:700AM',0,'May 28 2004 10:25:49:700AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(179,95,NULL,'You can add an opportunity here by giving complete details about the opportunity.',0,'May 28 2004 10:25:49:700AM',0,'May 28 2004 10:25:49:700AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(180,95,NULL,'The search results for existing opportunities are displayed here.',0,'May 28 2004 10:25:49:710AM',0,'May 28 2004 10:25:49:710AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(181,95,NULL,'There are different views of the opportunities you can choose from the drop down list and the corresponding types for the opportunities.',0,'May 28 2004 10:25:49:710AM',0,'May 28 2004 10:25:49:710AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(182,96,NULL,'In the Documents tab, documents associated with an opportunity can be added. This also displays the documents already linked with this opportunity and other details about the document. Details can be viewed, downloaded, modified or deleted by using the select button in the action column',0,'May 28 2004 10:25:49:720AM',0,'May 28 2004 10:25:49:720AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(183,96,NULL,'In the Calls tab you can add a call associated with the opportunity. This also displays the calls already linked with this opportunity and other details about the call. The call details can be viewed, modified, forwarded or deleted by using the select button in the action column.',0,'May 28 2004 10:25:49:720AM',0,'May 28 2004 10:25:49:720AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(184,96,NULL,'You can rename or delete the opportunity itself using the buttons below.',0,'May 28 2004 10:25:49:720AM',0,'May 28 2004 10:25:49:720AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(185,96,NULL,'You can modify, view and delete the details of any particular component by clicking the select button in the action column.',0,'May 28 2004 10:25:49:720AM',0,'May 28 2004 10:25:49:720AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(186,96,NULL,'In the Components tab, you can add a component. It also displays the status, amount and the date when the component will be closed.',0,'May 28 2004 10:25:49:720AM',0,'May 28 2004 10:25:49:720AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(187,96,NULL,'There are three tabs in each opportunity i.e. components, calls and documents.',0,'May 28 2004 10:25:49:730AM',0,'May 28 2004 10:25:49:730AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(188,96,NULL,'You get the organization name or the contact name at the top, which on clicking will take you to the Account details.',0,'May 28 2004 10:25:49:730AM',0,'May 28 2004 10:25:49:730AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(189,97,NULL,'You can select the list of the recipients to whom you want to forward a call to by using the "Add Recipients" link. This will bring up a window with all users, from which you can then choose using check boxes.',0,'May 28 2004 10:25:49:740AM',0,'May 28 2004 10:25:49:740AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(190,97,NULL,'You can email a copy of the call to a user''s Internet email by checking the Email check box.',0,'May 28 2004 10:25:49:740AM',0,'May 28 2004 10:25:49:740AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(191,97,NULL,'You can add to the message by simply typing in the Body text box.',0,'May 28 2004 10:25:49:750AM',0,'May 28 2004 10:25:49:750AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(192,98,NULL,'The version of the particular document can be modified using the add version link.',0,'May 28 2004 10:25:49:750AM',0,'May 28 2004 10:25:49:750AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(193,98,NULL,'A document can be viewed, downloaded, modified or deleted by using the select button in the action column.',0,'May 28 2004 10:25:49:760AM',0,'May 28 2004 10:25:49:760AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(194,98,NULL,'A click on the subject of the document will show all the versions present.',0,'May 28 2004 10:25:49:760AM',0,'May 28 2004 10:25:49:760AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(195,99,NULL,'The type of the call can be selected using the drop down list and all the other details related to the call are updated using the update button',0,'May 28 2004 10:25:49:770AM',0,'May 28 2004 10:25:49:770AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(196,100,NULL,'In the Calls tab you can add a call to the opportunity. This also displays the calls already linked with this opportunity and other details about the call. The call details can be viewed, modified, forwarded or deleted by using the select button in the action column',0,'May 28 2004 10:25:49:780AM',0,'May 28 2004 10:25:49:780AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(197,100,NULL,'In the Components tab, you can add a component. It also displays the status, amount and the date when the component will be closed.',0,'May 28 2004 10:25:49:780AM',0,'May 28 2004 10:25:49:780AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(198,100,NULL,'There are three tabs in each opportunity i.e. components, calls and documents.',0,'May 28 2004 10:25:49:780AM',0,'May 28 2004 10:25:49:780AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(199,100,NULL,'You can rename or delete the whole opportunity (not just one of these components) using the buttons at the bottom.',0,'May 28 2004 10:25:49:790AM',0,'May 28 2004 10:25:49:790AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(200,100,NULL,'The organization or contact name appears on top, above the Components Tab, which when clicked, will take you to the Account details.',0,'May 28 2004 10:25:49:790AM',0,'May 28 2004 10:25:49:790AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(201,100,NULL,'You can modify, view and delete the details of any component by clicking the select button in the Action column, on the far left.',0,'May 28 2004 10:25:49:790AM',0,'May 28 2004 10:25:49:790AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(202,100,NULL,'In the Documents tab, documents associated with the particular opportunity can be added. This also displays the documents already linked with this opportunity and other details about the document. Details can be viewed, downloaded, modified or deleted by using the select button in the action column',0,'May 28 2004 10:25:49:800AM',0,'May 28 2004 10:25:49:800AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(203,101,NULL,'In the Calls tab you can add a call associated with the opportunity. This also displays the calls already linked with this opportunity and other details about the call. The call details can be viewed, modified, forwarded or deleted by using the select button in the action column',0,'May 28 2004 10:25:49:810AM',0,'May 28 2004 10:25:49:810AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(204,101,NULL,'If the call subject is clicked then complete details about the call are displayed.',0,'May 28 2004 10:25:49:810AM',0,'May 28 2004 10:25:49:810AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(205,102,NULL,'There are different views of the opportunities you can choose from the dropdown list and the corresponding types of the opportunities.',0,'May 28 2004 10:25:49:820AM',0,'May 28 2004 10:25:49:820AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(206,102,NULL,'You can add an opportunity here by giving complete details about the opportunity.',0,'May 28 2004 10:25:49:820AM',0,'May 28 2004 10:25:49:820AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(207,102,NULL,'The search results for existing opportunities are displayed here.',0,'May 28 2004 10:25:49:820AM',0,'May 28 2004 10:25:49:820AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(208,102,NULL,'For each of the components you can view the details, modify the content or delete it completely using the select button in the Action column. You can click on any of the component names, which shows more details about the component, such as the calls and documents associated with it.',0,'May 28 2004 10:25:49:820AM',0,'May 28 2004 10:25:49:820AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(209,103,NULL,'The list of employees reporting to a particular employee/supervisor is also shown below the progress chart.',0,'May 28 2004 10:25:49:830AM',0,'May 28 2004 10:25:49:830AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(210,103,NULL,'Opportunities are displayed, with name and probable revemue. Clicking on the opportunities displays more details of the opportunity.',0,'May 28 2004 10:25:49:840AM',0,'May 28 2004 10:25:49:840AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(211,103,NULL,'You can view the progress chart in different views for all the employees working under the owner or creator of the opportunity. The views can be selected from the drop down box under the chart. The mouse over or a click on the break point on the progress chart will give the date and exact value associated with that point.',0,'May 28 2004 10:25:49:840AM',0,'May 28 2004 10:25:49:840AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(212,104,NULL,'The component details are shown with additional options for modifying and deleting the component.',0,'May 28 2004 10:25:49:850AM',0,'May 28 2004 10:25:49:850AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(213,105,NULL,'The component type can be selected using the "select" link.',0,'May 28 2004 10:25:49:860AM',0,'May 28 2004 10:25:49:860AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(214,105,NULL,'You can assign the component to any of the employee present using the dropdown list.',0,'May 28 2004 10:25:49:860AM',0,'May 28 2004 10:25:49:860AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(215,106,NULL,'In the Calls tab you can add a call associated with the opportunity. This also displays the calls already linked with this opportunity and other details about the call. Call details can be viewed, modified, forwarded or deleted by using the select button in the action column.',0,'May 28 2004 10:25:49:870AM',0,'May 28 2004 10:25:49:870AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(216,106,NULL,'If the call subject is clicked then it will display complete details about the call.',0,'May 28 2004 10:25:49:870AM',0,'May 28 2004 10:25:49:870AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(217,107,NULL,'You can modify, delete and forward each of the calls.',0,'May 28 2004 10:25:49:880AM',0,'May 28 2004 10:25:49:880AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(218,108,NULL,'Clicking the Upload button will upload the selected document into the system.',0,'May 28 2004 10:25:49:890AM',0,'May 28 2004 10:25:49:890AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(219,108,NULL,'Clicking the Browse button opens a file browser on your own system. Simply navigate to the file on your drive that you want to upload and click Open. This will close the window and bring you back to the upload page.',0,'May 28 2004 10:25:49:890AM',0,'May 28 2004 10:25:49:890AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(220,108,NULL,'Add a very descriptive Subject for the file. This is a mandatory field.',0,'May 28 2004 10:25:49:980AM',0,'May 28 2004 10:25:49:980AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(221,109,NULL,'All the versions of the document can be downloaded from here. Simply select the version you want and click the Download link on the far left.',0,'May 28 2004 10:25:49:990AM',0,'May 28 2004 10:25:49:990AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(222,110,NULL,'The exported data can be viewed as a .csv file or in the html format. The exported data can also be deleted when the select button in the action field is clicked.',0,'May 28 2004 10:25:50:000AM',0,'May 28 2004 10:25:50:000AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(223,110,NULL,'You can also choose to display the list of all the exported data in the system or the exported data created by you.',0,'May 28 2004 10:25:50:000AM',0,'May 28 2004 10:25:50:000AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(224,110,NULL,'New export data can be generated, which lets you choose from the contacts list.',0,'May 28 2004 10:25:50:010AM',0,'May 28 2004 10:25:50:010AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(225,110,NULL,'Click on the subject of the new export, the data is displayed in html format',0,'May 28 2004 10:25:50:010AM',0,'May 28 2004 10:25:50:010AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(226,111,NULL,'Click the Generate button at top or bottom to generate the report from the fields you have included. Click cancel to quit and go back to the Export Data page.',0,'May 28 2004 10:25:50:020AM',0,'May 28 2004 10:25:50:020AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(227,111,NULL,'Highlight the fields you want to include in the left column and click the Add or All link. Highlight fields in the right column and click the Del link to remove them.',0,'May 28 2004 10:25:50:020AM',0,'May 28 2004 10:25:50:020AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(228,111,NULL,'Use the Sorting dropdown to sort the report by one of a variety of fields',0,'May 28 2004 10:25:50:020AM',0,'May 28 2004 10:25:50:020AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(229,111,NULL,'Use the Criteria dropdown to use opportunities from My or All Opportunities',0,'May 28 2004 10:25:50:020AM',0,'May 28 2004 10:25:50:020AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(230,111,NULL,'The Subject is a mandatory field.',0,'May 28 2004 10:25:50:030AM',0,'May 28 2004 10:25:50:030AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(231,112,NULL,'Clicking on the alert link will let you modify the details of the account owner.',0,'May 28 2004 10:25:50:050AM',0,'May 28 2004 10:25:50:050AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(232,112,NULL,'Accounts with contract end dates or other required actions will appear in the right hand window where you can take action on them.',0,'May 28 2004 10:25:50:050AM',0,'May 28 2004 10:25:50:050AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(233,112,NULL,'You can view the schedule, actions, alert dates and contract end dates for yourself or your employees by using the dropdown at the top of the page.',0,'May 28 2004 10:25:50:050AM',0,'May 28 2004 10:25:50:050AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(234,112,NULL,'You can modify the date range shown in the right hand window by clicking on a specific date on the calendar, or on one of the arrows to the left of each week on the calendar to give you a week''s view. Clicking on "Back To Next 7 Days View" at the top of the right window changes the view to the next seven days. The day or week you are currently viewing is highlighted in yellow. Today''s date is highlighted in blue. You can change the month and year using the dropdowns at the top of the calendar, and you can always return to today by using the Today link, also at the top of the calendar.',0,'May 28 2004 10:25:50:050AM',0,'May 28 2004 10:25:50:050AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(235,113,NULL,'Use the Insert button at top or bottom to save your changes, Cancel to quit without saving, and Reset to reset all the fields to their default values and start over.',0,'May 28 2004 10:25:50:060AM',0,'May 28 2004 10:25:50:060AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(236,113,NULL,'It''s a faily straightforward "fill in the blanks" exercise. There should be a "Primary" or "Business", or "Main" version of phone/fax numbers and addresses because other modules such as Communications Manager use these to perform other actions.',0,'May 28 2004 10:25:50:060AM',0,'May 28 2004 10:25:50:060AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(237,113,NULL,'Fill in as many fields as possible. Most of them can be used later as search terms and for queries in reports.',0,'May 28 2004 10:25:50:070AM',0,'May 28 2004 10:25:50:070AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(238,113,NULL,'Depending on whether you have chosen Organization or Individual, there are mandatory description fields to fill out about the account.',0,'May 28 2004 10:25:50:070AM',0,'May 28 2004 10:25:50:070AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(239,113,NULL,'Choose whether this account is an Organization or an Individual with the appropriate radio button.',0,'May 28 2004 10:25:50:070AM',0,'May 28 2004 10:25:50:070AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(240,113,NULL,'Clicking the Select link next to Account Type(s) will open a window with a variety of choices for Account Types. You cah choose and number by clicking the checkboxes to the left. It is important to use this feature as your choice(s) are used for searches and as the subject of querries in reports in other parts of the application.',0,'May 28 2004 10:25:50:070AM',0,'May 28 2004 10:25:50:070AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(241,114,NULL,'The account owner can also be changed using the drop down list',0,'May 28 2004 10:25:50:090AM',0,'May 28 2004 10:25:50:090AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(242,114,NULL,'The account type can be selected using the "Select" button',0,'May 28 2004 10:25:50:090AM',0,'May 28 2004 10:25:50:090AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(243,114,NULL,'This is for adding or updating account details. The last name or the organization name, based on the classification, is the only mandatory field in creating a new account. The type of account can be selected using the select option given next to the account type',0,'May 28 2004 10:25:50:090AM',0,'May 28 2004 10:25:50:090AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(244,114,NULL,'If the Account has a contract, you should enter a contract end date in the fields provided. This will generate an icon on the Home Page and an alert for the owner of the account that action must be taken at a prearranged time.',0,'May 28 2004 10:25:50:090AM',0,'May 28 2004 10:25:50:090AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(245,115,NULL,'You can also view, modify, clone and delete the contact by clicking the select button under the action column.',0,'May 28 2004 10:25:50:100AM',0,'May 28 2004 10:25:50:100AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(246,115,NULL,'When the name of the contact is clicked, it shows details of that contact, with the options to modify, clone and delete the contact details.',0,'May 28 2004 10:25:50:100AM',0,'May 28 2004 10:25:50:100AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(247,115,NULL,'You can add a contact, which is associated with the account.',0,'May 28 2004 10:25:50:110AM',0,'May 28 2004 10:25:50:110AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(248,116,NULL,'Using the select button in the action column you can view details and modify the record.',0,'May 28 2004 10:25:50:120AM',0,'May 28 2004 10:25:50:120AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(249,116,NULL,'You can click on the record type to view the folders details and modify them.',0,'May 28 2004 10:25:50:120AM',0,'May 28 2004 10:25:50:120AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(250,116,NULL,'A new record can be added to the folder.',0,'May 28 2004 10:25:50:120AM',0,'May 28 2004 10:25:50:120AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(251,116,NULL,'The folders can be populated by configuring the module in the admin tab.. The type of the folder can be changed using the drop down list shown.',0,'May 28 2004 10:25:50:120AM',0,'May 28 2004 10:25:50:120AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(252,117,NULL,'Opportunities associated with the contact, showing the best guess total and last modified date.',0,'May 28 2004 10:25:50:130AM',0,'May 28 2004 10:25:50:130AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(253,117,NULL,'You can add an opportunity.',0,'May 28 2004 10:25:50:140AM',0,'May 28 2004 10:25:50:140AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(254,117,NULL,'Three types of opportunities are present which can be selected from the drop down list.',0,'May 28 2004 10:25:50:140AM',0,'May 28 2004 10:25:50:140AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(255,117,NULL,'When the description of the opportunity is clicked, it will give you more details about the opportunity and the components present in it.',0,'May 28 2004 10:25:50:140AM',0,'May 28 2004 10:25:50:140AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(256,118,NULL,'By clicking on the description of the revenue you get the details about that revenue along with the options to modify and delete its details.',0,'May 28 2004 10:25:50:160AM',0,'May 28 2004 10:25:50:160AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(257,118,NULL,'You can view your revenue or all the revenues associated with the account using the drop down box.',0,'May 28 2004 10:25:50:160AM',0,'May 28 2004 10:25:50:160AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(258,118,NULL,'You can also view, modify and delete the details of the revenue by clicking the select button in the action column.',0,'May 28 2004 10:25:50:160AM',0,'May 28 2004 10:25:50:160AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(259,118,NULL,'Add / update a new revenue associated with the account.',0,'May 28 2004 10:25:50:160AM',0,'May 28 2004 10:25:50:160AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(260,119,NULL,'Clicking on the description of the revenue displays its details, along with options to modify and delete them.',0,'May 28 2004 10:25:50:170AM',0,'May 28 2004 10:25:50:170AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(261,119,NULL,'You can view your revenue or all the revenues associated with the account using the drop down box.',0,'May 28 2004 10:25:50:170AM',0,'May 28 2004 10:25:50:170AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(262,119,NULL,'You can also view, modify and delete the details of the revenue by clicking the select button in the action column.',0,'May 28 2004 10:25:50:170AM',0,'May 28 2004 10:25:50:170AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(263,119,NULL,'Add / update a new revenue associated with the account.',0,'May 28 2004 10:25:50:180AM',0,'May 28 2004 10:25:50:180AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(264,120,NULL,'Add new revenue to an account.',0,'May 28 2004 10:25:50:270AM',0,'May 28 2004 10:25:50:270AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(265,121,NULL,'Fill in the blanks and use "Update" to save your changes or "Reset" to return to the original values.',0,'May 28 2004 10:25:50:280AM',0,'May 28 2004 10:25:50:280AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(266,122,NULL,'You can also click the select button under the action column to view, modify or delete the ticket.',0,'May 28 2004 10:25:50:290AM',0,'May 28 2004 10:25:50:290AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(267,122,NULL,'Clicking on the ticket number will let you view the details, modify or delete the ticket.',0,'May 28 2004 10:25:50:290AM',0,'May 28 2004 10:25:50:290AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(268,122,NULL,'Add a new ticket.',0,'May 28 2004 10:25:50:290AM',0,'May 28 2004 10:25:50:290AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(269,123,NULL,'The details of the documents can be viewed or modified by clicking on the select button under the Action column.',0,'May 28 2004 10:25:50:300AM',0,'May 28 2004 10:25:50:300AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(270,123,NULL,'Document versions can be updated by using the "add version" link.',0,'May 28 2004 10:25:50:300AM',0,'May 28 2004 10:25:50:300AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(271,123,NULL,'A new document can be added which is associated with the account.',0,'May 28 2004 10:25:50:310AM',0,'May 28 2004 10:25:50:310AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(272,123,NULL,'You can view the details of, modify, download or delete the documents associated with the account.',0,'May 28 2004 10:25:50:310AM',0,'May 28 2004 10:25:50:310AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(273,124,NULL,'You can search for accounts in the system. The search can be based on the account name, phone number or the account type. Three types of accounts can be selected from the drop down list shown.',0,'May 28 2004 10:25:50:320AM',0,'May 28 2004 10:25:50:320AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(274,125,NULL,'Click Modify at the top or bottom of the page to modify these datails.',0,'May 28 2004 10:25:50:330AM',0,'May 28 2004 10:25:50:330AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(275,126,NULL,'The list of employees reporting to a particular employee/supervisor is also shown below the progress chart.',0,'May 28 2004 10:25:50:340AM',0,'May 28 2004 10:25:50:340AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(276,126,NULL,'The Accounts present are also shown, with name and the amount of money associated with that Account. Clicking on the Account displays the details of the Account.',0,'May 28 2004 10:25:50:340AM',0,'May 28 2004 10:25:50:340AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(277,126,NULL,'You can view the progress chart in different views for all the employees working under the owner or creator of the Account. The views can be selected from the drop down box present under the chart. A mouse over or a click on the break point on the progress chart will give the date and exact value associated with that point.',0,'May 28 2004 10:25:50:340AM',0,'May 28 2004 10:25:50:340AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(278,127,NULL,'The exported data can be viewed as a .csv file or in the html format. The exported data can also be deleted when the select button in the action field is clicked.',0,'May 28 2004 10:25:50:350AM',0,'May 28 2004 10:25:50:350AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(279,127,NULL,'You can also choose to display the list of all the exported data in the system or the exported data created by you.',0,'May 28 2004 10:25:50:350AM',0,'May 28 2004 10:25:50:350AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(280,127,NULL,'New export data can be generated using the "Generate new export" link.',0,'May 28 2004 10:25:50:360AM',0,'May 28 2004 10:25:50:360AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(281,128,NULL,'The details are updated by clicking the Update button.',0,'May 28 2004 10:25:50:370AM',0,'May 28 2004 10:25:50:370AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(282,131,NULL,'There are filters through which you can exactly select the data needed to generate the export data. Apart from selecting the type of accounts and the criteria, you can also select the fields required and then sort them.',0,'May 28 2004 10:25:50:430AM',0,'May 28 2004 10:25:50:430AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(283,132,NULL,'Using the select button under the action column you can view the details about the call, modify the call, forward the call or delete the call on the whole.',0,'May 28 2004 10:25:50:440AM',0,'May 28 2004 10:25:50:440AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(284,132,NULL,'Clicking on the subject of the call will show you the details about the call that was made to the contact.',0,'May 28 2004 10:25:50:440AM',0,'May 28 2004 10:25:50:440AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(285,132,NULL,'You can add a call associated with the contact using the "Add a call" link.',0,'May 28 2004 10:25:50:450AM',0,'May 28 2004 10:25:50:450AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(286,133,NULL,'Record details can be saved using the save button.',0,'May 28 2004 10:25:50:450AM',0,'May 28 2004 10:25:50:450AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(287,134,NULL,'The details of the new call can be saved using the save button.',0,'May 28 2004 10:25:50:470AM',0,'May 28 2004 10:25:50:470AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(288,134,NULL,'The call type can be selected from the dropdown box.',0,'May 28 2004 10:25:50:470AM',0,'May 28 2004 10:25:50:470AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(289,135,NULL,'You can browse your local system to select a new document to upload.',0,'May 28 2004 10:25:50:480AM',0,'May 28 2004 10:25:50:480AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(290,138,NULL,'You can upload a new version of an existing document.',0,'May 28 2004 10:25:50:500AM',0,'May 28 2004 10:25:50:500AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(291,141,NULL,'You can insert a new ticket, add the ticket source and also assign new contact.',0,'May 28 2004 10:25:50:600AM',0,'May 28 2004 10:25:50:600AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(292,142,NULL,'The details of the documents can be viewed or modified by clicking on the select button under the Action column',0,'May 28 2004 10:25:50:610AM',0,'May 28 2004 10:25:50:610AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(293,142,NULL,'You can view the details, modify, download or delete the documents associated with the ticket',0,'May 28 2004 10:25:50:610AM',0,'May 28 2004 10:25:50:610AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(294,142,NULL,'A new document can be added which is associated with the ticket',0,'May 28 2004 10:25:50:620AM',0,'May 28 2004 10:25:50:620AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(295,142,NULL,'The document versions can be updated by using the "add version" link',0,'May 28 2004 10:25:50:620AM',0,'May 28 2004 10:25:50:620AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(296,147,NULL,'Clicking on the account name shows complete details about the account',0,'May 28 2004 10:25:50:660AM',0,'May 28 2004 10:25:50:660AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(297,147,NULL,'You can add a new account',0,'May 28 2004 10:25:50:660AM',0,'May 28 2004 10:25:50:660AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(298,147,NULL,'The select button in the Action column allows you to view, modify and archive the account. Archiving makes the account invisible, but it is still in the database.',0,'May 28 2004 10:25:50:660AM',0,'May 28 2004 10:25:50:660AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(299,148,NULL,'You can download all the versions of the documents',0,'May 28 2004 10:25:50:670AM',0,'May 28 2004 10:25:50:670AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(300,149,NULL,'You can modify / update the current document information, such as the subject and the filename',0,'May 28 2004 10:25:50:680AM',0,'May 28 2004 10:25:50:680AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(301,150,NULL,'The details of the account can be modified here. The details can be saved using the Modify button.',0,'May 28 2004 10:25:50:690AM',0,'May 28 2004 10:25:50:690AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(302,151,NULL,'You can modify, delete or forward the calls using the corresponding buttons.',0,'May 28 2004 10:25:50:690AM',0,'May 28 2004 10:25:50:690AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(303,152,NULL,'The details of the new call can be saved using the save button.',0,'May 28 2004 10:25:50:710AM',0,'May 28 2004 10:25:50:710AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(304,152,NULL,'The call type can be selected from the dropdown box.',0,'May 28 2004 10:25:50:710AM',0,'May 28 2004 10:25:50:710AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(305,153,NULL,'You can modify, delete or forward the calls using the corresponding buttons.',0,'May 28 2004 10:25:50:720AM',0,'May 28 2004 10:25:50:720AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(306,154,NULL,'You can select the list of the recipients to whom you want to forward the particular call to by using the "Add Recipients" link.',0,'May 28 2004 10:25:50:730AM',0,'May 28 2004 10:25:50:730AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(307,155,NULL,'You can also view, modify and delete the opportunity associated with the contact.',0,'May 28 2004 10:25:50:730AM',0,'May 28 2004 10:25:50:730AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(308,155,NULL,'When the description of the opportunity is clicked, it will display more details about the opportunity and its components.',0,'May 28 2004 10:25:50:740AM',0,'May 28 2004 10:25:50:740AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(309,155,NULL,'Add an opportunity.',0,'May 28 2004 10:25:50:740AM',0,'May 28 2004 10:25:50:740AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(310,155,NULL,'Select an opportunity type from the drop down list.',0,'May 28 2004 10:25:50:740AM',0,'May 28 2004 10:25:50:740AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(311,156,NULL,'You can rename or delete the opportunity itself using the buttons below.',0,'May 28 2004 10:25:50:750AM',0,'May 28 2004 10:25:50:750AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(312,156,NULL,'You can modify, view and delete the details of any particular component by clicking the select button in the action column.',0,'May 28 2004 10:25:50:750AM',0,'May 28 2004 10:25:50:750AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(313,156,NULL,'You can add a new component associated with the account. It also displays the status, amount and the date when the component will be closed.',0,'May 28 2004 10:25:50:760AM',0,'May 28 2004 10:25:50:760AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(314,157,NULL,'Lets you modify or delete the ticket information',0,'May 28 2004 10:25:50:770AM',0,'May 28 2004 10:25:50:770AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(315,157,NULL,'You can view the tasks and documents related to a ticket along with the history of that document by clicking on the corresponding links.',0,'May 28 2004 10:25:50:770AM',0,'May 28 2004 10:25:50:770AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(316,158,NULL,'You can also have tasks and documents related to a ticket along with the document history.',0,'May 28 2004 10:25:50:780AM',0,'May 28 2004 10:25:50:780AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(317,158,NULL,'Lets you modify / update the ticket information.',0,'May 28 2004 10:25:50:780AM',0,'May 28 2004 10:25:50:780AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(318,159,NULL,'The details of the task can be viewed or modified by clicking on the select button under the Action column.',0,'May 28 2004 10:25:50:790AM',0,'May 28 2004 10:25:50:790AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(319,159,NULL,'You can update the task by clicking on the description of the task.',0,'May 28 2004 10:25:50:790AM',0,'May 28 2004 10:25:50:790AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(320,159,NULL,'You can add a task which is associated with the existing ticket.',0,'May 28 2004 10:25:50:790AM',0,'May 28 2004 10:25:50:790AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(321,160,NULL,'The document can be uploaded using the browse button.',0,'May 28 2004 10:25:50:880AM',0,'May 28 2004 10:25:50:880AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(322,162,NULL,'You can download all the different versions of the documents using the "Download" link in the Action column.',0,'May 28 2004 10:25:50:900AM',0,'May 28 2004 10:25:50:900AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(323,163,NULL,'The subject and the filename of the document can be modified.',0,'May 28 2004 10:25:50:910AM',0,'May 28 2004 10:25:50:910AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(324,164,NULL,'The subject and the file name can be changed. The version number is updated when an updated document is uploaded.',0,'May 28 2004 10:25:50:920AM',0,'May 28 2004 10:25:50:920AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(325,165,NULL,'The exported data can be viewed as a .csv file or in html format. The exported data can also be deleted when the select button in the action field is clicked.',0,'May 28 2004 10:25:50:930AM',0,'May 28 2004 10:25:50:930AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(326,165,NULL,'You can also choose to display a list of all the exported data in the system or the exported data created by you.',0,'May 28 2004 10:25:50:930AM',0,'May 28 2004 10:25:50:930AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(327,165,NULL,'New export data can be generated using the "Generate new export" link.',0,'May 28 2004 10:25:50:930AM',0,'May 28 2004 10:25:50:930AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(328,166,NULL,'Revenue details along with the option to modify and delete revenue.',0,'May 28 2004 10:25:50:950AM',0,'May 28 2004 10:25:50:950AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(329,168,NULL,'You can add / update an opportunity here and assign it to an employee. The opportunity can be associated with an account or a contact. Each opportunity created requires the estimate or the probability of closing the deal, the duration and the best estimate of the person following up the lead.',0,'May 28 2004 10:25:50:970AM',0,'May 28 2004 10:25:50:970AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(330,169,NULL,'You can add / update an opportunity here and assign it to an employee. The opportunity can be associated with an account or a contact. Each opportunity created requires the estimate or the probability of closing the deal, the duration and the best estimate of the person following up the lead.',0,'May 28 2004 10:25:50:980AM',0,'May 28 2004 10:25:50:980AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(331,170,NULL,'An opportunity can be renamed or deleted using the buttons present at the bottom of the page',0,'May 28 2004 10:25:50:990AM',0,'May 28 2004 10:25:50:990AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(332,170,NULL,'Clicking on the select button lets you view, modify or delete the details about the component',0,'May 28 2004 10:25:51:000AM',0,'May 28 2004 10:25:51:000AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(333,170,NULL,'Clicking on the name of the component would show the details about the component',0,'May 28 2004 10:25:51:000AM',0,'May 28 2004 10:25:51:000AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(334,170,NULL,'Add a new component which is associated with the account.',0,'May 28 2004 10:25:51:000AM',0,'May 28 2004 10:25:51:000AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(335,171,NULL,'The description of the opportunity can be changed using the update button.',0,'May 28 2004 10:25:51:010AM',0,'May 28 2004 10:25:51:010AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(336,172,NULL,'You can modify and delete the opportunity created using the modify and the delete buttons',0,'May 28 2004 10:25:51:020AM',0,'May 28 2004 10:25:51:020AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(337,173,NULL,'The component type can be selected using the ?select ? link',0,'May 28 2004 10:25:51:130AM',0,'May 28 2004 10:25:51:130AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(338,173,NULL,'You can assign the component to any of the employee present using the dropdown list present.',0,'May 28 2004 10:25:51:170AM',0,'May 28 2004 10:25:51:170AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(339,174,NULL,'The component type can be selected using the ?select ? link',0,'May 28 2004 10:25:51:230AM',0,'May 28 2004 10:25:51:230AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(340,174,NULL,'You can assign the component to any of the employee present using the dropdown list present.',0,'May 28 2004 10:25:51:270AM',0,'May 28 2004 10:25:51:270AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(341,174,NULL,'Clicking the update button can save the changes made to the component',0,'May 28 2004 10:25:51:300AM',0,'May 28 2004 10:25:51:300AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(342,175,NULL,'You can modify and delete the opportunity created using the modify and the delete buttons',0,'May 28 2004 10:25:51:310AM',0,'May 28 2004 10:25:51:310AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(343,176,NULL,'This page is contains a general information section, a block hour information section and service model options section.',0,'May 28 2004 10:25:51:320AM',0,'May 28 2004 10:25:51:320AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(344,176,NULL,'The general information section allows you to enter a service contract number, the start and end dates, the contract value, category, type, labor categories and free form description and billing notes.',0,'May 28 2004 10:25:51:320AM',0,'May 28 2004 10:25:51:320AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(345,176,NULL,'The category and type of for service contacts are configured by your administrator to suit your business requirements. If you find, that a category or type required to describe the contract is not available in the list, please contract your manager of administrator to add the options. The options can be added using the administrator view.',0,'May 28 2004 10:25:51:330AM',0,'May 28 2004 10:25:51:330AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(346,176,NULL,'The block hour information allows you to specify or adjust the hours associated with the contract.  The adjust link opens a pop up that allows you to enter hours credited or hours subtracted (preced with a ''-'' for negative numbers) a description and choose from a pre-configured list, the reason for the change. Again, if you do not find the required reason, please contact your manager or administrator to add the new option.',0,'May 28 2004 10:25:51:330AM',0,'May 28 2004 10:25:51:330AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(347,176,NULL,'When your company performs work as a result of requests to the help desk department, the hours remaining is modified based on the travel and labor hours counted towards this contract.',0,'May 28 2004 10:25:51:330AM',0,'May 28 2004 10:25:51:330AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(348,176,NULL,'The service model options allow you to specify the terms of the service contract for various types of services (telephone, onsite, email or a general response time.) All the service model options are mandatory. If  one of the service model options is not relevant to the account, it is required to explicitly choose the option that specifies that this option is not not applicable. Hence, it is recommended that each of these lists be pre-configured with at least the "not applicable" option.',0,'May 28 2004 10:25:51:340AM',0,'May 28 2004 10:25:51:340AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(349,176,NULL,'The select link in the labor categories field, allows multiple labor categories to be assigned to this service contract. The select link opens a pop up that displays labor category codes and a description of these codes. These labor category records were either setup during initial system installation or through the products module of this CRM application. If you require a labor category that is not available in the list view of the popup, you may add one using the catalog module if you have permission to add them, or contact your manager or administrator who has permissions to add labor categories using the catalog module.',0,'May 28 2004 10:25:51:340AM',0,'May 28 2004 10:25:51:340AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(350,177,NULL,'This page is contains a general information section, a block hour information section and service model options section.',0,'May 28 2004 10:25:51:350AM',0,'May 28 2004 10:25:51:350AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(351,177,NULL,'The functionality and business rule for the general information section and the service model options section are similar to those of "add contract".',0,'May 28 2004 10:25:51:440AM',0,'May 28 2004 10:25:51:440AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(352,177,NULL,'The block hour information section allows you adjust the hours for this contract. The adjust link is similar to that in the "add contract" page and allows you to either reimburse or subtract (precede with a ''-'') the hours for this contract. The new hours as a result of the adjustment is displayed when the pop up closes and is saved only when the service contract is updated.',0,'May 28 2004 10:25:51:440AM',0,'May 28 2004 10:25:51:440AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(353,179,NULL,'A history link is visible if hours where specified for this contract or when as a result of work orders to the help desk department, hours were counted towards this contract.',0,'May 28 2004 10:25:51:460AM',0,'May 28 2004 10:25:51:460AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(354,179,NULL,'The history link opens a popup that shows a list of entries that modified the hours. The hours may have been modified(or initially added)  when the service contract was created, or as a result of work orders to the help desk department or due to an explicit modification of the service contract details.',0,'May 28 2004 10:25:51:460AM',0,'May 28 2004 10:25:51:460AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(355,179,NULL,'The labor categories field displays a list of comma seperated labor category codes specified for this contract. A description of these codes can be viewed from the catalog module of this CRM application.',0,'May 28 2004 10:25:51:460AM',0,'May 28 2004 10:25:51:460AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(356,181,NULL,'The information about an asset is categorized into the specific asset information, asset category, the service contract information, the service options for this asset, the warranty information and financial information. It also allows additional notes to be entered for this asset.',0,'May 28 2004 10:25:51:480AM',0,'May 28 2004 10:25:51:480AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(357,181,NULL,'The serial number is mandatory to add an asset. It is usually provided by the manufacturer of the asset.',0,'May 28 2004 10:25:51:480AM',0,'May 28 2004 10:25:51:480AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(358,181,NULL,'The date listed is prefilled with the current date and specifies the date when the asset was recorded to be part of the service contract for this account.',0,'May 28 2004 10:25:51:480AM',0,'May 28 2004 10:25:51:480AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(359,181,NULL,'The Asset Tag is an internal identifier provided for the asset. The asset tag is usually unique for all assets associated with an account.',0,'May 28 2004 10:25:51:490AM',0,'May 28 2004 10:25:51:490AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(360,181,NULL,'The category section allows you to categorize the asset to a fine level of detail (e.g., Hardware - Server - Blade Server). Level 1, Level 2 and Level 3 are drop lists where the contents visible in each level depends upon the item chosen in the preceding level.',0,'May 28 2004 10:25:51:490AM',0,'May 28 2004 10:25:51:490AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(361,181,NULL,'The information in the drop lists of the category section are preconfigured in the admin module. If you have to add or modify the categories that need to be displayed, you may do so by configuring the asset module. An administrator or a person with access to the admin module would be able to configure the categories that need to be displayed in the category section of this page.',0,'May 28 2004 10:25:51:490AM',0,'May 28 2004 10:25:51:490AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(362,181,NULL,'The service model options section allows you to specify the service model options for an asset. The service model options for an asset are defaulted to the the service model options of the service contract that this asset is associated with. These may be changed by choosing another item from the respective drop lists.',0,'May 28 2004 10:25:51:500AM',0,'May 28 2004 10:25:51:500AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(363,181,NULL,'In the service contract section of this page, the select link opens a pop up and displays a list of service contracts associated with the account. Clicking on the add link against a service contract record in the pop up associates the specified service contract with the asset. The association is permanently recorded only when the asset is saved.',0,'May 28 2004 10:25:51:500AM',0,'May 28 2004 10:25:51:500AM',NULL,NULL,1,8)
INSERT [help_features] VALUES(364,182,NULL,'The asset details are categorized into specific asset information, asset category, service contract information, service options for this asset, warranty information and financial information.',0,'May 28 2004 10:25:51:520AM',0,'May 28 2004 10:25:51:520AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(365,182,NULL,'The service model options for this asset displays the items chosen when the asset record was created or modified. If they are specified to default to the service options in the service contract, the option is preceded by the word ''Default''.',0,'May 28 2004 10:25:51:520AM',0,'May 28 2004 10:25:51:520AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(366,185,NULL,'The account contact information  consists of the contact''s name and contact information (email, telephone and postal addresses.)',0,'May 28 2004 10:25:51:560AM',0,'May 28 2004 10:25:51:560AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(367,185,NULL,'The ''select'' link of the contact type field open''s a popup that allows you to choose the contact types that are applicable for this contact. The contact types are preconfigured in the admin module. If you do not find a contact type that you need, you may edit the types in the admin module or contact your supervisor or an administrator who has permissions to do so.',0,'May 28 2004 10:25:51:560AM',0,'May 28 2004 10:25:51:560AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(368,185,NULL,'Checking the box at the end of this page enables you to provide portal access to this account contact. Since portal usage information is sent by email to the account contacts, to complete the process of providing portal access to an account contact, it is mandatory for the account contact to have an email address.',0,'May 28 2004 10:25:51:560AM',0,'May 28 2004 10:25:51:560AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(369,186,NULL,'The ''select'' link of the contact type field open''s a popup that allows you to choose the contact types that are applicable for this contact. The contact types are preconfigured in the admin module. If you do not find a contact type that you need, you may edit the types in the admin module or contact your supervisor or an administrator who has permissions to do so.',0,'May 28 2004 10:25:51:570AM',0,'May 28 2004 10:25:51:570AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(370,186,NULL,'The details can be updated using the update button.',0,'May 28 2004 10:25:51:580AM',0,'May 28 2004 10:25:51:580AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(371,186,NULL,'The account contact information consists of the contact''s name and contact information (email, telephone and postal addresses.)',0,'May 28 2004 10:25:51:580AM',0,'May 28 2004 10:25:51:580AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(372,187,NULL,'Based on your permissions, you can provide portal access to an account contact who does not have portal access, edit the portal user information and disable(or enable) the portal user from this page.',0,'May 28 2004 10:25:51:590AM',0,'May 28 2004 10:25:51:590AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(373,187,NULL,'If the account contact does not have an email address, you will not be allowed to add or edit the portal user information for the account contact.',0,'May 28 2004 10:25:51:590AM',0,'May 28 2004 10:25:51:590AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(374,188,NULL,'The information that is modified in this page affects portal access to the application for the user.',0,'May 28 2004 10:25:51:600AM',0,'May 28 2004 10:25:51:600AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(375,188,NULL,'The information than can be modified are, the portal role (if more than one role exists,) the expiration date and the password.',0,'May 28 2004 10:25:51:600AM',0,'May 28 2004 10:25:51:600AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(376,188,NULL,'The password is automatically generated and mailed to the account contact, hence, for this purpose it is mandatory for the account contact to have an email address when the portal information is modified.',0,'May 28 2004 10:25:51:610AM',0,'May 28 2004 10:25:51:610AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(377,189,NULL,'This page allows you to specify the portall role, the expiration date and the email to which portal access information (username and password) is sent.',0,'May 28 2004 10:25:51:620AM',0,'May 28 2004 10:25:51:620AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(378,189,NULL,'The password is automatically generated and mailed to the account contact, hence, for this purpose it is mandatory for the account contact to have an email address when the portal information is modified.',0,'May 28 2004 10:25:51:620AM',0,'May 28 2004 10:25:51:620AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(379,190,NULL,'Clicking the select button under the action column gives you the option to view the details about the campaign, download the mail merge and also lets you to export it to Excel.',0,'May 28 2004 10:25:51:640AM',0,'May 28 2004 10:25:51:640AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(380,190,NULL,'Clicking on the campaign name gives you complete details about the campaign.',0,'May 28 2004 10:25:51:640AM',0,'May 28 2004 10:25:51:640AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(381,190,NULL,'You can display the campaigns created and their details using three different views by selecting from the drop down list.',0,'May 28 2004 10:25:51:640AM',0,'May 28 2004 10:25:51:640AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(382,191,NULL,'This creates a new Campaign. This takes in both the campaign and its description.',0,'May 28 2004 10:25:51:650AM',0,'May 28 2004 10:25:51:650AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(383,192,NULL,'You can view, modify and delete details by clicking the select button under the action column.',0,'May 28 2004 10:25:51:740AM',0,'May 28 2004 10:25:51:740AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(384,192,NULL,'For each of the campaign, the groups, message and delivery columns show whether they are complete or not. Clicking on these will help you choose the group, message and the delivery date.',0,'May 28 2004 10:25:51:750AM',0,'May 28 2004 10:25:51:750AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(385,192,NULL,'Clicking the name of the campaign shows you more details about the campaign and also shows the list of the things to be selected before a campaign can be activated',0,'May 28 2004 10:25:51:750AM',0,'May 28 2004 10:25:51:750AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(386,192,NULL,'You can view your incomplete campaigns or all the incomplete campaigns. You can select the view with the drop down list at the top.',0,'May 28 2004 10:25:51:750AM',0,'May 28 2004 10:25:51:750AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(387,192,NULL,'Add a campaign',0,'May 28 2004 10:25:51:750AM',0,'May 28 2004 10:25:51:750AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(388,193,NULL,'You can also click the select button under the Action column for viewing, modifying or deleting the details.',0,'May 28 2004 10:25:51:760AM',0,'May 28 2004 10:25:51:760AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(389,193,NULL,'Clicking the group name will show the list of contacts present in the group.',0,'May 28 2004 10:25:51:760AM',0,'May 28 2004 10:25:51:760AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(390,193,NULL,'Add a contact group using the link "Add a Contact Group".',0,'May 28 2004 10:25:51:770AM',0,'May 28 2004 10:25:51:770AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(391,193,NULL,'You can filter the list of groups displayed by selecting from the drop down.',0,'May 28 2004 10:25:51:770AM',0,'May 28 2004 10:25:51:770AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(392,194,NULL,'You can preview the details of the group by clicking on the preview button.',0,'May 28 2004 10:25:51:780AM',0,'May 28 2004 10:25:51:780AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(393,194,NULL,'You can also select from the list of "Selected criteria and contacts" and remove them by clicking the remove button.',0,'May 28 2004 10:25:51:780AM',0,'May 28 2004 10:25:51:780AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(394,194,NULL,'You can define the criteria to generate the list by using the different filters present and then add them to the "Selected criteria and contacts".',0,'May 28 2004 10:25:51:780AM',0,'May 28 2004 10:25:51:780AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(395,194,NULL,'You can select the criteria for the group to be created. Clicking the "Add/Remove Contacts" can choose the specific contacts.',0,'May 28 2004 10:25:51:780AM',0,'May 28 2004 10:25:51:780AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(396,195,NULL,'You can view, modify, clone or delete each of the messages.',0,'May 28 2004 10:25:51:800AM',0,'May 28 2004 10:25:51:800AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(397,195,NULL,'The dropdown list acts as filters for displaying the messages that meet certain criteria.',0,'May 28 2004 10:25:51:800AM',0,'May 28 2004 10:25:51:800AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(398,195,NULL,'Clicking on the message name will show details about the message, which can be updated.',0,'May 28 2004 10:25:51:800AM',0,'May 28 2004 10:25:51:800AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(399,195,NULL,'Add a new message',0,'May 28 2004 10:25:51:800AM',0,'May 28 2004 10:25:51:800AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(400,196,NULL,'The new message can be saved by clicking the save message button.',0,'May 28 2004 10:25:51:810AM',0,'May 28 2004 10:25:51:810AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(401,196,NULL,'The permissions or the access type for the message can be chosen from drop down box.',0,'May 28 2004 10:25:51:810AM',0,'May 28 2004 10:25:51:810AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(402,197,NULL,'Clicking on the "surveys" will let you create new interactive surveys.',0,'May 28 2004 10:25:51:820AM',0,'May 28 2004 10:25:51:820AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(403,198,NULL,'You can use the preview button to view the details about the contacts in a group.',0,'May 28 2004 10:25:51:830AM',0,'May 28 2004 10:25:51:830AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(404,198,NULL,'You can modify or delete a group.',0,'May 28 2004 10:25:51:830AM',0,'May 28 2004 10:25:51:830AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(405,199,NULL,'You can change the version of the document when ever an updated document is uploaded.',0,'May 28 2004 10:25:51:840AM',0,'May 28 2004 10:25:51:840AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(406,203,NULL,'You can browse to select a new document to upload if its related to the campaign.',0,'May 28 2004 10:25:51:870AM',0,'May 28 2004 10:25:51:870AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(407,205,NULL,'You can also go back from the current detailed view to the group details criteria.',0,'May 28 2004 10:25:51:980AM',0,'May 28 2004 10:25:51:980AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(408,206,NULL,'You can download from the list of documents available by using the "download" link under the action column.',0,'May 28 2004 10:25:51:990AM',0,'May 28 2004 10:25:51:990AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(409,208,NULL,'The name of the survey is a mandatory field for creating a survey. A description, introduction and thank-you note can also be added.',0,'May 28 2004 10:25:52:010AM',0,'May 28 2004 10:25:52:010AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(410,210,NULL,'You can download the mail merge shown at the bottom of the details.',0,'May 28 2004 10:25:52:020AM',0,'May 28 2004 10:25:52:020AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(411,211,NULL,'Different versions of the document can be downloaded using the "download" link in the action column.',0,'May 28 2004 10:25:52:030AM',0,'May 28 2004 10:25:52:030AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(412,216,NULL,'You can update the campaign schedule by filling in the run date and the delivery method whether it''s an email, fax or letter or any other method.',0,'May 28 2004 10:25:52:150AM',0,'May 28 2004 10:25:52:150AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(413,217,NULL,'You can also generate a list of contacts be selecting from the filters and adding them to the "selected criteria and contacts" list.',0,'May 28 2004 10:25:52:160AM',0,'May 28 2004 10:25:52:160AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(414,217,NULL,'You can choose the contacts in the group using the "Add / Remove contacts" link present.',0,'May 28 2004 10:25:52:160AM',0,'May 28 2004 10:25:52:160AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(415,217,NULL,'You can update the name of the group',0,'May 28 2004 10:25:52:160AM',0,'May 28 2004 10:25:52:160AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(416,219,NULL,'There can be multiple attachments to a single message. The attachment that needs to be downloaded has to be selected first and then downloaded.',0,'May 28 2004 10:25:52:180AM',0,'May 28 2004 10:25:52:180AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(417,223,NULL,'The details of the documents can be viewed or modified by clicking on the select button under the Action column.',0,'May 28 2004 10:25:52:210AM',0,'May 28 2004 10:25:52:210AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(418,223,NULL,'You can view the details, modify, download or delete the documents associated with the account.',0,'May 28 2004 10:25:52:210AM',0,'May 28 2004 10:25:52:210AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(419,223,NULL,'A new document can be added to the account.',0,'May 28 2004 10:25:52:210AM',0,'May 28 2004 10:25:52:210AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(420,223,NULL,'The document versions can be updated by using the "add version" link.',0,'May 28 2004 10:25:52:210AM',0,'May 28 2004 10:25:52:210AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(421,224,NULL,'The name of the campaign can be changed or deleted by using the buttons at the bottom of the page.',0,'May 28 2004 10:25:52:230AM',0,'May 28 2004 10:25:52:230AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(422,224,NULL,'You can choose a group / groups, a message for the campaign, and a delivery date for the campaign to start. You can also add attachments to the messages you send to recipients.',0,'May 28 2004 10:25:52:230AM',0,'May 28 2004 10:25:52:230AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(423,225,NULL,'You can check the groups you want for the current campaign.',0,'May 28 2004 10:25:52:240AM',0,'May 28 2004 10:25:52:240AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(424,225,NULL,'You can also add attachments to the messages you send to recipients by clicking the preview recipient''s link next to each group.',0,'May 28 2004 10:25:52:240AM',0,'May 28 2004 10:25:52:240AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(425,225,NULL,'You can view all the groups present or the groups created by you just by choosing from the drop down box.',0,'May 28 2004 10:25:52:240AM',0,'May 28 2004 10:25:52:240AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(426,226,NULL,'You can select a message for this campaign from the dropdown list of all the messages or just your messages.',0,'May 28 2004 10:25:52:250AM',0,'May 28 2004 10:25:52:250AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(427,226,NULL,'The messages can be of multiple types, which can be used as filters and can be selected from the drop down list. For each type you have further classification.',0,'May 28 2004 10:25:52:250AM',0,'May 28 2004 10:25:52:250AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(428,227,NULL,'The attachments configured are the surveys or the file attachments. Using the links "change survey" and "change file attachments", you can change either of them.',0,'May 28 2004 10:25:52:260AM',0,'May 28 2004 10:25:52:260AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(429,228,NULL,'You can view and select from all, or only your own surveys.',0,'May 28 2004 10:25:52:270AM',0,'May 28 2004 10:25:52:270AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(430,229,NULL,'You can download or remove the file name. You can also upload files using the browse button.',0,'May 28 2004 10:25:52:280AM',0,'May 28 2004 10:25:52:280AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(431,230,NULL,'The name and the description of the campaign can be changed.',0,'May 28 2004 10:25:52:290AM',0,'May 28 2004 10:25:52:290AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(432,231,NULL,'You can modify, delete or clone the message details by clicking on corresponding buttons.',0,'May 28 2004 10:25:52:300AM',0,'May 28 2004 10:25:52:300AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(433,232,NULL,'You can select font properties for the text of the message along with the size and indentation.',0,'May 28 2004 10:25:52:300AM',0,'May 28 2004 10:25:52:300AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(434,232,NULL,'The name of the message and the access type can be given, which specifies who can view the message.',0,'May 28 2004 10:25:52:310AM',0,'May 28 2004 10:25:52:310AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(435,233,NULL,'You can modify, delete or clone the message details by clicking on corresponding buttons.',0,'May 28 2004 10:25:52:310AM',0,'May 28 2004 10:25:52:310AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(436,234,NULL,'You can select font properties for the text of the message along with the size and indentation.',0,'May 28 2004 10:25:52:410AM',0,'May 28 2004 10:25:52:410AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(437,234,NULL,'The name of the message and the access type can be given, which specifies who can view the message.',0,'May 28 2004 10:25:52:410AM',0,'May 28 2004 10:25:52:410AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(438,235,NULL,'You can also view, modify and delete the details of a survey.',0,'May 28 2004 10:25:52:420AM',0,'May 28 2004 10:25:52:420AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(439,235,NULL,'Clicking on the name of the survey shows its details.',0,'May 28 2004 10:25:52:420AM',0,'May 28 2004 10:25:52:420AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(440,235,NULL,'Add a new survey',0,'May 28 2004 10:25:52:430AM',0,'May 28 2004 10:25:52:430AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(441,235,NULL,'You can view all or your own surveys using the drop down list.',0,'May 28 2004 10:25:52:430AM',0,'May 28 2004 10:25:52:430AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(442,236,NULL,'The "Save & Add" button saves the current question and lets you add another one immediately.',0,'May 28 2004 10:25:52:443AM',0,'May 28 2004 10:25:52:443AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(443,236,NULL,'You can also specify whether the particular question is required or not by checking the checkbox.',0,'May 28 2004 10:25:52:443AM',0,'May 28 2004 10:25:52:443AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(444,236,NULL,'If the selected question type is "Item List", then an Edit button is enabled which helps in adding new elements to the existing list.',0,'May 28 2004 10:25:52:443AM',0,'May 28 2004 10:25:52:443AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(445,236,NULL,'A new question type can be selected through the drop down list.',0,'May 28 2004 10:25:52:443AM',0,'May 28 2004 10:25:52:443AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(446,237,NULL,'The preview button shows you the survey questions in a pop-up window.',0,'May 28 2004 10:25:52:453AM',0,'May 28 2004 10:25:52:453AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(447,237,NULL,'You can modify, delete, and preview the survey details using the buttons at the top of the page.',0,'May 28 2004 10:25:52:463AM',0,'May 28 2004 10:25:52:463AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(448,237,NULL,'You can view the survey introduction text, the questions and the thank-you text.',0,'May 28 2004 10:25:52:463AM',0,'May 28 2004 10:25:52:463AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(449,238,NULL,'You can add questions to the survey here.',0,'May 28 2004 10:25:52:473AM',0,'May 28 2004 10:25:52:473AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(450,238,NULL,'Clicking the "Done" button can save the survey and you can also traverse back by clicking the "Back" button.',0,'May 28 2004 10:25:52:473AM',0,'May 28 2004 10:25:52:473AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(451,238,NULL,'The survey questions can be moved up or down using the "Up" or "Down" links present in the action field.',0,'May 28 2004 10:25:52:473AM',0,'May 28 2004 10:25:52:473AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(452,238,NULL,'You can edit or delete any of the survey questions using the "edit" or "del" link under the action field.',0,'May 28 2004 10:25:52:473AM',0,'May 28 2004 10:25:52:473AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(453,238,NULL,'You can add new survey questions here.',0,'May 28 2004 10:25:52:483AM',0,'May 28 2004 10:25:52:483AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(454,239,NULL,'You can click on "Create Attachments" and include interactive items, like surveys, or provide additional materials like files.',0,'May 28 2004 10:25:52:483AM',0,'May 28 2004 10:25:52:483AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(455,239,NULL,'Clicking the "Create Message"  link lets you compose a message to reach your audience.',0,'May 28 2004 10:25:52:493AM',0,'May 28 2004 10:25:52:493AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(456,239,NULL,'You can click the "Build Groups" link to assemble dynamic distribution of groups. Each campaign needs at least one group to send a message to.',0,'May 28 2004 10:25:52:493AM',0,'May 28 2004 10:25:52:493AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(457,239,NULL,'The "Campaign Builder" can be clicked to select groups of contacts that you would like to send a message to, schedule a delivery date, etc.',0,'May 28 2004 10:25:52:493AM',0,'May 28 2004 10:25:52:493AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(458,239,NULL,'You can click on the "Dashboard" to view the sent messages and to drill down and view recipients and survey results.',0,'May 28 2004 10:25:52:493AM',0,'May 28 2004 10:25:52:493AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(459,240,NULL,'Lets you modify or delete ticket information',0,'May 28 2004 10:25:52:523AM',0,'May 28 2004 10:25:52:523AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(460,240,NULL,'You can also store tasks and documents related to a ticket.',0,'May 28 2004 10:25:52:523AM',0,'May 28 2004 10:25:52:523AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(461,241,NULL,'For each new ticket you can select the organization, the contact and also the issue for which the ticket is being created. The assignment and the resolution of the ticket can also be entered.',0,'May 28 2004 10:25:52:533AM',0,'May 28 2004 10:25:52:533AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(462,242,NULL,'The search can be done based on different parameters like the ticket number, account associated, priority, employee whom the ticket is assigned etc.',0,'May 28 2004 10:25:52:533AM',0,'May 28 2004 10:25:52:533AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(463,243,NULL,'Clicking on the subject of the exported data shows you the details of the ticket like the ticket ID, the organization and its issue (why the particular ticket was generated).',0,'May 28 2004 10:25:52:543AM',0,'May 28 2004 10:25:52:543AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(464,243,NULL,'Clicking on the select button under the action column lets you view the data, download the data in .CSV format or delete the data.',0,'May 28 2004 10:25:52:543AM',0,'May 28 2004 10:25:52:543AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(465,243,NULL,'You can filter the exported date generated, by you or by all employees using the dropdown list.',0,'May 28 2004 10:25:52:553AM',0,'May 28 2004 10:25:52:553AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(466,243,NULL,'You can generate a new exported data by clicking the link "Generate new export".',0,'May 28 2004 10:25:52:553AM',0,'May 28 2004 10:25:52:553AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(467,244,NULL,'You can save the details of the modified ticket by clicking the "Update" button.',0,'May 28 2004 10:25:52:563AM',0,'May 28 2004 10:25:52:563AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(468,245,NULL,'You can save the details of the modified ticket by clicking the "Update" button.',0,'May 28 2004 10:25:52:573AM',0,'May 28 2004 10:25:52:573AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(469,246,NULL,'The details of the task can be viewed or modified by clicking on the select button under the Action column.',0,'May 28 2004 10:25:52:583AM',0,'May 28 2004 10:25:52:583AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(470,246,NULL,'You can update the task by clicking on the description of the task.',0,'May 28 2004 10:25:52:583AM',0,'May 28 2004 10:25:52:583AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(471,246,NULL,'You can add a task which is associated with the existing ticket.',0,'May 28 2004 10:25:52:583AM',0,'May 28 2004 10:25:52:583AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(472,247,NULL,'The details of the documents can be viewed or modified by clicking on the select button under the Action column.',0,'May 28 2004 10:25:52:603AM',0,'May 28 2004 10:25:52:603AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(473,247,NULL,'You can view the details, modify, download or delete the documents associated with the ticket.',0,'May 28 2004 10:25:52:613AM',0,'May 28 2004 10:25:52:613AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(474,247,NULL,'A new document associated with the ticket can be added.',0,'May 28 2004 10:25:52:633AM',0,'May 28 2004 10:25:52:633AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(475,247,NULL,'The document versions can be updated by using the "add version" link.',0,'May 28 2004 10:25:52:633AM',0,'May 28 2004 10:25:52:633AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(476,248,NULL,'A new record is added into the folder using the link "Add a record to this folder". Multiple records can be added to this folder if the folder has the necessary settings.',0,'May 28 2004 10:25:52:733AM',0,'May 28 2004 10:25:52:733AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(477,248,NULL,'You can select the custom folder using the drop down list.',0,'May 28 2004 10:25:52:733AM',0,'May 28 2004 10:25:52:733AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(478,249,NULL,'The details are saved by clicking the save button.',0,'May 28 2004 10:25:52:743AM',0,'May 28 2004 10:25:52:743AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(479,250,NULL,'A chronological history of all actions associated with a ticket is maintined.',0,'May 28 2004 10:25:52:753AM',0,'May 28 2004 10:25:52:753AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(480,258,NULL,'The changes can be saved using the "Update" button.',0,'May 28 2004 10:25:52:813AM',0,'May 28 2004 10:25:52:813AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(481,259,NULL,'You can modify the folder information along with the record details by clicking on the Modify button.',0,'May 28 2004 10:25:52:813AM',0,'May 28 2004 10:25:52:813AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(482,262,NULL,'The document can be uploaded using the browse button.',0,'May 28 2004 10:25:52:843AM',0,'May 28 2004 10:25:52:843AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(483,263,NULL,'You can download all the versions of a document.',0,'May 28 2004 10:25:52:853AM',0,'May 28 2004 10:25:52:853AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(484,264,NULL,'You can also have tasks and documents related to a ticket.',0,'May 28 2004 10:25:52:853AM',0,'May 28 2004 10:25:52:853AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(485,264,NULL,'Lets you modify / update the ticket information.',0,'May 28 2004 10:25:52:863AM',0,'May 28 2004 10:25:52:863AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(486,265,NULL,'A new version of a file can be uploaded using the browse button.',0,'May 28 2004 10:25:52:863AM',0,'May 28 2004 10:25:52:863AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(487,266,NULL,'You can delete a record by clicking on "Del" next to the record.',0,'May 28 2004 10:25:52:873AM',0,'May 28 2004 10:25:52:873AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(488,266,NULL,'You can add a record by clicking on "Add Ticket".',0,'May 28 2004 10:25:52:873AM',0,'May 28 2004 10:25:52:873AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(489,266,NULL,'You can view more records in a particular section by clicking "Show More".',0,'May 28 2004 10:25:52:883AM',0,'May 28 2004 10:25:52:883AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(490,266,NULL,'You can view more details by clicking on the record.',0,'May 28 2004 10:25:52:883AM',0,'May 28 2004 10:25:52:883AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(491,266,NULL,'You can update a record by clicking on "Edit" next to the record.',0,'May 28 2004 10:25:52:883AM',0,'May 28 2004 10:25:52:883AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(492,267,NULL,'The first activity date displays the date at which work started in an activity log and the last activity date displays the last date that work was done for the activity log.',0,'May 28 2004 10:25:52:913AM',0,'May 28 2004 10:25:52:913AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(493,267,NULL,'You may view, add, edit and delete activity logs from this page based on your permissions',0,'May 28 2004 10:25:52:913AM',0,'May 28 2004 10:25:52:913AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(494,267,NULL,'Adding, editing and deleting activity logs with hours counting towards a service contract changes the hours remaining in a service contract. The hours remaining is displayed in the ticket header.',0,'May 28 2004 10:25:52:913AM',0,'May 28 2004 10:25:52:913AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(495,268,NULL,'This page is divided into the general information, per day description of service and additional information sections',0,'May 28 2004 10:25:52:923AM',0,'May 28 2004 10:25:52:923AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(496,268,NULL,'The ''General Information'' section displays the associated service contract.',0,'May 28 2004 10:25:52:923AM',0,'May 28 2004 10:25:52:923AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(497,268,NULL,'The ''Per Day Description of Service'' section that allows you to enter description of work done.',0,'May 28 2004 10:25:52:953AM',0,'May 28 2004 10:25:52:953AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(498,268,NULL,'The ''Additional information'' section that allows you to enter the follow up information and phone and engineer response time.',0,'May 28 2004 10:25:53:013AM',0,'May 28 2004 10:25:53:013AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(499,269,NULL,'This page is divided into the general information, per day description of service and additional information sections',0,'May 28 2004 10:25:53:053AM',0,'May 28 2004 10:25:53:053AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(500,269,NULL,'The travel time and the labor time in the per day description section are summed and displayed to you for reference.',0,'May 28 2004 10:25:53:053AM',0,'May 28 2004 10:25:53:053AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(501,270,NULL,'This page is divided into the general information, per day description of service and additional information sections',0,'May 28 2004 10:25:53:063AM',0,'May 28 2004 10:25:53:063AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(502,270,NULL,'The ''General Information'' section displays the associated service contract.',0,'May 28 2004 10:25:53:063AM',0,'May 28 2004 10:25:53:063AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(503,270,NULL,'The ''Per Day Description of Service'' section that allows you to enter description of work done.',0,'May 28 2004 10:25:53:063AM',0,'May 28 2004 10:25:53:063AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(504,270,NULL,'# The ''Additional information'' section that allows you to enter the follow up information and phone and engineer response time.',0,'May 28 2004 10:25:53:063AM',0,'May 28 2004 10:25:53:063AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(505,271,NULL,'This page displays information about an asset that is relevant for maintenance work to be done on the asset and then displays the maintenance notes for the asset created to resolve the issue recorded in the ticket.',0,'May 28 2004 10:25:53:083AM',0,'May 28 2004 10:25:53:083AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(506,271,NULL,'You may view, add, edit and delete maintenance notes from this page based on your permissions.',0,'May 28 2004 10:25:53:093AM',0,'May 28 2004 10:25:53:093AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(507,272,NULL,'This page is divided into a general maintenance information section and a replacement parts section.',0,'May 28 2004 10:25:53:093AM',0,'May 28 2004 10:25:53:093AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(508,272,NULL,'The general mainetenance information section allows you to enter a description relating the reason for failure of the asset, or a description relating to the neccessity to service or upgrade the asset to keep it performing optimally or to include additional features.',0,'May 28 2004 10:25:53:103AM',0,'May 28 2004 10:25:53:103AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(509,272,NULL,'The replacement parts section allows you to enter the part number and a description of the part in each row. It initially displays three rows, allowing three parts to be entered. If additional parts need to be entered, you may save this maintenance note and choose to modify it. The modify page allows you to enter an additional part. Alternatively, to add more replacement parts, you may create another maintenance note.',0,'May 28 2004 10:25:53:103AM',0,'May 28 2004 10:25:53:103AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(510,273,NULL,'This page is divided into a general maintenance information section and a replacement parts section.',0,'May 28 2004 10:25:53:203AM',0,'May 28 2004 10:25:53:203AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(511,273,NULL,'The general mainetenance information section allows you to modify the description relating the reason for failure of the asset, or a description relating to the neccessity to service or upgrade the asset to keep it performing optimally or to include additional features.',0,'May 28 2004 10:25:53:203AM',0,'May 28 2004 10:25:53:203AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(512,273,NULL,'The replacement parts section allows you to enter the part number and a description of the part in each row.  It displays one additional row to allow you to enter an additional replacement part. If more parts need to be entered, you may update this maintenance note and choose to modify it again. Alternatively, to add more replacement parts, you may create another maintenance note.',0,'May 28 2004 10:25:53:203AM',0,'May 28 2004 10:25:53:203AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(513,274,NULL,'A new detailed employee record can be added.',0,'May 28 2004 10:25:53:233AM',0,'May 28 2004 10:25:53:233AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(514,274,NULL,'The details of each employee can be viewed, modified or deleted using the select button in the action column.',0,'May 28 2004 10:25:53:233AM',0,'May 28 2004 10:25:53:233AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(515,275,NULL,'You can modify or delete the employee details using the modify or delete buttons.',0,'May 28 2004 10:25:53:243AM',0,'May 28 2004 10:25:53:243AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(516,276,NULL,'The "Save" button saves the details of the employee entered.',0,'May 28 2004 10:25:53:243AM',0,'May 28 2004 10:25:53:243AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(517,276,NULL,'The "Save & New" button lets you to save the details of one employee and enter another employee in one operation.',0,'May 28 2004 10:25:53:253AM',0,'May 28 2004 10:25:53:253AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(518,277,NULL,'Clicking on the update button saves the modified details of the employee.',0,'May 28 2004 10:25:53:253AM',0,'May 28 2004 10:25:53:253AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(519,278,NULL,'The employee record can be modified or deleted from the system completely.',0,'May 28 2004 10:25:53:263AM',0,'May 28 2004 10:25:53:263AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(520,279,NULL,'You can cancel the reports that are scheduled to be processed by the server by the clicking the select button.',0,'May 28 2004 10:25:53:283AM',0,'May 28 2004 10:25:53:283AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(521,279,NULL,'The generated reports can be deleted or viewed/downloaded in .pdf format by clicking the select button under the action column.',0,'May 28 2004 10:25:53:293AM',0,'May 28 2004 10:25:53:293AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(522,279,NULL,'Add a new report',0,'May 28 2004 10:25:53:293AM',0,'May 28 2004 10:25:53:293AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(523,280,NULL,'There are four different modules and you can click on the module where you want to generate the report.',0,'May 28 2004 10:25:53:303AM',0,'May 28 2004 10:25:53:303AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(524,283,NULL,'You can use the "generate report" button to run the report.',0,'May 28 2004 10:25:53:313AM',0,'May 28 2004 10:25:53:313AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(525,283,NULL,'If the parameters exist, you can specify the name of the criteria for future reference and click the check box present at the bottom of the page.',0,'May 28 2004 10:25:53:403AM',0,'May 28 2004 10:25:53:403AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(526,284,NULL,'You can run the report by clicking on the title of the report.',0,'May 28 2004 10:25:53:413AM',0,'May 28 2004 10:25:53:413AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(527,285,NULL,'If the criteria are present, select the criteria, then continue to enter the parameters to run the report.',0,'May 28 2004 10:25:53:423AM',0,'May 28 2004 10:25:53:423AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(528,286,NULL,'You can view the queue either by using the link in the text or using the view queue button.',0,'May 28 2004 10:25:53:433AM',0,'May 28 2004 10:25:53:433AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(529,287,NULL,'You can cancel the report that is scheduled to be processed by the server by clicking the select button and selecting "Cancel".',0,'May 28 2004 10:25:53:443AM',0,'May 28 2004 10:25:53:443AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(530,287,NULL,'You can view the reports generated, download them or delete them by clicking on the select button under the action column.',0,'May 28 2004 10:25:53:443AM',0,'May 28 2004 10:25:53:443AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(531,287,NULL,'A new report can be generated by clicking on the link "Add a Report".',0,'May 28 2004 10:25:53:443AM',0,'May 28 2004 10:25:53:443AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(532,288,NULL,'The alphabetical slide rule allows users to be listed based on their last name. Simply click on the starting letter desired.',0,'May 28 2004 10:25:53:463AM',0,'May 28 2004 10:25:53:463AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(533,288,NULL,'The columns "Name", ''Username" and "Role" can be clicked to display the users in the ascending or descending order of the chosen criteria.',0,'May 28 2004 10:25:53:463AM',0,'May 28 2004 10:25:53:463AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(534,288,NULL,'The "Add New User" link opens a window that allows the administrator to add new users.',0,'May 28 2004 10:25:53:463AM',0,'May 28 2004 10:25:53:463AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(535,288,NULL,'The "select" buttons in the "Action" column alongside the name of each user opens a pop-up menu that provides the administrator with options to view more information, modify user information, or disable (or inactivate) the user.',0,'May 28 2004 10:25:53:473AM',0,'May 28 2004 10:25:53:473AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(536,288,NULL,'The list is displayed with 10 names per page by default. Additional items in the list may be viewed by clicking on the "Previous" and "Next" navigation links at the bottom of the table or by changing the number of items to be displayed per page.',0,'May 28 2004 10:25:53:473AM',0,'May 28 2004 10:25:53:473AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(537,288,NULL,'The users of the CRM system are listed in alphabetical order. Their user name, role and who they report to are also listed to provide a quick overview of information for each user.',0,'May 28 2004 10:25:53:473AM',0,'May 28 2004 10:25:53:473AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(538,288,NULL,'The drop list provides a filter to either view only the active or only the inactive users. Inactive users are those who do not have the privilege to use the system currently either because their user names have been disabled or they have expired. These users may be activated (enabled) at a later time.',0,'May 28 2004 10:25:53:473AM',0,'May 28 2004 10:25:53:473AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(539,289,NULL,'The ''Reports To" field allows the administrator to setup a user hierarchy. The drop list displays all the users of the system and allows one to be chosen.',0,'May 28 2004 10:25:53:483AM',0,'May 28 2004 10:25:53:483AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(540,289,NULL,'The "Role" drop list allows a role to be associated with a user. This association determines the privileges the user may have when he accesses the system.',0,'May 28 2004 10:25:53:483AM',0,'May 28 2004 10:25:53:483AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(541,289,NULL,'The "Password" fields allows the administrator to setup a password for the user. The password is used along with the Username to login to the system. Since the password is stored in encrypted form and cannot be interpreted, the administrator is asked to confirm the users password. The user may subsequently change his password according to personal preferences.',0,'May 28 2004 10:25:53:493AM',0,'May 28 2004 10:25:53:493AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(542,289,NULL,'The Username is the phrase that is used by the user to login to the system. It must be unique.',0,'May 28 2004 10:25:53:493AM',0,'May 28 2004 10:25:53:493AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(543,289,NULL,'An "Expire Date" may be set for each user after which the user is disabled. If this field is left blank the user is active indefinitely. This date can either be typed in the mm/dd/yyyy format or chosen from a calendar that can be accessed from the icon at the right of the field.',0,'May 28 2004 10:25:53:493AM',0,'May 28 2004 10:25:53:493AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(544,289,NULL,'The contact field allows the administrator to associate contact information with the user. The administrator may either create new contact information or choose one from the existing list of contacts. This information provides the administrator with the user''s e-mail, telephone and (or) fax number, postal address and any other information that may help the administrator or the system manager to contact the user.',0,'May 28 2004 10:25:53:493AM',0,'May 28 2004 10:25:53:493AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(545,290,NULL,'The "Cancel" button allows current and uncommitted changes to be undone.',0,'May 28 2004 10:25:53:513AM',0,'May 28 2004 10:25:53:513AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(546,290,NULL,'When the "Generate new password" field is checked, the system constructs a password for the user and uses the contact information to email the new password to the user.',0,'May 28 2004 10:25:53:513AM',0,'May 28 2004 10:25:53:513AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(547,290,NULL,'The "Disable" button provides a quick link to the administrator to disable the user.',0,'May 28 2004 10:25:53:513AM',0,'May 28 2004 10:25:53:513AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(548,290,NULL,'The "Username", "Role", "Reports To" and password of the user are editable. For more information about each of these fields see help on "Add user".',0,'May 28 2004 10:25:53:513AM',0,'May 28 2004 10:25:53:513AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(549,291,NULL,'The list is displayed by default with 10 items per page, additional items in the login history may be viewed by clicking on the "Previous" and "Next" navigation links at the bottom of the table or by changing the number of items to be displayed on a page.',0,'May 28 2004 10:25:53:523AM',0,'May 28 2004 10:25:53:523AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(550,291,NULL,'The login history of the user displays the IP address of the computer from which the user logged in, and the date/time when the user logged in.',0,'May 28 2004 10:25:53:523AM',0,'May 28 2004 10:25:53:523AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(551,292,NULL,'Clicking on the select button under the action column would let you to view the details about the viewpoint also modify them.',0,'May 28 2004 10:25:53:533AM',0,'May 28 2004 10:25:53:533AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(552,292,NULL,'You can click on the contact under the viewpoint column to know more details about that viewpoint and its permissions.',0,'May 28 2004 10:25:53:533AM',0,'May 28 2004 10:25:53:533AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(553,292,NULL,'You can add a new viewpoint using the link "Add New Viewpoint".',0,'May 28 2004 10:25:53:543AM',0,'May 28 2004 10:25:53:543AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(554,293,NULL,'You can add a new viewpoint by any employee by clicking the add button.',0,'May 28 2004 10:25:53:553AM',0,'May 28 2004 10:25:53:553AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(555,293,NULL,'The permissions for the different modules can be given by checking the Access checkbox.',0,'May 28 2004 10:25:53:563AM',0,'May 28 2004 10:25:53:563AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(556,293,NULL,'The contact can be selected and removed using the links "change contact" and "clear contact".',0,'May 28 2004 10:25:53:563AM',0,'May 28 2004 10:25:53:563AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(557,294,NULL,'The details can be updated using the update button.',0,'May 28 2004 10:25:53:573AM',0,'May 28 2004 10:25:53:573AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(558,294,NULL,'You can also set the permissions to access different modules by checking the check box under the Access column.',0,'May 28 2004 10:25:53:573AM',0,'May 28 2004 10:25:53:573AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(559,294,NULL,'You can enable the viewpoint by checking the "Enabled" checkbox.',0,'May 28 2004 10:25:53:573AM',0,'May 28 2004 10:25:53:573AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(560,295,NULL,'You can also click the select button under the action column to view or modify the details of roles.',0,'May 28 2004 10:25:53:583AM',0,'May 28 2004 10:25:53:583AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(561,295,NULL,'Clicking on the role name gives you details about the role and the permissions it provides.',0,'May 28 2004 10:25:53:583AM',0,'May 28 2004 10:25:53:583AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(562,295,NULL,'You can add a new role into the system.',0,'May 28 2004 10:25:53:593AM',0,'May 28 2004 10:25:53:593AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(563,296,NULL,'Clicking the update button updates the role.',0,'May 28 2004 10:25:53:603AM',0,'May 28 2004 10:25:53:603AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(564,297,NULL,'The update of the role can be done by clicking the update button.',0,'May 28 2004 10:25:53:693AM',0,'May 28 2004 10:25:53:693AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(565,298,NULL,'Clicking on the module name will display a list of module items that can be configured.',0,'May 28 2004 10:25:53:703AM',0,'May 28 2004 10:25:53:703AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(566,299,NULL,'Scheduled Events: A timer triggers a customizable workflow process.',0,'May 28 2004 10:25:53:713AM',0,'May 28 2004 10:25:53:713AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(567,299,NULL,'Object Events: An Action triggers customizable workflow process. For example, when an object is inserted, updated, deleted or selected, a process is triggered.',0,'May 28 2004 10:25:53:713AM',0,'May 28 2004 10:25:53:713AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(568,299,NULL,'Categories: This lets you create hierarchical categories for a specific feature in the module.',0,'May 28 2004 10:25:53:713AM',0,'May 28 2004 10:25:53:713AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(569,299,NULL,'Lookup Lists: You can view the drop-down lists used in the module and make changes.',0,'May 28 2004 10:25:53:723AM',0,'May 28 2004 10:25:53:723AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(570,299,NULL,'Custom Folders and Fields: Custom folders allows you to create forms that will be present within each module, essentially custom fields.',0,'May 28 2004 10:25:53:723AM',0,'May 28 2004 10:25:53:723AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(571,300,NULL,'You can create a new item type using the add button and add it to the existing list. You can position the item in the list using the up and down buttons, remove it using the remove button and also sort the list. The final changes can be saved using the "Save Changes" button.',0,'May 28 2004 10:25:53:733AM',0,'May 28 2004 10:25:53:733AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(572,301,NULL,'You can update the existing the folder, set the options for the records and the permissions for the users.',0,'May 28 2004 10:25:53:743AM',0,'May 28 2004 10:25:53:743AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(573,302,NULL,'You can update the existing the folder, set the options for the records and the permissions for the users.',0,'May 28 2004 10:25:53:743AM',0,'May 28 2004 10:25:53:743AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(574,303,NULL,'The "Edit" link will let you alter the time for which the users session ends.',0,'May 28 2004 10:25:53:753AM',0,'May 28 2004 10:25:53:753AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(575,304,NULL,'The time out can be set by selecting the time from the drop down and clicking the update button.',0,'May 28 2004 10:25:53:763AM',0,'May 28 2004 10:25:53:763AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(576,305,NULL,'The usage can be displayed for the current date or a custom date can be specified. This can be selected from the drop down of the date range.',0,'May 28 2004 10:25:53:773AM',0,'May 28 2004 10:25:53:773AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(577,305,NULL,'The start date and the end date can be specified if the date range is "custom date range". The update can be done using the update button.',0,'May 28 2004 10:25:53:773AM',0,'May 28 2004 10:25:53:773AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(578,308,NULL,'You can also enable or disable the custom folders by clicking "yes" or "no".',0,'May 28 2004 10:25:53:793AM',0,'May 28 2004 10:25:53:793AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(579,308,NULL,'Clicking on the custom folder will give details about that folder and also lets you add groups.',0,'May 28 2004 10:25:53:793AM',0,'May 28 2004 10:25:53:793AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(580,308,NULL,'You can update an existing folder using the edit button under the action column.',0,'May 28 2004 10:25:53:803AM',0,'May 28 2004 10:25:53:803AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(581,308,NULL,'You can update an existing folder using the edit button under the action column.',0,'May 28 2004 10:25:53:803AM',0,'May 28 2004 10:25:53:803AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(582,308,NULL,'Add a folder to the general contacts module.',0,'May 28 2004 10:25:53:803AM',0,'May 28 2004 10:25:53:803AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(583,309,NULL,'You can also enable or disable the custom folders by clicking "yes" or "no".',0,'May 28 2004 10:25:53:813AM',0,'May 28 2004 10:25:53:813AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(584,309,NULL,'You can update an existing folder using the edit button under the action column.',0,'May 28 2004 10:25:53:813AM',0,'May 28 2004 10:25:53:813AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(585,309,NULL,'Clicking on the custom folder will give details about that folder and also lets you add groups.',0,'May 28 2004 10:25:53:813AM',0,'May 28 2004 10:25:53:813AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(586,309,NULL,'You can update an existing folder using the edit button under the action column.',0,'May 28 2004 10:25:53:813AM',0,'May 28 2004 10:25:53:813AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(587,309,NULL,'Add a folder to the general contacts module.',0,'May 28 2004 10:25:53:823AM',0,'May 28 2004 10:25:53:823AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(588,313,NULL,'You can view the process details by clicking on the select button under the Action column or by clicking on the name of the Triggered Process.',0,'May 28 2004 10:25:53:843AM',0,'May 28 2004 10:25:53:843AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(589,313,NULL,'You can view the process details by clicking on the select button under the Action column or by clicking on the name of the Triggered Process.',0,'May 28 2004 10:25:53:853AM',0,'May 28 2004 10:25:53:853AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(590,314,NULL,'You can add a group name and save it using the "save" button.',0,'May 28 2004 10:25:53:853AM',0,'May 28 2004 10:25:53:853AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(591,316,NULL,'You can click "Edit" in the Action column to update or delete a contact type.',0,'May 28 2004 10:25:53:873AM',0,'May 28 2004 10:25:53:873AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(592,316,NULL,'You can preview all the items present in a List name using the drop down in the preview column.',0,'May 28 2004 10:25:53:873AM',0,'May 28 2004 10:25:53:873AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(593,319,NULL,'You can click "Edit" in the Action column to update or delete a contact type.',0,'May 28 2004 10:25:53:983AM',0,'May 28 2004 10:25:53:983AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(594,319,NULL,'You can preview all the items present in a List name using the drop down in the preview column.',0,'May 28 2004 10:25:53:983AM',0,'May 28 2004 10:25:53:983AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(595,320,NULL,'You can also delete the folder and all the fields using the "Delete this folder and all fields" at the bottom of the page.',0,'May 28 2004 10:25:53:993AM',0,'May 28 2004 10:25:53:993AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(596,320,NULL,'The groups can also be moved up or down using the "Up" and "Down". They can also be edited and deleted using the "Edit" and "Del" links.',0,'May 28 2004 10:25:53:993AM',0,'May 28 2004 10:25:53:993AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(597,320,NULL,'The custom field can also be edited and deleted using the corresponding links "Edit" and "Del".',0,'May 28 2004 10:25:53:993AM',0,'May 28 2004 10:25:53:993AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(598,320,NULL,'The custom field created can be moved up or down for the display using the corresponding links "Up" and "Down".',0,'May 28 2004 10:25:54:003AM',0,'May 28 2004 10:25:54:003AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(599,320,NULL,'You can add a custom field for the group using the "Add a custom field" link.',0,'May 28 2004 10:25:54:003AM',0,'May 28 2004 10:25:54:003AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(600,320,NULL,'Add a group to the folder selected',0,'May 28 2004 10:25:54:003AM',0,'May 28 2004 10:25:54:003AM',NULL,NULL,1,6)
INSERT [help_features] VALUES(601,320,NULL,'You can select the folder by using the drop down box under the general contacts module.',0,'May 28 2004 10:25:54:003AM',0,'May 28 2004 10:25:54:003AM',NULL,NULL,1,7)
INSERT [help_features] VALUES(602,321,NULL,'Clicking on the list of categories displayed in level1 shows you its sub levels or sub-directories present in level2 and clicking on these in turn shows its subdirectories in level3 and so on.',0,'May 28 2004 10:25:54:013AM',0,'May 28 2004 10:25:54:013AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(603,321,NULL,'You can select to display either the Active Categories or the Draft Categories by clicking on the tabs "Active Categories" and "Draft Categories" respectively.',0,'May 28 2004 10:25:54:023AM',0,'May 28 2004 10:25:54:023AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(604,322,NULL,'The activated list can be brought back / reverted to the active list by clicking the "Revert to Active List".',0,'May 28 2004 10:25:54:023AM',0,'May 28 2004 10:25:54:023AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(605,322,NULL,'You can activate each level by using the "Activate now" button.',0,'May 28 2004 10:25:54:033AM',0,'May 28 2004 10:25:54:033AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(606,322,NULL,'In the draft categories you can edit your category using the edit button present at the bottom of each level.',0,'May 28 2004 10:25:54:033AM',0,'May 28 2004 10:25:54:033AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(607,322,NULL,'You can select to display either the Active Categories or the Draft Categories by clicking on the tabs "Active Categories" and "Draft Categories" respectively.',0,'May 28 2004 10:25:54:033AM',0,'May 28 2004 10:25:54:033AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(608,322,NULL,'Clicking on the list of categories displayed in level1 shows you its sub-levels or sub-directories present in level2 and clicking on these in turn would shows their subdirectories in level3 and so on.',0,'May 28 2004 10:25:54:033AM',0,'May 28 2004 10:25:54:033AM',NULL,NULL,1,5)
INSERT [help_features] VALUES(609,326,NULL,'The "Modify" button in the "Details" tab provides a quick link that allows the users information to be modified without having to browse back to the previous window.',0,'May 28 2004 10:25:54:063AM',0,'May 28 2004 10:25:54:063AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(610,326,NULL,'The "Employee Link" in the ''Primary Information" table header provides a quick link to view the user''s contact information.',0,'May 28 2004 10:25:54:063AM',0,'May 28 2004 10:25:54:063AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(611,326,NULL,'The "Details" tab displays the information about the user in a non-editable format.',0,'May 28 2004 10:25:54:073AM',0,'May 28 2004 10:25:54:073AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(612,326,NULL,'The "Disable" button provides a quick link to disable/inactivate the user.',0,'May 28 2004 10:25:54:073AM',0,'May 28 2004 10:25:54:073AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(613,331,NULL,'The user and module section allows the administrator to manage users, roles, role hierarchy and manage modules.',0,'May 28 2004 10:25:54:103AM',0,'May 28 2004 10:25:54:103AM',NULL,NULL,1,1)
INSERT [help_features] VALUES(614,331,NULL,'The global parameters and server configuration module allows the administrator to set the session timeout parameter.',0,'May 28 2004 10:25:54:103AM',0,'May 28 2004 10:25:54:103AM',NULL,NULL,1,2)
INSERT [help_features] VALUES(615,331,NULL,'The usage section allows the administrator to view the total number of users, memory used, and system usage parameters for various time intervals.',0,'May 28 2004 10:25:54:113AM',0,'May 28 2004 10:25:54:113AM',NULL,NULL,1,3)
INSERT [help_features] VALUES(616,331,NULL,'The administration module is divided into distinct categories such as managing users, module configuration, setting global parameters, server configuration and monitoring system usage and resources.',0,'May 28 2004 10:25:54:113AM',0,'May 28 2004 10:25:54:113AM',NULL,NULL,1,4)
INSERT [help_features] VALUES(617,333,NULL,'Clicking on the different links of the search results will direct you to the corresponding details in the modules.',0,'May 28 2004 10:25:54:163AM',0,'May 28 2004 10:25:54:163AM',NULL,NULL,1,1)

SET IDENTITY_INSERT [help_features] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_sc_category
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_sc_category] ON
GO
INSERT [lookup_sc_category] VALUES(1,'Consulting',0,10,1)
INSERT [lookup_sc_category] VALUES(2,'Hardware Maintenance',0,20,1)
INSERT [lookup_sc_category] VALUES(3,'Manufacturer''s Maintenance',0,30,1)
INSERT [lookup_sc_category] VALUES(4,'Monitoring',0,40,1)
INSERT [lookup_sc_category] VALUES(5,'Time and Materials',0,50,1)
INSERT [lookup_sc_category] VALUES(6,'Warranty',0,60,1)

SET IDENTITY_INSERT [lookup_sc_category] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_department
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_department] ON
GO
INSERT [lookup_department] VALUES(1,'Accounting',0,0,1)
INSERT [lookup_department] VALUES(2,'Administration',0,0,1)
INSERT [lookup_department] VALUES(3,'Billing',0,0,1)
INSERT [lookup_department] VALUES(4,'Customer Relations',0,0,1)
INSERT [lookup_department] VALUES(5,'Engineering',0,0,1)
INSERT [lookup_department] VALUES(6,'Finance',0,0,1)
INSERT [lookup_department] VALUES(7,'Human Resources',0,0,1)
INSERT [lookup_department] VALUES(8,'Legal',0,0,1)
INSERT [lookup_department] VALUES(9,'Marketing',0,0,1)
INSERT [lookup_department] VALUES(10,'Operations',0,0,1)
INSERT [lookup_department] VALUES(11,'Purchasing',0,0,1)
INSERT [lookup_department] VALUES(12,'Sales',0,0,1)
INSERT [lookup_department] VALUES(13,'Shipping/Receiving',0,0,1)

SET IDENTITY_INSERT [lookup_department] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_revenue_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_revenue_types] ON
GO
INSERT [lookup_revenue_types] VALUES(1,'Technical',0,0,1)

SET IDENTITY_INSERT [lookup_revenue_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_orgaddress_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_orgaddress_types] ON
GO
INSERT [lookup_orgaddress_types] VALUES(1,'Primary',0,10,1)
INSERT [lookup_orgaddress_types] VALUES(2,'Auxiliary',0,20,1)
INSERT [lookup_orgaddress_types] VALUES(3,'Billing',0,30,1)
INSERT [lookup_orgaddress_types] VALUES(4,'Shipping',0,40,1)

SET IDENTITY_INSERT [lookup_orgaddress_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_response_model
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_response_model] ON
GO
INSERT [lookup_response_model] VALUES(1,'M-F 8AM-5PM 8 hours',0,10,1)
INSERT [lookup_response_model] VALUES(2,'M-F 8AM-5PM 6 hours',0,20,1)
INSERT [lookup_response_model] VALUES(3,'M-F 8AM-5PM 4 hours',0,30,1)
INSERT [lookup_response_model] VALUES(4,'M-F 8AM-5PM same day',0,40,1)
INSERT [lookup_response_model] VALUES(5,'M-F 8AM-5PM next business day',0,50,1)
INSERT [lookup_response_model] VALUES(6,'M-F 8AM-8PM 4 hours',0,60,1)
INSERT [lookup_response_model] VALUES(7,'M-F 8AM-8PM 2 hours',0,70,1)
INSERT [lookup_response_model] VALUES(8,'24x7 8 hours',0,80,1)
INSERT [lookup_response_model] VALUES(9,'24x7 4 hours',0,90,1)
INSERT [lookup_response_model] VALUES(10,'24x7 2 hours',0,100,1)
INSERT [lookup_response_model] VALUES(11,'No response time guaranteed',0,110,1)

SET IDENTITY_INSERT [lookup_response_model] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_orgemail_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_orgemail_types] ON
GO
INSERT [lookup_orgemail_types] VALUES(1,'Primary',0,10,1)
INSERT [lookup_orgemail_types] VALUES(2,'Auxiliary',0,20,1)

SET IDENTITY_INSERT [lookup_orgemail_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default module_field_categorylink
SET NOCOUNT ON
SET IDENTITY_INSERT [module_field_categorylink] ON
GO
INSERT [module_field_categorylink] VALUES(1,1,1,10,'Accounts','May 28 2004 10:25:37:700AM')
INSERT [module_field_categorylink] VALUES(2,2,2,10,'Contacts','May 28 2004 10:25:37:850AM')
INSERT [module_field_categorylink] VALUES(3,8,11072003,10,'Tickets','May 28 2004 10:25:38:440AM')
INSERT [module_field_categorylink] VALUES(4,17,200403192,10,'Product Catalog Categories','May 28 2004 10:25:39:153AM')

SET IDENTITY_INSERT [module_field_categorylink] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_phone_model
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_phone_model] ON
GO
INSERT [lookup_phone_model] VALUES(1,'< 15 minutes',0,10,1)
INSERT [lookup_phone_model] VALUES(2,'< 5 minutes',0,20,1)
INSERT [lookup_phone_model] VALUES(3,'M-F 7AM-4PM',0,30,1)
INSERT [lookup_phone_model] VALUES(4,'M-F 8AM-5PM',0,40,1)
INSERT [lookup_phone_model] VALUES(5,'M-F 8AM-8PM',0,50,1)
INSERT [lookup_phone_model] VALUES(6,'24x7',0,60,1)
INSERT [lookup_phone_model] VALUES(7,'No phone support',0,70,1)

SET IDENTITY_INSERT [lookup_phone_model] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_orgphone_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_orgphone_types] ON
GO
INSERT [lookup_orgphone_types] VALUES(1,'Main',0,10,1)
INSERT [lookup_orgphone_types] VALUES(2,'Fax',0,20,1)

SET IDENTITY_INSERT [lookup_orgphone_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_onsite_model
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_onsite_model] ON
GO
INSERT [lookup_onsite_model] VALUES(1,'M-F 7AM-4PM',0,10,1)
INSERT [lookup_onsite_model] VALUES(2,'M-F 8AM-5PM',0,20,1)
INSERT [lookup_onsite_model] VALUES(3,'M-F 8AM-8PM',0,30,1)
INSERT [lookup_onsite_model] VALUES(4,'24x7',0,40,1)
INSERT [lookup_onsite_model] VALUES(5,'No onsite service',0,50,1)

SET IDENTITY_INSERT [lookup_onsite_model] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_email_model
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_email_model] ON
GO
INSERT [lookup_email_model] VALUES(1,'2 hours',0,10,1)
INSERT [lookup_email_model] VALUES(2,'4 hours',0,20,1)
INSERT [lookup_email_model] VALUES(3,'Same day',0,30,1)
INSERT [lookup_email_model] VALUES(4,'Next business day',0,40,1)

SET IDENTITY_INSERT [lookup_email_model] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_hours_reason
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_hours_reason] ON
GO
INSERT [lookup_hours_reason] VALUES(1,'Purchase',0,10,1)
INSERT [lookup_hours_reason] VALUES(2,'Renewal',0,20,1)
INSERT [lookup_hours_reason] VALUES(3,'Correction',0,30,1)

SET IDENTITY_INSERT [lookup_hours_reason] OFF
GO
SET NOCOUNT OFF
 
-- Insert default help_business_rules
SET NOCOUNT ON
SET IDENTITY_INSERT [help_business_rules] ON
GO
INSERT [help_business_rules] VALUES(1,1,'You can view your calendar and the calendars of those who work for you',0,'May 28 2004 10:25:47:707AM',0,'May 28 2004 10:25:47:707AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(2,77,'Apart from email addresses, you may not map more than one column of the cvs file to the same field of the application. An attempt to do so, displays error messages against the rows for which such a mapping was specified.',0,'May 28 2004 10:25:49:297AM',0,'May 28 2004 10:25:49:297AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(3,176,'The current end date should be greater than the current contract date if the current contract date is specified. If current contract date is not specified, the current end date should be greater than the initial contract date.',0,'May 28 2004 10:25:51:340AM',0,'May 28 2004 10:25:51:340AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(4,176,'The current contract date is not required. If it is left blank, it is prefilled with the initial contract date when this contract record is saved.',0,'May 28 2004 10:25:51:340AM',0,'May 28 2004 10:25:51:340AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(5,181,'For most assets it is percieved that the puchased date is earler than the expiration date. As the application does not enforce this rule, it is recommended that you verify the entry in these two fields before saving the information about the asset. It is possible for an asset to have an expiration date that is earlier than the purchased date if the asset is a pre-used asset, and its warranty expired during the time it was with the previous owner or if the warranty does not transfer with the transfer of the asset.',0,'May 28 2004 10:25:51:500AM',0,'May 28 2004 10:25:51:500AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(6,183,'Similar to the adding an asset',0,'May 28 2004 10:25:51:540AM',0,'May 28 2004 10:25:51:540AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(7,185,'An account contact may have a number of email addresses, this page allows one email address to be chosen as the primary email address. The primary email address is by default used to email the account contact about portal usage information. However, if the account contact has only one email address, it is not required to choose it as the primary contact.',0,'May 28 2004 10:25:51:570AM',0,'May 28 2004 10:25:51:570AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(8,186,'An account contact may have a number of email addresses, this page allows one email address to be chosen as the primary email address. The primary email address is by default used to email the account contact about portal usage information. However, if the account contact has only one email address, it is not required to choose it as the primary contact.',0,'May 28 2004 10:25:51:580AM',0,'May 28 2004 10:25:51:580AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(9,266,'Other tickets in my Department: These are records that are assigned to anyone in your department, are unassigned in your department, and are open.',0,'May 28 2004 10:25:52:893AM',0,'May 28 2004 10:25:52:893AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(10,266,'Tickets assigned to me: These are records that are assigned to you and are open',0,'May 28 2004 10:25:52:893AM',0,'May 28 2004 10:25:52:893AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(11,266,'Tickets created by me: These are records that have been entered by you and are open',0,'May 28 2004 10:25:52:893AM',0,'May 28 2004 10:25:52:893AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(12,268,'If the follow up field is checked, the alert date and description are mandatory.',0,'May 28 2004 10:25:53:023AM',0,'May 28 2004 10:25:53:023AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(13,268,'The phone and engineer response time are text fields that allow you to enter the "time of day'' when the response was made.',0,'May 28 2004 10:25:53:043AM',0,'May 28 2004 10:25:53:043AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(14,268,'All fields in a row of the description of service section is mandatory.',0,'May 28 2004 10:25:53:043AM',0,'May 28 2004 10:25:53:043AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(15,268,'The travel time and the labor time can be selected from the drop list. If you choose the values in these duration fields to count towards a service contract, the hours remaining in the service contract is changed accordingly when this activity log is saved.',0,'May 28 2004 10:25:53:043AM',0,'May 28 2004 10:25:53:043AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(16,270,'All fields in a row of the description of service section is mandatory.',0,'May 28 2004 10:25:53:073AM',0,'May 28 2004 10:25:53:073AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(17,270,'If the follow up field is checked, the alert date and description are mandatory.',0,'May 28 2004 10:25:53:073AM',0,'May 28 2004 10:25:53:073AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(18,270,'The phone and engineer response time are text fields that allow you to enter the "time of day'' when the response was made.',0,'May 28 2004 10:25:53:073AM',0,'May 28 2004 10:25:53:073AM',NULL,NULL,1)
INSERT [help_business_rules] VALUES(19,270,'The travel time and the labor time can be selected from the drop list. If you choose the values in these duration fields to count towards a service contract, the hours remaining in the service contract is changed accordingly when this activity log is saved.',0,'May 28 2004 10:25:53:083AM',0,'May 28 2004 10:25:53:083AM',NULL,NULL,1)

SET IDENTITY_INSERT [help_business_rules] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_contactaddress_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_contactaddress_types] ON
GO
INSERT [lookup_contactaddress_types] VALUES(1,'Business',0,10,1)
INSERT [lookup_contactaddress_types] VALUES(2,'Home',0,20,1)
INSERT [lookup_contactaddress_types] VALUES(3,'Other',0,30,1)

SET IDENTITY_INSERT [lookup_contactaddress_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_task_priority
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_task_priority] ON
GO
INSERT [lookup_task_priority] VALUES(1,'1',1,1,1)
INSERT [lookup_task_priority] VALUES(2,'2',0,2,1)
INSERT [lookup_task_priority] VALUES(3,'3',0,3,1)
INSERT [lookup_task_priority] VALUES(4,'4',0,4,1)
INSERT [lookup_task_priority] VALUES(5,'5',0,5,1)

SET IDENTITY_INSERT [lookup_task_priority] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_contactemail_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_contactemail_types] ON
GO
INSERT [lookup_contactemail_types] VALUES(1,'Business',0,10,1)
INSERT [lookup_contactemail_types] VALUES(2,'Personal',0,20,1)
INSERT [lookup_contactemail_types] VALUES(3,'Other',0,30,1)

SET IDENTITY_INSERT [lookup_contactemail_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_task_loe
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_task_loe] ON
GO
INSERT [lookup_task_loe] VALUES(1,'Minute(s)',0,1,1)
INSERT [lookup_task_loe] VALUES(2,'Hour(s)',1,2,1)
INSERT [lookup_task_loe] VALUES(3,'Day(s)',0,3,1)
INSERT [lookup_task_loe] VALUES(4,'Week(s)',0,4,1)
INSERT [lookup_task_loe] VALUES(5,'Month(s)',0,5,1)

SET IDENTITY_INSERT [lookup_task_loe] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_contactphone_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_contactphone_types] ON
GO
INSERT [lookup_contactphone_types] VALUES(1,'Business',0,10,1)
INSERT [lookup_contactphone_types] VALUES(2,'Business2',0,20,1)
INSERT [lookup_contactphone_types] VALUES(3,'Business Fax',0,30,1)
INSERT [lookup_contactphone_types] VALUES(4,'Home',0,40,1)
INSERT [lookup_contactphone_types] VALUES(5,'Home2',0,50,1)
INSERT [lookup_contactphone_types] VALUES(6,'Home Fax',0,60,1)
INSERT [lookup_contactphone_types] VALUES(7,'Mobile',0,70,1)
INSERT [lookup_contactphone_types] VALUES(8,'Pager',0,80,1)
INSERT [lookup_contactphone_types] VALUES(9,'Other',0,90,1)

SET IDENTITY_INSERT [lookup_contactphone_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default database_version
SET NOCOUNT ON
SET IDENTITY_INSERT [database_version] ON
GO
INSERT [database_version] VALUES(1,'ce\dhv\cfs2\src\sql\init\workflow.bsh','ce\dhv\cfs2\src\sql\init\workflow','May 28 2004 10:25:59:370AM')

SET IDENTITY_INSERT [database_version] OFF
GO
SET NOCOUNT OFF
 
-- Insert default help_tips
SET NOCOUNT ON
SET IDENTITY_INSERT [help_tips] ON
GO
INSERT [help_tips] VALUES(1,1,'Assign due dates for tasks so that you can be alerted',0,'May 28 2004 10:25:47:727AM',0,'May 28 2004 10:25:47:727AM',1)
INSERT [help_tips] VALUES(2,266,'Make sure to resolve your tickets as soon as possible so they don''t appear here!',0,'May 28 2004 10:25:52:893AM',0,'May 28 2004 10:25:52:893AM',1)

SET IDENTITY_INSERT [help_tips] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_call_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_call_types] ON
GO
INSERT [lookup_call_types] VALUES(1,'Incoming Call',1,10,1)
INSERT [lookup_call_types] VALUES(2,'Outgoing Call',0,20,1)
INSERT [lookup_call_types] VALUES(3,'Proactive Call',0,30,1)
INSERT [lookup_call_types] VALUES(4,'Inhouse Meeting',0,40,1)
INSERT [lookup_call_types] VALUES(5,'Outside Appointment',0,50,1)
INSERT [lookup_call_types] VALUES(6,'Proactive Meeting',0,60,1)
INSERT [lookup_call_types] VALUES(7,'Email Servicing',0,70,1)
INSERT [lookup_call_types] VALUES(8,'Email Proactive',0,80,1)
INSERT [lookup_call_types] VALUES(9,'Fax Servicing',0,90,1)
INSERT [lookup_call_types] VALUES(10,'Fax Proactive',0,100,1)

SET IDENTITY_INSERT [lookup_call_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_access_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_access_types] ON
GO
INSERT [lookup_access_types] VALUES(1,626030330,'Controlled-Hierarchy',1,1,1,626030335)
INSERT [lookup_access_types] VALUES(2,626030330,'Public',0,2,1,626030334)
INSERT [lookup_access_types] VALUES(3,626030330,'Personal',0,3,1,626030333)
INSERT [lookup_access_types] VALUES(4,626030331,'Public',1,1,1,626030334)
INSERT [lookup_access_types] VALUES(5,626030332,'Public',1,1,1,626030334)
INSERT [lookup_access_types] VALUES(6,707031028,'Controlled-Hierarchy',1,1,1,626030335)
INSERT [lookup_access_types] VALUES(7,707031028,'Public',0,2,1,626030334)
INSERT [lookup_access_types] VALUES(8,707031028,'Personal',0,3,1,626030333)

SET IDENTITY_INSERT [lookup_access_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_quote_status
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_quote_status] ON
GO
INSERT [lookup_quote_status] VALUES(1,'Incomplete',0,0,1)
INSERT [lookup_quote_status] VALUES(2,'Pending internal approval',0,0,1)
INSERT [lookup_quote_status] VALUES(3,'Approved internally',0,0,1)
INSERT [lookup_quote_status] VALUES(4,'Unapproved internally',0,0,1)
INSERT [lookup_quote_status] VALUES(5,'Pending customer acceptance',0,0,1)
INSERT [lookup_quote_status] VALUES(6,'Accepted by customer',0,0,1)
INSERT [lookup_quote_status] VALUES(7,'Rejected by customer',0,0,1)
INSERT [lookup_quote_status] VALUES(8,'Changes requested by customer',0,0,1)
INSERT [lookup_quote_status] VALUES(9,'Cancelled',0,0,1)
INSERT [lookup_quote_status] VALUES(10,'Complete',0,0,1)

SET IDENTITY_INSERT [lookup_quote_status] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_opportunity_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_opportunity_types] ON
GO
INSERT [lookup_opportunity_types] VALUES(1,NULL,'Annuity',0,0,1)
INSERT [lookup_opportunity_types] VALUES(2,NULL,'Consultation',0,1,1)
INSERT [lookup_opportunity_types] VALUES(3,NULL,'Development',0,2,1)
INSERT [lookup_opportunity_types] VALUES(4,NULL,'Maintenance',0,3,1)
INSERT [lookup_opportunity_types] VALUES(5,NULL,'Product Sales',0,4,1)
INSERT [lookup_opportunity_types] VALUES(6,NULL,'Services',0,5,1)

SET IDENTITY_INSERT [lookup_opportunity_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default organization
SET NOCOUNT ON
SET IDENTITY_INSERT [organization] ON
GO
INSERT [organization] VALUES(0,'My Company',NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,0,NULL,NULL,'May 28 2004 10:25:31:380AM',0,'May 28 2004 10:25:31:380AM',0,1,NULL,0,-1,-1,-1,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL)

SET IDENTITY_INSERT [organization] OFF
GO
SET NOCOUNT OFF
 
-- Insert default sync_system
SET NOCOUNT ON
SET IDENTITY_INSERT [sync_system] ON
GO
INSERT [sync_system] VALUES(1,'Deprecated',1)
INSERT [sync_system] VALUES(2,'Auto Guide PocketPC',1)
INSERT [sync_system] VALUES(3,'Unused',1)
INSERT [sync_system] VALUES(4,'CFSHttpXMLWriter',1)
INSERT [sync_system] VALUES(5,'Test',1)

SET IDENTITY_INSERT [sync_system] OFF
GO
SET NOCOUNT OFF
 
-- Insert default sync_table
SET NOCOUNT ON
SET IDENTITY_INSERT [sync_table] ON
GO
INSERT [sync_table] VALUES(1,1,'ticket','org.aspcfs.modules.troubletickets.base.Ticket','May 28 2004 10:25:34:107AM','May 28 2004 10:25:34:107AM',NULL,-1,0,'id')
INSERT [sync_table] VALUES(2,2,'syncClient','org.aspcfs.modules.service.base.SyncClient','May 28 2004 10:25:34:107AM','May 28 2004 10:25:34:107AM',NULL,2,0,NULL)
INSERT [sync_table] VALUES(3,2,'user','org.aspcfs.modules.admin.base.User','May 28 2004 10:25:34:107AM','May 28 2004 10:25:34:107AM',NULL,4,0,NULL)
INSERT [sync_table] VALUES(4,2,'account','org.aspcfs.modules.accounts.base.Organization','May 28 2004 10:25:34:117AM','May 28 2004 10:25:34:117AM',NULL,5,0,NULL)
INSERT [sync_table] VALUES(5,2,'accountInventory','org.aspcfs.modules.media.autoguide.base.Inventory','May 28 2004 10:25:34:117AM','May 28 2004 10:25:34:117AM',NULL,6,0,NULL)
INSERT [sync_table] VALUES(6,2,'inventoryOption','org.aspcfs.modules.media.autoguide.base.InventoryOption','May 28 2004 10:25:34:117AM','May 28 2004 10:25:34:117AM',NULL,8,0,NULL)
INSERT [sync_table] VALUES(7,2,'adRun','org.aspcfs.modules.media.autoguide.base.AdRun','May 28 2004 10:25:34:117AM','May 28 2004 10:25:34:117AM',NULL,10,0,NULL)
INSERT [sync_table] VALUES(8,2,'tableList','org.aspcfs.modules.service.base.SyncTableList','May 28 2004 10:25:34:127AM','May 28 2004 10:25:34:127AM',NULL,12,0,NULL)
INSERT [sync_table] VALUES(9,2,'status_master',NULL,'May 28 2004 10:25:34:127AM','May 28 2004 10:25:34:127AM',NULL,14,0,NULL)
INSERT [sync_table] VALUES(10,2,'system',NULL,'May 28 2004 10:25:34:127AM','May 28 2004 10:25:34:127AM',NULL,16,0,NULL)
INSERT [sync_table] VALUES(11,2,'userList','org.aspcfs.modules.admin.base.UserList','May 28 2004 10:25:34:137AM','May 28 2004 10:25:34:137AM','CREATE TABLE users ( user_id              int NOT NULL, record_status_id     int NULL, user_name            nvarchar(20) NULL, pin                  nvarchar(20) NULL, modified             datetime NULL, PRIMARY KEY (user_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',50,1,NULL)
INSERT [sync_table] VALUES(12,2,'XIF18users',NULL,'May 28 2004 10:25:34:147AM','May 28 2004 10:25:34:147AM','CREATE INDEX XIF18users ON users ( record_status_id )',60,0,NULL)
INSERT [sync_table] VALUES(13,2,'makeList','org.aspcfs.modules.media.autoguide.base.MakeList','May 28 2004 10:25:34:147AM','May 28 2004 10:25:34:147AM','CREATE TABLE make ( make_id              int NOT NULL, make_name            nvarchar(20) NULL, record_status_id     int NULL, entered              datetime NULL, modified             datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (make_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',70,1,NULL)
INSERT [sync_table] VALUES(14,2,'XIF2make',NULL,'May 28 2004 10:25:34:147AM','May 28 2004 10:25:34:147AM','CREATE INDEX XIF2make ON make ( record_status_id )',80,0,NULL)
INSERT [sync_table] VALUES(15,2,'modelList','org.aspcfs.modules.media.autoguide.base.ModelList','May 28 2004 10:25:34:147AM','May 28 2004 10:25:34:147AM','CREATE TABLE model ( model_id             int NOT NULL, make_id              int NULL, record_status_id     int NULL, model_name           nvarchar(40) NULL, entered              datetime NULL, modified             datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (model_id), FOREIGN KEY (make_id) REFERENCES make (make_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',100,1,NULL)
INSERT [sync_table] VALUES(16,2,'XIF3model',NULL,'May 28 2004 10:25:34:147AM','May 28 2004 10:25:34:147AM','CREATE INDEX XIF3model ON model ( record_status_id )',110,0,NULL)
INSERT [sync_table] VALUES(17,2,'XIF5model',NULL,'May 28 2004 10:25:34:157AM','May 28 2004 10:25:34:157AM','CREATE INDEX XIF5model ON model ( make_id )',120,0,NULL)
INSERT [sync_table] VALUES(18,2,'vehicleList','org.aspcfs.modules.media.autoguide.base.VehicleList','May 28 2004 10:25:34:157AM','May 28 2004 10:25:34:157AM','CREATE TABLE vehicle ( year                 nvarchar(4) NOT NULL, vehicle_id           int NOT NULL, model_id             int NULL, make_id              int NULL, record_status_id     int NULL, entered              datetime NULL, modified             datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (vehicle_id), FOREIGN KEY (model_id) REFERENCES model (model_id), FOREIGN KEY (make_id) REFERENCES make (make_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',130,1,NULL)
INSERT [sync_table] VALUES(19,2,'XIF30vehicle',NULL,'May 28 2004 10:25:34:157AM','May 28 2004 10:25:34:157AM','CREATE INDEX XIF30vehicle ON vehicle ( make_id )',140,0,NULL)
INSERT [sync_table] VALUES(20,2,'XIF31vehicle',NULL,'May 28 2004 10:25:34:157AM','May 28 2004 10:25:34:157AM','CREATE INDEX XIF31vehicle ON vehicle ( model_id )',150,0,NULL)
INSERT [sync_table] VALUES(21,2,'XIF4vehicle',NULL,'May 28 2004 10:25:34:157AM','May 28 2004 10:25:34:157AM','CREATE INDEX XIF4vehicle ON vehicle ( record_status_id )',160,0,NULL)
INSERT [sync_table] VALUES(22,2,'accountList','org.aspcfs.modules.accounts.base.OrganizationList','May 28 2004 10:25:34:167AM','May 28 2004 10:25:34:167AM','CREATE TABLE account ( account_id           int NOT NULL, account_name         nvarchar(80) NULL, record_status_id     int NULL, address              nvarchar(80) NULL, modified             datetime NULL, city                 nvarchar(80) NULL, state                nvarchar(2) NULL, notes                nvarchar(255) NULL, zip                  nvarchar(11) NULL, phone                nvarchar(20) NULL, contact              nvarchar(20) NULL, dmv_number           nvarchar(20) NULL, owner_id             int NULL, entered              datetime NULL, enteredby            int NULL, modifiedby           int NULL, PRIMARY KEY (account_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',170,1,NULL)
INSERT [sync_table] VALUES(23,2,'XIF16account',NULL,'May 28 2004 10:25:34:167AM','May 28 2004 10:25:34:167AM','CREATE INDEX XIF16account ON account ( record_status_id )',180,0,NULL)
INSERT [sync_table] VALUES(24,2,'accountInventoryList','org.aspcfs.modules.media.autoguide.base.InventoryList','May 28 2004 10:25:34:167AM','May 28 2004 10:25:34:167AM','CREATE TABLE account_inventory ( inventory_id         int NOT NULL, vin                  nvarchar(20) NULL, vehicle_id           int NULL, account_id           int NULL, mileage              nvarchar(20) NULL, enteredby            int NULL, new                  bit, condition            nvarchar(20) NULL, comments             nvarchar(255) NULL, stock_no             nvarchar(20) NULL, ext_color            nvarchar(20) NULL, int_color            nvarchar(20) NULL, style                nvarchar(40) NULL, invoice_price        money NULL, selling_price        money NULL, selling_price_text		nvarchar(100) NULL, modified             datetime NULL, sold                 int NULL, modifiedby           int NULL, record_status_id     int NULL, entered              datetime NULL, PRIMARY KEY (inventory_id), FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',190,1,NULL)
INSERT [sync_table] VALUES(25,2,'XIF10account_inventory',NULL,'May 28 2004 10:25:34:167AM','May 28 2004 10:25:34:167AM','CREATE INDEX XIF10account_inventory ON account_inventory ( record_status_id )',200,0,NULL)
INSERT [sync_table] VALUES(26,2,'XIF10account_inventory',NULL,'May 28 2004 10:25:34:177AM','May 28 2004 10:25:34:177AM','CREATE INDEX XIF11account_inventory ON account_inventory ( modifiedby )',210,0,NULL)
INSERT [sync_table] VALUES(27,2,'XIF19account_inventory',NULL,'May 28 2004 10:25:34:177AM','May 28 2004 10:25:34:177AM','CREATE INDEX XIF19account_inventory ON account_inventory ( account_id )',220,0,NULL)
INSERT [sync_table] VALUES(28,2,'XIF35account_inventory',NULL,'May 28 2004 10:25:34:177AM','May 28 2004 10:25:34:177AM','CREATE INDEX XIF35account_inventory ON account_inventory ( vehicle_id )',230,0,NULL)
INSERT [sync_table] VALUES(29,2,'optionList','org.aspcfs.modules.media.autoguide.base.OptionList','May 28 2004 10:25:34:187AM','May 28 2004 10:25:34:187AM','CREATE TABLE options ( option_id            int NOT NULL, option_name          nvarchar(20) NULL, record_status_id     int NULL, record_status_date   datetime NULL, PRIMARY KEY (option_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',330,1,NULL)
INSERT [sync_table] VALUES(30,2,'XIF24options',NULL,'May 28 2004 10:25:34:187AM','May 28 2004 10:25:34:187AM','CREATE INDEX XIF24options ON options ( record_status_id )',340,0,NULL)
INSERT [sync_table] VALUES(31,2,'inventoryOptionList','org.aspcfs.modules.media.autoguide.base.InventoryOptionList','May 28 2004 10:25:34:187AM','May 28 2004 10:25:34:187AM','CREATE TABLE inventory_options ( inventory_id         int NOT NULL, option_id            int NOT NULL, record_status_id     int NULL, modified             datetime NULL, PRIMARY KEY (option_id, inventory_id), FOREIGN KEY (inventory_id) REFERENCES account_inventory (inventory_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id), FOREIGN KEY (option_id) REFERENCES options (option_id) )',350,1,NULL)
INSERT [sync_table] VALUES(32,2,'XIF25inventory_options',NULL,'May 28 2004 10:25:34:187AM','May 28 2004 10:25:34:187AM','CREATE INDEX XIF25inventory_options ON inventory_options ( option_id )',360,0,NULL)
INSERT [sync_table] VALUES(33,2,'XIF27inventory_options',NULL,'May 28 2004 10:25:34:187AM','May 28 2004 10:25:34:187AM','CREATE INDEX XIF27inventory_options ON inventory_options ( record_status_id )',370,0,NULL)
INSERT [sync_table] VALUES(34,2,'XIF33inventory_options',NULL,'May 28 2004 10:25:34:197AM','May 28 2004 10:25:34:197AM','CREATE INDEX XIF33inventory_options ON inventory_options ( inventory_id )',380,0,NULL)
INSERT [sync_table] VALUES(35,2,'adTypeList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:197AM','May 28 2004 10:25:34:197AM','CREATE TABLE ad_type ( ad_type_id           int NOT NULL, ad_type_name         nvarchar(20) NULL, PRIMARY KEY (ad_type_id) )',385,1,NULL)
INSERT [sync_table] VALUES(36,2,'adRunList','org.aspcfs.modules.media.autoguide.base.AdRunList','May 28 2004 10:25:34:197AM','May 28 2004 10:25:34:197AM','CREATE TABLE ad_run ( ad_run_id            int NOT NULL, record_status_id     int NULL, inventory_id         int NULL, ad_type_id           int NULL, ad_run_date          datetime NULL, has_picture          int NULL, modified             datetime NULL, entered              datetime NULL, modifiedby           int NULL, enteredby            int NULL, PRIMARY KEY (ad_run_id), FOREIGN KEY (inventory_id) REFERENCES account_inventory (inventory_id), FOREIGN KEY (ad_type_id) REFERENCES ad_type (ad_type_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',390,1,NULL)
INSERT [sync_table] VALUES(37,2,'XIF22ad_run',NULL,'May 28 2004 10:25:34:197AM','May 28 2004 10:25:34:197AM','CREATE INDEX XIF22ad_run ON ad_run ( record_status_id )',400,0,NULL)
INSERT [sync_table] VALUES(38,2,'XIF36ad_run',NULL,'May 28 2004 10:25:34:207AM','May 28 2004 10:25:34:207AM','CREATE INDEX XIF36ad_run ON ad_run ( ad_type_id )',402,0,NULL)
INSERT [sync_table] VALUES(39,2,'XIF37ad_run',NULL,'May 28 2004 10:25:34:207AM','May 28 2004 10:25:34:207AM','CREATE INDEX XIF37ad_run ON ad_run ( inventory_id )',404,0,NULL)
INSERT [sync_table] VALUES(40,2,'inventory_picture',NULL,'May 28 2004 10:25:34:207AM','May 28 2004 10:25:34:207AM','CREATE TABLE inventory_picture ( picture_name         nvarchar(20) NOT NULL, inventory_id         int NOT NULL, record_status_id     int NULL, entered              datetime NULL, modified             datetime NULL, modifiedby           int NULL, enteredby            int NULL, PRIMARY KEY (picture_name, inventory_id), FOREIGN KEY (inventory_id) REFERENCES account_inventory (inventory_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id) )',410,0,NULL)
INSERT [sync_table] VALUES(41,2,'XIF23inventory_picture',NULL,'May 28 2004 10:25:34:217AM','May 28 2004 10:25:34:217AM','CREATE INDEX XIF23inventory_picture ON inventory_picture ( record_status_id )',420,0,NULL)
INSERT [sync_table] VALUES(42,2,'XIF32inventory_picture',NULL,'May 28 2004 10:25:34:217AM','May 28 2004 10:25:34:217AM','CREATE INDEX XIF32inventory_picture ON inventory_picture ( inventory_id )',430,0,NULL)
INSERT [sync_table] VALUES(43,2,'preferences',NULL,'May 28 2004 10:25:34:217AM','May 28 2004 10:25:34:217AM','CREATE TABLE preferences ( user_id              int NOT NULL, record_status_id     int NULL, modified             datetime NULL, PRIMARY KEY (user_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id), FOREIGN KEY (user_id) REFERENCES users (user_id) )',440,0,NULL)
INSERT [sync_table] VALUES(44,2,'XIF29preferences',NULL,'May 28 2004 10:25:34:227AM','May 28 2004 10:25:34:227AM','CREATE INDEX XIF29preferences ON preferences ( record_status_id )',450,0,NULL)
INSERT [sync_table] VALUES(45,2,'user_account',NULL,'May 28 2004 10:25:34:227AM','May 28 2004 10:25:34:227AM','CREATE TABLE user_account ( user_id              int NOT NULL, account_id           int NOT NULL, record_status_id     int NULL, modified             datetime NULL, PRIMARY KEY (user_id, account_id), FOREIGN KEY (record_status_id) REFERENCES status_master (record_status_id), FOREIGN KEY (account_id) REFERENCES account (account_id), FOREIGN KEY (user_id) REFERENCES users (user_id) )',460,0,NULL)
INSERT [sync_table] VALUES(46,2,'XIF14user_account',NULL,'May 28 2004 10:25:34:227AM','May 28 2004 10:25:34:227AM','CREATE INDEX XIF14user_account ON user_account ( user_id )',470,0,NULL)
INSERT [sync_table] VALUES(47,2,'XIF15user_account',NULL,'May 28 2004 10:25:34:227AM','May 28 2004 10:25:34:227AM','CREATE INDEX XIF15user_account ON user_account ( account_id )',480,0,NULL)
INSERT [sync_table] VALUES(48,2,'XIF17user_account',NULL,'May 28 2004 10:25:34:227AM','May 28 2004 10:25:34:227AM','CREATE INDEX XIF17user_account ON user_account ( record_status_id )',490,0,NULL)
INSERT [sync_table] VALUES(49,2,'deleteInventoryCache','org.aspcfs.modules.media.autoguide.actions.DeleteInventoryCache','May 28 2004 10:25:34:227AM','May 28 2004 10:25:34:227AM',NULL,500,0,NULL)
INSERT [sync_table] VALUES(50,4,'lookupIndustry','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:237AM','May 28 2004 10:25:34:237AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(51,4,'lookupIndustryList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:237AM','May 28 2004 10:25:34:237AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(52,4,'systemPrefs','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:237AM','May 28 2004 10:25:34:237AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(53,4,'systemModules','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:237AM','May 28 2004 10:25:34:237AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(54,4,'systemModulesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:247AM','May 28 2004 10:25:34:247AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(55,4,'lookupContactTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:247AM','May 28 2004 10:25:34:247AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(56,4,'lookupContactTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:247AM','May 28 2004 10:25:34:247AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(57,4,'lookupAccountTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:247AM','May 28 2004 10:25:34:247AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(58,4,'lookupAccountTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:247AM','May 28 2004 10:25:34:247AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(59,4,'lookupDepartment','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:247AM','May 28 2004 10:25:34:247AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(60,4,'lookupDepartmentList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:247AM','May 28 2004 10:25:34:247AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(61,4,'lookupOrgAddressTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:257AM','May 28 2004 10:25:34:257AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(62,4,'lookupOrgAddressTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:257AM','May 28 2004 10:25:34:257AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(63,4,'lookupOrgEmailTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:257AM','May 28 2004 10:25:34:257AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(64,4,'lookupOrgEmailTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:257AM','May 28 2004 10:25:34:257AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(65,4,'lookupOrgPhoneTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:257AM','May 28 2004 10:25:34:257AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(66,4,'lookupOrgPhoneTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:257AM','May 28 2004 10:25:34:257AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(67,4,'lookupInstantMessengerTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:257AM','May 28 2004 10:25:34:257AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(68,4,'lookupInstantMessengerTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:267AM','May 28 2004 10:25:34:267AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(69,4,'lookupEmploymentTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:267AM','May 28 2004 10:25:34:267AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(70,4,'lookupEmploymentTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:267AM','May 28 2004 10:25:34:267AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(71,4,'lookupLocale','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:277AM','May 28 2004 10:25:34:277AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(72,4,'lookupLocaleList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:277AM','May 28 2004 10:25:34:277AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(73,4,'lookupContactAddressTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:277AM','May 28 2004 10:25:34:277AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(74,4,'lookupContactAddressTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:277AM','May 28 2004 10:25:34:277AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(75,4,'lookupContactEmailTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:277AM','May 28 2004 10:25:34:277AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(76,4,'lookupContactEmailTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:277AM','May 28 2004 10:25:34:277AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(77,4,'lookupContactPhoneTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:277AM','May 28 2004 10:25:34:277AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(78,4,'lookupContactPhoneTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:287AM','May 28 2004 10:25:34:287AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(79,4,'lookupStage','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:287AM','May 28 2004 10:25:34:287AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(80,4,'lookupStageList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:287AM','May 28 2004 10:25:34:287AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(81,4,'lookupDeliveryOptions','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:287AM','May 28 2004 10:25:34:287AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(82,4,'lookupDeliveryOptionsList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:287AM','May 28 2004 10:25:34:287AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(83,4,'lookupCallTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:287AM','May 28 2004 10:25:34:287AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(84,4,'lookupCallTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:287AM','May 28 2004 10:25:34:287AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(85,4,'ticketCategory','org.aspcfs.modules.troubletickets.base.TicketCategory','May 28 2004 10:25:34:297AM','May 28 2004 10:25:34:297AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(86,4,'ticketCategoryList','org.aspcfs.modules.troubletickets.base.TicketCategoryList','May 28 2004 10:25:34:297AM','May 28 2004 10:25:34:297AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(87,4,'ticketSeverity','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:297AM','May 28 2004 10:25:34:297AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(88,4,'ticketSeverityList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:297AM','May 28 2004 10:25:34:297AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(89,4,'lookupTicketSource','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:297AM','May 28 2004 10:25:34:297AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(90,4,'lookupTicketSourceList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:297AM','May 28 2004 10:25:34:297AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(91,4,'ticketPriority','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:297AM','May 28 2004 10:25:34:297AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(92,4,'ticketPriorityList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:307AM','May 28 2004 10:25:34:307AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(93,4,'lookupRevenueTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:307AM','May 28 2004 10:25:34:307AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(94,4,'lookupRevenueTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:307AM','May 28 2004 10:25:34:307AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(95,4,'lookupRevenueDetailTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:307AM','May 28 2004 10:25:34:307AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(96,4,'lookupRevenueDetailTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:307AM','May 28 2004 10:25:34:307AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(97,4,'lookupSurveyTypes','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:307AM','May 28 2004 10:25:34:307AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(98,4,'lookupSurveyTypesList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:317AM','May 28 2004 10:25:34:317AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(99,4,'syncClient','org.aspcfs.modules.service.base.SyncClient','May 28 2004 10:25:34:317AM','May 28 2004 10:25:34:317AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(100,4,'user','org.aspcfs.modules.admin.base.User','May 28 2004 10:25:34:317AM','May 28 2004 10:25:34:317AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(101,4,'userList','org.aspcfs.modules.admin.base.UserList','May 28 2004 10:25:34:317AM','May 28 2004 10:25:34:317AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(102,4,'contact','org.aspcfs.modules.contacts.base.Contact','May 28 2004 10:25:34:317AM','May 28 2004 10:25:34:317AM',NULL,-1,0,'id')
INSERT [sync_table] VALUES(103,4,'contactList','org.aspcfs.modules.contacts.base.ContactList','May 28 2004 10:25:34:317AM','May 28 2004 10:25:34:317AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(104,4,'ticket','org.aspcfs.modules.troubletickets.base.Ticket','May 28 2004 10:25:34:327AM','May 28 2004 10:25:34:327AM',NULL,-1,0,'id')
INSERT [sync_table] VALUES(105,4,'ticketList','org.aspcfs.modules.troubletickets.base.TicketList','May 28 2004 10:25:34:327AM','May 28 2004 10:25:34:327AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(106,4,'account','org.aspcfs.modules.accounts.base.Organization','May 28 2004 10:25:34:327AM','May 28 2004 10:25:34:327AM',NULL,-1,0,'id')
INSERT [sync_table] VALUES(107,4,'accountList','org.aspcfs.modules.accounts.base.OrganizationList','May 28 2004 10:25:34:327AM','May 28 2004 10:25:34:327AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(108,4,'role','org.aspcfs.modules.admin.base.Role','May 28 2004 10:25:34:327AM','May 28 2004 10:25:34:327AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(109,4,'roleList','org.aspcfs.modules.admin.base.RoleList','May 28 2004 10:25:34:327AM','May 28 2004 10:25:34:327AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(110,4,'permissionCategory','org.aspcfs.modules.admin.base.PermissionCategory','May 28 2004 10:25:34:327AM','May 28 2004 10:25:34:327AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(111,4,'permissionCategoryList','org.aspcfs.modules.admin.base.PermissionCategoryList','May 28 2004 10:25:34:337AM','May 28 2004 10:25:34:337AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(112,4,'permission','org.aspcfs.modules.admin.base.Permission','May 28 2004 10:25:34:337AM','May 28 2004 10:25:34:337AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(113,4,'permissionList','org.aspcfs.modules.admin.base.PermissionList','May 28 2004 10:25:34:337AM','May 28 2004 10:25:34:337AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(114,4,'rolePermission','org.aspcfs.modules.admin.base.RolePermission','May 28 2004 10:25:34:337AM','May 28 2004 10:25:34:337AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(115,4,'rolePermissionList','org.aspcfs.modules.admin.base.RolePermissionList','May 28 2004 10:25:34:337AM','May 28 2004 10:25:34:337AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(116,4,'opportunity','org.aspcfs.modules.pipeline.base.Opportunity','May 28 2004 10:25:34:337AM','May 28 2004 10:25:34:337AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(117,4,'opportunityList','org.aspcfs.modules.pipeline.base.OpportunityList','May 28 2004 10:25:34:337AM','May 28 2004 10:25:34:337AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(118,4,'call','org.aspcfs.modules.contacts.base.Call','May 28 2004 10:25:34:347AM','May 28 2004 10:25:34:347AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(119,4,'callList','org.aspcfs.modules.contacts.base.CallList','May 28 2004 10:25:34:347AM','May 28 2004 10:25:34:347AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(120,4,'customFieldCategory','org.aspcfs.modules.base.CustomFieldCategory','May 28 2004 10:25:34:347AM','May 28 2004 10:25:34:347AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(121,4,'customFieldCategoryList','org.aspcfs.modules.base.CustomFieldCategoryList','May 28 2004 10:25:34:347AM','May 28 2004 10:25:34:347AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(122,4,'customFieldGroup','org.aspcfs.modules.base.CustomFieldGroup','May 28 2004 10:25:34:347AM','May 28 2004 10:25:34:347AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(123,4,'customFieldGroupList','org.aspcfs.modules.base.CustomFieldGroupList','May 28 2004 10:25:34:347AM','May 28 2004 10:25:34:347AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(124,4,'customField','org.aspcfs.modules.base.CustomField','May 28 2004 10:25:34:347AM','May 28 2004 10:25:34:347AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(125,4,'customFieldList','org.aspcfs.modules.base.CustomFieldList','May 28 2004 10:25:34:357AM','May 28 2004 10:25:34:357AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(126,4,'customFieldLookup','org.aspcfs.utils.web.LookupElement','May 28 2004 10:25:34:357AM','May 28 2004 10:25:34:357AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(127,4,'customFieldLookupList','org.aspcfs.utils.web.LookupList','May 28 2004 10:25:34:357AM','May 28 2004 10:25:34:357AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(128,4,'customFieldRecord','org.aspcfs.modules.base.CustomFieldRecord','May 28 2004 10:25:34:357AM','May 28 2004 10:25:34:357AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(129,4,'customFieldRecordList','org.aspcfs.modules.base.CustomFieldRecordList','May 28 2004 10:25:34:357AM','May 28 2004 10:25:34:357AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(130,4,'contactEmailAddress','org.aspcfs.modules.contacts.base.ContactEmailAddress','May 28 2004 10:25:34:357AM','May 28 2004 10:25:34:357AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(131,4,'contactEmailAddressList','org.aspcfs.modules.contacts.base.ContactEmailAddressList','May 28 2004 10:25:34:357AM','May 28 2004 10:25:34:357AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(132,4,'customFieldData','org.aspcfs.modules.base.CustomFieldData','May 28 2004 10:25:34:367AM','May 28 2004 10:25:34:367AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(133,4,'lookupProjectActivity','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:367AM','May 28 2004 10:25:34:367AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(134,4,'lookupProjectActivityList','org.aspcfs.utils.web.CustomLookupList','May 28 2004 10:25:34:367AM','May 28 2004 10:25:34:367AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(135,4,'lookupProjectIssues','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:367AM','May 28 2004 10:25:34:367AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(136,4,'lookupProjectIssuesList','org.aspcfs.utils.web.CustomLookupList','May 28 2004 10:25:34:377AM','May 28 2004 10:25:34:377AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(137,4,'lookupProjectLoe','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:377AM','May 28 2004 10:25:34:377AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(138,4,'lookupProjectLoeList','org.aspcfs.utils.web.CustomLookupList','May 28 2004 10:25:34:377AM','May 28 2004 10:25:34:377AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(139,4,'lookupProjectPriority','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:377AM','May 28 2004 10:25:34:377AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(140,4,'lookupProjectPriorityList','org.aspcfs.utils.web.CustomLookupList','May 28 2004 10:25:34:387AM','May 28 2004 10:25:34:387AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(141,4,'lookupProjectStatus','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:387AM','May 28 2004 10:25:34:387AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(142,4,'lookupProjectStatusList','org.aspcfs.utils.web.CustomLookupList','May 28 2004 10:25:34:387AM','May 28 2004 10:25:34:387AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(143,4,'project','com.zeroio.iteam.base.Project','May 28 2004 10:25:34:387AM','May 28 2004 10:25:34:387AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(144,4,'projectList','com.zeroio.iteam.base.ProjectList','May 28 2004 10:25:34:397AM','May 28 2004 10:25:34:397AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(145,4,'requirement','com.zeroio.iteam.base.Requirement','May 28 2004 10:25:34:397AM','May 28 2004 10:25:34:397AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(146,4,'requirementList','com.zeroio.iteam.base.RequirementList','May 28 2004 10:25:34:397AM','May 28 2004 10:25:34:397AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(147,4,'assignment','com.zeroio.iteam.base.Assignment','May 28 2004 10:25:34:397AM','May 28 2004 10:25:34:397AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(148,4,'assignmentList','com.zeroio.iteam.base.AssignmentList','May 28 2004 10:25:34:397AM','May 28 2004 10:25:34:397AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(149,4,'issue','com.zeroio.iteam.base.Issue','May 28 2004 10:25:34:397AM','May 28 2004 10:25:34:397AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(150,4,'issueList','com.zeroio.iteam.base.IssueList','May 28 2004 10:25:34:407AM','May 28 2004 10:25:34:407AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(151,4,'issueReply','com.zeroio.iteam.base.IssueReply','May 28 2004 10:25:34:407AM','May 28 2004 10:25:34:407AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(152,4,'issueReplyList','com.zeroio.iteam.base.IssueReplyList','May 28 2004 10:25:34:407AM','May 28 2004 10:25:34:407AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(153,4,'teamMember','com.zeroio.iteam.base.TeamMember','May 28 2004 10:25:34:407AM','May 28 2004 10:25:34:407AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(154,4,'fileItem','com.zeroio.iteam.base.FileItem','May 28 2004 10:25:34:407AM','May 28 2004 10:25:34:407AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(155,4,'fileItemList','com.zeroio.iteam.base.FileItemList','May 28 2004 10:25:34:407AM','May 28 2004 10:25:34:407AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(156,4,'fileItemVersion','com.zeroio.iteam.base.FileItemVersion','May 28 2004 10:25:34:417AM','May 28 2004 10:25:34:417AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(157,4,'fileItemVersionList','com.zeroio.iteam.base.FileItemVersionList','May 28 2004 10:25:34:417AM','May 28 2004 10:25:34:417AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(158,4,'fileDownloadLog','com.zeroio.iteam.base.FileDownloadLog','May 28 2004 10:25:34:417AM','May 28 2004 10:25:34:417AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(159,4,'contactAddress','org.aspcfs.modules.contacts.base.ContactAddress','May 28 2004 10:25:34:417AM','May 28 2004 10:25:34:417AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(160,4,'contactAddressList','org.aspcfs.modules.contacts.base.ContactAddressList','May 28 2004 10:25:34:417AM','May 28 2004 10:25:34:417AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(161,4,'contactPhoneNumber','org.aspcfs.modules.contacts.base.ContactPhoneNumber','May 28 2004 10:25:34:417AM','May 28 2004 10:25:34:417AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(162,4,'contactPhoneNumberList','org.aspcfs.modules.contacts.base.ContactPhoneNumberList','May 28 2004 10:25:34:427AM','May 28 2004 10:25:34:427AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(163,4,'organizationPhoneNumber','org.aspcfs.modules.accounts.base.OrganizationPhoneNumber','May 28 2004 10:25:34:437AM','May 28 2004 10:25:34:437AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(164,4,'organizationPhoneNumberList','org.aspcfs.modules.accounts.base.OrganizationPhoneNumberList','May 28 2004 10:25:34:437AM','May 28 2004 10:25:34:437AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(165,4,'organizationEmailAddress','org.aspcfs.modules.accounts.base.OrganizationEmailAddress','May 28 2004 10:25:34:437AM','May 28 2004 10:25:34:437AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(166,4,'organizationEmailAddressList','org.aspcfs.modules.accounts.base.OrganizationEmailAddressList','May 28 2004 10:25:34:437AM','May 28 2004 10:25:34:437AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(167,4,'organizationAddress','org.aspcfs.modules.accounts.base.OrganizationAddress','May 28 2004 10:25:34:437AM','May 28 2004 10:25:34:437AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(168,4,'organizationAddressList','org.aspcfs.modules.accounts.base.OrganizationAddressList','May 28 2004 10:25:34:447AM','May 28 2004 10:25:34:447AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(169,4,'ticketLog','org.aspcfs.modules.troubletickets.base.TicketLog','May 28 2004 10:25:34:447AM','May 28 2004 10:25:34:447AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(170,4,'ticketLogList','org.aspcfs.modules.troubletickets.base.TicketLogList','May 28 2004 10:25:34:447AM','May 28 2004 10:25:34:447AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(171,4,'message','org.aspcfs.modules.communications.base.Message','May 28 2004 10:25:34:447AM','May 28 2004 10:25:34:447AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(172,4,'messageList','org.aspcfs.modules.communications.base.MessageList','May 28 2004 10:25:34:447AM','May 28 2004 10:25:34:447AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(173,4,'searchCriteriaElements','org.aspcfs.modules.communications.base.SearchCriteriaList','May 28 2004 10:25:34:447AM','May 28 2004 10:25:34:447AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(174,4,'searchCriteriaElementsList','org.aspcfs.modules.communications.base.SearchCriteriaListList','May 28 2004 10:25:34:447AM','May 28 2004 10:25:34:447AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(175,4,'savedCriteriaElement','org.aspcfs.modules.communications.base.SavedCriteriaElement','May 28 2004 10:25:34:457AM','May 28 2004 10:25:34:457AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(176,4,'searchFieldElement','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:457AM','May 28 2004 10:25:34:457AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(177,4,'searchFieldElementList','org.aspcfs.utils.web.CustomLookupList','May 28 2004 10:25:34:457AM','May 28 2004 10:25:34:457AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(178,4,'revenue','org.aspcfs.modules.accounts.base.Revenue','May 28 2004 10:25:34:457AM','May 28 2004 10:25:34:457AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(179,4,'revenueList','org.aspcfs.modules.accounts.base.RevenueList','May 28 2004 10:25:34:457AM','May 28 2004 10:25:34:457AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(180,4,'campaign','org.aspcfs.modules.communications.base.Campaign','May 28 2004 10:25:34:457AM','May 28 2004 10:25:34:457AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(181,4,'campaignList','org.aspcfs.modules.communications.base.CampaignList','May 28 2004 10:25:34:457AM','May 28 2004 10:25:34:457AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(182,4,'scheduledRecipient','org.aspcfs.modules.communications.base.ScheduledRecipient','May 28 2004 10:25:34:467AM','May 28 2004 10:25:34:467AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(183,4,'scheduledRecipientList','org.aspcfs.modules.communications.base.ScheduledRecipientList','May 28 2004 10:25:34:467AM','May 28 2004 10:25:34:467AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(184,4,'accessLog','org.aspcfs.modules.admin.base.AccessLog','May 28 2004 10:25:34:467AM','May 28 2004 10:25:34:467AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(185,4,'accessLogList','org.aspcfs.modules.admin.base.AccessLogList','May 28 2004 10:25:34:467AM','May 28 2004 10:25:34:467AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(186,4,'accountTypeLevels','org.aspcfs.modules.accounts.base.AccountTypeLevel','May 28 2004 10:25:34:467AM','May 28 2004 10:25:34:467AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(187,4,'fieldTypes','org.aspcfs.utils.web.CustomLookupElement','May 28 2004 10:25:34:467AM','May 28 2004 10:25:34:467AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(188,4,'fieldTypesList','org.aspcfs.utils.web.CustomLookupList','May 28 2004 10:25:34:477AM','May 28 2004 10:25:34:477AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(189,4,'excludedRecipient','org.aspcfs.modules.communications.base.ExcludedRecipient','May 28 2004 10:25:34:477AM','May 28 2004 10:25:34:477AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(190,4,'campaignRun','org.aspcfs.modules.communications.base.CampaignRun','May 28 2004 10:25:34:477AM','May 28 2004 10:25:34:477AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(191,4,'campaignRunList','org.aspcfs.modules.communications.base.CampaignRunList','May 28 2004 10:25:34:477AM','May 28 2004 10:25:34:477AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(192,4,'campaignListGroups','org.aspcfs.modules.communications.base.CampaignListGroup','May 28 2004 10:25:34:477AM','May 28 2004 10:25:34:477AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(193,5,'ticket','org.aspcfs.modules.troubletickets.base.Ticket','May 28 2004 10:25:34:477AM','May 28 2004 10:25:34:477AM',NULL,-1,0,'id')
INSERT [sync_table] VALUES(194,5,'ticketCategory','org.aspcfs.modules.troubletickets.base.TicketCategory','May 28 2004 10:25:34:487AM','May 28 2004 10:25:34:487AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(195,5,'ticketCategoryList','org.aspcfs.modules.troubletickets.base.TicketCategoryList','May 28 2004 10:25:34:487AM','May 28 2004 10:25:34:487AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(196,5,'syncClient','org.aspcfs.modules.service.base.SyncClient','May 28 2004 10:25:34:487AM','May 28 2004 10:25:34:487AM',NULL,2,0,NULL)
INSERT [sync_table] VALUES(197,5,'accountList','org.aspcfs.modules.accounts.base.OrganizationList','May 28 2004 10:25:34:487AM','May 28 2004 10:25:34:487AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(198,5,'userList','org.aspcfs.modules.admin.base.UserList','May 28 2004 10:25:34:487AM','May 28 2004 10:25:34:487AM',NULL,-1,0,NULL)
INSERT [sync_table] VALUES(199,5,'contactList','org.aspcfs.modules.contacts.base.ContactList','May 28 2004 10:25:34:487AM','May 28 2004 10:25:34:487AM',NULL,-1,0,NULL)

SET IDENTITY_INSERT [sync_table] OFF
GO
SET NOCOUNT OFF
 
-- Insert default field_types
SET NOCOUNT ON
SET IDENTITY_INSERT [field_types] ON
GO
INSERT [field_types] VALUES(1,0,'string','=','is',1)
INSERT [field_types] VALUES(2,0,'string','!=','is not',1)
INSERT [field_types] VALUES(3,0,'string','= | or field_name is null','is empty',0)
INSERT [field_types] VALUES(4,0,'string','!= | and field_name is not null','is not empty',0)
INSERT [field_types] VALUES(5,0,'string','like %search_value%','contains',0)
INSERT [field_types] VALUES(6,0,'string','not like %search_value%','does not contain',0)
INSERT [field_types] VALUES(7,1,'date','<','before',1)
INSERT [field_types] VALUES(8,1,'date','>','after',1)
INSERT [field_types] VALUES(9,1,'date','between','between',0)
INSERT [field_types] VALUES(10,1,'date','<=','on or before',1)
INSERT [field_types] VALUES(11,1,'date','>=','on or after',1)
INSERT [field_types] VALUES(12,2,'number','>','greater than',1)
INSERT [field_types] VALUES(13,2,'number','<','less than',1)
INSERT [field_types] VALUES(14,2,'number','=','equals',1)
INSERT [field_types] VALUES(15,2,'number','>=','greater than or equal to',1)
INSERT [field_types] VALUES(16,2,'number','<=','less than or equal to',1)
INSERT [field_types] VALUES(17,2,'number','is not null','exist',1)
INSERT [field_types] VALUES(18,2,'number','is null','does not exist',1)

SET IDENTITY_INSERT [field_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default search_fields
SET NOCOUNT ON
SET IDENTITY_INSERT [search_fields] ON
GO
INSERT [search_fields] VALUES(1,'company','Company Name',1,0,NULL,NULL,1)
INSERT [search_fields] VALUES(2,'namefirst','Contact First Name',1,0,NULL,NULL,1)
INSERT [search_fields] VALUES(3,'namelast','Contact Last Name',1,0,NULL,NULL,1)
INSERT [search_fields] VALUES(4,'entered','Entered Date',1,1,NULL,NULL,1)
INSERT [search_fields] VALUES(5,'zip','Zip Code',1,0,NULL,NULL,1)
INSERT [search_fields] VALUES(6,'areacode','Area Code',1,0,NULL,NULL,1)
INSERT [search_fields] VALUES(7,'city','City',1,0,NULL,NULL,1)
INSERT [search_fields] VALUES(8,'typeId','Contact Type',1,0,NULL,NULL,1)
INSERT [search_fields] VALUES(9,'contactId','Contact ID',0,0,NULL,NULL,1)
INSERT [search_fields] VALUES(10,'title','Contact Title',0,0,NULL,NULL,1)
INSERT [search_fields] VALUES(11,'accountTypeId','Account Type',1,0,NULL,NULL,1)

SET IDENTITY_INSERT [search_fields] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_component_library
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_component_library] ON
GO
INSERT [business_process_component_library] VALUES(1,'org.aspcfs.modules.troubletickets.components.LoadTicketDetails',1,'org.aspcfs.modules.troubletickets.components.LoadTicketDetails','Load all ticket information for use in other steps',1)
INSERT [business_process_component_library] VALUES(2,'org.aspcfs.modules.troubletickets.components.QueryTicketJustClosed',1,'org.aspcfs.modules.troubletickets.components.QueryTicketJustClosed','Was the ticket just closed?',1)
INSERT [business_process_component_library] VALUES(3,'org.aspcfs.modules.components.SendUserNotification',1,'org.aspcfs.modules.components.SendUserNotification','Send an email notification to a user',1)
INSERT [business_process_component_library] VALUES(4,'org.aspcfs.modules.troubletickets.components.SendTicketSurvey',1,'org.aspcfs.modules.troubletickets.components.SendTicketSurvey','org.aspcfs.modules.troubletickets.components.SendTicketSurvey',1)
INSERT [business_process_component_library] VALUES(5,'org.aspcfs.modules.troubletickets.components.QueryTicketJustAssigned',1,'org.aspcfs.modules.troubletickets.components.QueryTicketJustAssigned','Was the ticket just assigned or reassigned?',1)
INSERT [business_process_component_library] VALUES(6,'org.aspcfs.modules.troubletickets.components.GenerateTicketList',2,'org.aspcfs.modules.troubletickets.components.GenerateTicketList','Generate a list of tickets based on specified parameters.  Are there any tickets matching the parameters?',1)
INSERT [business_process_component_library] VALUES(7,'org.aspcfs.modules.troubletickets.components.SendTicketListReport',2,'org.aspcfs.modules.troubletickets.components.SendTicketListReport','Sends a ticket report to specified users with the specified parameters',1)

SET IDENTITY_INSERT [business_process_component_library] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_orderaddress_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_orderaddress_types] ON
GO
INSERT [lookup_orderaddress_types] VALUES(1,'Billing',0,0,1)
INSERT [lookup_orderaddress_types] VALUES(2,'Shipping',0,0,1)

SET IDENTITY_INSERT [lookup_orderaddress_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_component_result_lookup
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_component_result_lookup] ON
GO
INSERT [business_process_component_result_lookup] VALUES(1,2,1,'Yes',0,1)
INSERT [business_process_component_result_lookup] VALUES(2,2,0,'No',1,1)
INSERT [business_process_component_result_lookup] VALUES(3,5,1,'Yes',0,1)

SET IDENTITY_INSERT [business_process_component_result_lookup] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_parameter_library
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_parameter_library] ON
GO
INSERT [business_process_parameter_library] VALUES(1,3,'notification.module',NULL,'Tickets',1)
INSERT [business_process_parameter_library] VALUES(2,3,'notification.itemId',NULL,'${this.id}',1)
INSERT [business_process_parameter_library] VALUES(3,3,'notification.itemModified',NULL,'${this.modified}',1)
INSERT [business_process_parameter_library] VALUES(4,3,'notification.userToNotify',NULL,'${previous.enteredBy}',1)
INSERT [business_process_parameter_library] VALUES(5,3,'notification.subject',NULL,'Dark Horse CRM Ticket Closed: ${this.paddedId}',1)
INSERT [business_process_parameter_library] VALUES(6,3,'notification.body',NULL,'The following ticket in Dark Horse CRM has been closed:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Comment: ${this.comment}

Closed by: ${ticketModifiedByContact.nameFirstLast}

Solution: ${this.solution}
',1)
INSERT [business_process_parameter_library] VALUES(7,6,'notification.module',NULL,'Tickets',1)
INSERT [business_process_parameter_library] VALUES(8,6,'notification.itemId',NULL,'${this.id}',1)
INSERT [business_process_parameter_library] VALUES(9,6,'notification.itemModified',NULL,'${this.modified}',1)
INSERT [business_process_parameter_library] VALUES(10,6,'notification.userToNotify',NULL,'${this.assignedTo}',1)
INSERT [business_process_parameter_library] VALUES(11,6,'notification.subject',NULL,'Dark Horse CRM Ticket Assigned: ${this.paddedId}',1)
INSERT [business_process_parameter_library] VALUES(12,6,'notification.body',NULL,'The following ticket in Dark Horse CRM has been assigned to you:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Assigned By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}
',1)
INSERT [business_process_parameter_library] VALUES(13,7,'ticketList.onlyOpen',NULL,'true',1)
INSERT [business_process_parameter_library] VALUES(14,7,'ticketList.onlyAssigned',NULL,'true',1)
INSERT [business_process_parameter_library] VALUES(15,7,'ticketList.onlyUnassigned',NULL,'true',1)
INSERT [business_process_parameter_library] VALUES(16,7,'ticketList.minutesOlderThan',NULL,'10',1)
INSERT [business_process_parameter_library] VALUES(17,7,'ticketList.lastAnchor',NULL,'${process.lastAnchor}',1)
INSERT [business_process_parameter_library] VALUES(18,7,'ticketList.nextAnchor',NULL,'${process.nextAnchor}',1)
INSERT [business_process_parameter_library] VALUES(19,8,'notification.users.to',NULL,'${this.enteredBy}',1)
INSERT [business_process_parameter_library] VALUES(20,8,'notification.contacts.to',NULL,'${this.contactId}',1)
INSERT [business_process_parameter_library] VALUES(21,8,'notification.subject',NULL,'Dark Horse CRM Unassigned Ticket Report (${objects.size})',1)
INSERT [business_process_parameter_library] VALUES(22,8,'notification.body',NULL,'** This is an automated message **

The following tickets in Dark Horse CRM are unassigned and need attention:

',1)
INSERT [business_process_parameter_library] VALUES(23,8,'report.ticket.content',NULL,'----- Ticket Details -----
Ticket # ${this.paddedId}
Created: ${this.enteredString}
Organization: ${ticketOrganization.name}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Last Modified By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}


',1)

SET IDENTITY_INSERT [business_process_parameter_library] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process] ON
GO
INSERT [business_process] VALUES(1,'dhv.ticket.insert','Ticket change notification',1,8,1,1,'May 28 2004 10:25:58:020AM')
INSERT [business_process] VALUES(2,'dhv.report.ticketList.overdue','Overdue ticket notification',2,8,7,1,'May 28 2004 10:25:58:780AM')

SET IDENTITY_INSERT [business_process] OFF
GO
SET NOCOUNT OFF
 
-- Insert default ticket_level
SET NOCOUNT ON
SET IDENTITY_INSERT [ticket_level] ON
GO
INSERT [ticket_level] VALUES(1,'Entry level',0,0,1)
INSERT [ticket_level] VALUES(2,'First level',0,1,1)
INSERT [ticket_level] VALUES(3,'Second level',0,2,1)
INSERT [ticket_level] VALUES(4,'Third level',0,3,1)
INSERT [ticket_level] VALUES(5,'Top level',0,4,1)

SET IDENTITY_INSERT [ticket_level] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_lists_lookup
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_lists_lookup] ON
GO
INSERT [lookup_lists_lookup] VALUES(1,1,1,'lookupList','lookup_account_types',10,'Account Types','May 28 2004 10:25:37:710AM',1)
INSERT [lookup_lists_lookup] VALUES(2,1,2,'lookupList','lookup_revenue_types',20,'Revenue Types','May 28 2004 10:25:37:710AM',1)
INSERT [lookup_lists_lookup] VALUES(3,1,3,'contactType','lookup_contact_types',30,'Contact Types','May 28 2004 10:25:37:720AM',1)
INSERT [lookup_lists_lookup] VALUES(4,2,1,'contactType','lookup_contact_types',10,'Types','May 28 2004 10:25:37:860AM',2)
INSERT [lookup_lists_lookup] VALUES(5,2,2,'lookupList','lookup_contactemail_types',20,'Email Types','May 28 2004 10:25:37:860AM',2)
INSERT [lookup_lists_lookup] VALUES(6,2,3,'lookupList','lookup_contactaddress_types',30,'Address Types','May 28 2004 10:25:37:860AM',2)
INSERT [lookup_lists_lookup] VALUES(7,2,4,'lookupList','lookup_contactphone_types',40,'Phone Types','May 28 2004 10:25:37:870AM',2)
INSERT [lookup_lists_lookup] VALUES(8,4,1,'lookupList','lookup_stage',10,'Stage','May 28 2004 10:25:38:060AM',4)
INSERT [lookup_lists_lookup] VALUES(9,4,2,'lookupList','lookup_opportunity_types',20,'Opportunity Types','May 28 2004 10:25:38:070AM',4)
INSERT [lookup_lists_lookup] VALUES(10,8,1,'lookupList','lookup_ticketsource',10,'Ticket Source','May 28 2004 10:25:38:440AM',8)
INSERT [lookup_lists_lookup] VALUES(11,8,2,'lookupList','ticket_severity',20,'Ticket Severity','May 28 2004 10:25:38:440AM',8)
INSERT [lookup_lists_lookup] VALUES(12,8,3,'lookupList','ticket_priority',30,'Ticket Priority','May 28 2004 10:25:38:440AM',8)
INSERT [lookup_lists_lookup] VALUES(13,15,130041304,'lookupList','lookup_asset_status',10,'Asset Status','May 28 2004 10:25:38:943AM',130041000)
INSERT [lookup_lists_lookup] VALUES(14,16,130041305,'lookupList','lookup_sc_category',10,'Service Contract Category','May 28 2004 10:25:38:953AM',130041100)
INSERT [lookup_lists_lookup] VALUES(15,16,130041306,'lookupList','lookup_sc_type',20,'Service Contract Type','May 28 2004 10:25:38:963AM',130041100)
INSERT [lookup_lists_lookup] VALUES(16,16,116041409,'lookupList','lookup_response_model',30,'Response Time Model','May 28 2004 10:25:38:963AM',130041100)
INSERT [lookup_lists_lookup] VALUES(17,16,116041410,'lookupList','lookup_phone_model',40,'Phone Service Model','May 28 2004 10:25:38:963AM',130041100)
INSERT [lookup_lists_lookup] VALUES(18,16,116041411,'lookupList','lookup_onsite_model',50,'Onsite Service Model','May 28 2004 10:25:39:103AM',130041100)
INSERT [lookup_lists_lookup] VALUES(19,16,116041412,'lookupList','lookup_email_model',60,'Email Service Model','May 28 2004 10:25:39:113AM',130041100)
INSERT [lookup_lists_lookup] VALUES(20,16,308041546,'lookupList','lookup_hours_reason',70,'Contract Hours Adjustment Reason','May 28 2004 10:25:39:123AM',130041100)
INSERT [lookup_lists_lookup] VALUES(21,21,1111031132,'lookupList','lookup_department',10,'Departments','May 28 2004 10:25:39:233AM',1111031131)

SET IDENTITY_INSERT [lookup_lists_lookup] OFF
GO
SET NOCOUNT OFF
 
-- Insert default role
SET NOCOUNT ON
SET IDENTITY_INSERT [role] ON
GO
INSERT [role] VALUES(1,'Administrator','Performs system configuration and maintenance',0,'May 28 2004 10:25:39:303AM',0,'May 28 2004 10:25:39:303AM',1,0)
INSERT [role] VALUES(2,'Operations Manager','Manages operations',0,'May 28 2004 10:25:40:083AM',0,'May 28 2004 10:25:40:083AM',1,0)
INSERT [role] VALUES(3,'Sales Manager','Manages all accounts and opportunities',0,'May 28 2004 10:25:40:907AM',0,'May 28 2004 10:25:40:907AM',1,0)
INSERT [role] VALUES(4,'Salesperson','Manages own accounts and opportunities',0,'May 28 2004 10:25:41:757AM',0,'May 28 2004 10:25:41:757AM',1,0)
INSERT [role] VALUES(5,'Customer Service Manager','Manages all tickets',0,'May 28 2004 10:25:42:407AM',0,'May 28 2004 10:25:42:407AM',1,0)
INSERT [role] VALUES(6,'Customer Service Representative','Manages own tickets',0,'May 28 2004 10:25:42:950AM',0,'May 28 2004 10:25:42:950AM',1,0)
INSERT [role] VALUES(7,'Marketing Manager','Manages communications',0,'May 28 2004 10:25:43:430AM',0,'May 28 2004 10:25:43:430AM',1,0)
INSERT [role] VALUES(8,'Accounting Manager','Reviews revenue and opportunities',0,'May 28 2004 10:25:44:080AM',0,'May 28 2004 10:25:44:080AM',1,0)
INSERT [role] VALUES(9,'HR Representative','Manages employee information',0,'May 28 2004 10:25:44:660AM',0,'May 28 2004 10:25:44:660AM',1,0)
INSERT [role] VALUES(10,'Customer','Customer portal user',0,'May 28 2004 10:25:44:900AM',0,'May 28 2004 10:25:44:900AM',1,1)
INSERT [role] VALUES(11,'Products and Services Customer','Products and Services portal user',0,'May 28 2004 10:25:44:970AM',0,'May 28 2004 10:25:44:970AM',1,420041011)

SET IDENTITY_INSERT [role] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_payment_methods
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_payment_methods] ON
GO
INSERT [lookup_payment_methods] VALUES(1,'Cash',0,0,1)
INSERT [lookup_payment_methods] VALUES(2,'Credit Card',0,0,1)
INSERT [lookup_payment_methods] VALUES(3,'Personal Check',0,0,1)
INSERT [lookup_payment_methods] VALUES(4,'Money Order',0,0,1)
INSERT [lookup_payment_methods] VALUES(5,'Certified Check',0,0,1)

SET IDENTITY_INSERT [lookup_payment_methods] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_component
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_component] ON
GO
INSERT [business_process_component] VALUES(1,1,1,NULL,NULL,1)
INSERT [business_process_component] VALUES(2,1,2,1,NULL,1)
INSERT [business_process_component] VALUES(3,1,3,2,1,1)
INSERT [business_process_component] VALUES(4,1,4,2,1,0)
INSERT [business_process_component] VALUES(5,1,5,2,0,1)
INSERT [business_process_component] VALUES(6,1,3,5,1,1)
INSERT [business_process_component] VALUES(7,2,6,NULL,NULL,1)
INSERT [business_process_component] VALUES(8,2,7,7,NULL,1)

SET IDENTITY_INSERT [business_process_component] OFF
GO
SET NOCOUNT OFF
 
-- Insert default category_editor_lookup
SET NOCOUNT ON
SET IDENTITY_INSERT [category_editor_lookup] ON
GO
INSERT [category_editor_lookup] VALUES(1,8,202041401,'ticket_category',10,'Ticket Categories','May 28 2004 10:25:38:500AM',8,4)
INSERT [category_editor_lookup] VALUES(2,15,202041400,'asset_category',10,'Asset Categories','May 28 2004 10:25:38:943AM',130041000,3)

SET IDENTITY_INSERT [category_editor_lookup] OFF
GO
SET NOCOUNT OFF
 
-- Insert default ticket_severity
SET NOCOUNT ON
SET IDENTITY_INSERT [ticket_severity] ON
GO
INSERT [ticket_severity] VALUES(1,'Normal','background-color:lightgreen;color:black;',1,0,1)
INSERT [ticket_severity] VALUES(2,'Important','background-color:yellow;color:black;',0,1,1)
INSERT [ticket_severity] VALUES(3,'Critical','background-color:red;color:black;font-weight:bold;',0,2,1)

SET IDENTITY_INSERT [ticket_severity] OFF
GO
SET NOCOUNT OFF
 
-- Insert default help_module
SET NOCOUNT ON
SET IDENTITY_INSERT [help_module] ON
GO
INSERT [help_module] VALUES(1,12,'This is the "Home Page". The top set of tabs shows the individual modules that you can access. The second row are the functions available to you in this module.
If you are looking for a particular module or function you have seen during training or on someone else''s machine, and it''s NOT visible, then it probably means that you do not have permission for that module or function.

Permissions within the system are assigned to Roles and then Users are assigned to Roles by the System Administrator.','The Home Page has several main features.

Welcome: This is the welcome page. Here you will see a calendar of all of your upcoming alerts in the system, as well as for users that report to you.

Mailbox: The message system is designed to support INTERNAL business messaging needs and to prepare OUTGOING emails to addresses who are already in the system. Messaging is NOT a normal email replacement. It will not send email to addresses assigned "on-the-fly" and it will not receive OUTSIDE email.

Tasks: Tasks allows you to create and assign tasks. Tasks created can be assigned to the creator of the task or an employee working in the system. This page lists the tasks present along with their priorities, due dates and age.

Action Lists: Action Lists allow you to create a list of contacts that are related in some way. For each of the contacts in a list, you can add calls, opportunities, tickets, tasks or send a message, which would correspondingly show up in their respective tabs. For example, adding a ticket to the contact would be reflected in the Ticket module.

Re-assignments: You can reassign data from one employee to another employee as long as each employee reports to you. The data can be of different types related to accounts, contacts, opportunities, activities, tickets etc, which the newly reassigned employee could view.

Settings: This feature allows you to modify the information about yourself and your location, and also change your password to the system.')
INSERT [help_module] VALUES(2,2,'The purpose of this module is for the users to view contacts and add new contacts. You can also search for contacts as well as export contact data.','The Contacts module has three main features

Add: A new contact can be added into the system. The contact can be a general contact, or one that is associated with an account. All the details about the contact like the email address, phone numbers, address and some additional details can be added.

Search: Use this page to search for contacts in the system based on different filters.

Export: Contact data can be exported and displayed in different formats, and can be filtered in different ways. The Export page also lets you view the data, download it, and show the number of times the exported data has been downloaded.

Import: The contacts importer is a sophisticated tool for importing contacts into DHV CRM. Features include the ability to custom/auto map fields to application properties, perform error checking and examine import progress.')
INSERT [help_module] VALUES(3,4,'Pipeline helps in creating opportunities or leads in the company. Each opportunity helps to follow-up on a lead, which might eventually turn into a client. Here you can create an opportunity, search for an existing opportunity in the system, or export the data in different formats. The dashboard displays a progress chart in different views for all the employees working under the hierarchy of the owner of the opportunity.','This Pipeline System has four main features:

Dashboard: Gives you a quick, visual overview of opportunities.

Add: This page lets you add an opportunity into the system. Here a new opportunity can be added by giving the description of the opportunity. You can add a component that is associated with the opportunity. Each component can be assigned to an employee and the type of the component can be selected. For each component the probability of closing the component, the date estimated, the best guess for closing the deal and the duration for that component can be entered.

Search: You can search for an opportunity already existing in the system based on different filters.

Export: The data can be filtered, exported and displayed in different formats.')
INSERT [help_module] VALUES(4,1,'You are looking at the Accounts module homepage, which has a dashboard view of all your accounts. This view is based on a date range selected from the calendar; by default it shows the schedule for the next seven days. You can optionally view the calendar of those below you in your hierarchy. The scheduled actions of each user can also be viewed. In the Accounts Module, new accounts can be added, existing accounts can be searched based on different filters, revenue for each account can be created/maintained and finally, data can be exported to different formats.','The Accounts module has five main features.

Dashboard: Displays a dashboard view account contract expirations.

Add: Allows you to add a new account

Search: This page provides a search feature for the accounts present in the system

Revenue: Graphically visualizes revenue if the historical data is present in the system. All the accounts with revenue are shown along with a list of employees working under you under the progress chart. You can add accounts, search for the existing ones in the system based on different filters and export the data to different formats

Export: Data can be exported and displayed in different formats. The exported data can be filtered in different ways. You can view the data, download it, and see the number of times an exported report has been downloaded')
INSERT [help_module] VALUES(5,6,'Communications is a "Campaign Manager" Module where you can manage complex email. fax, or mail communications with your customers. Communications allows you to create and choose Groups, Messages, and Schedules to define communications scenarios from the simple to the very complex. Groups can range from a single contact chosen from a pick list to the result of a complex query of the Account/Contact database. Messages can be anything from a single-line email to a rich, multimedia product catalog to an interactive survey.','The Communication module has six main features.

Dashboard: Track and analyze campaigns that have been activated and executed.
Messages can be sent out by any combination of email, fax, or mail merge. The Dashboard shows an overview of sent messages and allows you to drill down and view recipients and any survey results.

Add: This page lets you add a new campaign.

Campaign List: This page lets you add a new campaign into the system.

Groups: Each campaign needs at least one group to send a message to. Use criteria to filter the contacts you need to reach and use them over and over again. As new contacts meet the criteria, they will be included in future campaigns. This page lists the group names. It shows the groups created by you or everybody i.e. all the groups. 

Messages: Compose a message to reach your audience. Each campaign requires a message that will be sent to selected groups. Write the message once, then use it in any number of future campaigns. Modified messages will only affect future campaigns. Displays the list of messages, with the description and other details.

Attachments: Customize and configure your Campaigns with attachments. Attachments can include interactive items, like surveys, or provide additional materials like files.')
INSERT [help_module] VALUES(6,8,'You are looking at the Help Desk module home page. The dashboard shows the most recent tickets that have been assigned to you, as well as tickets that are in your department, and tickets that have been created by you. You can add new tickets, search for existing tickets based on different filters and export ticket data.','The Help Desk module has four main features.

View: Lists all the tickets assigned to you and the tickets assigned in your department. Details such as the ticket number, priority, age, i.e. how old the ticket is, the company and the tickets assignment are displayed.

Add: You can add a new ticket here.

Search: Form used for searching the tickets that already exist in the system based on different filters and parameters.

Export: This page shows exported data. The data can be exported to different formats. The exported data can be viewed with its subject, the size of the exported data file, when it was created and by whom. It also shows the number of times that particular exported file was downloaded. The exported data, created by you or all the employees can be viewed in two different views. A new data file can also be exported.')
INSERT [help_module] VALUES(7,21,'You are looking at the Employee module home page. This page displays the details of all the employees present in the system.','The main feature of the employee module is the view.

View: This page displays the details of each employee, which can be viewed, modified or deleted. Each employee record contains details such as the name of the employee, their department, title and phone number. This also lets you add a new employee into the system.')
INSERT [help_module] VALUES(8,14,'You are looking at the Reports module home page. This page displays a list of generated reports that are ready to be downloaded. It also displays a list of reports that are scheduled to be processed by server. You can add new reports too.','The Reports module has two main features.

Queue: Queue shows the list of reports that are scheduled to be processed by the server.

Add: This shows the different modules present and displays the list of corresponding reports present in each module, allowing you to add a report to the schedule queue.')
INSERT [help_module] VALUES(9,9,'The admin module lets the user review the system usage, configure modules, and configure the global/system parameters.','This Admin System has five main features.

Users: This section allows the administrator to view and add users and manage user hierarchies. The users are typically employees in your company who interact with your clients or customers, but can be outsides that you have granted permissions on the system.

Roles: This page lists the different roles you have defined in the system, their role description and the number of people present in the system who carry out that role. New roles can be added into the system at any time.

Modules: This page lets you configure various parameters in the modules that meet the needs of your organization, including configuration of lookup lists and custom fields. There are four types of modules. Each module has different number of configure options. The changes in the module affect all the users.

System: You can configure the system for the session timeout and set the time limit for the time out.

Usage: Current System Usage and Billing Usage Information are displayed.')
INSERT [help_module] VALUES(10,3,'Auto Guide Brief','Auto Guide Detail')
INSERT [help_module] VALUES(11,10,'Help Brief','Help Detail')
INSERT [help_module] VALUES(12,5,'Demo Brief','Demo Detail')
INSERT [help_module] VALUES(13,11,'System Brief','System Detail')
INSERT [help_module] VALUES(14,17,'Brief description for product catalog','detail description for product catalog')

SET IDENTITY_INSERT [help_module] OFF
GO
SET NOCOUNT OFF
 
-- Insert default access
SET NOCOUNT ON
SET IDENTITY_INSERT [access] ON
GO
INSERT [access] VALUES(0,'dhvadmin','---',-1,1,-1,8,18,NULL,'America/New_York',NULL,'May 28 2004 10:25:31:360AM',0,'May 28 2004 10:25:31:360AM',0,'May 28 2004 10:25:31:360AM',NULL,-1,-1,1)

SET IDENTITY_INSERT [access] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_project_activity
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_project_activity] ON
GO
INSERT [lookup_project_activity] VALUES(1,'Project Initialization',0,1,1,0,0)
INSERT [lookup_project_activity] VALUES(2,'Analysis/Software Requirements',0,2,1,0,0)
INSERT [lookup_project_activity] VALUES(3,'Functional Specifications',0,3,1,0,0)
INSERT [lookup_project_activity] VALUES(4,'Prototype',0,4,1,0,0)
INSERT [lookup_project_activity] VALUES(5,'System Development',0,5,1,0,0)
INSERT [lookup_project_activity] VALUES(6,'Testing',0,6,1,0,0)
INSERT [lookup_project_activity] VALUES(7,'Training',0,7,1,0,0)
INSERT [lookup_project_activity] VALUES(8,'Documentation',0,8,1,0,0)
INSERT [lookup_project_activity] VALUES(9,'Deployment',0,9,1,0,0)
INSERT [lookup_project_activity] VALUES(10,'Post Implementation Review',0,10,1,0,0)

SET IDENTITY_INSERT [lookup_project_activity] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_creditcard_types
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_creditcard_types] ON
GO
INSERT [lookup_creditcard_types] VALUES(1,'Visa',0,0,1)
INSERT [lookup_creditcard_types] VALUES(2,'Master Card',0,0,1)
INSERT [lookup_creditcard_types] VALUES(3,'American Express',0,0,1)
INSERT [lookup_creditcard_types] VALUES(4,'Discover',0,0,1)

SET IDENTITY_INSERT [lookup_creditcard_types] OFF
GO
SET NOCOUNT OFF
 
-- Insert default permission_category
SET NOCOUNT ON
SET IDENTITY_INSERT [permission_category] ON
GO
INSERT [permission_category] VALUES(1,'Accounts',NULL,700,1,1,1,1,0,0,0,0,1)
INSERT [permission_category] VALUES(2,'Contacts',NULL,500,1,1,1,1,0,0,0,0,1)
INSERT [permission_category] VALUES(3,'Auto Guide',NULL,800,0,0,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(4,'Pipeline',NULL,600,1,1,0,1,1,0,0,0,1)
INSERT [permission_category] VALUES(5,'Demo',NULL,2100,0,0,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(6,'Communications',NULL,1200,1,1,0,0,0,0,0,0,1)
INSERT [permission_category] VALUES(7,'Projects',NULL,1300,0,0,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(8,'Help Desk',NULL,1600,1,1,1,1,0,1,1,1,1)
INSERT [permission_category] VALUES(9,'Admin',NULL,1800,1,1,0,0,0,0,0,0,1)
INSERT [permission_category] VALUES(10,'Help',NULL,1900,1,1,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(11,'System',NULL,100,1,1,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(12,'My Home Page',NULL,200,1,1,0,0,0,0,0,0,1)
INSERT [permission_category] VALUES(13,'QA',NULL,2000,0,0,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(14,'Reports',NULL,1700,1,1,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(15,'Assets',NULL,1500,1,1,0,1,0,1,0,0,0)
INSERT [permission_category] VALUES(16,'Service Contracts',NULL,1400,1,1,0,1,0,0,0,0,0)
INSERT [permission_category] VALUES(17,'Product Catalog',NULL,1100,1,1,1,0,0,0,0,0,0)
INSERT [permission_category] VALUES(18,'Products and Services',NULL,300,0,0,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(19,'Quotes',NULL,900,1,1,0,0,0,0,0,0,0)
INSERT [permission_category] VALUES(20,'Orders',NULL,1000,1,1,0,0,0,0,0,0,1)
INSERT [permission_category] VALUES(21,'Employees',NULL,400,1,1,0,1,0,0,0,0,1)

SET IDENTITY_INSERT [permission_category] OFF
GO
SET NOCOUNT OFF
 
-- Insert default help_contents
SET NOCOUNT ON
SET IDENTITY_INSERT [help_contents] ON
GO
INSERT [help_contents] VALUES(1,12,1,'MyCFS.do','Home',NULL,'Overview','You are looking at Home Page view, which has a dashboard view of all your assigned tasks, tickets, assignments, calls you have to make, and accounts that need attention. This view is based on a time selected from the calendar; by default it shows the schedule for the next seven days. You can optionally view the calendar of those below you in your hierarchy.',NULL,NULL,NULL,0,'May 28 2004 10:25:47:647AM',0,'May 28 2004 10:25:47:647AM',1)
INSERT [help_contents] VALUES(2,12,1,'MyCFSInbox.do','Inbox',NULL,'Mailbox','The messaging feature is designed to support INTERNAL business messaging needs and to prepare OUTGOING emails to addresses who are already in the system. Messaging is NOT a normal email replacement. It will not send email to address assigned "on-the-fly" and it will not receive OUTSIDE email.',NULL,NULL,NULL,0,'May 28 2004 10:25:47:737AM',0,'May 28 2004 10:25:47:737AM',1)
INSERT [help_contents] VALUES(3,12,1,'MyCFSInbox.do','CFSNoteDetails',NULL,'Message Details','This page shows the message details, shows who sent the mail, when it was received and also the text in the mail box.',NULL,NULL,NULL,0,'May 28 2004 10:25:47:777AM',0,'May 28 2004 10:25:47:777AM',1)
INSERT [help_contents] VALUES(4,12,1,'MyCFSInbox.do','NewMessage',NULL,'New Message','Sending mail to other users of the system',NULL,NULL,NULL,0,'May 28 2004 10:25:47:787AM',0,'May 28 2004 10:25:47:787AM',1)
INSERT [help_contents] VALUES(5,12,1,'MyCFSInbox.do','ReplyToMessage',NULL,'Reply Message','This pages lets you reply to email. You can also select the list of recipients for your email by clicking the Add Recipients link.',NULL,NULL,NULL,0,'May 28 2004 10:25:47:797AM',0,'May 28 2004 10:25:47:797AM',1)
INSERT [help_contents] VALUES(6,12,1,'MyCFSInbox.do','SendMessage',NULL,NULL,'This page shows the list of recipients for whom your email has been sent to',NULL,NULL,NULL,0,'May 28 2004 10:25:47:837AM',0,'May 28 2004 10:25:47:837AM',1)
INSERT [help_contents] VALUES(7,12,1,'MyCFSInbox.do','ForwardMessage',NULL,'Forward message','Each message can be forwarded to any number of recipients',NULL,NULL,NULL,0,'May 28 2004 10:25:47:847AM',0,'May 28 2004 10:25:47:847AM',1)
INSERT [help_contents] VALUES(8,12,1,'MyTasks.do',NULL,NULL,'Tasks','Tasks created can be assigned to the owner/creator of the task or an employee working in the system. This page lists the tasks present along with their priorities, their due dates and age.',NULL,NULL,NULL,0,'May 28 2004 10:25:47:947AM',0,'May 28 2004 10:25:47:947AM',1)
INSERT [help_contents] VALUES(9,12,1,'MyTasks.do','New',NULL,'Advanced Task','Allows an advanced task to be created',NULL,NULL,NULL,0,'May 28 2004 10:25:47:977AM',0,'May 28 2004 10:25:47:977AM',1)
INSERT [help_contents] VALUES(10,12,1,'MyTasksForward.do','ForwardMessage',NULL,'Forwarding a Task','A task can be forwarded to any of the recipients. Recipients can either be users of the system or any of the contacts stored in the system. Checking the options fields check box indicates that if the recipient is a user of the system, then a copy of the task is also send to the recipient''s mailbox.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:017AM',0,'May 28 2004 10:25:48:017AM',1)
INSERT [help_contents] VALUES(11,12,1,'MyTasks.do','Modify',NULL,'Modify task','Allows you to modify any infomation about a task',NULL,NULL,NULL,0,'May 28 2004 10:25:48:037AM',0,'May 28 2004 10:25:48:037AM',1)
INSERT [help_contents] VALUES(12,12,1,'MyActionLists.do','List',NULL,'Action Lists','Action Lists allow you to create new Action Lists and assign contacts to the Action Lists created. For each of the contacts in a list, you can add a call, opportunity, ticket, task or send a message, which would correspondingly show up in their respective tabs. For example, adding a ticket to the contact would be reflected in the Ticket module.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:057AM',0,'May 28 2004 10:25:48:057AM',1)
INSERT [help_contents] VALUES(13,12,1,'MyActionContacts.do','List',NULL,'Action Contacts','This page will list out all the contacts present for the particular contact list. This also shows the status of the call, opportunity, ticket, task, or the message associated with the contact. This also shows when the contact information was last updated.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:077AM',0,'May 28 2004 10:25:48:077AM',1)
INSERT [help_contents] VALUES(14,12,1,'MyActionLists.do','Add',NULL,'Add Action List','Allows you to add an action list. Basically, you describe the group of contacts you will add, then visually design a query to generate the group of contacts.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:097AM',0,'May 28 2004 10:25:48:097AM',1)
INSERT [help_contents] VALUES(15,12,1,'MyActionLists.do','Modify',NULL,'Modify Action','The Action Lists details, like the description and status of the Action Lists, can be modified.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:127AM',0,'May 28 2004 10:25:48:127AM',1)
INSERT [help_contents] VALUES(16,12,1,'Reassignments.do','Reassign',NULL,'Re-assignments','A user can reassign data from one employee to another employee working under him. The data can be of different types related to accounts, contacts opportunities, activities, tickets etc, which the newly reassigned employee could view in his schedule.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:137AM',0,'May 28 2004 10:25:48:137AM',1)
INSERT [help_contents] VALUES(17,12,1,'MyCFS.do','MyProfile',NULL,'My Settings','This is the personal settings page, where you can modify the information about yourself, your location and also change your password to the system.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:157AM',0,'May 28 2004 10:25:48:157AM',1)
INSERT [help_contents] VALUES(18,12,1,'MyCFSProfile.do','MyCFSProfile',NULL,'Personal Information','This page lets you update/add your personal information.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:167AM',0,'May 28 2004 10:25:48:167AM',1)
INSERT [help_contents] VALUES(19,12,1,'MyCFSSettings.do','MyCFSSettings',NULL,'Location Settings','You can change your location settings',NULL,NULL,NULL,0,'May 28 2004 10:25:48:187AM',0,'May 28 2004 10:25:48:187AM',1)
INSERT [help_contents] VALUES(20,12,1,'MyCFSPassword.do','MyCFSPassword',NULL,'Update password','Your password to the system can be changed',NULL,NULL,NULL,0,'May 28 2004 10:25:48:197AM',0,'May 28 2004 10:25:48:197AM',1)
INSERT [help_contents] VALUES(21,12,1,'MyTasks.do','ListTasks',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:287AM',0,'May 28 2004 10:25:48:287AM',1)
INSERT [help_contents] VALUES(22,12,1,'MyTasks.do',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:317AM',0,'May 28 2004 10:25:48:317AM',1)
INSERT [help_contents] VALUES(23,12,1,'MyCFS.do','Home',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:327AM',0,'May 28 2004 10:25:48:327AM',1)
INSERT [help_contents] VALUES(24,12,1,'MyTasksForward.do','SendMessage',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:327AM',0,'May 28 2004 10:25:48:327AM',1)
INSERT [help_contents] VALUES(25,12,1,'MyCFSProfile.do','UpdateProfile',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:337AM',0,'May 28 2004 10:25:48:337AM',1)
INSERT [help_contents] VALUES(26,12,1,'MyCFSInbox.do','CFSNoteTrash',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:347AM',0,'May 28 2004 10:25:48:347AM',1)
INSERT [help_contents] VALUES(27,12,1,'MyActionContacts.do','Update',NULL,NULL,'No introduction available',NULL,NULL,NULL,0,'May 28 2004 10:25:48:357AM',0,'May 28 2004 10:25:48:357AM',1)
INSERT [help_contents] VALUES(28,12,1,'MyActionContacts.do','Prepare',NULL,NULL,'You can add the new Action List and also select the contacts to be present in the Action List.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:367AM',0,'May 28 2004 10:25:48:367AM',1)
INSERT [help_contents] VALUES(29,12,1,'MyTasks.do','ListTasks',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:377AM',0,'May 28 2004 10:25:48:377AM',1)
INSERT [help_contents] VALUES(30,12,1,'MyCFSInbox.do','Inbox',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:387AM',0,'May 28 2004 10:25:48:387AM',1)
INSERT [help_contents] VALUES(31,12,1,'MyActionContacts.do','Modify',NULL,'Modify Action List','Allows you to manually add or remove contacts to or from an existing Action List.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:397AM',0,'May 28 2004 10:25:48:397AM',1)
INSERT [help_contents] VALUES(32,12,1,'Reassignments.do','DoReassign',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:417AM',0,'May 28 2004 10:25:48:417AM',1)
INSERT [help_contents] VALUES(33,12,1,'TaskForm.do','Prepare',NULL,NULL,'Addition of a new Advanced task that can be assigned to the owner or any other employee working  under him.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:417AM',0,'May 28 2004 10:25:48:417AM',1)
INSERT [help_contents] VALUES(34,2,2,'ExternalContacts.do','Prepare',NULL,'Add a Contact','A new contact can be added to the system. The contact can be a general contact, or one that is associated with an account. All the details about the contact such as the email address, phone numbers, address and some additional details can be added.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:447AM',0,'May 28 2004 10:25:48:447AM',1)
INSERT [help_contents] VALUES(35,2,2,'ExternalContacts.do','SearchContactsForm',NULL,'Search Contacts','Use this page to search for contacts in the system based on different filters',NULL,NULL,NULL,0,'May 28 2004 10:25:48:477AM',0,'May 28 2004 10:25:48:477AM',1)
INSERT [help_contents] VALUES(36,2,2,'ExternalContacts.do','Reports',NULL,'Export Data','Contact data can be exported and displayed in different formats, and can be filtered in different ways. The Export page also lets you view the data, download it, and shows the number of times the exported data has been downloaded.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:477AM',0,'May 28 2004 10:25:48:477AM',1)
INSERT [help_contents] VALUES(37,2,2,'ExternalContacts.do','GenerateForm',NULL,'Exporting data','Use this page to generate a Contacts export report.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:507AM',0,'May 28 2004 10:25:48:507AM',1)
INSERT [help_contents] VALUES(38,2,2,'ExternalContacts.do','ModifyContact',NULL,'Modify Contact','The details about the contact can be modified here.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:617AM',0,'May 28 2004 10:25:48:617AM',1)
INSERT [help_contents] VALUES(39,2,2,'ExternalContacts.do',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:627AM',0,'May 28 2004 10:25:48:627AM',1)
INSERT [help_contents] VALUES(40,2,2,'ExternalContacts.do','Save',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:627AM',0,'May 28 2004 10:25:48:627AM',1)
INSERT [help_contents] VALUES(41,2,2,'ExternalContactsCalls.do','View',NULL,'Call Details','The calls related to the contact are listed here along with the other details such as the length of the call and the date the call was made. You can also add a call.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:747AM',0,'May 28 2004 10:25:48:747AM',1)
INSERT [help_contents] VALUES(42,2,2,'ExternalContactsCalls.do','Add',NULL,'Adding a Call','A new call can be added which is associated with the contact. The type of call can be selected using the drop down list present.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:767AM',0,'May 28 2004 10:25:48:767AM',1)
INSERT [help_contents] VALUES(43,2,2,'ExternalContactsCallsForward.do','ForwardMessage',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:777AM',0,'May 28 2004 10:25:48:777AM',1)
INSERT [help_contents] VALUES(44,2,2,'ExternalContactsCallsForward.do','SendMessage',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:777AM',0,'May 28 2004 10:25:48:777AM',1)
INSERT [help_contents] VALUES(45,2,2,'ExternalContactsOpps.do','ViewOpps',NULL,'Opportunity Details','All the opportunities associated with the contact are shown here, with its best possible total and the when the opportunity was last modified. You can filter the different types of opportunities using the drop down.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:787AM',0,'May 28 2004 10:25:48:787AM',1)
INSERT [help_contents] VALUES(46,2,2,'ExternalContactsCalls.do','Details',NULL,'Call Details','Calls associated with the contacts are displayed. The call details are shown with the length of the call, associated notes, alert description, alert date etc.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:807AM',0,'May 28 2004 10:25:48:807AM',1)
INSERT [help_contents] VALUES(47,2,2,'ExternalContactsOppComponents.do','Prepare',NULL,'Add a component','A component can be added to an opportunity and associated to any employee present in the system. The component type can also be selected.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:817AM',0,'May 28 2004 10:25:48:817AM',1)
INSERT [help_contents] VALUES(48,2,2,'ExternalContactsOpps.do','DetailsOpp',NULL,'Opportunity Details','You can view all the details about the components here, such as the status, the guess amount and the current stage. A new component can also be added to an existing opportunity.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:837AM',0,'May 28 2004 10:25:48:837AM',1)
INSERT [help_contents] VALUES(49,2,2,'ExternalContactsOppComponents.do','DetailsComponent',NULL,'Component Details','This page shows the details about the opportunity such as the probability of closing the opportunity, the current stage of the opportunity, etc.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:847AM',0,'May 28 2004 10:25:48:847AM',1)
INSERT [help_contents] VALUES(50,2,2,'ExternalContactsCalls.do','Modify',NULL,'Modifying call details','You can modify all the details of the calls.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:867AM',0,'May 28 2004 10:25:48:867AM',1)
INSERT [help_contents] VALUES(51,2,2,'ExternalContacts.do','InsertFields',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:867AM',0,'May 28 2004 10:25:48:867AM',1)
INSERT [help_contents] VALUES(52,2,2,'ExternalContacts.do','UpdateFields',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:877AM',0,'May 28 2004 10:25:48:877AM',1)
INSERT [help_contents] VALUES(53,2,2,'ExternalContacts.do','ListContacts',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:887AM',0,'May 28 2004 10:25:48:887AM',1)
INSERT [help_contents] VALUES(54,2,2,'ExternalContacts.do','Clone',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:887AM',0,'May 28 2004 10:25:48:887AM',1)
INSERT [help_contents] VALUES(55,2,2,'ExternalContacts.do','AddFolderRecord',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:897AM',0,'May 28 2004 10:25:48:897AM',1)
INSERT [help_contents] VALUES(56,2,2,'ExternalContactsOpps.do','Save',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:907AM',0,'May 28 2004 10:25:48:907AM',1)
INSERT [help_contents] VALUES(57,2,2,'ExternalContacts.do','SearchContacts',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:48:907AM',0,'May 28 2004 10:25:48:907AM',1)
INSERT [help_contents] VALUES(58,2,2,'ExternalContacts.do','MessageDetails',NULL,NULL,'The selected message is displayed with the message text and attachments, if any.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:917AM',0,'May 28 2004 10:25:48:917AM',1)
INSERT [help_contents] VALUES(59,2,2,'ExternalContactsOppComponents.do','SaveComponent',NULL,NULL,'This page shows the details of an opportunity, such as the probability of closing the opportunity, the current stage of the opportunity, etc.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:927AM',0,'May 28 2004 10:25:48:927AM',1)
INSERT [help_contents] VALUES(60,2,2,'ExternalContacts.do','SearchContacts',NULL,'List of Contacts','This page shows the list of contacts in the system. The name of the contact along with the company name and phone numbers are shown. If the name of the contact is an account, it''s shown right next to it. You can also add a contact.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:937AM',0,'May 28 2004 10:25:48:937AM',1)
INSERT [help_contents] VALUES(61,2,2,'ExternalContacts.do','ExportReport',NULL,'Overview','Data can be filtered, exported and displayed in different formats. This also shows the number of times an exported data has been downloaded.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:957AM',0,'May 28 2004 10:25:48:957AM',1)
INSERT [help_contents] VALUES(62,2,2,'ExternalContacts.do','ContactDetails',NULL,'Contact Details','The details about the contact are displayed here along with the record information containing the owner, the employee who entered the details and finally the person who last modified these details.',NULL,NULL,NULL,0,'May 28 2004 10:25:48:967AM',0,'May 28 2004 10:25:48:967AM',1)
INSERT [help_contents] VALUES(63,2,2,'ExternalContacts.do','ViewMessages',NULL,'Message Details','This page lists all the messages associated with the contact, showing the name of the message, its date and its status.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:057AM',0,'May 28 2004 10:25:49:057AM',1)
INSERT [help_contents] VALUES(64,2,2,'ExternalContactsCallsForward.do','ForwardCall',NULL,'Forwarding a call','The details of the calls that are associated with a contact can be forwarded to different employees present in the system.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:067AM',0,'May 28 2004 10:25:49:067AM',1)
INSERT [help_contents] VALUES(65,2,2,'ExternalContactsCallsForward.do','SendCall',NULL,'List of recipients','This page shows the list of recipients to whom the call details that are associated with a contact have been forwarded.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:077AM',0,'May 28 2004 10:25:49:077AM',1)
INSERT [help_contents] VALUES(66,2,2,'ExternalContactsOppComponents.do','ModifyComponent',NULL,'Modifying the component details','The details of the component associated with an opportunity can be modified.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:087AM',0,'May 28 2004 10:25:49:087AM',1)
INSERT [help_contents] VALUES(67,2,2,'ExternalContactsOpps.do','ModifyOpp',NULL,'Modify the opportunity','The description of the opportunity can be renamed / updated.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:097AM',0,'May 28 2004 10:25:49:097AM',1)
INSERT [help_contents] VALUES(68,2,2,'ExternalContacts.do','Fields',NULL,'List of Folder Records','Each contact can have several folders, and each folder further can have multiple records. You can add a record to a folder. Each record present in the folder displays the record name, when it was entered, who modified this record last and when.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:127AM',0,'May 28 2004 10:25:49:127AM',1)
INSERT [help_contents] VALUES(69,2,2,'ExternalContacts.do','ModifyFields',NULL,'Modify Folder Record','Here you can modify the details of the folder record.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:147AM',0,'May 28 2004 10:25:49:147AM',1)
INSERT [help_contents] VALUES(70,2,2,'ExternalContactsOpps.do','UpdateOpp',NULL,'Opportunity Details','All the opportunities associated with the contact are shown here, with its best possible total and the when the opportunity was last modified. You can filter the different types of opportunities that can be selected using the drop down and display them.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:157AM',0,'May 28 2004 10:25:49:157AM',1)
INSERT [help_contents] VALUES(71,2,2,'ContactsList.do','ContactList',NULL,NULL,'Enables you to select contacts from a list and then add them to the Action List. It shows the name of the contact along with his email and type of contact.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:177AM',0,'May 28 2004 10:25:49:177AM',1)
INSERT [help_contents] VALUES(72,2,2,'Contacts.do','Details',NULL,'Contact detail page','The contact details associated with the account are displayed here. The details such as the account number, email address, phone number and the addresses are shown.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:187AM',0,'May 28 2004 10:25:49:187AM',1)
INSERT [help_contents] VALUES(73,2,2,'Contacts.do','ViewMessages',NULL,'List of Messages','The list of messages related to the contacts.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:197AM',0,'May 28 2004 10:25:49:197AM',1)
INSERT [help_contents] VALUES(74,2,2,'ContactForm.do','Prepare',NULL,NULL,'Adding/Modifying a new contact',NULL,NULL,NULL,0,'May 28 2004 10:25:49:207AM',0,'May 28 2004 10:25:49:207AM',1)
INSERT [help_contents] VALUES(75,2,2,'ExternalContacts.do',NULL,NULL,'Overview','If a contact already exists in the system, you can search for that contact by name, company, title, contact type or source, by typing the search term in the appropriate field, and clicking the Search button.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:217AM',0,'May 28 2004 10:25:49:217AM',1)
INSERT [help_contents] VALUES(76,2,2,'ExternalContactsImports.do','New',NULL,'Add Import','This page allows you to upload a cvs file and import contacts from the uploaded file.  Once uploaded, the import is tagged as "Import Pending."

Once the file is uploaded, the import process can be started off by mapping the contents (the columns) of the file to the the fields of the application.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:277AM',0,'May 28 2004 10:25:49:277AM',1)
INSERT [help_contents] VALUES(77,2,2,'ExternalContactsImports.do','InitValidate',NULL,'Process Import','This page displays the first five records of the cvs file, and then maps known columns to the fields of the application. It allows you to cusomize your import by allowing you to map the columns of the cvs file to the fields of the application.

If the uploaded file is erroneous in its content (not in cvs format, or if the number of headings and columns do not match), you are not allowed to process the import until the errors are corrected.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:277AM',0,'May 28 2004 10:25:49:277AM',1)
INSERT [help_contents] VALUES(78,2,2,'ExternalContactsImports.do','View',NULL,'Contact Imports','This page lists contact imports and their status. An import may either be unprocessed, queued for processing, running, awaiting approval or approved.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:307AM',0,'May 28 2004 10:25:49:307AM',1)
INSERT [help_contents] VALUES(79,4,3,'Leads.do','Dashboard',NULL,'Overview','The progress chart is displayed in different views for all the employees working under the owner or creator of the opportunity. The opportunities are shown, with their names and the probable gross revenue associated with that opportunity. Finally the list of employees reporting to a particular employee/supervisor is also shown below the progress chart',NULL,NULL,NULL,0,'May 28 2004 10:25:49:427AM',0,'May 28 2004 10:25:49:427AM',1)
INSERT [help_contents] VALUES(80,4,3,'Leads.do','Prepare',NULL,'Add a Opportunity','This page lets you add a opportunity into the system.

Here a new opportunity can be added by giving a description of the opportunity, then adding a component that is associated with the opportunity. An opportunity can have one or more components. Each component can be assigned to a different employee and the type of the component can be selected. For each component the probability of closing the component, the date estimated, the best guess for closing the deal and the duration for that component are required.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:437AM',0,'May 28 2004 10:25:49:437AM',1)
INSERT [help_contents] VALUES(81,4,3,'Leads.do','SearchForm',NULL,'Search Opportunities','You can search for an existing opportunity based on different filters.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:467AM',0,'May 28 2004 10:25:49:467AM',1)
INSERT [help_contents] VALUES(82,4,3,'LeadsReports.do','Default',NULL,'Export Data','Pipeline data can be exported, filtered, and displayed in different formats. You can also view the data online in html format, and see number of times the exported data has been downloaded.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:477AM',0,'May 28 2004 10:25:49:477AM',1)
INSERT [help_contents] VALUES(83,4,3,'Leads.do','SearchOpp',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:49:497AM',0,'May 28 2004 10:25:49:497AM',1)
INSERT [help_contents] VALUES(84,4,3,'Leads.do','Reports',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:49:497AM',0,'May 28 2004 10:25:49:497AM',1)
INSERT [help_contents] VALUES(85,4,3,'LeadsComponents.do','ModifyComponent',NULL,'Modify Component','You can modify the component details associated with an opportunity in a pipeline.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:507AM',0,'May 28 2004 10:25:49:507AM',1)
INSERT [help_contents] VALUES(86,4,3,'LeadsCalls.do','Add',NULL,'Adding a call','You can add a new call here associated with the opportunity.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:527AM',0,'May 28 2004 10:25:49:527AM',1)
INSERT [help_contents] VALUES(87,4,3,'Leads.do','ModifyOpp',NULL,'Modify the opportunity:','The description of the opportunity can be modified / updated.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:537AM',0,'May 28 2004 10:25:49:537AM',1)
INSERT [help_contents] VALUES(88,4,3,'LeadsCalls.do','Insert',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:49:547AM',0,'May 28 2004 10:25:49:547AM',1)
INSERT [help_contents] VALUES(89,4,3,'LeadsDocuments.do','Modify',NULL,'Modify Document','Modify the Subject or filename of a document.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:557AM',0,'May 28 2004 10:25:49:557AM',1)
INSERT [help_contents] VALUES(90,4,3,'LeadsCallsForward.do','ForwardMessage',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:49:567AM',0,'May 28 2004 10:25:49:567AM',1)
INSERT [help_contents] VALUES(91,4,3,'Leads.do','Save',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:49:577AM',0,'May 28 2004 10:25:49:577AM',1)
INSERT [help_contents] VALUES(92,4,3,'Leads.do','GenerateForm',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:49:577AM',0,'May 28 2004 10:25:49:577AM',1)
INSERT [help_contents] VALUES(93,4,3,'LeadsComponents.do','DetailsComponent',NULL,'Component Details','The component details for the opportunity are shown here.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:587AM',0,'May 28 2004 10:25:49:587AM',1)
INSERT [help_contents] VALUES(94,4,3,'LeadsDocuments.do','AddVersion',NULL,'Upload a new version of document','You can upload a new version of the document and the new version of the file can be selected and uploaded.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:597AM',0,'May 28 2004 10:25:49:597AM',1)
INSERT [help_contents] VALUES(95,4,3,'Leads.do','Search',NULL,'List of components','The components resulted from the search are shown here. Different views of the components and its types are displayed. The name of the component with the estimated amount of money associated with the opportunity and the probability of that components being a success is shown. This also displays the time for closing the deal (term) and the organization name or the contact name if they are associated with the opportunity. A new opportunity can also be added.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:607AM',0,'May 28 2004 10:25:49:607AM',1)
INSERT [help_contents] VALUES(96,4,3,'Leads.do','UpdateOpp',NULL,'Opportunity Details','You can view all the details about the components here and also add a new component to a particular opportunity. Calls and the documents can be associated with the opportunity',NULL,NULL,NULL,0,'May 28 2004 10:25:49:710AM',0,'May 28 2004 10:25:49:710AM',1)
INSERT [help_contents] VALUES(97,4,3,'LeadsCallsForward.do','ForwardCall',NULL,'Forwarding a call','The details of calls associated with a contact can be forwarded to different users present in the system.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:730AM',0,'May 28 2004 10:25:49:730AM',1)
INSERT [help_contents] VALUES(98,4,3,'LeadsDocuments.do','View',NULL,'Document Details','In the Documents tab, the documents associated with a particular opportunity can be added to, and viewed.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:750AM',0,'May 28 2004 10:25:49:750AM',1)
INSERT [help_contents] VALUES(99,4,3,'LeadsCalls.do','Modify',NULL,'Modify call details','You can modify the details of the calls.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:770AM',0,'May 28 2004 10:25:49:770AM',1)
INSERT [help_contents] VALUES(100,4,3,'Leads.do','DetailsOpp',NULL,'Opportunity Details','You can view all the details about an opportunity components here and also add a new component to a particular opportunity. Calls and documents can also be added to an opportunity or viewed by clicking on the appropriate tab.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:770AM',0,'May 28 2004 10:25:49:770AM',1)
INSERT [help_contents] VALUES(101,4,3,'LeadsCalls.do','View',NULL,'Call Details','Calls associated with the opportunity are shown. Calls can be added to the opportunity, and details about listed calls can be examined.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:800AM',0,'May 28 2004 10:25:49:800AM',1)
INSERT [help_contents] VALUES(102,4,3,'Leads.do','ViewOpp',NULL,NULL,'The opportunities resulted from the search are shown here. Different views of the opportunities and its types are displayed. The name of the component with the estimated amount of money associated with the opportunity and the probability of that opportunity being a success are shown. This also displays the time for closing the deal (term) and the organization name or the contact name if they are associated with the opportunity.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:810AM',0,'May 28 2004 10:25:49:810AM',1)
INSERT [help_contents] VALUES(103,4,3,'Leads.do',NULL,NULL,NULL,'Pipeline helps in creating prospective opportunities or leads in the company. Each opportunity helps to follow up a lead, who might eventually turn into a client. Here you can create an opportunity, search for an existing opportunity in the system, export the data to different formats. The dashboard reflects the progress chart in different views for all the employees working under the owner/creator of the opportunity.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:830AM',0,'May 28 2004 10:25:49:830AM',1)
INSERT [help_contents] VALUES(104,4,3,'LeadsComponents.do','SaveComponent',NULL,'Component Details','The component details for the opportunity are shown here.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:840AM',0,'May 28 2004 10:25:49:840AM',1)
INSERT [help_contents] VALUES(105,4,3,'LeadsComponents.do','Prepare',NULL,'Add a component','A component can be added to an opportunity and assigned to any employee in the system. The component type can also be selected.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:850AM',0,'May 28 2004 10:25:49:850AM',1)
INSERT [help_contents] VALUES(106,4,3,'LeadsCalls.do','Update',NULL,'Call Details','The calls associated with the opportunity are shown. Calls can be added to the opportunity.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:860AM',0,'May 28 2004 10:25:49:860AM',1)
INSERT [help_contents] VALUES(107,4,3,'LeadsCalls.do','Details',NULL,'Call Details','Details about the call associated with the opportunity',NULL,NULL,NULL,0,'May 28 2004 10:25:49:880AM',0,'May 28 2004 10:25:49:880AM',1)
INSERT [help_contents] VALUES(108,4,3,'LeadsDocuments.do','Add',NULL,'Upload a document','New documents related to the opportunity can be uploaded into the system.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:880AM',0,'May 28 2004 10:25:49:880AM',1)
INSERT [help_contents] VALUES(109,4,3,'LeadsDocuments.do','Details',NULL,'Document Details','This shows all versions of the updated document. The name of the file with it''s size, version and the number of downloads are shown here.',NULL,NULL,NULL,0,'May 28 2004 10:25:49:980AM',0,'May 28 2004 10:25:49:980AM',1)
INSERT [help_contents] VALUES(110,4,3,'LeadsReports.do','ExportList',NULL,'List of exported data','The data present can be used to export data and display that in different formats. The exported data can be filtered in different ways. This would also let you view the data download it. This also shows the number of times an exported data has been downloaded',NULL,NULL,NULL,0,'May 28 2004 10:25:49:990AM',0,'May 28 2004 10:25:49:990AM',1)
INSERT [help_contents] VALUES(111,4,3,'LeadsReports.do','ExportForm',NULL,'Generating Export data','Generate an exported report from pipeline data',NULL,NULL,NULL,0,'May 28 2004 10:25:50:010AM',0,'May 28 2004 10:25:50:010AM',1)
INSERT [help_contents] VALUES(112,1,4,'Accounts.do','Dashboard',NULL,'Overview','The date range can be modified which is shown in the right hand window by clicking on a specific date on the calendar. Accounts with contract end dates or other required actions appear in the right hand window reminding the user to take action on them. The schedule, actions, alert dates and contract end dates are displayed for user or the employees under him by using the dropdown at the top of the page. Clicking on the alert link will let the user modify the details of the account owner.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:040AM',0,'May 28 2004 10:25:50:040AM',1)
INSERT [help_contents] VALUES(113,1,4,'Accounts.do','Add',NULL,'Add an Account','A new account can be added here',NULL,NULL,NULL,0,'May 28 2004 10:25:50:060AM',0,'May 28 2004 10:25:50:060AM',1)
INSERT [help_contents] VALUES(114,1,4,'Accounts.do','Modify',NULL,'Modify Account','The details of an account can be modified here',NULL,NULL,NULL,0,'May 28 2004 10:25:50:080AM',0,'May 28 2004 10:25:50:080AM',1)
INSERT [help_contents] VALUES(115,1,4,'Contacts.do','View',NULL,'Contact Details','A contact can be associated with an account. The lists of the contacts associated with the account are shown along with the title.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:100AM',0,'May 28 2004 10:25:50:100AM',1)
INSERT [help_contents] VALUES(116,1,4,'Accounts.do','Fields',NULL,'Folder Record Details','You create folders for accounts. Each folder can have one or more records associated with it, depending on the type of the folder. The details about records associated with the folder are shown',NULL,NULL,NULL,0,'May 28 2004 10:25:50:110AM',0,'May 28 2004 10:25:50:110AM',1)
INSERT [help_contents] VALUES(117,1,4,'Opportunities.do','View',NULL,'Opportunity Details','Opportunities associated with the contact, showing the best guess total and last modified date.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:120AM',0,'May 28 2004 10:25:50:120AM',1)
INSERT [help_contents] VALUES(118,1,4,'RevenueManager.do','View',NULL,'Revenue Details','The revenue associated with the account is shown here. The details about the revenue like the description, the date and the amount associated are displayed.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:150AM',0,'May 28 2004 10:25:50:150AM',1)
INSERT [help_contents] VALUES(119,1,4,'RevenueManager.do','View',NULL,'Revenue Details','The revenue associated with the account is shown here. Details about the revenue such as the description, the date, and the amount associated are displayed.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:160AM',0,'May 28 2004 10:25:50:160AM',1)
INSERT [help_contents] VALUES(120,1,4,'RevenueManager.do','Add',NULL,'Add Revenue','Adding new revenue to an account',NULL,NULL,NULL,0,'May 28 2004 10:25:50:260AM',0,'May 28 2004 10:25:50:260AM',1)
INSERT [help_contents] VALUES(121,1,4,'RevenueManager.do','Modify',NULL,'Modify Revenue','Here revenue details can be modified',NULL,NULL,NULL,0,'May 28 2004 10:25:50:280AM',0,'May 28 2004 10:25:50:280AM',1)
INSERT [help_contents] VALUES(122,1,4,'Accounts.do','ViewTickets',NULL,'Ticket Details','This page shows the complete list of the tickets related to an account, and lets you add a new ticket',NULL,NULL,NULL,0,'May 28 2004 10:25:50:280AM',0,'May 28 2004 10:25:50:280AM',1)
INSERT [help_contents] VALUES(123,1,4,'AccountsDocuments.do','View',NULL,'Document Details','Here the documents associated with the account are listed. New documents related to the account can be added.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:300AM',0,'May 28 2004 10:25:50:300AM',1)
INSERT [help_contents] VALUES(124,1,4,'Accounts.do','SearchForm',NULL,'Search Accounts','This page provides the search feature for accounts in the system.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:310AM',0,'May 28 2004 10:25:50:310AM',1)
INSERT [help_contents] VALUES(125,1,4,'Accounts.do','Details',NULL,'Account Details','This shows the details of the account, which can be modified. Each account can have folders, contacts, opportunities, revenue, tickets, and documents, for which there are separate tabs.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:320AM',0,'May 28 2004 10:25:50:320AM',1)
INSERT [help_contents] VALUES(126,1,4,'RevenueManager.do','Dashboard',NULL,'Revenue Dashboard','This revenue dashboard shows a progress chart for different years and types. All the accounts with revenue are also shown along with a list of employees working under you are also listed under the progress chart. You can add accounts, search for the existing ones in the system based on different filters and export the data in different formats.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:330AM',0,'May 28 2004 10:25:50:330AM',1)
INSERT [help_contents] VALUES(127,1,4,'Accounts.do','Reports',NULL,'Export Data','The data can be filtered, exported, displayed, and downloaded in different formats.You can also see the number of times an exported report has been downloaded.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:350AM',0,'May 28 2004 10:25:50:350AM',1)
INSERT [help_contents] VALUES(128,1,4,'Accounts.do','ModifyFields',NULL,'Modify folder record','The Folder record details can be updated.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:360AM',0,'May 28 2004 10:25:50:360AM',1)
INSERT [help_contents] VALUES(129,1,4,'AccountTickets.do','ReopenTicket',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:370AM',0,'May 28 2004 10:25:50:370AM',1)
INSERT [help_contents] VALUES(130,1,4,'Accounts.do','Delete',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:380AM',0,'May 28 2004 10:25:50:380AM',1)
INSERT [help_contents] VALUES(131,1,4,'Accounts.do','GenerateForm',NULL,'Generate New Export','To generate the Export data',NULL,NULL,NULL,0,'May 28 2004 10:25:50:430AM',0,'May 28 2004 10:25:50:430AM',1)
INSERT [help_contents] VALUES(132,1,4,'AccountContactsCalls.do','View',NULL,'Call Details','Calls associated with the contact',NULL,NULL,NULL,0,'May 28 2004 10:25:50:440AM',0,'May 28 2004 10:25:50:440AM',1)
INSERT [help_contents] VALUES(133,1,4,'Accounts.do','AddFolderRecord',NULL,'Add folder record','A new Folder record can be added to the Folder.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:450AM',0,'May 28 2004 10:25:50:450AM',1)
INSERT [help_contents] VALUES(134,1,4,'AccountContactsCalls.do','Add',NULL,'Add a call','You can add a new call, which is associated with a particular contact.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:460AM',0,'May 28 2004 10:25:50:460AM',1)
INSERT [help_contents] VALUES(135,1,4,'AccountsDocuments.do','Add',NULL,'Upload Document','New documents can be uploaded and associated with an account',NULL,NULL,NULL,0,'May 28 2004 10:25:50:470AM',0,'May 28 2004 10:25:50:470AM',1)
INSERT [help_contents] VALUES(136,1,4,'AccountsDocuments.do','Add',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:480AM',0,'May 28 2004 10:25:50:480AM',1)
INSERT [help_contents] VALUES(137,1,4,'AccountContactsOpps.do','UpdateOpp',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:490AM',0,'May 28 2004 10:25:50:490AM',1)
INSERT [help_contents] VALUES(138,1,4,'AccountTicketsDocuments.do','AddVersion',NULL,NULL,'Upload a New Version of an existing Document',NULL,NULL,NULL,0,'May 28 2004 10:25:50:490AM',0,'May 28 2004 10:25:50:490AM',1)
INSERT [help_contents] VALUES(139,1,4,'Accounts.do','Details',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:500AM',0,'May 28 2004 10:25:50:500AM',1)
INSERT [help_contents] VALUES(140,1,4,'Accounts.do','View',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:510AM',0,'May 28 2004 10:25:50:510AM',1)
INSERT [help_contents] VALUES(141,1,4,'AccountTickets.do','AddTicket',NULL,'Adding a new Ticket','This page lets you create a new ticket for the account',NULL,NULL,NULL,0,'May 28 2004 10:25:50:600AM',0,'May 28 2004 10:25:50:600AM',1)
INSERT [help_contents] VALUES(142,1,4,'AccountTicketsDocuments.do','View',NULL,'Document Details','Here the documents associated with the ticket are listed. New documents related to the ticket can be added',NULL,NULL,NULL,0,'May 28 2004 10:25:50:610AM',0,'May 28 2004 10:25:50:610AM',1)
INSERT [help_contents] VALUES(143,1,4,'AccountTickets.do','UpdateTicket',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:620AM',0,'May 28 2004 10:25:50:620AM',1)
INSERT [help_contents] VALUES(144,1,4,'AccountContactsOppComponents.do','Prepare',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:630AM',0,'May 28 2004 10:25:50:630AM',1)
INSERT [help_contents] VALUES(145,1,4,'Accounts.do','InsertFields',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:630AM',0,'May 28 2004 10:25:50:630AM',1)
INSERT [help_contents] VALUES(146,1,4,'AccountContactsOpps.do','Save',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:640AM',0,'May 28 2004 10:25:50:640AM',1)
INSERT [help_contents] VALUES(147,1,4,'Accounts.do','Search',NULL,NULL,'Lists the Accounts present and also lets you create an account',NULL,NULL,NULL,0,'May 28 2004 10:25:50:650AM',0,'May 28 2004 10:25:50:650AM',1)
INSERT [help_contents] VALUES(148,1,4,'AccountTicketsDocuments.do','Details',NULL,NULL,'Page shows all the versions of the current document',NULL,NULL,NULL,0,'May 28 2004 10:25:50:660AM',0,'May 28 2004 10:25:50:660AM',1)
INSERT [help_contents] VALUES(149,1,4,'AccountTicketsDocuments.do','Modify',NULL,NULL,'Modify the current document',NULL,NULL,NULL,0,'May 28 2004 10:25:50:670AM',0,'May 28 2004 10:25:50:670AM',1)
INSERT [help_contents] VALUES(150,1,4,'Accounts.do','Insert',NULL,'Account Details','Displays the details of the account, which can be modified. Each account can have folders, the contacts, opportunities, revenue, and tickets. You can update several documents associated with each account.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:680AM',0,'May 28 2004 10:25:50:680AM',1)
INSERT [help_contents] VALUES(151,1,4,'AccountContactsCalls.do','Details',NULL,'Call details','The details of the call are shown here which can be modified, deleted or forwarded to any of the users.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:690AM',0,'May 28 2004 10:25:50:690AM',1)
INSERT [help_contents] VALUES(152,1,4,'AccountContactsCalls.do','Modify',NULL,'Add / update a call','You can add a new call to a contact.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:700AM',0,'May 28 2004 10:25:50:700AM',1)
INSERT [help_contents] VALUES(153,1,4,'AccountContactsCalls.do','Save',NULL,'Call details','The details of the call are shown here, and can be modified, deleted or forwarded to any of the employees',NULL,NULL,NULL,0,'May 28 2004 10:25:50:710AM',0,'May 28 2004 10:25:50:710AM',1)
INSERT [help_contents] VALUES(154,1,4,'AccountContactsCalls.do','ForwardCall',NULL,'Forward Call','The details of the calls that are associated with a contact can be forwarded to different employees.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:720AM',0,'May 28 2004 10:25:50:720AM',1)
INSERT [help_contents] VALUES(155,1,4,'AccountContactsOpps.do','ViewOpps',NULL,'List of Opportunities','Opportunities associated with the contact, showing the best guess total and last modified date.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:730AM',0,'May 28 2004 10:25:50:730AM',1)
INSERT [help_contents] VALUES(156,1,4,'AccountContactsOpps.do','DetailsOpp',NULL,'Opportunity Details','You can view all the details about the components here and also add a new component to a particular opportunity. The opportunity can be renamed and its details can be modified',NULL,NULL,NULL,0,'May 28 2004 10:25:50:750AM',0,'May 28 2004 10:25:50:750AM',1)
INSERT [help_contents] VALUES(157,1,4,'AccountTickets.do','TicketDetails',NULL,'Ticket Details','This page lets you view the details of the ticket, and also lets you modify or delete the ticket.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:760AM',0,'May 28 2004 10:25:50:760AM',1)
INSERT [help_contents] VALUES(158,1,4,'AccountTickets.do','ModifyTicket',NULL,'Modify ticket','This page lets you modify the ticket information and update its details',NULL,NULL,NULL,0,'May 28 2004 10:25:50:770AM',0,'May 28 2004 10:25:50:770AM',1)
INSERT [help_contents] VALUES(159,1,4,'AccountTicketTasks.do','List',NULL,'Task Details','This page lists the tasks assigned for a particular account. New tasks can be added, which would then appear in the list of tasks, showing their priority and their assignment.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:780AM',0,'May 28 2004 10:25:50:780AM',1)
INSERT [help_contents] VALUES(160,1,4,'AccountTicketsDocuments.do','Add',NULL,'Uploading a Document','Upload a new document related to the account.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:880AM',0,'May 28 2004 10:25:50:880AM',1)
INSERT [help_contents] VALUES(161,1,4,'AccountTickets.do','ViewHistory',NULL,'Ticket Log History','This page maintains a complete log history of each ticket from its creation till the ticket is closed.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:890AM',0,'May 28 2004 10:25:50:890AM',1)
INSERT [help_contents] VALUES(162,1,4,'AccountsDocuments.do','Details',NULL,'Document Details','All the versions of the current document are listed here',NULL,NULL,NULL,0,'May 28 2004 10:25:50:890AM',0,'May 28 2004 10:25:50:890AM',1)
INSERT [help_contents] VALUES(163,1,4,'AccountsDocuments.do','Modify',NULL,'Modify Document','Modify the document information',NULL,NULL,NULL,0,'May 28 2004 10:25:50:900AM',0,'May 28 2004 10:25:50:900AM',1)
INSERT [help_contents] VALUES(164,1,4,'AccountsDocuments.do','AddVersion',NULL,'Upload New Version','Upload a new document version',NULL,NULL,NULL,0,'May 28 2004 10:25:50:910AM',0,'May 28 2004 10:25:50:910AM',1)
INSERT [help_contents] VALUES(165,1,4,'Accounts.do','ExportReport',NULL,'List of Exported data','The data can be filtered, exported and displayed in different formats. You can then view the data and also download it.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:920AM',0,'May 28 2004 10:25:50:920AM',1)
INSERT [help_contents] VALUES(166,1,4,'RevenueManager.do','Details',NULL,'Revenue Details','Details about revenue',NULL,NULL,NULL,0,'May 28 2004 10:25:50:940AM',0,'May 28 2004 10:25:50:940AM',1)
INSERT [help_contents] VALUES(167,1,4,'RevenueManager.do','Dashboard',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:50:950AM',0,'May 28 2004 10:25:50:950AM',1)
INSERT [help_contents] VALUES(168,1,4,'OpportunityForm.do','Prepare',NULL,'Add Opportunity','A new opportunity associated with the contact can be added',NULL,NULL,NULL,0,'May 28 2004 10:25:50:960AM',0,'May 28 2004 10:25:50:960AM',1)
INSERT [help_contents] VALUES(169,1,4,'Opportunities.do','Add',NULL,'Add opportunity','A new opportunity associated with the contact can be added',NULL,NULL,NULL,0,'May 28 2004 10:25:50:970AM',0,'May 28 2004 10:25:50:970AM',1)
INSERT [help_contents] VALUES(170,1,4,'Opportunities.do','Details',NULL,'Opportunity Details','You can view all the details about the components here like the status, the guess amount and the current stage. A new component can also be added to a particular opportunity.',NULL,NULL,NULL,0,'May 28 2004 10:25:50:990AM',0,'May 28 2004 10:25:50:990AM',1)
INSERT [help_contents] VALUES(171,1,4,'Opportunities.do','Modify',NULL,'Modify Opportunity','The details of the opportunity can be modified',NULL,NULL,NULL,0,'May 28 2004 10:25:51:000AM',0,'May 28 2004 10:25:51:000AM',1)
INSERT [help_contents] VALUES(172,1,4,'OpportunitiesComponents.do','DetailsComponent',NULL,'Component Details','This page shows the details about the opportunity like what is the probability of closing the opportunity, what is the current stage of the opportunity etc',NULL,NULL,NULL,0,'May 28 2004 10:25:51:010AM',0,'May 28 2004 10:25:51:010AM',1)
INSERT [help_contents] VALUES(173,1,4,'OpportunitiesComponents.do','Prepare',NULL,'Add a component','A component can be added to an opportunity and assigned to any employee present in the system. The component type can also be selected.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:070AM',0,'May 28 2004 10:25:51:070AM',1)
INSERT [help_contents] VALUES(174,1,4,'OpportunitiesComponents.do','ModifyComponent',NULL,'Modify Component','The details of the component can be added / updated to an opportunity and assigned to any employee present in the system. The component type can also be selected.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:200AM',0,'May 28 2004 10:25:51:200AM',1)
INSERT [help_contents] VALUES(175,1,4,'OpportunitiesComponents.do','SaveComponent',NULL,'Component Details','This page shows the details about the opportunity like what is the probability of closing the opportunity, what is the current stage of the opportunity etc',NULL,NULL,NULL,0,'May 28 2004 10:25:51:310AM',0,'May 28 2004 10:25:51:310AM',1)
INSERT [help_contents] VALUES(176,1,4,'AccountsServiceContracts.do','Add',NULL,'Add Contract','This page allows you to add a service contract to the account. 

A service contract describes the terms and conditions in a contract including the start and end dates, the contract value, the number of hours, service models and other details.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:320AM',0,'May 28 2004 10:25:51:320AM',1)
INSERT [help_contents] VALUES(177,1,4,'AccountsServiceContracts.do','Modify',NULL,'Modify Contract','This page allows your to modify contract information.

A service contract describes the terms and conditions in a contract including the start and end dates, the contract value, the number of hours, service models and other details.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:350AM',0,'May 28 2004 10:25:51:350AM',1)
INSERT [help_contents] VALUES(178,1,4,'AccountsServiceContracts.do','List',NULL,'Contracts','This page lists all the service contracts associated with the account. Based on your permissions you would be able to add new service contracts and modify exting ones from this page.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:450AM',0,'May 28 2004 10:25:51:450AM',1)
INSERT [help_contents] VALUES(179,1,4,'AccountsServiceContracts.do','View',NULL,'Service Contract Details','This page displays the information of a service contract. The information is divided into general information, block hour information and service model options',NULL,NULL,NULL,0,'May 28 2004 10:25:51:450AM',0,'May 28 2004 10:25:51:450AM',1)
INSERT [help_contents] VALUES(180,1,4,'AccountsAssets.do','List',NULL,'Assets','This page displays assets associated with the service contract of the account. Based on your permissions you would be able to add new assets or modify existing ones from this page.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:460AM',0,'May 28 2004 10:25:51:460AM',1)
INSERT [help_contents] VALUES(181,1,4,'AccountsAssets.do','Add',NULL,'Add Asset','This page allows you to add an asset to the account and associate it with a service contract',NULL,NULL,NULL,0,'May 28 2004 10:25:51:470AM',0,'May 28 2004 10:25:51:470AM',1)
INSERT [help_contents] VALUES(182,1,4,'AccountsAssets.do','View',NULL,'Asset Details','This page allows you to view asset details associated with a service contract  of the account.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:500AM',0,'May 28 2004 10:25:51:500AM',1)
INSERT [help_contents] VALUES(183,1,4,'AccountsAssets.do','Modify',NULL,'Modify Asset','This page allows you to modify an asset  associated it with a service contract of this account.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:530AM',0,'May 28 2004 10:25:51:530AM',1)
INSERT [help_contents] VALUES(184,1,4,'AccountsAssets.do','History',NULL,'Asset History','The page displays the maintenance history of the asset.  This history for the asset is generated when the help desk department initiates a maintenance for this asset. The asset is maintained based on the service model options specified for the asset.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:540AM',0,'May 28 2004 10:25:51:540AM',1)
INSERT [help_contents] VALUES(185,1,4,'Contacts.do','Prepare',NULL,'Add Account Contact','This page allows you to add an account contact and to permit the account to use the CRM application as a portal user',NULL,NULL,NULL,0,'May 28 2004 10:25:51:540AM',0,'May 28 2004 10:25:51:540AM',1)
INSERT [help_contents] VALUES(186,1,4,'Contacts.do','Modify',NULL,'Modify contact','The details of an account contact can be modified or updated here.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:570AM',0,'May 28 2004 10:25:51:570AM',1)
INSERT [help_contents] VALUES(187,1,4,'ContactsPortal.do','View',NULL,'Contact Portal','This page displays the portal information (username, expiration date) of this account contact.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:580AM',0,'May 28 2004 10:25:51:580AM',1)
INSERT [help_contents] VALUES(188,1,4,'ContactsPortal.do','Modify',NULL,'Modify Contact Portal','This page allows you to modify the portal information of the account contact.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:590AM',0,'May 28 2004 10:25:51:590AM',1)
INSERT [help_contents] VALUES(189,1,4,'ContactsPortal.do','Add',NULL,'Add Contact Portal','This page allows you to allow the account contact access to this appication as a portal user. A portal user is allowed to see account information only for the account to which he is listed as a contact.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:610AM',0,'May 28 2004 10:25:51:610AM',1)
INSERT [help_contents] VALUES(190,6,5,'CampaignManager.do','Dashboard',NULL,'Communications Dashboard','Track and analyze campaigns that have been activated and executed.

Messages can be sent out by any combination of email, fax, or mail merge. The Dashboard shows an overview of sent messages and allows you to drill down and view recipients and any survey results.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:630AM',0,'May 28 2004 10:25:51:630AM',1)
INSERT [help_contents] VALUES(191,6,5,'CampaignManager.do','Add',NULL,'Add a campaign','This page lets you add a new campaign into the system.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:640AM',0,'May 28 2004 10:25:51:640AM',1)
INSERT [help_contents] VALUES(192,6,5,'CampaignManager.do','View',NULL,'Campaign List','Create or work on existing campaigns.

The Campaign Builder allows you to select groups of contacts that you would like to send a message to, as well as schedule a delivery date. Additional options are available.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:650AM',0,'May 28 2004 10:25:51:650AM',1)
INSERT [help_contents] VALUES(193,6,5,'CampaignManagerGroup.do','View',NULL,'View Groups','Each campaign needs at least one group to which to send a message. Use criteria to filter the contacts you need to reach and use them over and over again. As new contacts meet the criteria, they will be automatically included in future campaigns. This page lists the group names. It shows the groups created by you or everybody; i.e. all the groups.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:760AM',0,'May 28 2004 10:25:51:760AM',1)
INSERT [help_contents] VALUES(194,6,5,'CampaignManagerGroup.do','Add',NULL,'Add a Group','A new contact group can be added. Separate criteria can be specified when creating the group. The criteria can be defined to generate a list. The list to be added can be previewed before saving the group details.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:770AM',0,'May 28 2004 10:25:51:770AM',1)
INSERT [help_contents] VALUES(195,6,5,'CampaignManagerMessage.do','View',NULL,'Message List','Compose a message to reach your audience.
Each campaign requires a message that will be sent to selected groups. Write the message once, then use it in any number of future campaigns. Modified messages will only affect future campaigns. Displays the list of messages, with the description and other details.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:790AM',0,'May 28 2004 10:25:51:790AM',1)
INSERT [help_contents] VALUES(196,6,5,'CampaignManagerMessage.do','Add',NULL,'Adding a Message','You can add a new message for the campaign, which would show up in the message list.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:800AM',0,'May 28 2004 10:25:51:800AM',1)
INSERT [help_contents] VALUES(197,6,5,'CampaignManagerAttachment.do',NULL,NULL,'Create Attachments','Customize and configure your Campaigns with attachments. Attachments can include interactive items, like surveys, or provide additional materials like files.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:820AM',0,'May 28 2004 10:25:51:820AM',1)
INSERT [help_contents] VALUES(198,6,5,'CampaignManagerGroup.do','Details',NULL,NULL,'Contacts of the group are displayed',NULL,NULL,NULL,0,'May 28 2004 10:25:51:820AM',0,'May 28 2004 10:25:51:820AM',1)
INSERT [help_contents] VALUES(199,6,5,'CampaignDocuments.do','AddVersion',NULL,NULL,'version change of a document',NULL,NULL,NULL,0,'May 28 2004 10:25:51:840AM',0,'May 28 2004 10:25:51:840AM',1)
INSERT [help_contents] VALUES(200,6,5,'CampaignManager.do','Dashboard',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:51:850AM',0,'May 28 2004 10:25:51:850AM',1)
INSERT [help_contents] VALUES(201,6,5,'CampaignManagerMessage.do','Insert',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:51:850AM',0,'May 28 2004 10:25:51:850AM',1)
INSERT [help_contents] VALUES(202,6,5,'CampaignManagerGroup.do','Update',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:51:860AM',0,'May 28 2004 10:25:51:860AM',1)
INSERT [help_contents] VALUES(203,6,5,'CampaignDocuments.do','Add',NULL,NULL,'New documents can be uploaded and be associated with the campaign.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:860AM',0,'May 28 2004 10:25:51:860AM',1)
INSERT [help_contents] VALUES(204,6,5,'CampaignManager.do','ResponseDetails',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:51:970AM',0,'May 28 2004 10:25:51:970AM',1)
INSERT [help_contents] VALUES(205,6,5,'CampaignManagerGroup.do','Preview',NULL,NULL,'Here details about the contacts, i.e. the name, their company, and their email address are displayed.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:970AM',0,'May 28 2004 10:25:51:970AM',1)
INSERT [help_contents] VALUES(206,6,5,'CampaignManager.do','PrepareDownload',NULL,'Campaign Details','This page shows the details about the campaign and also shows the list of available documents.',NULL,NULL,NULL,0,'May 28 2004 10:25:51:990AM',0,'May 28 2004 10:25:51:990AM',1)
INSERT [help_contents] VALUES(207,6,5,'CampaignManager.do','ViewGroups',NULL,'Groups','The group name along with the contacts present in the Group are listed',NULL,NULL,NULL,0,'May 28 2004 10:25:51:990AM',0,'May 28 2004 10:25:51:990AM',1)
INSERT [help_contents] VALUES(208,6,5,'CampaignManagerSurvey.do','Add',NULL,'Adding a survey','You can add a new survey here',NULL,NULL,NULL,0,'May 28 2004 10:25:52:000AM',0,'May 28 2004 10:25:52:000AM',1)
INSERT [help_contents] VALUES(209,6,5,'CampaignManagerSurvey.do','MoveQuestion',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:010AM',0,'May 28 2004 10:25:52:010AM',1)
INSERT [help_contents] VALUES(210,6,5,'CampaignManager.do','Details',NULL,'Campaign Details','Campaign details are the number of groups selected for the campaign, the text message of the campaign, when is it scheduled to run, how the delivery of the message done, who entered these details and who modified it are shown here.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:020AM',0,'May 28 2004 10:25:52:020AM',1)
INSERT [help_contents] VALUES(211,6,5,'CampaignDocuments.do','Details',NULL,NULL,'All Versions of this current Document are shown here with the details like the size of the uploaded file, the number of downloads etc.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:020AM',0,'May 28 2004 10:25:52:020AM',1)
INSERT [help_contents] VALUES(212,6,5,'CampaignDocuments.do','Modify',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:030AM',0,'May 28 2004 10:25:52:030AM',1)
INSERT [help_contents] VALUES(213,6,5,'CampaignManager.do','Insert',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:130AM',0,'May 28 2004 10:25:52:130AM',1)
INSERT [help_contents] VALUES(214,6,5,'CampaignManagerSurvey.do','ViewReturn',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:130AM',0,'May 28 2004 10:25:52:130AM',1)
INSERT [help_contents] VALUES(215,6,5,'CampaignManagerMessage.do','Details',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:140AM',0,'May 28 2004 10:25:52:140AM',1)
INSERT [help_contents] VALUES(216,6,5,'CampaignManager.do','ViewSchedule',NULL,NULL,'For the campaign you can schedule a delivery date to send the message to the recipients.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:150AM',0,'May 28 2004 10:25:52:150AM',1)
INSERT [help_contents] VALUES(217,6,5,'CampaignManagerGroup.do','Modify',NULL,NULL,'Here you can update the group details and also the update contact criteria.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:150AM',0,'May 28 2004 10:25:52:150AM',1)
INSERT [help_contents] VALUES(218,6,5,'CampaignManager.do','PreviewRecipients',NULL,'List of Recipients','The page displays a list of recipients with their name, company name, the date when the campaign was sent to those recipients and its status.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:170AM',0,'May 28 2004 10:25:52:170AM',1)
INSERT [help_contents] VALUES(219,6,5,'CampaignManager.do','PreviewMessage',NULL,'Message Details','The message details are shown here, in the form of an email with a subject and message.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:180AM',0,'May 28 2004 10:25:52:180AM',1)
INSERT [help_contents] VALUES(220,6,5,'CampaignManager.do','PreviewSchedule',NULL,'Campaign Schedule','This shows the delivery date and the delivery method or the campaign.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:180AM',0,'May 28 2004 10:25:52:180AM',1)
INSERT [help_contents] VALUES(221,6,5,'CampaignManager.do','ViewResults',NULL,'Campaign Results','This page shows the results of the responses received from all the recipients in the group. This also shows the Last response received.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:190AM',0,'May 28 2004 10:25:52:190AM',1)
INSERT [help_contents] VALUES(222,6,5,'CampaignManager.do','ViewResponse',NULL,'Campaign Response','This page shows the responses of all the recipients along with their system IP addresses and their email address',NULL,NULL,NULL,0,'May 28 2004 10:25:52:200AM',0,'May 28 2004 10:25:52:200AM',1)
INSERT [help_contents] VALUES(223,6,5,'CampaignDocuments.do','View',NULL,'Campaign Document details','This page lists all the documents associated with this campaign and for each document it lists the size of the file, the extension and the version of the file.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:200AM',0,'May 28 2004 10:25:52:200AM',1)
INSERT [help_contents] VALUES(224,6,5,'CampaignManager.do','ViewDetails',NULL,'Campaign Details','This is the detail page for the campaign, where step-by-step information is given on how to activate the campaign; i.e. what should be selected before a campaign is activated.

This campaign can be configured and can now be activated.
Once activated, today''s campaigns will begin processing in under 5 minutes and cannot be cancelled.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:220AM',0,'May 28 2004 10:25:52:220AM',1)
INSERT [help_contents] VALUES(225,6,5,'CampaignManager.do','AddGroups',NULL,'Choose Groups','Selecting or updating the group / groups for the campaign can be done here.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:230AM',0,'May 28 2004 10:25:52:230AM',1)
INSERT [help_contents] VALUES(226,6,5,'CampaignManager.do','ViewMessage',NULL,'Message Details','Updating a message for the campaign',NULL,NULL,NULL,0,'May 28 2004 10:25:52:240AM',0,'May 28 2004 10:25:52:240AM',1)
INSERT [help_contents] VALUES(227,6,5,'CampaignManager.do','ViewAttachmentsOverview',NULL,'Attachment Details','For each message, we can add the attachments.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:250AM',0,'May 28 2004 10:25:52:250AM',1)
INSERT [help_contents] VALUES(228,6,5,'CampaignManager.do','ViewAttachment',NULL,'Surveys','A survey can be selected for this campaign.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:260AM',0,'May 28 2004 10:25:52:260AM',1)
INSERT [help_contents] VALUES(229,6,5,'CampaignManager.do','ManageFileAttachments',NULL,'File Attachments','Campaign can also have a file as an attachment',NULL,NULL,NULL,0,'May 28 2004 10:25:52:270AM',0,'May 28 2004 10:25:52:270AM',1)
INSERT [help_contents] VALUES(230,6,5,'CampaignManager.do','Modify',NULL,'Modify Campaign Details','Updating the campaign name /description',NULL,NULL,NULL,0,'May 28 2004 10:25:52:280AM',0,'May 28 2004 10:25:52:280AM',1)
INSERT [help_contents] VALUES(231,6,5,'CampaignManagerMessage.do','Details',NULL,'Message Details','This page shows the details of the message.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:290AM',0,'May 28 2004 10:25:52:290AM',1)
INSERT [help_contents] VALUES(232,6,5,'CampaignManagerMessage.do','Modify',NULL,'Modify Message','This page lets you Add/Update a new message. The message can have an access type, limiting who can view a message.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:300AM',0,'May 28 2004 10:25:52:300AM',1)
INSERT [help_contents] VALUES(233,6,5,'CampaignManagerMessage.do','Update',NULL,'Message Details','This page shows the details of the message.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:310AM',0,'May 28 2004 10:25:52:310AM',1)
INSERT [help_contents] VALUES(234,6,5,'CampaignManagerMessage.do','Clone',NULL,'Adding a Message','This page lets you Add a new message or Update an existing one. The message can have an access type, defining who can view it.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:320AM',0,'May 28 2004 10:25:52:320AM',1)
INSERT [help_contents] VALUES(235,6,5,'CampaignManagerSurvey.do','View',NULL,'List of Surveys','This page displays the surveys created and lets you update them.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:420AM',0,'May 28 2004 10:25:52:420AM',1)
INSERT [help_contents] VALUES(236,6,5,'CampaignManagerSurvey.do','InsertAndAdd',NULL,'Survey Questions','Here you can add a new survey question. If the question type is "Item List", you can edit the list of items present in that list and also mark whether the particular question is required or not.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:430AM',0,'May 28 2004 10:25:52:430AM',1)
INSERT [help_contents] VALUES(237,6,5,'CampaignManagerSurvey.do','Details',NULL,'Survey Details','The details about the survey are displayed here along with the option to modify, delete and preview the survey.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:443AM',0,'May 28 2004 10:25:52:443AM',1)
INSERT [help_contents] VALUES(238,6,5,'CampaignManagerSurvey.do','Modify',NULL,'Survey Details','This page displays all the questions added to a particular survey. It also enables you to add new questions. The order of the questions can be changed by moving questions up or down in the list. Questions can also be edited or deleted.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:463AM',0,'May 28 2004 10:25:52:463AM',1)
INSERT [help_contents] VALUES(239,6,5,'CampaignManager.do',NULL,NULL,'Overview','You are looking at the communications module. This page reviews and manages campaigns with the following options: Dashboard, Campaign Builder, Build groups, Create messages and create attachments.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:483AM',0,'May 28 2004 10:25:52:483AM',1)
INSERT [help_contents] VALUES(240,8,6,'TroubleTickets.do','Details',NULL,'Ticket Details','This page lets you view the details of the ticket also lets you modify or delete the ticket.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:513AM',0,'May 28 2004 10:25:52:513AM',1)
INSERT [help_contents] VALUES(241,8,6,'TroubleTickets.do','Add',NULL,'Add a Ticket','You can add a new ticket here',NULL,NULL,NULL,0,'May 28 2004 10:25:52:523AM',0,'May 28 2004 10:25:52:523AM',1)
INSERT [help_contents] VALUES(242,8,6,'TroubleTickets.do','SearchTicketsForm',NULL,'Search Existing Tickets','Form used for searching existing tickets based on different filters and parameters.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:533AM',0,'May 28 2004 10:25:52:533AM',1)
INSERT [help_contents] VALUES(243,8,6,'TroubleTickets.do','Reports',NULL,'Export Data','This is the page shows exported data.
The data can be exported in different formats. The exported data can be viewed with its subject, the size of the exported data file, when it was created and by whom. It also shows the number of times that particular exported file was downloaded. A new data file can also be exported.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:543AM',0,'May 28 2004 10:25:52:543AM',1)
INSERT [help_contents] VALUES(244,8,6,'TroubleTickets.do','Modify',NULL,'Modify Ticket Details','Here you can modify ticket details like information, classification, assignment and resolution.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:563AM',0,'May 28 2004 10:25:52:563AM',1)
INSERT [help_contents] VALUES(245,8,6,'TroubleTickets.do','Modify',NULL,'Modify Ticket Details','Here you can modify the ticket details like ticket information, it''s classification, the ticket?s assignment and it''s resolution.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:563AM',0,'May 28 2004 10:25:52:563AM',1)
INSERT [help_contents] VALUES(246,8,6,'TroubleTicketTasks.do','List',NULL,'List of Tasks','This page lists the tasks assigned for a particular ticket. New tasks can be added, which would then appear in the list of tasks, showing their priority, their assignment and other details.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:573AM',0,'May 28 2004 10:25:52:573AM',1)
INSERT [help_contents] VALUES(247,8,6,'TroubleTicketsDocuments.do','View',NULL,'List of Documents','Here the documents associated with a ticket are listed. New documents related to the ticket can be added.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:583AM',0,'May 28 2004 10:25:52:583AM',1)
INSERT [help_contents] VALUES(248,8,6,'TroubleTicketsFolders.do','Fields',NULL,'List of Folder Records','New folders can be created for each ticket. New Folders are defined and configured in the Admin Module. This page also displays a list of records with their details such as when the record was created, last modified, the action performed on the record etc.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:733AM',0,'May 28 2004 10:25:52:733AM',1)
INSERT [help_contents] VALUES(249,8,6,'TroubleTicketsFolders.do','AddFolderRecord',NULL,'Add Folder Record','The details of the record are added',NULL,NULL,NULL,0,'May 28 2004 10:25:52:743AM',0,'May 28 2004 10:25:52:743AM',1)
INSERT [help_contents] VALUES(250,8,6,'TroubleTickets.do','ViewHistory',NULL,'Ticket Log History','The log history of the ticket is maintained.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:743AM',0,'May 28 2004 10:25:52:743AM',1)
INSERT [help_contents] VALUES(251,8,6,'TroubleTickets.do',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:753AM',0,'May 28 2004 10:25:52:753AM',1)
INSERT [help_contents] VALUES(252,8,6,'TroubleTickets.do','Insert',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:763AM',0,'May 28 2004 10:25:52:763AM',1)
INSERT [help_contents] VALUES(253,8,6,'TroubleTicketsFolders.do','InsertFields',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:763AM',0,'May 28 2004 10:25:52:763AM',1)
INSERT [help_contents] VALUES(254,8,6,'TroubleTickets.do','GenerateForm',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:773AM',0,'May 28 2004 10:25:52:773AM',1)
INSERT [help_contents] VALUES(255,8,6,'TroubleTickets.do','Details',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:783AM',0,'May 28 2004 10:25:52:783AM',1)
INSERT [help_contents] VALUES(256,8,6,'TroubleTickets.do','Update',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:793AM',0,'May 28 2004 10:25:52:793AM',1)
INSERT [help_contents] VALUES(257,8,6,'TroubleTickets.do','ExportReport',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:793AM',0,'May 28 2004 10:25:52:793AM',1)
INSERT [help_contents] VALUES(258,8,6,'TroubleTicketsFolders.do','ModifyFields',NULL,'Modify Folder Record','This lists the details of the folder record, which can be modified.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:803AM',0,'May 28 2004 10:25:52:803AM',1)
INSERT [help_contents] VALUES(259,8,6,'TroubleTicketsFolders.do','UpdateFields',NULL,'Folder Record Details','The details about the folder along with the record information such as when the record was created and when it was modified is displayed here.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:813AM',0,'May 28 2004 10:25:52:813AM',1)
INSERT [help_contents] VALUES(260,8,6,'TroubleTickets.do','SearchTickets',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:823AM',0,'May 28 2004 10:25:52:823AM',1)
INSERT [help_contents] VALUES(261,8,6,'TroubleTickets.do','Home',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:52:823AM',0,'May 28 2004 10:25:52:823AM',1)
INSERT [help_contents] VALUES(262,8,6,'TroubleTicketsDocuments.do','Add',NULL,'Adding a Document','A new document related to a ticket can be uploaded.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:833AM',0,'May 28 2004 10:25:52:833AM',1)
INSERT [help_contents] VALUES(263,8,6,'TroubleTicketsDocuments.do','Details',NULL,'Document Details','This page shows all the versions of the current document.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:843AM',0,'May 28 2004 10:25:52:843AM',1)
INSERT [help_contents] VALUES(264,8,6,'TroubleTicketsDocuments.do','Modify',NULL,'Modify Document Details','This page lets you modify the ticket information and update the details.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:853AM',0,'May 28 2004 10:25:52:853AM',1)
INSERT [help_contents] VALUES(265,8,6,'TroubleTicketsDocuments.do','AddVersion',NULL,'Add version number to Documents','You can upload a new version of an existing document.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:863AM',0,'May 28 2004 10:25:52:863AM',1)
INSERT [help_contents] VALUES(266,8,6,'TroubleTickets.do','Home',NULL,'Overview','This page displays the complete list of the tickets assigned to the user, the list of the tickets present in his department and finally the list of the tickets created by the user. For each ticket, the details about the ticket, such as the ticket number, priority, age of the ticket, the company and finally the assignment details are displayed. The issue details are also shown separately for each ticket.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:873AM',0,'May 28 2004 10:25:52:873AM',1)
INSERT [help_contents] VALUES(267,8,6,'TroubleTicketActivityLog.do','List',NULL,'Activity Log','This page lists the services (activities performed) rendered to a client after a ticket has been created.  Each Activity Log is usually a sequence of descriptions of the work done during the business days of the week. To resolve the issues listed in a ticket,  multiple activity logs (usually one for each business week) may be required.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:903AM',0,'May 28 2004 10:25:52:903AM',1)
INSERT [help_contents] VALUES(268,8,6,'TroubleTicketActivityLog.do','Add',NULL,'Add Activity Log','This page allows you to describe the activity performed on each day in order to resolve the issue specified in the ticket.',NULL,NULL,NULL,0,'May 28 2004 10:25:52:913AM',0,'May 28 2004 10:25:52:913AM',1)
INSERT [help_contents] VALUES(269,8,6,'TroubleTicketActivityLog.do','View',NULL,'Activity Log Details','This page displays activities performed on each day in order to resolve the issue specified in the ticket. It also displays follow up information if they are recorded during creation or modification of the activity log.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:043AM',0,'May 28 2004 10:25:53:043AM',1)
INSERT [help_contents] VALUES(270,8,6,'TroubleTicketActivityLog.do','Modify',NULL,'Modify Activity Log','This page allows you to edit the activities performed on each day in order to resolve the issue specified in the ticket.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:053AM',0,'May 28 2004 10:25:53:053AM',1)
INSERT [help_contents] VALUES(271,8,6,'TroubleTicketMaintenanceNotes.do','List',NULL,'Maintenance Notes','This page displays a list of maintenance notes performed on an asset.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:083AM',0,'May 28 2004 10:25:53:083AM',1)
INSERT [help_contents] VALUES(272,8,6,'TroubleTicketMaintenanceNotes.do','Add',NULL,'Add Maintenance Note','This page allows you to create a maintenance note.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:093AM',0,'May 28 2004 10:25:53:093AM',1)
INSERT [help_contents] VALUES(273,8,6,'TroubleTicketMaintenanceNotes.do','Modify',NULL,'Modify Maintenance Note','This page allows you to modify a maintenance note.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:103AM',0,'May 28 2004 10:25:53:103AM',1)
INSERT [help_contents] VALUES(274,21,7,'CompanyDirectory.do','ListEmployees',NULL,'Overview','The details of each employee can be viewed, modified or deleted and a new detailed employee record can be added.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:223AM',0,'May 28 2004 10:25:53:223AM',1)
INSERT [help_contents] VALUES(275,21,7,'CompanyDirectory.do','EmployeeDetails',NULL,'Employee Details','This is the employee detail page. This page displays the email, phone number, addresses and additional details of each employee.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:233AM',0,'May 28 2004 10:25:53:233AM',1)
INSERT [help_contents] VALUES(276,21,7,'CompanyDirectory.do','Prepare',NULL,'Add an Employee','You can add an employee into the system. The details of the employee such as his email address; phone numbers, address and other additional details can be given along with his name',NULL,NULL,NULL,0,'May 28 2004 10:25:53:243AM',0,'May 28 2004 10:25:53:243AM',1)
INSERT [help_contents] VALUES(277,21,7,'CompanyDirectory.do','ModifyEmployee',NULL,'Modify Employee Details','Employee details such as the name of the employee, email address, phone numbers and address can be modified here.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:253AM',0,'May 28 2004 10:25:53:253AM',1)
INSERT [help_contents] VALUES(278,21,7,'CompanyDirectory.do','Save',NULL,NULL,'This page shows the details of the employee record, which can be modified or deleted.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:263AM',0,'May 28 2004 10:25:53:263AM',1)
INSERT [help_contents] VALUES(279,14,8,'Reports.do','ViewQueue',NULL,'Overview','This is the home of the reports. 

A list of customized reports can be viewed and the queue of the reports that are scheduled to be processed by the server are also displayed. Each report that is ready to be retrieved is displayed along with its details such as the subject of the report, the date when the report was generated, report status and finally the size of the report for the user to download.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:283AM',0,'May 28 2004 10:25:53:283AM',1)
INSERT [help_contents] VALUES(280,14,8,'Reports.do','RunReport',NULL,'List of Modules','This shows the different modules present and displays the list of corresponding reports present in each module.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:293AM',0,'May 28 2004 10:25:53:293AM',1)
INSERT [help_contents] VALUES(281,14,8,'Reports.do',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:303AM',0,'May 28 2004 10:25:53:303AM',1)
INSERT [help_contents] VALUES(282,14,8,'Reports.do','CancelReport',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:303AM',0,'May 28 2004 10:25:53:303AM',1)
INSERT [help_contents] VALUES(283,14,8,'Reports.do','ParameterList',NULL,'Parameters specification','This page takes the parameters that need to be specified to run the report.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:313AM',0,'May 28 2004 10:25:53:313AM',1)
INSERT [help_contents] VALUES(284,14,8,'Reports.do','ListReports',NULL,'Lis of Reports','In this module, you can choose the report that you want to run from the list of the reports.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:413AM',0,'May 28 2004 10:25:53:413AM',1)
INSERT [help_contents] VALUES(285,14,8,'Reports.do','CriteriaList',NULL,'Criteria List','You can choose to base this report on previously saved criteria, or continue and create new criteria.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:413AM',0,'May 28 2004 10:25:53:413AM',1)
INSERT [help_contents] VALUES(286,14,8,'Reports.do','GenerateReport',NULL,'Reports Added To Queue','This page shows that the requested report is added to the queue. Also lets you know the details about the report and queue status.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:423AM',0,'May 28 2004 10:25:53:423AM',1)
INSERT [help_contents] VALUES(287,14,8,'Reports.do',NULL,NULL,'Overview',NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:433AM',0,'May 28 2004 10:25:53:433AM',1)
INSERT [help_contents] VALUES(288,9,9,'Users.do','ListUsers',NULL,'List of Users','This section allows the administrator to view and add users and manage user hierarchies. The users are typically employees in your company who interact with your clients or customers.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:453AM',0,'May 28 2004 10:25:53:453AM',1)
INSERT [help_contents] VALUES(289,9,9,'Users.do','InsertUserForm',NULL,'Adding a New User','This form allows new users to be added to the system and records their contact information.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:483AM',0,'May 28 2004 10:25:53:483AM',1)
INSERT [help_contents] VALUES(290,9,9,'Users.do','ModifyUser',NULL,'Modify User Details','This form provides the administrator with an editable view of the user information, and also allows the administrator to view the users login history and view points.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:503AM',0,'May 28 2004 10:25:53:503AM',1)
INSERT [help_contents] VALUES(291,9,9,'Users.do','ViewLog',NULL,'User Login History','Provides a login history of the chosen user.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:513AM',0,'May 28 2004 10:25:53:513AM',1)
INSERT [help_contents] VALUES(292,9,9,'Viewpoints.do','ListViewpoints',NULL,'Viewpoints of User','The page displays the viewpoints of the employees regarding a particular module in the system. Lets you add a new viewpoint. The details displayed are when the viewpoint was entered and whether it is enabled or not.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:533AM',0,'May 28 2004 10:25:53:533AM',1)
INSERT [help_contents] VALUES(293,9,9,'Viewpoints.do','InsertViewpointForm',NULL,'Add Viewpoint','The contact name can be selected and the permissions /access for the modules can be given.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:553AM',0,'May 28 2004 10:25:53:553AM',1)
INSERT [help_contents] VALUES(294,9,9,'Viewpoints.do','ViewpointDetails',NULL,'Update Viewpoint','You can update a viewpoint and set the permissions to access different modules.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:563AM',0,'May 28 2004 10:25:53:563AM',1)
INSERT [help_contents] VALUES(295,9,9,'Roles.do','ListRoles',NULL,'List of Roles','You are looking at roles. 

This page lists the different roles present in the system, their role descriptions and the number of people present in the system who are assigned that role. New roles can be added at any time.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:583AM',0,'May 28 2004 10:25:53:583AM',1)
INSERT [help_contents] VALUES(296,9,9,'Roles.do','InsertRoleForm',NULL,'Add a New Role','This page will let you Add/Update the roles in the system. Also lets you change the permissions. The permissions can be changed or set for each module separately depending on the role.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:593AM',0,'May 28 2004 10:25:53:593AM',1)
INSERT [help_contents] VALUES(297,9,9,'Roles.do','RoleDetails',NULL,'Update Role','This page will let you update the roles in the system. Also lets you change the permissions. The permissions can be changed or set for each module separately depending on the role.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:603AM',0,'May 28 2004 10:25:53:603AM',1)
INSERT [help_contents] VALUES(298,9,9,'Admin.do','Config',NULL,'Configure Modules','This page lets you configure modules that meet the needs of your organization, including configuration of lookup lists and custom fields. Depending on permissions, each module that you can configure is listed and each module has a different number of configure options. The changes typically affect all users immediately.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:693AM',0,'May 28 2004 10:25:53:693AM',1)
INSERT [help_contents] VALUES(299,9,9,'Admin.do','ConfigDetails',NULL,'Configuration Options','You can configure different options in each module.The following are some of the configuration options that you might see in the modules. Some of these options are specific to the module so they might NOT be present in all the modules.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:703AM',0,'May 28 2004 10:25:53:703AM',1)
INSERT [help_contents] VALUES(300,9,9,'Admin.do','ModifyList',NULL,'Edit Lookup List','This page lets you edit and add to the list items.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:723AM',0,'May 28 2004 10:25:53:723AM',1)
INSERT [help_contents] VALUES(301,9,9,'AdminFieldsFolder.do','AddFolder',NULL,'Adding a New Folder','Add/Update the existing folder here',NULL,NULL,NULL,0,'May 28 2004 10:25:53:733AM',0,'May 28 2004 10:25:53:733AM',1)
INSERT [help_contents] VALUES(302,9,9,'AdminFieldsFolder.do','ModifyFolder',NULL,'Modify Existing Folder','Update the existing folder here',NULL,NULL,NULL,0,'May 28 2004 10:25:53:743AM',0,'May 28 2004 10:25:53:743AM',1)
INSERT [help_contents] VALUES(303,9,9,'AdminConfig.do','ListGlobalParams',NULL,'Configure System','You can configure the system for the session idle timeout and set the time for the time out.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:753AM',0,'May 28 2004 10:25:53:753AM',1)
INSERT [help_contents] VALUES(304,9,9,'AdminConfig.do','ModifyTimeout',NULL,'Modify Timeout','The session timeout is the time in which a user will automatically be logged out if the specified period of inactivity is reached.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:753AM',0,'May 28 2004 10:25:53:753AM',1)
INSERT [help_contents] VALUES(305,9,9,'Admin.do','Usage',NULL,'Resource Usage Details','Current System Usage and Billing Usage Information are displayed.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:763AM',0,'May 28 2004 10:25:53:763AM',1)
INSERT [help_contents] VALUES(306,9,9,'Admin.do',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:773AM',0,'May 28 2004 10:25:53:773AM',1)
INSERT [help_contents] VALUES(307,9,9,'Users.do','DisableUserConfirm',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:783AM',0,'May 28 2004 10:25:53:783AM',1)
INSERT [help_contents] VALUES(308,9,9,'AdminFieldsFolder.do',NULL,NULL,'Custom Folders','This page lists all the custom folders created in the General Contacts; let''s you edit them and also allow you to enable/disable the folders.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:793AM',0,'May 28 2004 10:25:53:793AM',1)
INSERT [help_contents] VALUES(309,9,9,'AdminFieldsFolder.do','ListFolders',NULL,'List of Custom Folders','This page lists all the custom folders created in the General Contacts; let''s you edit them and also allow you to enable/disable the folders.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:803AM',0,'May 28 2004 10:25:53:803AM',1)
INSERT [help_contents] VALUES(310,9,9,'AdminFields.do','ModifyField',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:823AM',0,'May 28 2004 10:25:53:823AM',1)
INSERT [help_contents] VALUES(311,9,9,'Admin.do','ListGlobalParams',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:833AM',0,'May 28 2004 10:25:53:833AM',1)
INSERT [help_contents] VALUES(312,9,9,'Admin.do','ModifyTimeout',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:833AM',0,'May 28 2004 10:25:53:833AM',1)
INSERT [help_contents] VALUES(313,9,9,'AdminObjectEvents.do',NULL,NULL,'Object Events:','The list of Object Events are displayed along with the corresponding Triggered Processes. The number of components and whether that Object Event is available or not is also shown.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:843AM',0,'May 28 2004 10:25:53:843AM',1)
INSERT [help_contents] VALUES(314,9,9,'AdminFieldsGroup.do','AddGroup',NULL,NULL,'Add a group',NULL,NULL,NULL,0,'May 28 2004 10:25:53:853AM',0,'May 28 2004 10:25:53:853AM',1)
INSERT [help_contents] VALUES(315,9,9,'AdminFields.do','AddField',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:863AM',0,'May 28 2004 10:25:53:863AM',1)
INSERT [help_contents] VALUES(316,9,9,'Admin.do','UpdateList',NULL,NULL,'The Lookup List displays all the list names, which can be edited, the number of items can be known and the ones present can be previewed.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:863AM',0,'May 28 2004 10:25:53:863AM',1)
INSERT [help_contents] VALUES(317,9,9,'AdminScheduledEvents.do',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:883AM',0,'May 28 2004 10:25:53:883AM',1)
INSERT [help_contents] VALUES(318,9,9,'Admin.do','Config',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:53:973AM',0,'May 28 2004 10:25:53:973AM',1)
INSERT [help_contents] VALUES(319,9,9,'Admin.do','EditLists',NULL,'Lookup Lists','The Lookup List displays all the list names, which can be edited, the number of items is displayed and the ones present can be previewed.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:973AM',0,'May 28 2004 10:25:53:973AM',1)
INSERT [help_contents] VALUES(320,9,9,'AdminFieldsGroup.do','ListGroups',NULL,'Folder Details','This page lists the folder details and the groups added to this folder. Each group can further have a custom field created or deleted. You can also place it in the desired position in the dropdown list.',NULL,NULL,NULL,0,'May 28 2004 10:25:53:983AM',0,'May 28 2004 10:25:53:983AM',1)
INSERT [help_contents] VALUES(321,9,9,'AdminCategories.do','ViewActive',NULL,'Active Category Details','The four different levels for the "Active" and "Draft" categories are displayed. The level1 has the category name, which is further classified into sub directories/levels. The level1 has the sublevel called level2 which in turn has sublevel called level3 and so on.',NULL,NULL,NULL,0,'May 28 2004 10:25:54:003AM',0,'May 28 2004 10:25:54:003AM',1)
INSERT [help_contents] VALUES(322,9,9,'AdminCategories.do','View',NULL,'Draft Category Details','The four different levels for the active and the draft categories are displayed. The level1 has the category name, which is further classified into sub directories/levels. The level1 has the sublevel called level2 which in turn has sublevel called level3 and so on. The draft categories can be edited and activated. The activated draft categories would be then reflected in the Active Categories list. The modified/updated draft category can also be reverted to its original state.',NULL,NULL,NULL,0,'May 28 2004 10:25:54:023AM',0,'May 28 2004 10:25:54:023AM',1)
INSERT [help_contents] VALUES(323,9,9,'Users.do','InsertUserForm',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:043AM',0,'May 28 2004 10:25:54:043AM',1)
INSERT [help_contents] VALUES(324,9,9,'Users.do','UpdateUser',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:043AM',0,'May 28 2004 10:25:54:043AM',1)
INSERT [help_contents] VALUES(325,9,9,'Users.do','AddUser',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:053AM',0,'May 28 2004 10:25:54:053AM',1)
INSERT [help_contents] VALUES(326,9,9,'Users.do','UserDetails',NULL,'User Details','This form provides the administrator with more information about the user, namely information pertaining to the users login history and view points.',NULL,NULL,NULL,0,'May 28 2004 10:25:54:063AM',0,'May 28 2004 10:25:54:063AM',1)
INSERT [help_contents] VALUES(327,9,9,'Roles.do',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:073AM',0,'May 28 2004 10:25:54:073AM',1)
INSERT [help_contents] VALUES(328,9,9,'Roles.do','ListRoles',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:073AM',0,'May 28 2004 10:25:54:073AM',1)
INSERT [help_contents] VALUES(329,9,9,'Viewpoints.do','InsertViewpoint',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:083AM',0,'May 28 2004 10:25:54:083AM',1)
INSERT [help_contents] VALUES(330,9,9,'Viewpoints.do','InsertViewpoint',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:093AM',0,'May 28 2004 10:25:54:093AM',1)
INSERT [help_contents] VALUES(331,9,9,'Admin.do',NULL,NULL,'Overview','You are looking at the Admin module home page. Here you can manage the system by reviewing its usage, configuring specific modules and system parameters.',NULL,NULL,NULL,0,'May 28 2004 10:25:54:093AM',0,'May 28 2004 10:25:54:093AM',1)
INSERT [help_contents] VALUES(332,11,13,'Search.do','SiteSearch',NULL,NULL,NULL,NULL,NULL,NULL,0,'May 28 2004 10:25:54:143AM',0,'May 28 2004 10:25:54:143AM',1)
INSERT [help_contents] VALUES(333,11,13,'Search.do','SiteSearch',NULL,'General Search','You can search the system for data associated with a particular key term. This can be done using the search data text box present on the left side of the window. The data associated with the corresponding key term is looked for in different modules for a match and the results are displayed per module. The search results are shown with detail description.',NULL,NULL,NULL,0,'May 28 2004 10:25:54:153AM',0,'May 28 2004 10:25:54:153AM',1)
INSERT [help_contents] VALUES(334,17,14,'ProductsCatalog.do','ListAllProducts',NULL,'a','b',NULL,NULL,NULL,0,'May 28 2004 10:25:54:173AM',0,'May 28 2004 10:25:54:173AM',1)

SET IDENTITY_INSERT [help_contents] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_ticketsource
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_ticketsource] ON
GO
INSERT [lookup_ticketsource] VALUES(1,'Phone',0,1,1)
INSERT [lookup_ticketsource] VALUES(2,'Email',0,2,1)
INSERT [lookup_ticketsource] VALUES(3,'Web',0,3,1)
INSERT [lookup_ticketsource] VALUES(4,'Letter',0,4,1)
INSERT [lookup_ticketsource] VALUES(5,'Other',0,5,1)

SET IDENTITY_INSERT [lookup_ticketsource] OFF
GO
SET NOCOUNT OFF
 
-- Insert default lookup_project_priority
SET NOCOUNT ON
SET IDENTITY_INSERT [lookup_project_priority] ON
GO
INSERT [lookup_project_priority] VALUES(1,'Low',0,1,1,0,NULL,10)
INSERT [lookup_project_priority] VALUES(2,'Normal',1,2,1,0,NULL,20)
INSERT [lookup_project_priority] VALUES(3,'High',0,3,1,0,NULL,30)

SET IDENTITY_INSERT [lookup_project_priority] OFF
GO
SET NOCOUNT OFF
 
-- Insert default business_process_component_parameter
SET NOCOUNT ON
SET IDENTITY_INSERT [business_process_component_parameter] ON
GO
INSERT [business_process_component_parameter] VALUES(1,3,1,'Tickets',1)
INSERT [business_process_component_parameter] VALUES(2,3,2,'${this.id}',1)
INSERT [business_process_component_parameter] VALUES(3,3,3,'${this.modified}',1)
INSERT [business_process_component_parameter] VALUES(4,3,4,'${previous.enteredBy}',1)
INSERT [business_process_component_parameter] VALUES(5,3,5,'Dark Horse CRM Ticket Closed: ${this.paddedId}',1)
INSERT [business_process_component_parameter] VALUES(6,3,6,'The following ticket in Dark Horse CRM has been closed:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Comment: ${this.comment}

Closed by: ${ticketModifiedByContact.nameFirstLast}

Solution: ${this.solution}
',1)
INSERT [business_process_component_parameter] VALUES(7,6,7,'Tickets',1)
INSERT [business_process_component_parameter] VALUES(8,6,8,'${this.id}',1)
INSERT [business_process_component_parameter] VALUES(9,6,9,'${this.modified}',1)
INSERT [business_process_component_parameter] VALUES(10,6,10,'${this.assignedTo}',1)
INSERT [business_process_component_parameter] VALUES(11,6,11,'Dark Horse CRM Ticket Assigned: ${this.paddedId}',1)
INSERT [business_process_component_parameter] VALUES(12,6,12,'The following ticket in Dark Horse CRM has been assigned to you:

--- Ticket Details ---

Ticket # ${this.paddedId}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Assigned By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}
',1)
INSERT [business_process_component_parameter] VALUES(13,7,13,'true',1)
INSERT [business_process_component_parameter] VALUES(14,7,14,'true',0)
INSERT [business_process_component_parameter] VALUES(15,7,15,'true',1)
INSERT [business_process_component_parameter] VALUES(16,7,16,'10',1)
INSERT [business_process_component_parameter] VALUES(17,7,17,'${process.lastAnchor}',1)
INSERT [business_process_component_parameter] VALUES(18,7,18,'${process.nextAnchor}',1)
INSERT [business_process_component_parameter] VALUES(19,8,19,'${this.enteredBy}',1)
INSERT [business_process_component_parameter] VALUES(20,8,20,'${this.contactId}',0)
INSERT [business_process_component_parameter] VALUES(21,8,21,'Dark Horse CRM Unassigned Ticket Report (${objects.size})',1)
INSERT [business_process_component_parameter] VALUES(22,8,22,'** This is an automated message **

The following tickets in Dark Horse CRM are unassigned and need attention:

',1)
INSERT [business_process_component_parameter] VALUES(23,8,23,'----- Ticket Details -----
Ticket # ${this.paddedId}
Created: ${this.enteredString}
Organization: ${ticketOrganization.name}
Priority: ${ticketPriorityLookup.description}
Severity: ${ticketSeverityLookup.description}
Issue: ${this.problem}

Last Modified By: ${ticketModifiedByContact.nameFirstLast}
Comment: ${this.comment}


',1)

SET IDENTITY_INSERT [business_process_component_parameter] OFF
GO
SET NOCOUNT OFF
