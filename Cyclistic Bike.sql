/* Union all to merge tables */
SELECT * 
FROM [Capstone Project ].[dbo].[202111-divvy-tripdata]
UNION 
SELECT * 
FROM [Capstone Project ].[dbo].[202112-divvy-tripdata]
UNION 
SELECT * 
FROM [Capstone Project ].[dbo].[202201-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202202-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202203-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202204-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202205-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202206-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202207-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202208-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202209-divvy-tripdata]
UNION
SELECT * 
FROM [Capstone Project ].[dbo].[202210-divvy-tripdata];


/* Create single Capstone Table */
create table Cyclistic_Project (
ride_id nvarchar (50),
rideable_type nvarchar(50),
start_station_name nvarchar(max),
end_station_name nvarchar(max),
member_casual nvarchar (50),
started_date date,
started_time time(7),
ended_date date,
ended_time time(7),
ride_length time(7),
ride_length_secs real,
weekday_started tinyint,
weekday_ended tinyint 
)

/* Insert the table combinaions into one table I can work with */
INSERT INTO Cyclistic_Project
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended 
FROM [Capstone Project ].[dbo].[202111-divvy-tripdata]
UNION 
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202112-divvy-tripdata]
UNION 
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202201-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202202-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202203-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202204-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202205-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202206-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202207-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202208-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202209-divvy-tripdata]
UNION
SELECT ride_id, rideable_type, start_station_name, end_station_name, member_casual, started_date, started_time, ended_date, ended_time, ride_length, ride_length_secs, weekday_started, weekday_ended  
FROM [Capstone Project ].[dbo].[202210-divvy-tripdata];

/* Sample view of the table */
SELECT TOP 15 *
FROM Cyclistic_Project;

/* No of rides */
SELECT rideable_type, 
COUNT(ride_id) AS no_of_user_types
FROM Cyclistic_Project
GROUP BY rideable_type
ORDER BY no_of_user_types DESC;        /* Electric_bike (2,858,450), Classic_bike (2,635,781), Docked_bike (181,586)*/

/* Most patronized bike types by user type */
SELECT rideable_type AS bike_type,
member_casual AS user_type,
COUNT(ride_id) AS no_of_rides
FROM Cyclistic_Project
GROUP BY rideable_type, member_casual
ORDER BY no_of_rides DESC;     /* Members - Classic_bike(1,739,447), Electric_bike(1,612,899) 
                                  Casuals - Classic_bike(896,334), Electric_bike(1,245,551), Docked_bike(181,586) */

/* Average length of ride in seconds for each user type */
SELECT member_casual AS user_type,
ROUND (AVG(ride_length_secs), 2) AS avg_ride_length_secs
FROM Cyclistic_Project
GROUP BY member_casual;        /* Average - Members (521.55), Casuals (680.21) */

/* Most active days for each user type */
SELECT member_casual AS user_type,
weekday_started AS day_of_week,
COUNT(weekday_started) AS no_of_rides_perday
FROM Cyclistic_Project
GROUP BY member_casual, weekday_started
ORDER BY no_of_rides_perday DESC; /* Members (5), Casuals (7) */

/* Max ride length for each user type */
SELECT member_casual AS user_type,
MAX(ride_length_secs) AS max_length
FROM Cyclistic_Project
GROUP BY member_casual;        /* Members (69,947), Casuals (84,509) */

/* How many rides got started and ended immeidately? */
SELECT member_casual AS user_type, 
COUNT(ride_id) AS no_of_unused_rides
FROM (SELECT *
FROM Cyclistic_Project
WHERE (started_time = ended_time) AND (start_station_name IS NOT NULL) and (end_station_name IS NOT NULL)) AS rides
GROUP BY member_casual
ORDER BY no_of_unused_rides DESC;  /* Members (4,373), Casuals (908) */

/* Top 10 stations with the most immediate cancellations */
SELECT TOP 10 start_station_name AS station_name,
COUNT(ride_id) AS no_of_unused_rides
FROM (SELECT *
FROM [Cyclistic_Project]
WHERE (started_time = ended_time) AND (start_station_name IS NOT NULL) AND (end_station_name IS NOT NULL)) AS rides
GROUP BY start_station_name
ORDER BY no_of_unused_rides DESC;   

/* Stations favored most for start & end of trips for both user types */
SELECT start_station_name, 
member_casual AS user_type,
COUNT (ride_id) AS no_of_rides_per_station
FROM Cyclistic_Project
WHERE start_station_name IS NOT NULL
GROUP BY start_station_name, member_casual
ORDER BY no_of_rides_per_station DESC;     
SELECT end_station_name,
member_casual AS user_type,
COUNT (ride_id) AS no_of_rides_per_station
FROM Cyclistic_Project
WHERE end_station_name IS NOT NULL
GROUP BY end_station_name, member_casual
ORDER BY no_of_rides_per_station DESC;        

/* Trips by time of day */
SELECT started_time, 
ended_time,
CASE WHEN CAST(started_time AS TIME) BETWEEN '05:00:00' AND '23:00:00' THEN 'Day' ELSE 'Night' 
END AS day_night_category1,
CASE WHEN CAST(ended_time AS TIME) BETWEEN '05:00:00' AND '23:00:00' THEN 'Day' ELSE 'Night' 
END AS day_night_category2
FROM Cyclistic_Project

/* Trips which began at night */
WITH temp_table1 AS 
(SELECT started_time, ended_time, started_date, ended_date,
CASE WHEN CAST(started_time AS TIME) BETWEEN '05:00:00' AND '23:00:00' THEN 'Day' ELSE 'Night' 
END AS day_night_category1,
CASE WHEN CAST(ended_time AS TIME) BETWEEN '05:00:00' AND '23:00:00' THEN 'Day' ELSE 'Night' 
END AS day_night_category2
FROM Cyclistic_Project)
SELECT COUNT (*) AS period_count
FROM temp_table1
WHERE day_night_category1 = 'Day'    /* The no of day & night trips are 5,355,575 & 320,242 respectively */ 

