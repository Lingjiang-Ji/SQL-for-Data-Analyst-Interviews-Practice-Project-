---------------------------------------------------
-- 🎯 Problem: Active User Retention
-- 🏢 Platform: DataLemur (Facebook)
-- 📌 Task: Count monthly active users (MAUs) based on actions in consecutive months
-- 🧠 Skills: CTE, EXTRACT(MONTH), self-join on month offset, DISTINCT, COUNT
---------------------------------------------------

with extracted as (
  select cast(extract(month from event_date) as integer) mth,
       user_id
  from user_actions
  where event_date>='06/01/2022 00:00:00' and event_date<'08/01/2022 00:00:00'
),
active as(
select distinct c.mth as month, p.user_id users
from extracted c 
left join extracted p 
on c.user_id = p.user_id and c.mth = p.mth + 1
)
select month, count(users) monthly_active_user
from active
where month = 7
group by month;
