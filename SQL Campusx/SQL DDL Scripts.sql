/* Create a database */
 Create DATABASE campusx;
/*Drop a database */
DROP DATABASE campusx;
/* Another good way to create a database */
CREATE DATABASE IF NOT EXISTS campusx;
/* Another good way to drop  a database */
DROP DATABASE IF EXISTS campusx;

/* DDL scripts for tables */
CREATE DATABASE IF NOT EXISTS campusx;
USE campusx;
CREATE TABLE users(
	user_id INTEGER,
    user_name VARCHAR(255),
    email VARCHAR(255),
	password VARCHAR(255)
);

insert into users values(1,'raghvendra','rag@gmail.com','1234'),
						(2,'nitish','nit@gmail.com','4567');
SELECT * FROM users;

/* TRUNCATE SCRIPT to REMOVE ALL THE ROWS whereas schema is alive  */
TRUNCATE TABLE users ;

#DROP TABLE- it will delete the rows and schema both  
DROP TABLE users;

#NOT NULL CONSTRAINTS
CREATE TABLE users(
	user_id INTEGER NOT NULL,
    name VARCHAR(255) NOT NULL,
    email VARCHAR(255),
    password VARCHAR(255)
);
insert into users values(1,'raghvendra','rag@gmail.com','1234');

#UNIQUE CONSTRAINTS 
CREATE TABLE users(
user_id INTEGER NOT NULL,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL) ; 

insert into users values(1,'raghvendra','rag@gmail.com','1234');
insert into users values(2,'KP','rag@gmail.com','1234'); # HERE we will get error Duplicate entry bcoz it is unique 


DROP TABLE users;

#ANOTHER WAY FOR CREATE CONSTRAINTS   it is good as we can make constraint of two combined columns and we can drop the contraints in future
#by its name 
CREATE TABLE users(
user_id INTEGER NOT NULL,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL ,
password VARCHAR(255) NOT NULL,

CONSTRAINT user_email_unique UNIQUE(email)
) ;	
 
 
#PRIMARY KEY CONSTRAINTS USING SIMPLE METHOD  
CREATE TABLE users(
user_id INTEGER NOT NULL PRIMARY KEY,
name VARCHAR(255) NOT NULL ,
email VARCHAR(255) NOT NULL ,
password VARCHAR(255) NOT NULL
) ;

#PRIMARY KEY CONSTRAINTS USING CONSTRAINTS Key WORD which can help make primary key with combined columns 
CREATE TABLE users(
user_id INTEGER NOT NULL,
name VARCHAR(255) NOT NULL ,
email VARCHAR(255) NOT NULL ,
password VARCHAR(255) NOT NULL,

CONSTRAINT user_email_unique UNIQUE(email),
CONSTRAINT users_pk PRIMARY KEY (user_id )
);

DROP TABLE users;

#AUTO_INCREMENT CONSTRAINT 
CREATE TABLE users(
user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL ,
email VARCHAR(255) NOT NULL UNIQUE ,
password VARCHAR(255) NOT NULL
);
insert into users(name,email,password) values('raghvendra','rag@gmail.com','1234');
select * from users;


#CHECK CONSTRAINTS 
 CREATE TABLE students(
	student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INTEGER CHECK (age > 6 AND age < 25)
    
 );
 
 DROP TABLE students;
 
 #CHECK CONSTRAINTS  using CONSTRAINT KEYWORD
 CREATE TABLE students(
	student_id INTEGER PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    age INTEGER NOT NULL,
    
    CONSTRAINT students_age_check check (age >6 and age <25)
    
 );
 
 DROP TABLE students;
 insert into students (name,age) values('raghvendra',26); # it will fail bcoz of the check constraint
 
 #DEFAULT CONSTRAINT 
 
 CREATE TABLE ticket(
  ticket_id INTEGER  PRIMARY KEY,
  name VARCHAR(255) NOT NULL,
  travel_date DATETIME DEFAULT CURRENT_TIMESTAMP
 
 );
 
 insert into ticket(ticket_id,name) values(1,'Rag');
select * from ticket;


#FOREGIN KEY 



#RESTRICT
#CASCADE
#SET NULL
#SET DEFAULT


use campusx;
select * from orders;

#Foreign KEy 
CREATE TABLE customers(
cid INTEGER PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) UNIQUE);

CREATE TABLE orders(
order_id INTEGER PRIMARY KEY  AUTO_INCREMENT,
cid INTEGER NOT NULL,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT order_fk FOREIGN KEY(cid) REFERENCES customers(cid));

drop table orders;

#CASCADE - if value is change it will do changes to the child and parent table both 

CREATE TABLE orders(
order_id INTEGER PRIMARY KEY  AUTO_INCREMENT,
cid INTEGER NOT NULL,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT order_fk FOREIGN KEY(cid) REFERENCES customers(cid)

ON DELETE CASCADE 
ON UPDATE CASCADE

);

#SET NULL - it will set null to the chld table if data is deleted 

CREATE TABLE orders(
order_id INTEGER PRIMARY KEY  AUTO_INCREMENT,
cid INTEGER ,
order_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,

CONSTRAINT order_fk FOREIGN KEY(cid) REFERENCES customers(cid)

ON DELETE SET NULL
ON UPDATE SET NULL

);


# ALTER TABLE 
# ADD COLUMNS 

# DELETE COLUMNS 
#MODIFY Columns 


# ADD COLUMNS
ALTER table customers ADD COLUMN surname VARCHAR(255) NOT NULL AFTER name;


#ADD MULTIPLE COLUMNS 
ALTER table customers 
ADD COLUMN pan_number VARCHAR(255) AFTER surname,
ADD COLUMN joining_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP;

#DELETE COLUMNS 
ALTER table customers 
DROP COLUMN pan_number;

#DELETE MULTIPLE COLUMNS 
ALTER table customers 
DROP COLUMN  surname,
DROP COLUMN joining_date;


#MODIFY COLUMN 
ALTER table customers 
MODIFY COLUMN name varchar(250);

#ADD & DELETING  constraints 

ALTER TABLE customers ADD COLUMN age INTEGER NOT NULL;

# ADD CONSTRAINT 
ALTER TABLE customers 
ADD CONSTRAINT customer_age_ck CHECK (age>23);


#CONSTRAINT EDIT NHI hota 


#DELETE CONSTRAINT 
ALTER TABLE customers 
DROP CONSTRAINT customer_age_ck;

#ADD THe UPDATE CONSTRAINT 

ALTER TABLE customers 
ADD CONSTRAINT customer_age_ck CHECK (age>18);
