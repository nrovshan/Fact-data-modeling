-- 2. A DDL for an user_devices_cumulated table

create table user_devices_cumulated(
              user_id numeric,
	          browser_type text,
	          date Date,
	          device_activity_datelist Date[],
	          primary key(user_id, browser_type, date))
;