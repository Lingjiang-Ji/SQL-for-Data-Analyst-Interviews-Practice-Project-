---------------------------------------------------
-- 🎯 Problem: Median Google Search Frequency
-- 🏢 Platform: DataLemur (Google)
-- 📌 Task: Calculate the median search frequency per user
-- 🧠 Skills: CTE, Window Functions, generate_series(), Median Calculation Logic
---------------------------------------------------
with a as(
select s.searches
from search_frequency s
join generate_series(1,s.num_users)
on true
),
r as(
select row_number() over (order by searches) rn,
       searches
from a 
),
t as(
select count(1) tt from a 
)
select round(avg(searches),1) median
from r, t
where ((rn = tt/2 or rn = tt/2+1) and tt%2=0)
      or (rn = tt/2 + 1 and tt%2=1);
