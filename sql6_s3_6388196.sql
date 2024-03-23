/* ---------------------------------------------- 
|	Student ID: 6388196								|
|	Name: Sasima Srijanya										|
   ---------------------------------------------*/

USE classicmodels;

-- Q1: Find the total numbers of quantity ordered per product line for the complete order, 
-- sorted the results from the highest numbers to the lowest ones. 
-- Note: the complete order is considered from the order with the status 'Shipped'.
SELECT p.productline, SUM(o.quantityOrdered) as QuantityOrdered
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
JOIN orders ON orders.orderNumber = o.orderNumber
WHERE orders.status = 'Shipped'
GROUP BY p.productline
ORDER BY QuantityOrdered DESC;

-- Q2: Calculate the amount of loss (cancelled) values per product of the 'Ships' product line for all 'Cancelled' orders. 
-- Note: the amount of values is calculated from the quantity ordered multiplied by its price)
SELECT p.productCode, p.productName, SUM(o.quantityOrdered * o.priceEach) as 'Amount of Cancelled Values'
FROM products as p JOIN orderdetails as o ON p.productCode = o.productCode
JOIN orders ON orders.orderNumber = o.orderNumber
WHERE p.productline = 'Ships' AND orders.status = 'Cancelled'
GROUP BY p.productCode
ORDER BY p.productCode;

-- Q3: List the products (code and name) that have never been sold
SELECT p.productCode, p.productName
FROM products as p LEFT JOIN orderdetails as o ON p.productCode = o.productCode
WHERE o.orderNumber IS NULL
GROUP BY p.productCode;

-- Q4: List the customers who made the orders with the product line 'Classic Cars' more than 3 times in total, 
-- sorted the result by the number of times from the highest values to the lowest ones.
-- Hint: the number of times they ordered can be counted from the unique order numbers
SELECT c.customerName, COUNT(DISTINCT(orders.orderNumber)) as timesorders
FROM customers as c JOIN orders ON c.customerNumber = orders.customernumber
JOIN orderdetails ON orderdetails.orderNumber = orders.orderNumber
JOIN products as p ON p.productCode = orderdetails.productCode
WHERE p.productline = 'Classic Cars'
GROUP BY c.customerName
HAVING timesorders > 3
ORDER BY timesorders DESC;

-- Q5: List the top 3 customers outside USA and their payment statistics (the total number of payment checks, 
-- the total amount of payments, and the average amount of payments)
SELECT c.customerName, c.country, COUNT(p.checkNumber) as TotalNumCheck, SUM(p.amount) as TotalAmtPaid, AVG(p.amount) as AvgPaid
FROM customers as c JOIN payments as p ON c.customerNumber = p.customerNumber
WHERE NOT c.country = 'USA'
GROUP BY c.customerName
ORDER BY TotalAmtPaid DESC
LIMIT 3;

-- Q6: List the German customers who made the orders not more than 3 times in total, 
-- sorted the result by the customer's name alphabetically.
SELECT customerName, COUNT(ordernumber) as numOrders
FROM customers as c LEFT JOIN orders as o ON c.customerNumber = o.customerNumber
WHERE country = 'Germany'
GROUP BY customerName
HAVING numOrders < 3
ORDER BY customerName;

-- Q7: List the locations of US customers (city, state) of the employee and 
-- their corresponding sale representatives’ office location (city, state)
SELECT DISTINCT CONCAT(c.city, ',', c.state) as "Customer's Location", CONCAT(o.city, ',', o.state) as "Sale Rep's location"
FROM customers as c JOIN employees as e ON c.salesRepEmployeeNumber = e.employeeNumber
JOIN offices as o ON o.officeCode = e.officeCode
WHERE c.country = 'USA' AND o.country = 'USA'
ORDER BY c.city;

-- Q8: List all combinations of the 'sales representative employees who work in USA office and all US customers
-- Hint: There are 36 US customers and 6 sales representatives located in USA
SELECT DISTINCT CONCAT(e.firstName, ' ', e.lastName) as SalesRep, CONCAT(o.city, ',', o.state) as "Sale location", c.customerName, CONCAT(c.city, ',', c.state) as "Customer's Location"
FROM employees as e JOIN offices as o ON e.officeCode = o.officeCode
CROSS JOIN customers as c 
WHERE o.country = 'USA' AND c.country = 'USA' AND e.jobTitle = 'Sales Rep';











