# SQL-for-Data-Analyst-Interviews(Practice-Project)


![SQL Badge](https://img.shields.io/badge/SQL-Advanced-blue)
![Project Status](https://img.shields.io/badge/Status-In%20Progress-yellow)
![DataLemur SQL](https://img.shields.io/badge/DataLemur-SQL-blue)

This project documents my journey solving 30+ real-world SQL problems from platforms like DataLemur and StrataScratch, based on actual interview questions from companies like Amazon, Airbnb, and Spotify.  
📌 Goal: Prepare for data analyst interviews and build a portfolio of reusable SQL snippets for common business analysis scenarios.

🧠 Skills Practiced
QL Aggregation: GROUP BY, SUM, COUNT

Ranking & TopN logic: ROW_NUMBER(), RANK() with PARTITION BY

Time-based filters and trends: LAG(), DATEDIFF()

Subqueries, CTEs, Window Functions

Business KPIs: revenue, retention, active user classification, funnel conversion

## 📂 Problem Log

| # | Title                       | Description                                       | Skills   | SQL File |
|---|-----------------------------|----------------------------------------------------------|----|----------|
| 1 | Highest Grossing Products  | Top 2 products by total spend in each category   |GROUP BY, SUM, ROW_NUMBER(), PARTITION BY, CTE | [View SQL](solutions/01_highest_grossing_products.sql) |
| 2 | Top Monthly Sellers    | Find top 3 sellers per product category in Jan 2024, handling ties properly |GROUP BY, SUM, ROW_NUMBER(), DENSE_RANK(), PARTITION BY, CTE| [View SQL](solutions/02_top_monthly_sellers.sql)        |
| 3 | Card Launch Success        | Find how many cards were issued in each card's launch month|ROW_NUMBER(), PARTITION BY, ORDER BY| [View SQL](solutions/03_card_launch_success.sql)  |
| 4 | Median Google Search Frequency   | Calculate the median search frequency per user|CTE, Window Functions, generate_series(), Median Calculation Logic   |[View SQL](solutions/04_median_google_search_frequency.sql)|
| 5 | Active User Retention          | Count monthly active users (MAUs) based on actions in consecutive months|CTE, EXTRACT(MONTH), self-join on month offset, DISTINCT, COUNT  | [View SQL](solutions/05_active_user_retention.sql)   |
| 6 | Y on Y Growth Rate       | Calculate year-over-year growth in spend per product|CTE, EXTRACT(YEAR), SUM, LEFT JOIN, ROUND, LAG() | [View SQL](solutions/06_Y_on_Y_growth_rate.sql) |
| 7 | Maximize Prime Item Inventory      | Maximize number of prime & non-prime item batches within 500,000 sqft |CTE, aggregation, FLOOR, arithmetic allocation, UNION ALL| [View SQL](solutions/07_maximize_prime_item_inventory.sql) |
| 8 | Advertiser Status       | Update advertiser lifecycle status based on current-day payments|FULL OUTER JOIN, CASE WHEN logic, NULL handling, status transition modeling|  [View SQL](solutions/08_advertiser_status.sql)|
| 9 | Odd and Even Measurements |Separate and sum odd- vs even-ordered measurement_value per day |CAST, FILTER clause, ROW_NUMBER(), GROUP BY |[View SQL](solutions/09_odd_and_even_measurements.sql) |
| 10 | User Shopping Sprees      | Identify users with ≥3 consecutive days of purchases |LAG(), Self-Join, Date Arithmetic, DISTINCT|[View SQL](solutions/10_user_shopping_sprees.sql) |
| 11 | Twets' Rolling Averages |Calculate the 3-day rolling average of tweets for each user|WINDOW FUNCTION, ROWS BETWEEN AND, ROUND(), lAG()    |[View SQL](solutions/11_tweets_rolling_avg.sql) |
| 12 |Top 5 Artists   |Find the top 5 artists whose songs appear most frequently in the Top 10 of the global song rank.  |WINDOW FUNCTION, DENSE_RANK(), GROUPBY  |[View SQL](solutions/12_top_5_artists.sql) |
| 13 | Coming soon...       |  | |  |
| 14 | Coming soon...       |  | |  |



<p align="center">
  <img src="banner.png" alt="SQL for Data Analyst Interviews Banner" width="100%">
</p>

