--------------------------------------------------------
-- 🎯 Problem: Shopping Spree Detection
-- 🏢 Platform: DataLemur (Amazon)
-- 📅 Task: Identify users with ≥3 consecutive days of purchases
-- 🧠 Skills: LAG(), Self-Join, Date Arithmetic, DISTINCT
-- 📌 Note: Started with a LAG() + CTE solution, then optimized to a simpler self-join version.
--------------------------------------------------------

-- ✅ Final Optimized Version: Self Join
select distinct c.user_id
from transactions c 
join transactions p1 
on c.user_id = p1.user_id 
    and extract(day from (c.transaction_date - p1.transaction_date))=1
join transactions p2 
on c.user_id = p2.user_id
    and extract(day from (c.transaction_date - p2.transaction_date)) = 2
order by c.user_id;

-- 🔙 Original Version (using LAG)
-- with lagged as(
-- select user_id,
--       lag(transaction_date) over (partition by user_id) p1,
--       lag(transaction_date,2) over (partition by user_id) p2,
--       transaction_date c 
-- from transactions
-- )
-- select distinct user_id
-- from lagged
-- where date(c) = date(p1)+1
--    and date(c) = date(p2)+2
-- order by user_id;
