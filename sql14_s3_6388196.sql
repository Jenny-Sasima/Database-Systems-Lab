-- Name: Sasima Srijanya
-- Student-ID: 6388196
-- /////////////////////// --

USE Transactions;

-- Q0) Create BankAccount table using the following statements 
CREATE TABLE BankAccount (
	AccountNum INT NOT NULL PRIMARY KEY,
	ACC_ID INT NOT NULL,
	AccountBalance DECIMAL(10,2),
	FOREIGN KEY (ACC_ID) REFERENCES accounts(acc_id)
);

-- Q1) Create a store procedure 'AddAccounts’ that insert 3 records as follow (no
-- need to pass parameters). If the records can be inserted, commit the transaction.
-- Otherwise, rollback the transaction.  
DROP PROCEDURE AddAccounts;

DELIMITER //
CREATE PROCEDURE AddAccounts ()
BEGIN
-- Insert statements for procedure here
	IF EXISTS(SELECT * FROM BankAccount)THEN
		ROLLBACK;
        SELECT 'Error';
    ELSE
		INSERT INTO BankAccount
		VALUES (117, 1, 1000.00),
			   (118, 2, 2000.00),
               (119, 3, 500.00);
        COMMIT;
    END IF;    
END //
DELIMITER ;

CALL AddAccounts();
SELECT * FROM BankAccount;

-- Q2)  Create 'TransferMoney' transaction to transfer money from one account to another
-- account using the variables declared below ---> to transfer money ‘550’ from account
-- number 117 to account number 118
DROP PROCEDURE TransferMoney;

DELIMITER //
CREATE PROCEDURE TransferMoney ()
BEGIN
-- Insert statements for procedure here
	SET @from = 117;
	SET @to = 118;
	SET @amount = 550;
    
	IF EXISTS(SELECT * FROM BankAccount WHERE AccountNum = @from AND AccountBalance >= @amount)THEN
		UPDATE BankAccount
		SET AccountBalance = AccountBalance - @amount
		WHERE AccountNum = @from;
		UPDATE BankAccount
		SET AccountBalance = AccountBalance + @amount
		WHERE AccountNum = @to;
        COMMIT;
        SELECT 'SUCCESFULLY TRANSFERED';
    ELSE
        ROLLBACK;
        SELECT 'INSUFFICIENT BALANCE';
    END IF;    
END //
DELIMITER ;

CALL TransferMoney();
SELECT * FROM BankAccount;