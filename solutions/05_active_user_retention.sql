---------------------------------------------------
-- 🎯 Problem: Active User Retention
-- 🏢 Platform: DataLemur (Facebook)
-- 📌 Task: Count monthly active users (MAUs) based on actions in consecutive months
-- 🧠 Skills: CTE, EXTRACT(MONTH), self-join on month offset, DISTINCT, COUNT
---------------------------------------------------

with extracted as(
select cast(extract(month from event_date) as INTEGER) mth,
       user_id
from user_actions
where event_date>='06/01/2022 00:00:00' and event_date<'08/01/2022 00:00:00'
)

SELECT c.mth as month, count(distinct (c.mth, p.user_id)) monthly_active_users
from extracted c 
right join extracted p 
on c.user_id = p.user_id and c.mth = p.mth + 1
group by c.mth 
having c.mth=7;
