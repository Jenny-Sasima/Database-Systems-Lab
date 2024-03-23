/* ---------------------------------------------- 
|	Student ID: 6388196								|
|	Name: Sasima Srijanya										|
   ---------------------------------------------*/

USE classicmodels;


-- Q1: Find the list of products that are sold to customers in Japan only (Not to Singaporian Customers)
-- ANS of Q1:   28 products 
SELECT DISTINCT p.productCode, p.productName
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
JOIN orders ON o.orderNumber = orders.orderNumber
JOIN customers as c ON c.customerNumber = orders.customerNumber
WHERE p.productCode NOT IN(
	SELECT DISTINCT productCode FROM customers as c
    JOIN orders as o ON o.customerNumber = c.customerNumber
    JOIN orderdetails ON orderdetails.orderNumber = o.orderNumber
    WHERE c.country = 'Singapore') AND country = 'Japan';


-- Q2: Find the list of products that are sold to customers in Singapore only (Not to Japanese customers
-- ANS of Q2:   35 products 
SELECT DISTINCT p.productCode, p.productName
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
JOIN orders ON o.orderNumber = orders.orderNumber
JOIN customers as c ON c.customerNumber = orders.customerNumber
WHERE p.productCode NOT IN(
	SELECT DISTINCT productCode FROM customers as c
    JOIN orders as o ON o.customerNumber = c.customerNumber
    JOIN orderdetails ON orderdetails.orderNumber = o.orderNumber
    WHERE c.country = 'Japan') AND country = 'Singapore';

-- Q3: Find the list of products that are sold to both customers in Japan and Singapore
-- ANS of Q3:   17 products 
SELECT DISTINCT p.productCode, p.productName
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
JOIN orders ON o.orderNumber = orders.orderNumber
JOIN customers as c ON c.customerNumber = orders.customerNumber
WHERE p.productCode IN(
	SELECT DISTINCT productCode FROM customers as c
    JOIN orders as o ON o.customerNumber = c.customerNumber
    JOIN orderdetails ON orderdetails.orderNumber = o.orderNumber
    WHERE c.country = 'Japan') AND country = 'Singapore';

-- Q4: How many of products in total that are sold to customers in Japan and Singapore? 
-- ANS of Q4:   80 products 
SELECT DISTINCT p.productCode, p.productName
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
JOIN orders ON o.orderNumber = orders.orderNumber
JOIN customers as c ON c.customerNumber = orders.customerNumber
WHERE country = 'Singapore'
UNION
SELECT DISTINCT p.productCode, p.productName
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
JOIN orders ON o.orderNumber = orders.orderNumber
JOIN customers as c ON c.customerNumber = orders.customerNumber
WHERE country = 'Japan';

-- Q5: List all contact names and phone numbers of both customers and the employess in one result
SELECT CONCAT(contactFirstname, ' ', contactLastname) as 'Contact Name', phone as 'Phone Number'
FROM customers
UNION
SELECT CONCAT(firstname, ' ', lastname) as 'Contact Name', CONCAT(phone, '-', extension) as 'Phone Number'
FROM employees JOIN offices ON employees.officeCode = offices.officeCode
ORDER BY `Contact Name` ASC;

-- Q6: Select top 3 of the most sold product (judged by the total numbers of quantity ordered) in 
-- the following product lines: Motorcycles, Classic Cars, and Vintage Cars respectively.
(SELECT p.productCode, p.productName, p.productLine, SUM(quantityOrdered) as 'totalQuantityOrdered'
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
WHERE p.productLine = 'Motorcycles'
GROUP BY p.productCode
ORDER BY `totalQuantityOrdered` DESC
LIMIT 3)
UNION
(SELECT p.productCode, p.productName, p.productLine, SUM(quantityOrdered) as 'totalQuantityOrdered'
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
WHERE p.productLine = 'Classic Cars'
GROUP BY p.productCode
ORDER BY `totalQuantityOrdered` DESC
LIMIT 3)
UNION
(SELECT p.productCode, p.productName, p.productLine, SUM(quantityOrdered) as 'totalQuantityOrdered'
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
WHERE p.productLine = 'Vintage Cars'
GROUP BY p.productCode
ORDER BY `totalQuantityOrdered` DESC
LIMIT 3);