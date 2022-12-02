-- show all databases on your MySQL server
show databases;

-- create a new database
-- create database <new database name>
create database swimming_coach;

use swimming_coach;

-- syntax for creating a table
create table parents (
    parent_id integer unsigned auto_increment primary key,
    first_name varchar(45) not null,
    last_name varchar(45) not null
) engine = innodb;

-- to see all tables in the database
show tables;

-- to see the columns definition of a table
describe parents;

-- create the locations table
create table locations (
    location_id integer unsigned auto_increment primary key,
    name varchar(255) not null default "",
    address varchar(255) not null
) engine = innodb;

-- insert a new location
insert into locations (name, address) values ("Bishan Swimming Complex", "Bishan St 81");
-- if we insert without name, the name will be "" because we have set the default value to be empty string

insert into locations(address) values ("Somewhere Road 443");

-- if we insert without address, we get an error because address is set to NOT NULL without any default value
insert into locations(name) values ("Somewhere Swimming Complex");

-- to see all the rows from a TABLE
select * from locations;

-- Create the students table which has a foreign key
-- step 1: create the students table as usual
create table students (
    student_id int unsigned primary key auto_increment,
    parent_id int unsigned not null,
    first_name varchar(45) not null,
    last_name varchar(45),
    swimming_level tinyint unsigned not null default 0,
    date_of_birth datetime not null
) engine = innodb;

-- step 2: add in the foreign key
alter table students add constraint fk_students_parents
    foreign key (parent_id) references parents(parent_id);

-- test out the foreign key
insert into parents (first_name, last_name) values ("Ah Kow", "Tan");

insert into students (parent_id, first_name, last_name, swimming_level, date_of_birth)
    values (1, "Ah Lian", "Tan", 1, "2019-01-01");

-- Won't work because there is no parent_id 1
insert into students (parent_id, first_name, last_name, swimming_level, date_of_birth)
    values (99, "Jason", "Goh", 1, "2019-01-01");

-- create table for sessions
create table sessions (
    session_id int unsigned auto_increment primary key,
    datetime datetime not null,
    location_id int unsigned not null,
    foreign key (location_id) references locations(location_id)
) engine = innodb;

-- remove a column from an existing table
alter table students drop column swimming_level;

-- add a new column
alter table students add column swimming_level int unsigned;

-- modify an existing column
alter table students modify column swimming_level tinyint unsigned not null default 0;

-- create table <name of table>  (<column def>,<column def>,(colunm def)) engine = innodb;
-- column def: <name of column> <data type>
create table attendance (
    attendance_id int unsigned not null primary key auto_increment,
    session_id int unsigned not null,
    student_id int unsigned not null
) engine = innodb;

-- rename a column
-- alter table attendance change user_id student_id int unsigned not null;

alter table attendance add constraint fk_attendance_session foreign key (session_id) references sessions(session_id);
-- foreign key  ( student_id) reference attendance(student_id)


alter table attendance add constraint fk_attendance_student foreign key (student_id) references students(student_id);

-- engine = innodb enforces the constraints
-- if we don't have the 'engine = innodb' we can still create the foregin keys BUT MySQL will not enforce
create table payments (
    payment_id int unsigned not null primary key auto_increment,
    amount int unsigned not null default 0,
    method varchar(100),
    session_id int unsigned not null,
    foreign key (session_id) references sessions(session_id),
    student_id int unsigned not null,
    foreign key (student_id) references students(student_id),
    parent_id int unsigned not null,
    foreign key (parent_id) references parents(parent_id)
) engine = innodb;

