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

insert into locations (name, address) values ("Yishun Swimming Complex", "351 Yishun Ave 3, Singapore 769057"),
 ("Jurong West Swimming Complex","21 Jurong West Street 93, Singapore 648965"), 
 ("Tampines Swimming Complex", "1 Tampines Walk, Singapore 528523"),
  ("Choa Chu Kang Swimming Complex", "1 Choa Chu Kang Street 53, Singapore 689236");

-- delete a row (the WHERE part is ultra important)
-- if we omit th WHERE, it will delete all the rows from the table
delete from locations where location_id=2;

update parents set first_name="Lyon" where parent_id = 1;

-- inserting a student
insert into students (parent_id, first_name, last_name, date_of_birth, swimming_level)
 values (5, "Richard", "Lee", "2018-06-02", 1);