--------------------------------------------------------
-- 🎯 Problem: Top 5 Artists
-- 🏢 Platform: DataLemur (Spotify)
-- 📅 Task: Find the top 5 artists whose songs appear most frequently in the Top 10 of the global song rank.
-- 🧠 Skills: WINDOW FUNCTION, DENSE_RANK(), GROUPBY
--------------------------------------------------------

with joined as(
select count(a.artist_name) c, a.artist_name
from global_song_rank gsr
join songs s on gsr.song_id = s.song_id
join artists a on a.artist_id = s.artist_id
where rank<=10
group by a.artist_name
)
,rk as(
select artist_name, dense_rank() over (order by c desc) artist_rank
from joined
order by artist_rank)

select * from rk where artist_rank<=5;

