CREATE DATABASE hackerhero_practice;
USE hackerhero_practice;
SET sql_mode="";
--  1. What's the query for creating this new database table with the fields above?
CREATE TABLE users (
id INT NOT NULL AUTO_INCREMENT UNIQUE,
first_name VARCHAR(255),
last_name VARCHAR(255),
email VARCHAR(255),
encrypted_password VARCHAR(255),
created_at DATETIME DEFAULT NOW(),
updated_at DATETIME DEFAULT NOW() ON UPDATE NOW(),
PRIMARY KEY (id)
);
-- 2. What's the query for inserting new records into this table? Write queries for inserting three fake users into the table (one query for each insert).
INSERT INTO 
	users(first_name, last_name, email, encrypted_password)
VALUES
	("Ted","Bataller","ted_email@gmail.com",MD5("pasword123"));
INSERT INTO 
	users(first_name, last_name, email, encrypted_password)
VALUES
	("Michael","Choi","michael_email@gmail.com",MD5("pasword654"));
INSERT INTO 
	users(first_name, last_name, email, encrypted_password)
VALUES
    ("Sample","User","sample_email@gmail.com",MD5("password999"));
-- 3. What's the query for updating one of the user records?  For example, if you wanted to update the user record for id = 1, with some fake data, what would the query be?
UPDATE users
SET first_name = "Jordan"
WHERE id = 1;
-- 4. What query would you run for updating all of the user records with the last_name of 'Choi'?
UPDATE users
SET first_name = "Mike"
WHERE last_name = "Choi";
-- 5. What query would you run for updating all the user records where ID is 3, 5, 7, 12, or 19?
UPDATE users
SET first_name = "Halou"
WHERE id IN (3,5,7,12,19);
-- 6. What's the query for deleting a user record where id = 1?
DELETE FROM users
WHERE id = 1;
-- 7. What's the query for deleting the entire users records in the users table?
DELETE FROM users;
-- 8. What's the query for dropping the entire users table?  What's the difference between dropping the table and deleting all records?
DROP TABLE users;
-- 9. What's the query for altering the email field to have it be 'email_address' instead?
ALTER TABLE users
RENAME COLUMN email TO email_address;
-- 10. What's the query for altering the id so that it's a BIGINT instead?
ALTER TABLE users
MODIFY id BIGINT NOT NULL AUTO_INCREMENT UNIQUE;
-- 11. What's the query for adding a new field to the users table called is_active where it's a Boolean (meaning it's either a 0 or a 1).  Imagine you wanted the default value of this to be 0 when a new record is created and you won't allow this field to ever be NULL.  With this in mind, now come up with a query.
ALTER TABLE users
ADD is_active BOOLEAN DEFAULT 0 NOT NULL;