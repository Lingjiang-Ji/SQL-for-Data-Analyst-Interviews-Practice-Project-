
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
