-- Name: Sasima Srijanya
-- Student-ID: 6388196
-- /////////////////////////////

USE testtrigger;

-- Q1) Create table LogFileAudit 
CREATE TABLE LogFileAudit (
	LogID     VARCHAR(225) PRIMARY KEY,
	`Action`  VARCHAR(225) NOT NULL,
	TableName VARCHAR(225) NOT NULL
);

-- Q1.1) Create a trigger addLogINS to insert a log data into LogFileAudit after inserting data into the person table.
DROP TRIGGER IF EXISTS addLogINS;

DELIMITER \\
CREATE TRIGGER addLogINS
BEFORE INSERT
ON person
FOR EACH ROW
BEGIN
	DECLARE new_id INT;
    
    IF NOT EXISTS(SELECT * FROM LogFileAudit) THEN 
		SET new_id = 1;
    ELSE
		SELECT MAX(LogID) + 1 FROM LogFileAudit INTO new_id;
    END IF;
    
	INSERT
		INTO LogFileAudit (LogID, `Action`, TableName)
		VALUES (new_id, 'INSERT', 'person');
END; \\
DELIMITER ;

INSERT
INTO person (pid, full_name, budget, proj_id)
VALUES ('011','John Doe', 1000.00, '1');

DELETE FROM person WHERE pid ='011';

-- Q1.2) Create a trigger addLogDEL to insert a log data into LogFileAudit after deleting data from the project table.
DROP TRIGGER IF EXISTS addLogDEL;

DELIMITER \\
CREATE TRIGGER addLogDEL
BEFORE DELETE
ON project
FOR EACH ROW
BEGIN
	DECLARE new_id INT;
    
    IF NOT EXISTS(SELECT * FROM LogFileAudit) THEN 
		SET new_id = 1;
    ELSE
		SELECT MAX(LogID) + 1 FROM LogFileAudit INTO new_id;
    END IF;
    
	INSERT
		INTO LogFileAudit (LogID, `Action`, TableName)
		VALUES (new_id, 'DELETE', 'project');
END; \\
DELIMITER ;

INSERT
INTO project VALUES ('5', 'project 5', 12345.00);

DELETE FROM project WHERE proj_id = '5';

-- Delete in table testtrigger
DELETE FROM LogFileAudit WHERE LogID = '1';

-- Q2)  Create a trigger “cascade_insert” to insert a new record into the project
-- table after inserting a new person into the person table, if the project id does
-- not exist yet in the project table.
DROP TRIGGER IF EXISTS cascade_insert;

DELIMITER \\
CREATE TRIGGER cascade_insert
AFTER INSERT 
ON person
FOR EACH ROW
BEGIN
    IF NOT EXISTS(SELECT * FROM project WHERE proj_id = new.proj_id) THEN 
		INSERT
			INTO project VALUES (new.proj_id, 'UNKNOWN', new.budget);
		END IF;
END; \\
DELIMITER ;

INSERT INTO person (pid, full_name, budget, proj_id) VALUES ('012','Harry Potter', 15000, 5);
DELETE FROM person WHERE pid ='012';