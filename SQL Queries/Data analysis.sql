-- QUESTIONS

-- 1. What is the gender breakdown of employees in the company?
Select gender ,count(*) as Count from hr where age>=18 and termdate is null
group by gender;

-- 2. What is the race/ethnicity breakdown of employees in the company?
select race,count(*) as count from hr where age>=18 and termdate is null
group by race
order by count(*) desc;

-- 3. What is the age distribution of employees in the company?
SELECT 
	min(age) as youngest, 
    max(age) as oldest
from hr where age>=18 and termdate is null;
#creating the age group 

SELECT 
case
when age>=18 and age <=24 then '18-24'
when age>=25 and age <=34 then '25-34'
when age>=35 and age <=44 then '35-44'
when age>=45 and age <=54 then '45-54'
when age>=55 and age <=64 then '55-64'
else '65+'
end as agegroup,
 count(*) as count
 from hr where age>=18 and termdate is null
 group by agegroup
 order by agegroup;

SELECT 
case
when age>=18 and age <=24 then '18-24'
when age>=25 and age <=34 then '25-34'
when age>=35 and age <=44 then '35-44'
when age>=45 and age <=54 then '45-54'
when age>=55 and age <=64 then '55-64'
else '65+'
end as agegroup,gender,
 count(*) as count
 from hr where age>=18 and termdate is null
 group by agegroup,gender
 order by agegroup,gender;




-- 4. How many employees work at headquarters versus remote locations?
select location from hr;
select location, count(*) from hr
where age>=18 and termdate is null
group by location; 

-- 5. What is the average length of employment for employees who have been terminated?
select 
avg(datediff(termdate,hire_date)/365) as avg_length_employment
from hr where termdate<=curdate() 
and termdate is not null and age>=18;
-- 6. How does the gender distribution vary across departments and job titles?
select department,gender,count(*) as count
from hr
where age>=18 and termdate is null
group by department,gender
order by department; 

-- 7. What is the distribution of job titles across the company?
select jobtitle,count(*) as count
from hr
where age>=18 and termdate is null
group by jobtitle
order by jobtitle desc;

-- 8. Which department has the highest turnover rate?
SELECT department,
	total_count,
    terminated_count,
    terminated_count/total_count AS termination_rate
    FROM(SELECT department,count(*) AS total_count,
    SUM(CASE WHEN termdate IS NOT NULL AND termdate<=curdate() THEN 1 ELSE 0 END) AS terminated_count
    FROM hr
    WHERE age>=18
    GROUP BY department) AS subquery
    ORDER BY termination_rate DESC;

-- 9. What is the distribution of employees across locations by city and state?
SELECT location_state, count(*) as count from hr
Where age>=18 and termdate is null
group by location_state
order by count desc;

-- 10. How has the company's employee count changed over time based on hire and term dates?
select year,
hires,
termination,
hires-termination as netchange,
round((hires-termination)/hires*100,2) as netchangepercent
from (
select YEAR(hire_date) as year,
count(*) as hires, 
SUM(case when termdate is not null and termdate<=curdate() then 1 else 0 end) as termination 
from hr
where age>=18 
group by year) as subquery
order by year asc;
-- 11. What is the tenure distribution for each department?
SELECT 
    department, 
    ROUND(AVG(DATEDIFF(termdate, hire_date) / 365), 0) AS average_tenure
FROM 
    hr
WHERE 
    termdate <= CURDATE() 
    AND age >= 18
GROUP BY 
    department;
