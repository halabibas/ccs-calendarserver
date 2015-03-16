----
-- Copyright (c) 2012-2015 Apple Inc. All rights reserved.
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
-- http://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
----

---------------------------------------------------
-- Upgrade database schema from VERSION 36 to 37 --
---------------------------------------------------

------------------------
-- Inbox Cleanup Work --
------------------------

create sequence JOB_SEQ;

create table JOB (
    "JOB_ID" integer primary key not null,
    "WORK_TYPE" nvarchar2(255),
    "PRIORITY" integer default 0,
    "WEIGHT" integer default 0,
    "NOT_BEFORE" timestamp default null,
    "NOT_AFTER" timestamp default null
);


-- IMIP_INVITATION_WORK --
alter table IMIP_INVITATION_WORK
    add ("JOB_ID" integer default 0 not null);
update IMIP_INVITATION_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'IMIP_INVITATION_WORK', NOT_BEFORE from IMIP_INVITATION_WORK);

alter table IMIP_INVITATION_WORK
    drop column NOT_BEFORE;
alter table IMIP_INVITATION_WORK
    modify ("JOB_ID" integer default null references JOB);

create index IMIP_INVITATION_WORK__586d064c on IMIP_INVITATION_WORK (
    JOB_ID
);


-- IMIP_POLLING_WORK --
alter table IMIP_POLLING_WORK
    add ("JOB_ID" integer default 0 not null);
update IMIP_POLLING_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'IMIP_POLLING_WORK', NOT_BEFORE from IMIP_POLLING_WORK);

alter table IMIP_POLLING_WORK
    drop column NOT_BEFORE;
alter table IMIP_POLLING_WORK
    modify ("JOB_ID" integer default null references JOB);

create index IMIP_POLLING_WORK_JOB_d5535891 on IMIP_POLLING_WORK (
    JOB_ID
);


-- IMIP_REPLY_WORK --
alter table IMIP_REPLY_WORK
    add ("JOB_ID" integer default 0 not null);
update IMIP_REPLY_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'IMIP_REPLY_WORK', NOT_BEFORE from IMIP_REPLY_WORK);

alter table IMIP_REPLY_WORK
    drop column NOT_BEFORE;
alter table IMIP_REPLY_WORK
    modify ("JOB_ID" integer default null references JOB);

create index IMIP_REPLY_WORK_JOB_I_bf4ae73e on IMIP_REPLY_WORK (
    JOB_ID
);


-- PUSH_NOTIFICATION_WORK --
alter table PUSH_NOTIFICATION_WORK
    add ("JOB_ID" integer default 0 not null);
update PUSH_NOTIFICATION_WORK set JOB_ID = JOB_SEQ.nextval;
alter table PUSH_NOTIFICATION_WORK
    rename column "PRIORITY" to "PUSH_PRIORITY";

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'PUSH_NOTIFICATION_WORK', NOT_BEFORE from PUSH_NOTIFICATION_WORK);

alter table PUSH_NOTIFICATION_WORK
    drop column NOT_BEFORE;
alter table PUSH_NOTIFICATION_WORK
    modify ("JOB_ID" integer default null references JOB);

create index PUSH_NOTIFICATION_WOR_8bbab117 on PUSH_NOTIFICATION_WORK (
    JOB_ID
);


-- GROUP_CACHER_POLLING_WORK --
alter table GROUP_CACHER_POLLING_WORK
    add ("JOB_ID" integer default 0 not null);
update GROUP_CACHER_POLLING_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'GROUP_CACHER_POLLING_WORK', NOT_BEFORE from GROUP_CACHER_POLLING_WORK);

alter table GROUP_CACHER_POLLING_WORK
    drop column NOT_BEFORE;
alter table GROUP_CACHER_POLLING_WORK
    modify ("JOB_ID" integer default null references JOB);

create index GROUP_CACHER_POLLING__6eb3151c on GROUP_CACHER_POLLING_WORK (
    JOB_ID
);


-- GROUP_REFRESH_WORK --
alter table GROUP_REFRESH_WORK
    add ("JOB_ID" integer default 0 not null);
update GROUP_REFRESH_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'GROUP_REFRESH_WORK', NOT_BEFORE from GROUP_REFRESH_WORK);

alter table GROUP_REFRESH_WORK
    drop column NOT_BEFORE;
alter table GROUP_REFRESH_WORK
    modify ("JOB_ID" integer default null references JOB);

create index GROUP_REFRESH_WORK_JO_717ede20 on GROUP_REFRESH_WORK (
    JOB_ID
);


-- GROUP_ATTENDEE_RECONCILIATION_ --
alter table GROUP_ATTENDEE_RECONCILIATION_
    add ("JOB_ID" integer default 0 not null);
update GROUP_ATTENDEE_RECONCILIATION_ set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'GROUP_ATTENDEE_RECONCILIATION_', NOT_BEFORE from GROUP_ATTENDEE_RECONCILIATION_);

alter table GROUP_ATTENDEE_RECONCILIATION_
    drop column NOT_BEFORE;
alter table GROUP_ATTENDEE_RECONCILIATION_
    modify ("JOB_ID" integer default null references JOB);

create index GROUP_ATTENDEE_RECONC_cd2d61b9 on GROUP_ATTENDEE_RECONCILIATION_ (
    JOB_ID
);


-- CALENDAR_OBJECT_SPLITTER_WORK --
alter table CALENDAR_OBJECT_SPLITTER_WORK
    add ("JOB_ID" integer default 0 not null);
update CALENDAR_OBJECT_SPLITTER_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'CALENDAR_OBJECT_SPLITTER_WORK', NOT_BEFORE from CALENDAR_OBJECT_SPLITTER_WORK);

alter table CALENDAR_OBJECT_SPLITTER_WORK
    drop column NOT_BEFORE;
alter table CALENDAR_OBJECT_SPLITTER_WORK
    modify ("JOB_ID" integer default null references JOB);

create index CALENDAR_OBJECT_SPLIT_33603b72 on CALENDAR_OBJECT_SPLITTER_WORK (
    JOB_ID
);


-- FIND_MIN_VALID_REVISION_WORK --
alter table FIND_MIN_VALID_REVISION_WORK
    add ("JOB_ID" integer default 0 not null);
update FIND_MIN_VALID_REVISION_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'FIND_MIN_VALID_REVISION_WORK', NOT_BEFORE from FIND_MIN_VALID_REVISION_WORK);

alter table FIND_MIN_VALID_REVISION_WORK
    drop column NOT_BEFORE;
alter table FIND_MIN_VALID_REVISION_WORK
    modify ("JOB_ID" integer default null references JOB);

create index FIND_MIN_VALID_REVISI_78d17400 on FIND_MIN_VALID_REVISION_WORK (
    JOB_ID
);


-- REVISION_CLEANUP_WORK --
alter table REVISION_CLEANUP_WORK
    add ("JOB_ID" integer default 0 not null);
update REVISION_CLEANUP_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'REVISION_CLEANUP_WORK', NOT_BEFORE from REVISION_CLEANUP_WORK);

alter table REVISION_CLEANUP_WORK
    drop column NOT_BEFORE;
alter table REVISION_CLEANUP_WORK
    modify ("JOB_ID" integer default null references JOB);

create index REVISION_CLEANUP_WORK_eb062686 on REVISION_CLEANUP_WORK (
    JOB_ID
);


-- INBOX_CLEANUP_WORK --
alter table INBOX_CLEANUP_WORK
    add ("JOB_ID" integer default 0 not null);
update INBOX_CLEANUP_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'INBOX_CLEANUP_WORK', NOT_BEFORE from INBOX_CLEANUP_WORK);

alter table INBOX_CLEANUP_WORK
    drop column NOT_BEFORE;
alter table INBOX_CLEANUP_WORK
    modify ("JOB_ID" integer default null references JOB);

create index INBOX_CLEANUP_WORK_JO_799132bd on INBOX_CLEANUP_WORK (
    JOB_ID
);


-- CLEANUP_ONE_INBOX_WORK --
alter table CLEANUP_ONE_INBOX_WORK
    add ("JOB_ID" integer default 0 not null);
update CLEANUP_ONE_INBOX_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'CLEANUP_ONE_INBOX_WORK', NOT_BEFORE from CLEANUP_ONE_INBOX_WORK);

alter table CLEANUP_ONE_INBOX_WORK
    drop column NOT_BEFORE;
alter table CLEANUP_ONE_INBOX_WORK
    modify ("JOB_ID" integer default null references JOB);

create index CLEANUP_ONE_INBOX_WOR_375dac36 on CLEANUP_ONE_INBOX_WORK (
    JOB_ID
);


-- SCHEDULE_REFRESH_WORK --
alter table SCHEDULE_REFRESH_WORK
    add ("JOB_ID" integer default 0 not null);
update SCHEDULE_REFRESH_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'SCHEDULE_REFRESH_WORK', NOT_BEFORE from SCHEDULE_REFRESH_WORK);

alter table SCHEDULE_REFRESH_WORK
    drop column NOT_BEFORE;
alter table SCHEDULE_REFRESH_WORK
    modify ("JOB_ID" integer default null references JOB);

create index SCHEDULE_REFRESH_WORK_3ffa2718 on SCHEDULE_REFRESH_WORK (
    JOB_ID
);


-- SCHEDULE_AUTO_REPLY_WORK --
alter table SCHEDULE_AUTO_REPLY_WORK
    add ("JOB_ID" integer default 0 not null);
update SCHEDULE_AUTO_REPLY_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'SCHEDULE_AUTO_REPLY_WORK', NOT_BEFORE from SCHEDULE_AUTO_REPLY_WORK);

alter table SCHEDULE_AUTO_REPLY_WORK
    drop column NOT_BEFORE;
alter table SCHEDULE_AUTO_REPLY_WORK
    modify ("JOB_ID" integer default null references JOB);

create index SCHEDULE_AUTO_REPLY_W_4d7bb5a8 on SCHEDULE_AUTO_REPLY_WORK (
    JOB_ID
);


-- SCHEDULE_ORGANIZER_WORK --
alter table SCHEDULE_ORGANIZER_WORK
    add ("JOB_ID" integer default 0 not null);
update SCHEDULE_ORGANIZER_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'SCHEDULE_ORGANIZER_WORK', NOT_BEFORE from SCHEDULE_ORGANIZER_WORK);

alter table SCHEDULE_ORGANIZER_WORK
    drop column NOT_BEFORE;
alter table SCHEDULE_ORGANIZER_WORK
    modify ("JOB_ID" integer default null references JOB);

create index SCHEDULE_ORGANIZER_WO_1e9f246d on SCHEDULE_ORGANIZER_WORK (
    JOB_ID
);


-- SCHEDULE_REPLY_WORK --
alter table SCHEDULE_REPLY_WORK
    add ("JOB_ID" integer default 0 not null);
update SCHEDULE_REPLY_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'SCHEDULE_REPLY_WORK', NOT_BEFORE from SCHEDULE_REPLY_WORK);

alter table SCHEDULE_REPLY_WORK
    drop column NOT_BEFORE;
alter table SCHEDULE_REPLY_WORK
    modify ("JOB_ID" integer default null references JOB);

create index SCHEDULE_REPLY_WORK_J_5913b4a4 on SCHEDULE_REPLY_WORK (
    JOB_ID
);


-- SCHEDULE_REPLY_CANCEL_WORK --
alter table SCHEDULE_REPLY_CANCEL_WORK
    add ("JOB_ID" integer default 0 not null);
update SCHEDULE_REPLY_CANCEL_WORK set JOB_ID = JOB_SEQ.nextval;

insert into JOB
  (JOB_ID, WORK_TYPE, NOT_BEFORE)
  (select JOB_ID, 'SCHEDULE_REPLY_CANCEL_WORK', NOT_BEFORE from SCHEDULE_REPLY_CANCEL_WORK);

alter table SCHEDULE_REPLY_CANCEL_WORK
    drop column NOT_BEFORE;
alter table SCHEDULE_REPLY_CANCEL_WORK
    modify ("JOB_ID" integer default null references JOB);

create index SCHEDULE_REPLY_CANCEL_94a0c766 on SCHEDULE_REPLY_CANCEL_WORK (
    JOB_ID
);


-- update the version
update CALENDARSERVER set VALUE = '37' where NAME = 'VERSION';
