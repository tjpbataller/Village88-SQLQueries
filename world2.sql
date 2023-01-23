-- SET sql_mode=(SELECT REPLACE(@@sql_mode,'ONLY_FULL_GROUP_BY',''));
USE world;
SET sql_mode="";
-- 1. How many countries in each continent, have life expectancy greater than 70?
SELECT continent, count(*) AS total_countries, LifeExpectancy
FROM country
WHERE LifeExpectancy > 70
GROUP BY continent;
-- 2. How many countries in each continent have life expectancy between 60 and 70?
SELECT continent, count(*) AS total_countries, LifeExpectancy
FROM country
WHERE LifeExpectancy BETWEEN 60 AND 70
GROUP BY continent;
-- 3. How many countries have life expectancy greater than 75?
SELECT name, LifeExpectancy
FROM country
WHERE LifeExpectancy > 75;
-- 4. How many countries have life expectancy less than 40?
SELECT name, LifeExpectancy
FROM country
WHERE LifeExpectancy < 40;
-- 5. How many people live in the top 10 countries with the most population?
SELECT name, population
FROM country
ORDER BY population desc
LIMIT 10;
-- 6. According to the world database, how many people are there in the world?
SELECT sum(population) as total_population
FROM country;
-- 7. Show results for continents where it shows the continent name and the total population.  Only show results where the total_population for the continent is more than 500,000,000.
-- If. the continent doesn't have 500,000,000 people, do NOT show the result.
SELECT continent, sum(population) AS total_population
FROM country
GROUP BY continent
HAVING total_population > 500000000;
-- 8. Show results of all continents that has average life expectancy for the continent to be less than 71.
--    Show each of these continent name, how many countries there are in each of the continent, total population for the continent, as well as the life expectancy of this continent.
--    For example, as Europe and North America both have continent life expectancy greater than 71, these continents shouldn't show up in your sql results.
SELECT continent, count(name) AS country, sum(population) AS total_population, avg(lifeexpectancy) AS life_expectancy
FROM country
GROUP BY continent
HAVING life_expectancy < 71;

-- 1. How many cities are there for each of the country?  Show the total city count for each country where you display the full country name.
SELECT country.name AS country, count(city.name) AS number_of_cities
FROM country
LEFT JOIN city ON country.code = city.countrycode
GROUP BY country;
-- 2. For each language, find out how many countries speak each language.
SELECT country.name AS country, countrylanguage.language AS language, count(country.name) AS number_of_countries
FROM country
INNER JOIN countrylanguage ON country.code = countrylanguage.countrycode
GROUP BY language;
-- 3. For each language, find out how many countries use that language as the official language.
SELECT countrylanguage.language AS language, count(country.name) AS total_countries, countrylanguage.isofficial AS isofficial
FROM country
INNER JOIN countrylanguage ON countrylanguage.countrycode = country.code
WHERE countrylanguage.isofficial = "T"
GROUP BY language;
-- 4. For each continent, find out how many cities there are (according to this database) and the average population of the cities for each continent.
--    For example, for continent A, have it state the number of cities for that continent, and the average city population for that continent.
SELECT country.continent, count(city.name) AS total_cities, avg(city.population) AS average_cities_population
FROM country
INNER JOIN city
ON country.code = city.countrycode
GROUP BY continent;
-- 5. (Advanced) Find out how many people in the world speak each language.  Make sure the total sum of. this number is comparable to the total population in the world.
SELECT countrylanguage.language AS language, SUM((country.population*countrylanguage.percentage)/100)  AS total_per_country
FROM country
INNER JOIN countrylanguage ON  countrylanguage.countrycode = country.code
GROUP BY language
ORDER BY total_per_country DESC;