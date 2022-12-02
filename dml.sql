-- This assumes that the tables in the databases are already created
-- see the ddl.sql for the table definitions

-- 'insert into' add new rows
insert into parents (first_name, last_name) values("Jon", "Snow");

-- insert multiple rows at one go
insert into parents (first_name, last_name) values ("Zoe", "Tay"),
    ("Fann", "Wong"),
    ("Dick", "Lee"),
    ("Junjie", "Lin"),
    ("Wang", "Lei");