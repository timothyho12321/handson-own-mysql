-- get all the columns from all the rows in a table
select * from employees;  -- select all the employees and all the columns

-- select [col1,col2,col3...] from [table name]
select * from offices;

-- select a few specific columns
select firstName, lastName, email from employees;

-- select columns and display them under a differet name
select firstName as "First Name", lastName as "Last Name", email as "Email" from employees;

-- for each row in productLines table
-- display the name of the product line and the textDescription
-- but under the column "Product Line" and "Description"
select productLine as "Product Name",
        textDescription as "Description"
from productlines

-- display only the unique columns in a table
-- eg. show all the job titles but without any duplicates
SELECT DISTINCT jobTitle FROM employees;

-- select rows from a table that meets some criteria
-- eg. select all employees from office code 1
SELECT * FROM employees WHERE officeCode=1;

-- we want to have a list of email and first name, last name of all employees in officeCode 2
SELECT firstName, lastName, email, officeCode FROM employees WHERE officeCode=2;
SELECT firstName AS "First Name", lastName AS "Last Name", email AS "Email", officeCode AS "Office" 
    FROM employees
    WHERE officeCode=2;

-- select all products where the buyPrice is greater than 50
select productCode,productName,buyPrice from products where buyPrice >50

-- select all payments where the amount is greater than 10000
SELECT * FROM payments WHERE amount > 10000;

-- find all emplyoees where the job title is "<anything>Sales"
-- i.e get all employees whose job title end with "sales"
SELECT firstName, lastName, email, jobTitle FROM employees WHERE jobTitle LIKE "%Sales";

-- find all emplyoees where the job title starts with "Sales"
SELECT firstName, lastName, email, jobTitle FROM employees WHERE jobTitle LIKE "Sales%";

-- display all products with the name "Davidson" inside
SELECT * FROM products WHERE productName LIKE "%davidson%";

-- display all products that start with 1969 in the name
select * from products WHERE productName LIKE "1969%"

-- display all sales rep from office code 1
select lastName AS "Last Name", firstName AS "First Name", email as "Email", jobTitle as "Job Title" 
from employees 
WHERE jobTitle="Sales Rep" AND officeCode=1;

-- display all sales rep from office code 1 and office code 2
SELECT * FROM employees WHERE jobTitle = "Sales Rep" AND (officeCode=2 OR officeCode=1)

-- find all customers from the country of USA and the state of NV
-- and whose credit limit is more than 5000
select * from customers WHERE country LIKE "USA" AND state="NV" AND creditLimit > 5000;

-- display the name, email of all employees, and the city of their office
SELECT  firstName, lastName, email, city, employees.officeCode FROM employees JOIN offices
 ON employees.officeCode = offices.officeCode

 -- for each customer, display the customerName and the first name, last name and email address of their sales rep
select customerName, firstName, lastName, email
from customers join employees
on customers.salesRepEmployeeNumber = employees.employeeNumber

-- display the details of all sales rep and the city that their office is in
-- the "WHERE" clause operates on the JOINED TABLE
SELECT  firstName, lastName, email, city, jobTitle, employees.officeCode
 FROM employees JOIN offices
    ON employees.officeCode = offices.officeCode
 WHERE jobTitle LIKE "Sales Rep"

 -- for every customer, display their sales rep's first name, last name, phone and extension
select customerName, firstName, lastName, offices.phone, extension  from employees
join offices
  on employees.officeCode = offices.officeCode
join customers
  on employees.employeeNumber = customers.salesRepEmployeeNumber

 -- for every customer, display their sales rep's first name, last name, phone and extension
select customerName, firstName, lastName, offices.phone, extension  from employees
join offices
  on employees.officeCode = offices.officeCode
join customers
  on employees.employeeNumber = customers.salesRepEmployeeNumber
where 

-- ...and also for customers in USA
select customerName, firstName, lastName, offices.phone, extension, customers.country  from employees
join offices
  on employees.officeCode = offices.officeCode
join customers
  on employees.employeeNumber = customers.salesRepEmployeeNumber
where customers.country like "USA"

-- in a left join, all rows from the left hand side of the join will show up in the results
SELECT * FROM customers left join employees on customers.salesRepEmployeeNumber = employees.employeeNumber

-- in a right join, all rows from the right hand side of the join will show up in the results
SELECT * FROM customers right join employees on customers.salesRepEmployeeNumber = employees.employeeNumber

-- date manipulation

-- show the current date with:
select curdate();

-- show both current date and time
select now();

-- display all payments made after June 2003
SELECT * FROM payments where paymentDate >= "2003-06-01";


-- display all payments made in the year 2003
SELECT * FROM payments where paymentDate >= "2003-01-01" AND paymentDate <= "2003-31-12";
SELECT * FROM payments where paymentDate BETWEEN "2003-01-01" AND "2003-31-12";

-- use the YEAR, MONTH and DAY functions to extract the respective components from a date column
SELECT checkNumber, amount, YEAR(paymentDate), MONTH(paymentDate), DAY(paymentDate) from payments;

-- display all payments made in the year 2003
select * from payments where year(paymentDate) = "2003"

-- Aggregate functions

-- Know how many employees we have in the company
SELECT COUNT(*) FROM employees;

-- Find how many quantity of a certain product 
-- is ordered in year 2003
select SUM(quantityOrdered) from orderdetails
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
WHERE productCode = "S18_2248"  
AND YEAR(orderDate) = "2003"

-- alternatively
select SUM(quantityOrdered) from orderdetails
JOIN orders ON orderdetails.orderNumber = orders.orderNumber
WHERE productCode = "S18_2248"  
AND orderDate BETWEEN "2003-01-01" AND "2003-12-31"

-- find the average credit limit of all customers
SELECT AVG(creditLimit) FROM customers;

-- show the average credit limit per country
SELECT country, AVG(creditLimit) FROM customers GROUP BY country;

-- count how many customers there are in each country
SELECT country, COUNT(*) FROM customers GROUP BY country;

-- count how many customers there are in each country and their average credit limit

-- IMPORTANT
-- 1. You must select the column what you group by
-- 2. Your other columns must be aggregate functions
-- eg. SUM, COUNT, AVG, MIN, MAX etc.

-- For each country, count how many customers there are 
-- with credit limit greater than 10000
SELECT country, COUNT(*) AS "customer_count" FROM customers
WHERE creditLimit > 10000
GROUP BY country
HAVING COUNT(*) >= 5

-- For each sales rep, find the average credit limit of their customers
-- Show the first name, last name of the sales rep, and the average credit limit for all their customers
SELECT employeeNumber, AVG(creditLimit) FROM employees JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE employees.jobTitle LIKE "Sales Rep"
GROUP BY employeeNumber
HAVING AVG(creditLimit) >= 80000

-- ...to show first name and last name as well
-- and show the top 3 (sorted in descending order)
SELECT employeeNumber, firstName, lastName, AVG(creditLimit) AS "average_credit_limit" FROM employees JOIN customers
ON employees.employeeNumber = customers.salesRepEmployeeNumber
WHERE employees.jobTitle LIKE "Sales Rep"
GROUP BY employeeNumber, firstName, lastName
HAVING AVG(creditLimit) >= 80000
ORDER BY average_credit_limit DESC
LIMIT 3

