-- 4. A datelist_int generation query. Convert the device_activity_datelist column into a datelist_int column

with users as(
  select * from user_devices_cumulated 
  where date = date('2023-01-31')
),

   series as(
   select * from generate_series(Date('2023-01-01'), Date('2023-01-31'), Interval '1 day')
   as series_date
),

   datelist_int as(
   select 
		   case when device_activity_datelist @> array[date(series_date)]
	        then cast(Pow(2, 32 - (date - Date(series_date))) as bigint)
	   else 0
	   end as datelist_int_value, *
   from users 
   cross join series  
 
   )

select 
    user_id,
	cast(cast(sum(datelist_int_value) as bigint) as bit(32))
from datelist_int
group by user_id;