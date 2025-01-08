-- 6. The incremental query to generate host_activity_datelist

insert into hosts_cumulated
with yesterday as(
  select * from hosts_cumulated
  where month_start = date('2023-01-01')
),

     today as(
   select 
		 host,
		 date(event_time) as date
   from events	 
   where date(event_time) = date('2023-01-01')
   group by host, date(event_time)
)

select 
      coalesce(t.host, y.host) as host,
	  coalesce(date_trunc('month',t.date), y.month_start) as month_start,
	  case 
	      when y.host_activity_datelist is null then array[t.date]
		  when t.date is null then y.host_activity_datelist
		  else y.host_activity_datelist || array[t.date]
	  end as host_activity_datelist
from today t full outer join yesterday y
on t.host = y.host
on conflict (host, month_start)
do
update set host_activity_datelist = excluded.host_activity_datelist;