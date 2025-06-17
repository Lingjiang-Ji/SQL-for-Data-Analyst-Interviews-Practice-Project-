--------------------------------------------------------
-- 🎯 Problem: Odd and Even Measurements
-- 🏢 Platform: DataLemur (Google)
-- 📅 Task: Separate and sum odd- vs even-ordered sensor measurements per day
-- 🧠 Skills: CAST, FILTER clause, ROW_NUMBER(), GROUP BY
--------------------------------------------------------

with rd as (
select cast(measurement_time as date) measurement_day,
       measurement_value,
       row_number() over (partition by cast(measurement_time as date)
                          order by measurement_time) rn 
from measurements 
)

select measurement_day,
       sum(measurement_value) filter (where rn%2=1) odd_sum,
       sum(measurement_value) filter (where rn%2=0) even_sum
from rd 
group by measurement_day;
