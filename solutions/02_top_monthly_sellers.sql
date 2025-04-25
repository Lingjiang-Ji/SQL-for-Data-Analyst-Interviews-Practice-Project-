---------------------------------------------------
-- 🎯 Problem: Top Monthly Sellers
-- 📦 Platform: StrataScratch (Amazon)
-- 📅 Task: Find top 3 sellers by total sales in each product category (in Jan 2024)
-- 🧠 Skills: GROUP BY, SUM, ROW_NUMBER(), DENSE_RANK(), PARTITION BY, CTE
---------------------------------------------------

🧮 Dual-Solution Design
This problem can be approached from two equally valid perspectives:
One has simpler logic, and one is more suitable for team work.

       
✅ Solution 1: Logical Simplicity 

Uses a `DISTINCT + ROW_NUMBER` approach to satistify the requirments and delete the duplicates.  
       
with tt as(
select seller_id,product_category,
       sum(total_sales) ts
from sales_data
where sales_date>='2024-01-01' and sales_date<'2024-02-01'
group by seller_id,product_category
),
r as(
select row_number() over (partition by product_category order by ts desc) rn,
       product_category, ts
from (
select distinct product_category, ts
from tt
) x
)
select s.seller_id, tt.ts total_sales, tt.product_category, 
       market_place, sales_date
from tt join r on tt.product_category = r.product_category and tt.ts = r.ts
join sales_data s on tt.seller_id = s.seller_id and tt.product_category = s.product_category
where rn<=3;


✅ Solution 2: Maintainability & Scalability (Suitable to cooperation environment)

Uses DENSE_RANK() to cleanly handle tied ranks, and ROW_NUMBER() to deduplicate sales records when joining back.
Easier to maintain and work in a team.

with tt as (
  select seller_id, product_category,
         sum(total_sales) as ts
  from sales_data
  where sales_date >= '2024-01-01' and sales_date < '2024-02-01'
  group by seller_id, product_category
),
r as (
  select *, 
         dense_rank() over (partition by product_category order by ts desc) as rk
  from tt
),
d as (
  select *, 
         row_number() over (partition by seller_id, product_category order by sales_date desc) as rn
  from sales_data
)
select r.seller_id, r.ts as total_sales, r.product_category, 
       d.market_place, d.sales_date
from r
join d  
  on r.seller_id = d.seller_id and r.product_category = d.product_category
where r.rk <= 3 and d.rn = 1;
