---------------------------------------------------
-- 🎯 Problem: Highest Grossing Products
-- 📦 Platform: DataLemur (Amazon)
-- 📅 Task: Find top 2 products by revenue in each category (for year 2022)
-- 🧠 Skills: GROUP BY, SUM, ROW_NUMBER(), PARTITION BY, CTE
---------------------------------------------------
with ts as (
select category,product,sum(spend) total_spend
from product_spend
where transaction_date>='2022-01-01' and transaction_date<'2023-01-01'
group by category,product
),
r as (
select row_number() over (PARTITION by category order by total_spend desc) rn,
category,product,total_spend
from ts
)
select category,product,total_spend
from r
where rn<=2;
