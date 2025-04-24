# 📈 Top Monthly Sellers (Amazon Sales Data Challenge)

## 📌 Problem Description

Given aggregated sales data per transaction, identify the **top 3 sellers by total sales** within **each product category** during **January 2024**. If multiple sellers tie on sales, include them all.

The output must include the following fields:

- `seller_id`
- `total_sales`
- `product_category`
- `market_place`
- `sales_date`

---

## 🧠 SQL Skills Demonstrated

- Aggregation with `GROUP BY` and `SUM`
- Ranking with `DENSE_RANK()` and `ROW_NUMBER()`
- Joining summarized and raw tables
- Use of CTEs for clarity and modular logic

---

## 🧮 Dual-Solution Design

This problem can be approached from two equally valid perspectives:

### ✅ Solution 1: Logical Simplicity (No Window Functions)

Uses a `DISTINCT + ROW_NUMBER` approach to **simulate ranking without needing full window functions**.  
Lightweight logic.
       
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

🟢 Pros:
- Clean and concise
- Easy to explain in interviews

🔴 Cons:
- Logic slightly opaque (manual simulation of ranking)
- Harder to adapt to other types of ranking (percentile, tie-breaking)

---

### ✅ Solution 2: Maintainability & Scalability (Window Functions)

Uses `DENSE_RANK()` to cleanly handle tied ranks, and `ROW_NUMBER()` to deduplicate sales records when joining back.
Easier to maintain

with tt as (
  select seller_id, product_category,
         sum(total_sales) as ts
  from sales_data
  where sales_date >= '2024-01-01' and sales_date < '2024-02-01'
  group by seller_id, product_category
),
ranked as (
  select *, 
         dense_rank() over (partition by product_category order by ts desc) as rk
  from tt
),
dedup_sales as (
  select *, 
         row_number() over (partition by seller_id, product_category order by sales_date desc) as rn
  from sales_data
)
select r.seller_id, r.ts as total_sales, r.product_category, 
       s.market_place, s.sales_date
from ranked r
join dedup_sales s 
  on r.seller_id = s.seller_id and r.product_category = s.product_category
where r.rk <= 3 and s.rn = 1;

       
🟢 Pros:
- Clear semantic use of ranking
- Easily extendable (e.g. to top 5, or handle sub-totals, etc.)
- More production-ready

🔴 Cons:
- Slightly longer query
- Requires full support for window functions

---
