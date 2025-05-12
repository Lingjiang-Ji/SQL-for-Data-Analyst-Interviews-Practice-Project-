---------------------------------------------------
-- 🎯 Problem: Maximize Prime Item Inventory
-- 🏢 Platform: DataLemur (Amazon)
-- 📌 Task: Maximize number of prime & non-prime item batches within 500,000 sqft
-- 🧠 Skills: CTE, aggregation, FLOOR, arithmetic allocation, UNION ALL
---------------------------------------------------

with sumed as (
select sum(square_footage) ba,
       count(item_type) n,
       item_type
from inventory
group by item_type
),
parea as (
select (500000-ba) pa 
from sumed 
where item_type='not_prime'
),
prime as (
select (floor(pa/ba))*n item_count, item_type, (floor(pa/ba))*ba pa
from parea 
join sumed on TRUE
where item_type='prime_eligible'
),
nparea as(
select (500000-pa) nparea
from prime
),
nprime as (
select (floor(nparea/ba))*n item_count, item_type
from sumed
join nparea on True
where item_type='not_prime'
)

select item_type, item_count
from prime

union ALL

select item_type, item_count
from nprime;

-- ✅ Note: This solution ensures at least 1 non-prime batch is always stocked, 
-- as explicitly required by the problem prompt — a condition the official solution overlooks.
