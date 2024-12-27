create database Netflix;
use Netflix;

select * from movies;
select * from dates;

/* Que 1. What are the top 5 oldest movies in the database?*/
select top 5 Title
from dates order by Release_Date;

/*Que 2. How many movies were released in each year present in database?*/
SELECT YEAR(Release_Date) AS Release_Year, COUNT(Title) AS movie_count FROM Dates
GROUP BY YEAR(Release_Date);

/*Que 3. Which movies have the same directors?*/
select Director,STRING_AGG(Title,', ') as Title from Movies
group by Director having count(Director) >1
order by Director;

/* Que 4. Which actors have appeared in the most movies in database?*/
SELECT top 1 COUNT(actor) AS Movie_count, actor
FROM (SELECT TRIM(value) AS actor FROM movies CROSS APPLY STRING_SPLIT(cast, ',')) AS actors
GROUP BY actor
ORDER BY movie_count DESC;


/*Que 5. What are the top 5 highest durations for movies, and their respective type?*/
SELECT TOP 5 type,CAST(LEFT(duration, LEN(duration) - 4) AS INT) AS duration
FROM Dates
ORDER BY duration DESC;

/* Que 6. List the movies and directors for all movies with a duration longer than the average movie duration*/
SELECT m.Title, m.Director, CAST(LEFT(d.Duration, LEN(d.Duration) - 4) AS INT) as Dur
FROM Movies m
join Dates d on m.Show_Id=d.Show_Id
WHERE d.Show_Id IN (SELECT Show_Id FROM Dates WHERE CAST(LEFT(duration, LEN(duration) - 4) AS INT) > (SELECT AVG(CAST(LEFT(duration, LEN(duration) - 4) AS INT)) FROM Dates))
order by Dur desc;

/*• Que 7. Which type of movies mostly released in 2018?*/
SELECT top 1 YEAR(release_date) as year,trim(value) AS Type1
FROM Dates CROSS APPLY STRING_SPLIT(Type, ',') as type1
where YEAR(release_date) = 2018
GROUP BY YEAR(Release_Date), trim(value)
order by COUNT(*) DESC;