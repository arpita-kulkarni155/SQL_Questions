CREATE TABLE Employee (
 EmpID int NOT NULL,
 EmpName Varchar,
 Gender Char, 
 Salary int,
 City Char(20))
 
 INSERT INTO Employee
 VALUES (1, 'Arjun', 'M', 75000,  'Pune'),
 (2, 'Ekadanta', 'M', 125000, 'Bangalore'),
 (3, 'Lalita', 'F', 150000 , 'Mathura'),
 (4, 'Madhav', 'M', 250000 , 'Delhi'),
 (5, 'Visakha', 'F', 120000 , 'Mathura')
 
  CREATE TABLE  EmployeeDetail (
 EmpIDint NOT NULL,
 Project Varchar,
 EmpPositionChar(20),
 DOJ date  )
 
 INSERT INTO EmployeeDetail
 VALUES (1, 'P1', 'Executive', '26-01-2019'),
 (2, 'P2', 'Executive', '04-05-2020'),
 (3, 'P1', 'Lead', '21-10-2021'),
 (4, 'P3', 'Manager', '29-11-2019'),
 (5, 'P2', 'Manager', '01-08-2020')
 
/* Q1(a): Find the list of employees whose salary ranges between 2L to 3L.*/
select empname 
from Employee 
where salary between 200000 and 500000;

/* Q1(b): Write a query to retrieve the list of employees from the same city.*/
select e1.empname 
from Employee e1, Employee e2  
where e1.city=e2.city and e1.empid<>e2.empid;

/* Q1(c): Query to find the null values in the Employee table.*/
select * from Employee where empid is NULL;

/*Q2(a): Query to find the cumulative sum of employee’s salary */
select empid,empname,salary,sum(salary) over (order by empid) as commulative_salary
from Employee;

/*Q2(b): What’s the male and female employees ratio.*/
select ROUND(sum(case 
		  when gender='F' then 1 else 0 end)*100.0/count(gender),1) as female_ratio,
	   ROUND(sum(case 
		  when gender='M' then 1 else 0 end )*100.0/count(gender),1)as male_ratio
from Employee;

/*Q2(c): Write a query to fetch 50% records from the Employee table.*/
select *
from Employee
where empid <= (select count(empid)/2 from Employee) 

/*Q3: Query to fetch the employee’s salary but replace the LAST 2 digits with ‘XX’  
i.e12345 will be 123Xx */
MYSQL soln :

select 
concat(left((salary),length(salary)-2),'xx') as replaced_salary
from Employee;

/* Q4: Write a query to fetch even and odd rows from Employee table.*/
select *
from Employee
where mod(empid,2)=0 

select * 
from Employee
where mod(empid,2)<>0

/*OR*/
select * from 
  (select *,row_number() over (order by empid) as RowNumber from Employee) as emp
where emp.RowNumber%2 =0

/*Q5(a): Write a query to find all the Employee names whose name:
 • Begin with ‘A’
 • Contains ‘A’ alphabet at second place
 • Contains ‘Y’ alphabet at second last place
 • Ends with ‘L’ and contains 4 alphabets 
• Begins with ‘V’ and ends with ‘A’ */

select * 
from Employee 
where empname like 'A%';

select * 
from Employee 
where empname like '_a%';

select * 
from Employee 
where empname like '%a_';

select * 
from Employee 
where empname like '___l';

select * 
from Employee 
where empname like 'V%a';

/*QWrite a query to find the list of Employee names which is:
 • starting with vowels (a, e, i, o, or u), without duplicates
 • ending with vowels (a, e, i, o, or u), without duplicates
 • starting & ending with vowels (a, e, i, o, or u), without duplicate */

/*pgSQL soln:*/
select distinct empname 
from employee
where lower(empname) similar to '[aeiou]%';

select distinct empname
from employee
where lower(empname) similar to '%[aeiou]';

select distinct empname
from employee
where lower(empname) similar to '[aeiou]%[aeiou]';

/*MYSQL soln:*/
select distinct empname
from employee
where lower(empname) REGEXP '^[aeiou]';

select distinct empname 
from Employee 
where lower(empname) REGEXP '[aeiou]$';

select distinct empname 
from Employee 
where lower(empname) REGEXP '^[aeiou].*[aeiou]$';





