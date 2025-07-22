--------------------------------------------------------
-- 🎯 Problem: Tweets Rolling Average
-- 🏢 Platform: DataLemur (Twitter)
-- 📅 Task: calculate the 3-day rolling average of tweets for each user
-- 🧠 Skills: WINDOW FUNCTION, ROWS BETWEEN AND, ROUND(), lAG()
-- 📌 Note: Started without knowing 'ROWS BETWEEN AND' to constrain 3 days, then optimized to a simpler version.
--------------------------------------------------------

-- ✅ Final Optimized Version: use 'rows between and' in window function
select user_id, tweet_date, 
       round(avg(tweet_count) over (partition by user_id
                                    order by tweet_date
                                    rows between 2 preceding and current row), 2) rolling_avg_3d
from tweets;

-- 🧪 Original Version (using LAG)
--with wed as(
--select user_id,
--       tweet_date,
--       tweet_count,
--       lag(tweet_count) over (partition by user_id order by tweet_date) tc1,
--       lag(tweet_count,2) over (partition by user_id order by tweet_date) tc2
--from tweets 
--),
--unstack as(
--select user_id, tweet_date, tweet_count tc 
--from wed 
--union all 
--select user_id, tweet_date, tc1 tc 
--from wed 
--union all 
--select user_id, tweet_date, tc2 tc 
--from wed 
--)
--select user_id, tweet_date, round(avg(tc),2)
--from unstack
--group by user_id, tweet_date
--order by user_id, tweet_date;
