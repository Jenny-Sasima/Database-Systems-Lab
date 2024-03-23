-- Student ID: u6388196
-- Student Name: Sasima Srijanya

USE premierproducts;
DROP VIEW vwCustomerRep;
DROP VIEW vwTotalOrder_Customer;

-- Q1) Create a new view named "vwCustomerRep" This view contains 5 columns: Customer Number, Customer Name, 
-- Zip code, firstname and lastname of the sale representative who supports that customer. 
CREATE VIEW vwCustomerRep
AS
SELECT CustomerNum, CustomerName, c.Zip, FirstName as RepFName, LastName as RepLName
FROM customer c JOIN rep r ON c.repNum = r.repNum
ORDER BY CustomerNum;

SELECT * FROM vwCustomerRep;

-- Q2)  Alter the view named "vwCustomerRep"
-- To include two more fields: Commission, and Rate
ALTER VIEW vwCustomerRep
AS
SELECT CustomerNum, CustomerName, c.Zip, FirstName as RepFName, LastName as RepLName, Commision, Rate
FROM customer c JOIN rep r ON c.repNum = r.repNum
ORDER BY CustomerNum;

SELECT * FROM vwCustomerRep;

-- Q3)  Create a new view named "vwTotalOrder_Customer"
-- This view count the total number of orders each customer made
CREATE VIEW vwTotalOrder_Customer
AS
SELECT c.CustomerNum, c.CustomerName, COUNT(orderNum) as Totalorders
FROM customer c JOIN orders o ON c.CustomerNum = o.CustomerNum
GROUP BY o.CustomerNum
ORDER BY CustomerNum;

SELECT * FROM vwTotalOrder_Customer;