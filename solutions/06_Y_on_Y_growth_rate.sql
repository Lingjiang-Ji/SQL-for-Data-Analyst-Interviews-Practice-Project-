---------------------------------------------------
-- 🎯 Problem: Y-on-Y Growth Rate
-- 🏢 Platform: DataLemur (Wayfair)
-- 📌 Task: Calculate year-over-year growth in spend per product
-- 🧠 Skills: CTE, EXTRACT(YEAR), SUM, LEFT JOIN, ROUND
---------------------------------------------------

with ey as (
select product_id, spend, extract(year from transaction_date) as year
from user_transactions
),
sumed as(
select sum(spend) spend, year, product_id
from ey 
group by product_id, year
)
select c.year, c.product_id, c.spend curr_year_spend,
       p.spend prev_year_spend, 
       round(100*(c.spend-p.spend)/p.spend,2) yoy_rate
from sumed c 
left join sumed p 
on c.product_id = p.product_id and c.year = p.year + 1
order by product_id,year;
