CREATE DATABASE campusx;
USE campusx;

CREATE TABLE users(
user_id INTEGER PRIMARY KEY AUTO_INCREMENT,
name VARCHAR(255) NOT NULL,
email VARCHAR(255) NOT NULL UNIQUE,
password VARCHAR(255) NOT NULL
);

#Insertion of DATA using column names, add mulitple rows 
#INSERT DATA into TABLE 
INSERT INTO campusx.users (user_id,name,email,password) 
values (NULL,'Raghvendra','rag@gmail.com','1234');

SELECT * from campusx.users;




INSERT INTO campusx.users 
values (NULL,'Priyankaa','pri@gmail.com','1235');

INSERT INTO campusx.users (name,email,password)
values ('KP','kp@gmail.com','1232');

INSERT INTO campusx.users 
values (NULL,'Rohan','ROhan@gmail.com','122'),
(NULL,'Rahul','Rahul@gmail.com','123'),
(NULL,'Rishan','rishav@gmail.com','1235');





