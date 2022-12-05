-- q1
SELECT city,phone,country FROM offices

-- q2
SELECT * FROM orders WHERE comments LIKE '%fedex%'

-- q3
select contactFirstName, contactLastName, customerName FROM customers ORDER BY customerName DESC

-- q4
SELECT * FROM employees 
WHERE officeCode BETWEEN 1 AND 3
AND (firstName LIKE '%son%' OR lastName LIKE "%son")
AND jobTitle LIKE 'Sales Rep'

-- q5
SELECT * FROM customers JOIN orders
ON customers.customerNumber = orders.customerNumber
WHERE customers.customerNumber = 124