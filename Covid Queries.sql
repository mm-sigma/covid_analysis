COPY covid(provience, country, latitude, longitude, dates, confirmed, deaths, recovered)
FROM 'S:\PROJECT\Mentorness SQL Corona Virus\Corona Virus Dataset.csv'
DELIMITER ','
CSV HEADER;


SELECT * FROM covid;


SELECT COUNT(*) AS null_count
FROM covid
WHERE provience IS NULL OR country IS NULL OR latitude IS NULL OR longitude IS NULL OR 
	dates IS NULL OR confirmed IS NULL OR deaths IS NULL OR recovered IS NULL;

UPDATE covid
	SET provience = COALESCE(provience,0),
	SET country = COALESCE(country,0),
	SET latitude = COALESCE(latitude,0),
	SET longitude = COALESCE(longitude,0),
	SET dates = COALESCE(dates,0),
	SET confirmed = COALESCE(confirmed,0),
	SET deaths = COALESCE(deaths,0),
	SET recovered = COALESCE(recovered,0);

	
SELECT COUNT(*) AS row_counts
FROM covid;


SELECT MIN(dates) AS start_dates, MAX(dates) AS end_dates
FROM covid;


SELECT DISTINCT(EXTRACT(MONTH FROM c.dates)) AS months, COUNT(EXTRACT(MONTH FROM c.dates)) AS months_count
FROM covid c
GROUP BY months;


SELECT DISTINCT(EXTRACT(MONTH FROM c.dates)) AS months, COUNT(EXTRACT(MONTH FROM c.dates)) AS months_count,
	AVG(c.confirmed) AS avg_confirmed,
	AVG(c.deaths) AS avg_deaths,
	AVG(c.recovered) AS avg_recovered
FROM covid c
GROUP BY months;


ALTER TABLE covid 
ADD month_name VARCHAR(255);

UPDATE covid
SET month_name =
	CASE
		WHEN EXTRACT(MONTH FROM c.dates) =1 THEN 'Jan'
		WHEN EXTRACT(MONTH FROM c.dates) =2 THEN 'Feb'
		WHEN EXTRACT(MONTH FROM c.dates) =3 THEN 'Mar'
		WHEN EXTRACT(MONTH FROM c.dates) =4 THEN 'Apr'
		WHEN EXTRACT(MONTH FROM c.dates) =5 THEN 'May'
		WHEN EXTRACT(MONTH FROM c.dates) =6 THEN 'Jun'
		WHEN EXTRACT(MONTH FROM c.dates) =7 THEN 'Jul'
		WHEN EXTRACT(MONTH FROM c.dates) =8 THEN 'Aug'
		WHEN EXTRACT(MONTH FROM c.dates) =9 THEN 'Sep'
		WHEN EXTRACT(MONTH FROM c.dates) =10 THEN 'Oct'
		WHEN EXTRACT(MONTH FROM c.dates) =11 THEN 'Nov'
		WHEN EXTRACT(MONTH FROM c.dates) =12 THEN 'Dec'
	END;


SELECT (EXTRACT(YEAR FROM c.dates)) AS years, (EXTRACT(MONTH FROM c.dates)) AS months, confirmed AS most_freq_confirmed, deaths AS most_freq_death, recovered AS most_freq_recovered
FROM covid c


SELECT (EXTRACT(YEAR FROM c.dates)) AS years,
	MIN(c.confirmed) AS min_confirmed,
	MIN(c.deaths) AS min_deaths,
	MIN(c.recovered) AS min_recovered
FROM covid c
GROUP BY years;


SELECT (EXTRACT(YEAR FROM c.dates)) AS years,
	MAX(c.confirmed) AS max_confirmed,
	MAX(c.deaths) AS max_deaths,
	MAX(c.recovered) AS max_recovered
FROM covid c
GROUP BY years;


SELECT DISTINCT(EXTRACT(MONTH FROM c.dates)) AS months,
	SUM(c.confirmed) AS total_confirmed,
	AVG(c.confirmed) AS avg_confirmed,
	VAR_SAMP(c.confirmed) AS var_confirmed,
	STDDEV_SAMP(c.confirmed) AS std_confirmed
FROM covid c
GROUP BY months;




SELECT DISTINCT(EXTRACT(MONTH FROM c.dates)) AS months,
	SUM(c.deaths) AS total_deaths,
	ROUND(AVG(c.deaths),0) AS avg_deaths,
	ROUND(VAR_SAMP(c.deaths),0) AS var_deaths,
	ROUND(STDDEV_SAMP(c.deaths),0) AS std_deaths
FROM covid c
GROUP BY months;

SELECT DISTINCT(EXTRACT(MONTH FROM c.dates)) AS months,
	SUM(c.recovered) AS total_recovered,
	ROUND(AVG(c.recovered),0) AS avg_recovered,
	ROUND(VAR_SAMP(c.recovered),0) AS var_recovered,
	ROUND(STDDEV_SAMP(c.recovered),0) AS std_recovered
FROM covid c
GROUP BY months;


SELECT * FROM covid;
SELECT DISTINCT(country), SUM(confirmed) AS highest_confirmed
FROM covid
GROUP BY country
ORDER BY highest_confirmed DESC
LIMIT 1;


SELECT DISTINCT(country), SUM(deaths) AS lowest_deaths
FROM covid
GROUP BY country
ORDER BY lowest_deaths ASC
LIMIT 1;

SELECT * FROM covid;
SELECT DISTINCT(country), SUM(recovered) AS highest_recovered
FROM covid
GROUP BY country
ORDER BY highest_recovered DESC
LIMIT 5;








