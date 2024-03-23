-- Name: Sasima Srijanya
-- Student-ID: 6388196
-- /////////////////////////////

USE premierproducts;

-- Q1) Create a stored procedure, named “sp_Customer_Order”
-- that takes as inputs two parameters: an order date (@date) and a
-- minimum amount of orders (@orderCount).
DROP PROCEDURE sp_Customer_Order;

DELIMITER //
CREATE PROCEDURE sp_Customer_Order (
-- Add parameters for the stored procedure here
IN order_date DATE,
IN order_amount INTEGER
)
BEGIN
-- Insert statements for procedure here
SELECT orders.OrderNum, OrderDate, SUM(NumOrdered) as TotalOrders, 
	(SELECT SUM(NumOrdered*QuotedPrice) as TotalPrice
	FROM orderline o2
    WHERE o1.OrderNum = o2.OrderNum
    GROUP BY OrderNum) as TotalPrice, CustomerNum
FROM orders JOIN orderline o1 ON orders.OrderNum = o1.OrderNum
WHERE DATE(OrderDate) = order_date
GROUP BY orders.OrderNum
HAVING TotalOrders >= order_amount;
END //
DELIMITER ;   
   
CALL sp_Customer_Order('2010-10-21', 1);

-- Q2) Create a stored procedure named “sp_Orders_By_Customer “
-- that takes a customer number (@customerNum) as input and
-- returns a list of orders for that customer.  
DROP PROCEDURE sp_Orders_By_Customer;

DELIMITER //
CREATE PROCEDURE sp_Orders_By_Customer (
-- Add parameters for the stored procedure here
IN cus_id INTEGER
)
BEGIN
-- Insert statements for procedure here
SELECT orders.OrderNum, OrderDate, SUM(NumOrdered) as TotalPartsOrders, 
	(SELECT SUM(NumOrdered*QuotedPrice) as TotalPrice
	FROM orderline o2
    WHERE o1.OrderNum = o2.OrderNum
    GROUP BY OrderNum) as TotalPrice
FROM orders JOIN orderline o1 ON orders.OrderNum = o1.OrderNum
WHERE CustomerNum = cus_id 
GROUP BY orders.OrderNum;
END //
DELIMITER ;

CALL sp_Orders_By_Customer(148);

-- Q3) Write a MySQL function named “update_rep” that takes two arguments:
-- old_rep_num and new_rep_num. The function should update the Rep table to
-- change the RepNum value from old_rep_num to new_rep_num. It should also
-- update the Customer and CurrentOrders tables to reflect the change. If
-- old_rep_num does not exist in the Rep table, the function should return false
-- (0). Otherwise, it should return true (1).
DROP FUNCTION update_rep;

DELIMITER //
CREATE FUNCTION update_rep(old_rep_num INTEGER, new_rep_num INTEGER)
RETURNS INTEGER
DETERMINISTIC
BEGIN
	-- function logic goes here
	DECLARE resultValue INTEGER;
    IF exists(SELECT * FROM rep WHERE RepNum = old_rep_num) THEN
		SET resultValue = 1;
        SET foreign_key_checks = 0;
		UPDATE rep
			SET RepNum = new_rep_num
			WHERE RepNum = old_rep_num;
		UPDATE currentorders
			SET RepNum = new_rep_num
			WHERE RepNum = old_rep_num;
		UPDATE customer
			SET RepNum = new_rep_num
			WHERE RepNum = old_rep_num;
		SET foreign_key_checks = 1;
	ELSE
		SET resultValue = 0;
	END IF;
	RETURN resultValue;
END;//
DELIMITER ;

SET @getReturn = update_rep(20, 999);
SELECT @getReturn; 