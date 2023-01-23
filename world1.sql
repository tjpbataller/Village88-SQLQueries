USE world;
SET sql_mode="";
-- 1. Get all the list of countries that are in the continent of Europe
SELECT * FROM country
WHERE continent = 'Europe';
-- 2. Get all the list of countries that are in the continent of North America and Africa
SELECT * FROM country
WHERE continent IN ('North America','Africa');
-- 3. Get all the list of cities that are part of a country with population greater than 100 millions.
SELECT country.code AS country_code, country.name AS country_name, country.continent, country.population AS country_population, city.name AS city FROM country
LEFT JOIN city ON country.code = city.countrycode
WHERE country.population > 100000000;
-- 4. Get all the list of countries (display the full country name) who speak 'Spanish' as their language
SELECT country.name AS country, countrylanguage.language AS language FROM country
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language = "Spanish";
-- 5. Get all the list of countries (display the full country name) who speak 'Spanish' as their official language
SELECT country.name AS country, countrylanguage.language AS language, countrylanguage.IsOfficial AS isofficial FROM country
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language = "Spanish" AND countrylanguage.isofficial = "T";
-- 6. Get all the list of countries (display the full country name) who speak either 'Spanish' or 'English' as their official language
SELECT country.name AS country, countrylanguage.language AS language FROM country
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language IN ("Spanish", "English") AND countrylanguage.isofficial = "T";
-- 7. Get all the list of countries (display the full country name) where 'Arabic' is spoken by more than 30% of the population but where it's not the country's official language.
SELECT country.name AS country, countrylanguage.language AS language, countrylanguage.percentage AS percentage, countrylanguage.IsOfficial AS isofficial FROM country
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language = "Arabic" AND countrylanguage.isofficial = "F" AND countrylanguage.percentage > 30;
-- 8. Get all the list of countries (display the full country name) where 'French' is the official language but where less than 50% of the population in that country actually speaks that language.
SELECT country.name AS country, countrylanguage.language AS language, countrylanguage.IsOfficial AS isofficial, countrylanguage.percentage AS percentage FROM country
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language = "French" AND countrylanguage.isofficial = "T" AND countrylanguage.percentage < 50;
-- 9. Get all the list of countries (display the full country name and the full language name) and their official language.  Order the result so that those with the same official language are shown together.
SELECT country.name AS country, countrylanguage.language AS language, countrylanguage.IsOfficial AS isofficial FROM country
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.isofficial = "T"
ORDER BY countrylanguage.language ASC;
-- 10. Get the top 100 cities with the most population.  Display the city's full country name also as well as their official language.
SELECT country.name AS country, city.name AS city, countrylanguage.language AS language, countrylanguage.IsOfficial AS isofficial FROM country
INNER JOIN countrylanguage ON country.code = countrylanguage.countrycode
INNER JOIN city ON country.code = city.countrycode
WHERE countrylanguage.isofficial = "T"
ORDER BY city.population DESC LIMIT 100;
-- 11. Get the top 100 cities with the most population where the life_expectancy for the country is less than 40.
SELECT country.name AS country, country.LifeExpectancy as lifeexpectancy, city.name AS city,  city.population AS population FROM country
LEFT JOIN city ON country.code = city.countrycode
WHERE country.lifeexpectancy < 40
ORDER BY city.population DESC;
-- 12. Get the top 100 countries who speak English and where life expectancy is highest.  Show the country with the highest life expectancy first.
SELECT country.name AS country, city.name AS city, country.lifeexpectancy AS lifeexpectancy FROM country
LEFT JOIN city ON country.code = city.countrycode
LEFT JOIN countrylanguage ON country.code = countrylanguage.countrycode
WHERE countrylanguage.language = "english"
ORDER BY country.lifeexpectancy DESC LIMIT 100;