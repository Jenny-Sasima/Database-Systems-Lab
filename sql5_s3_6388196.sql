/* ---------------------------------------------- 
|	Student ID: 6388196								|
|	Name: Sasima Srijanya										|
   ---------------------------------------------*/

USE classicmodels;

-- Q1: How many customers are located in NYC?
SELECT COUNT(city) as 'NYC Customers'
FROM customers
WHERE city = 'NYC';

-- Q2: What is the average amount of the payment and the standard deviation of 
-- the payments occurred in the third quarter of the year?
-- Note: Third quarter of every year is from 1 July – 30 September
SELECT AVG(amount) as avgPayment, STDDEV(amount) as stdPayment
FROM payments
WHERE QUARTER(paymentDate) = 3;

-- Q3: How many limited company customers that are under the responsibility of 
-- the sale representative named, 'Leslie Jennings'
-- Note: 'Ltd.' used in the name of a company indicates a limited company
SELECT COUNT(customerName) as numLtdComp
FROM customers as c INNER JOIN employees as e ON c.salesRepEmployeeNumber = e.employeeNumber
WHERE customerName LIKE '%Ltd%' AND e.lastName = 'Jennings' AND e.firstName = 'Leslie';

-- Q4: Show the number of offices located in each country, ordered by country names
SELECT country, COUNT(officeCode) as numOffices
FROM offices
GROUP BY country
ORDER BY country;

-- Q5: List all sale managers (employee number, full name, job title) and their subordinate sale representatives under their supervision.
-- Note: The attribute 'reportsTo' shows the recursive relationship. 
-- The value indicates the employee number of their manager that he/she reports to.
SELECT e1.employeeNumber, CONCAT(e1.firstName, ' ', e1.lastName) as fullname, e1.jobTitle, COUNT(e2.employeeNumber) as numSubEmp
FROM employees as e1 LEFT JOIN employees as e2 ON e1.employeeNumber = e2.reportsTo
WHERE e1.jobTitle LIKE '%Manager%'
GROUP BY e1.jobTitle;


-- Q6: Calculate the average of the price difference between 'MSRP' and 'buyPrice' of each product line
-- The result must include the name of the product line and its average difference price, sorted from the highest to lowest difference value.
SELECT productLine, ROUND(AVG(MSRP - buyPrice), 2) as avgDiff
FROM products
GROUP BY productLine
ORDER BY avgDiff DESC;

-- Q7: Show the list of the product lines that have the number of the products at least 10 but not more than 20 products. 
-- The result must include the name of the product line, the total numbers of the products and the range of MSRP per product line,
-- sorted by the name of product line
-- Note: The range of MSRP is calculated from the difference of the maximum and the minimum MSRP value
SELECT productLine, COUNT(productLine) as numprod, MAX(MSRP)-MIN(MSRP) as rangeMSRP
FROM products 
GROUP BY productLine
HAVING numprod >= 10 AND numprod <= 20
ORDER BY rangeMSRP DESC;

-- Q8: Show the top 3 most sold product (judged by the total number of quantity ordered) of the 'Ships' product line.
-- The result must include the product code, the product name, the total number of quantity ordered and the total amount of sales
-- (calculated by the quantity ordered multiplied by the price)
SELECT p.productCode, p.productName, SUM(o.quantityOrdered) as totalQuantity, SUM(o.quantityOrdered* o.priceEach) as totalSales
FROM products as p INNER JOIN orderdetails as o ON p.productCode = o.productCode
WHERE p.productLine = 'Ships'
GROUP BY productCode
ORDER BY totalQuantity DESC
LIMIT 3;







