--------------------------------------------------------
-- 🎯 Problem: Average Post Hiatus(Part 1)
-- 🏢 Platform: DataLemur (Facebook)
-- 📅 Task: Find the number of days between each user’s first post of the year and last post of the year in the year 2021.
-- 🧠 Skills: DATE_PART(), date calculation, GROUPBY, HAVING
--------------------------------------------------------

select user_id, 
       date_part('day',max(post_date) - min(post_date)) days_between
from posts
where post_date >='01/01/2021 00:00:00' and post_date<'01/01/2022 00:00:00'
group by user_id
having count(post_date)>1;
