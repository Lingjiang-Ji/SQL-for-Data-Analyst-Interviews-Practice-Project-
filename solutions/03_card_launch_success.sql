-- ---------------------------------------------------
-- 🎯 Problem: Card Launch Success
-- 🏢 Platform: DataLemur (JPMorgan)
-- 📅 Task: Find how many cards were issued in each card's launch month
-- 🧠 Skills: ROW_NUMBER(), PARTITION BY, ORDER BY
-- ---------------------------------------------------
with o as(
select row_number() over (partition by card_name order by issue_year,issue_month) rn,
       card_name, issued_amount
from monthly_cards_issued
)
select card_name, issued_amount
from o
where rn=1
order by issued_amount desc;
