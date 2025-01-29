use powerbisql;
select * from hr;
#data cleaning
Alter table hr change column ï»¿id emp_id varchar(20) Null;

Set sql_safe_updates=0;

UPDATE hr
SET birthdate = CASE
    WHEN birthdate LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN birthdate LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(birthdate, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

Select hire_date from hr;
Alter table hr
modify birthdate date;


UPDATE hr
SET hire_date = CASE
    WHEN hire_date LIKE '%/%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m/%d/%Y'), '%Y-%m-%d')
    WHEN hire_date LIKE '%-%' THEN DATE_FORMAT(STR_TO_DATE(hire_date, '%m-%d-%Y'), '%Y-%m-%d')
    ELSE NULL
END;

Alter table hr 
modify hire_date date;

update hr
set termdate=date(str_to_date(termdate,'%Y-%m-%d %H:%i:%s UTC'))
where termdate is not null and termdate!='';

select termdate from hr;

ALTER TABLE hr
MODIFY COLUMN termdate DATE; 

UPDATE hr
SET termdate = NULL
WHERE termdate = '';
desc hr;

ALTER TABLE hr
add column age int;

Update hr
set age=timestampdiff(year,birthdate,curdate());

Select age from hr;
SELECT 
	MIN(age) AS young, 
    MAX(age) AS oldest 
    from hr;
    
select count(*) from hr where age<=18;