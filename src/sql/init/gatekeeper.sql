/*
  CRON entries can be used to execute the specified java class, the method
  is specified with a "#"
*/

/* Sample cron entry for running the notifier, every day every 5 minutes */
INSERT INTO events
(minute, task, extrainfo, enabled)
VALUES
('*/5',
 'org.aspcfs.apps.notifier.Notifier#doTask',
 '@CFS_HOME@/WEB-INF/notifier.xml',
 @FALSE@
);

/* Sample cron entry for running auto guide maintenance, every day at 2am */
INSERT INTO events
(minute, hour, task, extrainfo, enabled)
VALUES
('0', '2',
 'org.aspcfs.apps.notifier.Notifier#doTask',
 '@CFS_HOME@/WEB-INF/notifier.xml org.aspcfs.modules.media.autoguide.tasks.AutoGuideMaintenance',
 @FALSE@
);

/* Sample cron entry for running pilot online process, every tuesday at 3:05pm */
INSERT INTO events
(minute, hour, dayofweek, task, extrainfo, enabled)
VALUES
('5', '15', '2',
 'org.aspcfs.apps.transfer.Transfer#doTask',
 '@CFS_HOME@/WEB-INF/dataImport-pilotonline.xml',
 @FALSE@
);

