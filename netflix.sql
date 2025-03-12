UPDATE netflix_titles SET director = 'N/A' WHERE director IS NULL OR director = '';
UPDATE netflix_titles SET cast = 'N/A' WHERE cast IS NULL OR cast = '';
UPDATE netflix_titles SET country = 'N/A' WHERE country IS NULL OR country = '';

/* 1.Find the total number of movies and TV shows separately. */
select count(case when type = 'TV Show' then 1 end) as TV_show_Count,
       count(case when type = 'Movie' then 1 end) as Movie_Count from netflix_titles
       
/* 2.Identify the most common rating assigned to Netflix content.*/
select rating,count(rating) as total_titles from netflix_titles
group by rating
order by total_titles desc limit 1

/* 3.Find the average duration of movies and TV shows separately.*/
select round(avg(case when type = 'TV Show' then duration end),2) as TV_show_duration,
       round(avg(case when type = 'Movie' then duration end),2) as Movie_duration from netflix_titles
       select duration from netflix_titles
       
 /* 4.List the top 5 most common genres on Netflix */
 select listed_in,count(listed_in) as total_titles from netflix_titles
group by listed_in
order by total_titles desc limit 5

/* 5.Find the number of movies and TV shows released each year, sorted by year in descending order.*/
select release_year,count(case when type = 'TV Show' then 1 end) as TV_show_Count,
       count(case when type = 'Movie' then 1 end) as Movie_Count from netflix_titles
       group by release_year
       order by release_year desc
       
/* 6.Identify the top 10 directors with the most content on Netflix.*/
select director, count(type) as total_content from netflix_titles
group by director
order by total_content desc limit 10

/*7.Find the country that has produced the most Netflix content.*/
select country, count(type) as total_content from netflix_titles
where country != 'N/A'
group by country
order by total_content desc limit 1 

/*8.List all titles that were released in the last 5 years.*/
select title, release_year from netflix_titles
where release_year >= year(current_date) - 5
order by release_year desc

/*9.Find the percentage of content that is movies versus TV shows.*/
select round(100*(count(case when type = 'TV Show' then 1 end))/count(type),2) as TV_show_percent,
       round(100*(count(case when type = 'Movie' then 1 end))/count(type),2) as Movie_percent from netflix_titles
       where type is not null

/*10.List all TV shows that have more than 5 seasons.*/
select type as Tv_show, duration from netflix_titles
where type = 'TV Show' and duration > 5

/*11.Rank countries based on the number of Netflix titles produced using a window function.*/
 with cte as (select country, count(type) as total_content from netflix_titles
where country != 'N/A'
group by country
order by total_content desc )
select country,total_content, rank() over(order by total_content desc ) as content_rank from cte

/*12.Find the genre that has the highest average duration (for movies).*/
select listed_in,round(avg(duration),2) as movie_duration_avg from netflix_titles
where type = 'Movie' 
group by listed_in 
order by movie_duration_avg desc

/*13.Find the year with the highest number of new content additions to Netflix.*/
select substring(date_added, -4)as year_added, count(*) as total_content_added from netflix_titles
where date_added is not null
group by substring(date_added, -4)
order by total_content_added desc

/*14.Identify directors who have worked in multiple genres and list the genres.*/
select director,listed_in,count(distinct listed_in) as total_projects from netflix_titles
where director != 'N/A' 
group by director,listed_in
having count(distinct listed_in) > 1





 
 
 
 
 
       