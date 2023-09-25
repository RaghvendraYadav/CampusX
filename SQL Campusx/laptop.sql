use sql_cx;
-- Total Laptops 
SELECT COUNT(*) FROM laptop;

-- Create backup of the data 
CREATE TABLE laptops_backup LIKE laptop;

-- Copied all data of laptop into laptops_backup 
INSERT INTO laptops_backup SELECT * FROM laptop;

-- Chekc no of rows
SELECT COUNT(*) FROM laptop;

-- CHeck Memory consumption  for reference 
SELECT * FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'sql_cx'
AND TABLE_NAME = 'laptop'; 


SELECT DATA_LENGTH/1024 FROM information_schema.TABLES
WHERE TABLE_SCHEMA = 'sql_cx'
AND TABLE_NAME = 'laptop'; 

-- Drop non important columns 
SELECT * FROM laptop;
-- remove unnamed column 
ALTER table laptop DROP column `Unnamed: 0`;

 ;
-- DELETE Rows which have all the null values
DELETE FROM laptop
WHERE `index` IN 
		(SELECT `index` FROM laptop
		WHERE Company IS NULL AND TypeName IS NULL AND Inches IS NULL AND 
		ScreenResolution IS NULL AND Cpu IS NULL AND Ram IS NULL AND 
		Memory IS NULL AND Gpu IS NULL AND OpSys IS NULL AND 
		Weight IS NULL AND Weight IS NULL AND Price IS NULL) ;
        
        
-- how to see duplicates 
DELETE FROM zomato.duplicates 
WHERE id not in (SELECT min(id) FROM zomato.duplicates 
group by name,gender,age);



-- Clean 
SELECT distinct(company) FROM laptop;
SELECT distinct(typeName) FROM laptop;

-- Change the data tyoe of inches to decimal From string 
Alter table laptop Modify column inches decimal(10,1);
SELECT distinct inches FROM laptop;



