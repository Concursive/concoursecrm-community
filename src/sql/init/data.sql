/*
#	Initial Site data
#
#	$Id$
#	$Log#
#
*/
	
INSERT INTO lookup_department (description) values ('Customer Relations');
INSERT INTO lookup_department (description) values ('Engineering');
INSERT INTO lookup_department (description) values ('Billing');
INSERT INTO lookup_department (description) values ('Shipping/Receiving');
INSERT INTO lookup_department (description) values ('Purchasing');
INSERT INTO lookup_department (description) values ('Accounting');
INSERT INTO lookup_department (description) values ('Human Resources');

INSERT INTO system_prefs (category, data, enteredby, modifiedby, enabled) VALUES ('system.objects.hooks', '<config><hook id="com.darkhorseventures.cfsbase.Ticket" class="com.darkhorseventures.cfs.troubletickets.hook.TicketHook"/></config>', 0, 0, true);
INSERT INTO system_prefs (category, data, enteredby, modifiedby, enabled) VALUES ('system.fields.labels', '<config><label><replace>logo</replace><with>&lt;img border=&quot;0&quot; src=&quot;images/dev21.jpg&quot;&gt;</with></label><label><replace>tickets-problem</replace><with>Message</with></label></config>', 0, 0, false);
INSERT INTO system_prefs (category, data, enteredby, modifiedby, enabled) VALUES ('system.fields.ignore', '<config><ignore>tickets-code</ignore><ignore>tickets-subcat1</ignore><ignore>tickets-subcat2</ignore><ignore>tickets-subcat3</ignore><ignore>tickets-severity</ignore><ignore>tickets-priority</ignore></config>', 0, 0, false);

