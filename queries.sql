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