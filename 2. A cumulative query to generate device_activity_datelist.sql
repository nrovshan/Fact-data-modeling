-- 3. A cumulative query to generate device_activity_datelist from events

insert into user_devices_cumulated
with yesterday as(
	select * from user_devices_cumulated
	where date = date('2023-01-30')
),
   today as(
	select 
		e.user_id,
		d.browser_type,
	    date(e.event_time) as date,
		row_number() over(partition by e.user_id, d.browser_type) as rov_num
	from events e
	left join devices d 
	on e.device_id = d.device_id
	where date(event_time) = date('2023-01-31')
	and e.user_id is not null
	 and d.browser_type is not null

	 
),
  deduped_today as(
   select *
   from today where rov_num = 1)
   

select 
    coalesce(dt.user_id, y.user_id) as user_id,
	coalesce(dt.browser_type, y.browser_type) as browser_type,
	coalesce(dt.date, y.date + 1) as date,
	case when y.device_activity_datelist is null
	     then array[dt.date]
		 when dt.date is null then y.device_activity_datelist
    else y.device_activity_datelist || array[dt.date]
	end as device_activity_datelist
from deduped_today dt full outer join yesterday y
on dt.user_id = y.user_id
and dt.browser_type = y.browser_type;
	
	
select * from user_devices_cumulated 
where date = date('2023-01-31');