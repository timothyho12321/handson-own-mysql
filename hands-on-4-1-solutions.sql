-- q1
SELECT city,phone,country FROM offices

-- q2
SELECT * FROM orders WHERE comments LIKE '%fedex%'

-- q3
select contactFirstName, contactLastName, customerName FROM customers ORDER BY customerName DESC;

-- q4
SELECT * FROM employees 
WHERE officeCode BETWEEN 1 AND 3
AND (firstName LIKE '%son%' OR lastName LIKE "%son")
AND jobTitle LIKE 'Sales Rep';

-- q5
SELECT * FROM customers JOIN orders
ON customers.customerNumber = orders.customerNumber
WHERE customers.customerNumber = 124;

-- q6
SELECT products.productName, orderdetails.* FROM orderdetails JOIN products ON
	orderdetails.productCode = products.productCode;

-- q7
SELECT customers.customerNumber, customerName, SUM(amount) FROM payments JOIN customers
	ON payments.customerNumber = customers.customerNumber
WHERE country="USA"
GROUP BY customers.customerNumber, customerName;

-- q8
SELECT * FROM customers JOIN orders ON customers.customerNumber = orders.customerNumber
WHERE customers.country = "UK" OR customers.country="USA"

-- q9
SELECT state, COUNT(*) FROM employees JOIN offices
 ON employees.officeCode = offices.officeCode
WHERE country LIKE "USA"
GROUP BY state

-- q10
SELECT MONTH(orderDate), COUNT(*) FROM orders
WHERE YEAR(orderDate) = 2003
GROUP BY MONTH(orderDate)

-- q10 variant: count how many products were ordered by each month
SELECT MONTH(orderdate), COUNT(*) FROM orders JOIN orderdetails
 ON orders.orderNumber = orderdetails.orderNumber
WHERE orderdate BETWEEN "2003-01-01" AND "2003-12-31"
GROUP BY MONTH(orderdate)

-- q11
SELECT AVG(amount), customerName FROM customers JOIN payments
 ON customers.customerNumber = payments.customerNumber
 GROUP BY payments.customerNumber, customerName

-- q12
SELECT productlines.productLine, COUNT(*) FROM
	productlines LEFT JOIN products
	ON products.productLine = productlines.productLine
GROUP BY productlines.productLine
	
-- q13
SELECT customers.customerNumber, customerName, AVG(amount) FROM payments JOIN customers
 ON payments.customerNumber = customers.customerNumber
GROUP BY customers.customerNumber, customerName
HAVING SUM(amount) >= 10000;

-- q14
