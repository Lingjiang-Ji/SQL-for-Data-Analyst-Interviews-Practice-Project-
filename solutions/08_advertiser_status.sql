---------------------------------------------------
-- 🎯 Problem: Advertiser Status
-- 🏢 Platform: DataLemur (Facebook)
-- 📌 Task: Update advertiser lifecycle status based on current-day payments
-- 🧠 Skills: FULL OUTER JOIN, CASE WHEN logic, NULL handling, status transition modeling
---------------------------------------------------

with payrcd as(
select a.user_id aid, d.user_id did, status, d.paid
from advertiser a 
full outer join daily_pay d 
on a.user_id = d.user_id
)

select case 
           when aid is null then did 
           else aid end as user_id,
       case
           when status is null then 'NEW'
           when paid is null then 'CHURN'
           when paid is not null and status = 'CHURN' then 'RESURRECT'
           else 'EXISTING' END as new_status
from payrcd
order by user_id;
           
