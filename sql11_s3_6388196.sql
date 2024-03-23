-- Name: Sasima Srijanya
-- Student ID: 6388196 
-- ////////////////////////

USE MovieTesting;

-- Q1) Show all title of movies and runtime in the database that have a runtime of over 2 hours?
SELECT title, runtime
FROM movies
WHERE HOUR(runtime) >= '02:00:00';

-- Q2) Write a query to show name and id of the actor who played the character "Jenny Curran" in the movie "Forrest Gump"? 
SELECT actors.actor_id, name
FROM actors JOIN movie_cast ON actors.actor_id = movie_cast.actor_id
JOIN movies ON movies.movie_id = movie_cast.movie_id
WHERE movies.title = "Forrest Gump" AND movie_cast.character_name = "Jenny Curran";

-- Q3) Write a sql command to show movie_id, title, and release_date of all movies that release before 2009;
SELECt movie_id, title, release_date
FROm movies
WHERE YEAR(release_date) < 2009;

-- Q4) Write a sql command to calculate average age of all actors in the database. 
SELECT AVG((YEAR(NOW()) - YEAR(birthdate))) as average_age
FROM actors;

-- Q5) Write a sql command to find average runtime of all movies in the database.
SELECT SEC_TO_TIME(AVG(TIME_TO_SEC(runtime))) as average_runtime
FROM movies;

DROP TABLE Q1;
-- Q6) 
-- 6.1) Write a query to create table Q1 with the following fields userId char(36), firstName nvarchar(20), lastName nvarchar(20)
CREATE TABLE Q1 (
   userId char(36),
   firstName nvarchar(20),
   lastName nvarchar(20)
);

-- 6.2) Write two queries to insert you and your friend data into table Q1 with a random generate on userId. (using UUID_SHORT()) 
INSERT INTO Q1 VALUES
(UUID_SHORT(), 'Poomrapee', 'Wareeboutr'),
(UUID_SHORT(), 'Pitchaya', 'Teerawongpairoj');

-- 6.3) From Q1, select firstname, lastname and present these data in one column called fullname with a single space between them, 
-- as well as, count total characterstotal characters of fullname.
SELECT CONCAT(firstName, ' ', lastname) as fullname, CHAR_LENGTH(CONCAT(firstName, ' ', lastname)) as total_characters
FROM Q1;

-- 6.4) Write a query to create table Q2 with the following fields Uname nvarchar(32), Upass binary(64).
CREATE TABLE Q2 (
  Uname nvarchar(32),
  Upass binary(64)
);

-- 6.5) Write a query to insert your username e.g., uxx88xxx and password ‘123456’ data into table
-- Q2. To insert into a password field, you need to encode it first using HASH function with MD5 encoding format
INSERT INTO Q2 VALUES
('u6388196', MD5('123456'));

CREATE TABLE my_table (
id INT(11) NOT NULL AUTO_INCREMENT,
name VARCHAR(50) NOT NULL,
is_active BOOLEAN NOT NULL DEFAULT FALSE,
PRIMARY KEY (id)
);
INSERT INTO my_table (name, is_active) VALUES ('My Item', TRUE);
INSERT INTO my_table (name, is_active) VALUES ('My Item', 1);
INSERT INTO my_table (name, is_active) VALUES ('My Item');