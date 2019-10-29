/*nvl(expr1,expr2) - It will check the first expression if it is null , then will return the value of 
second expression , otherwise will return expression1 itself.
Data types for both the expressions must match*/
select employee_id,last_name,salary,nvl(commission_pct,0) from employees
select employee_id,last_name,salary,nvl(to_char(commission_pct),'No Commission') from employees

--WAQ to display last_name and take home amount i.e. salary+commission
select last_name,salary+nvl(Commission_pct,0) TakeHomeAmount from employees



--nvl2
/*
Syntax :- nvl2(expr1,expr2,expr3)

This function will take 3 arguments . If the value of first argument is not null , then will return the
second argument , If first arg is null , then will return the third argument.
Data type of first arg can be anything , data type of second and third arg can be anything except
long.Data type of sec. and third arg can be anything but they should be same.
*/
select employee_id,last_name,nvl2(Commission_pct,'Takes Commission','Doesnt take Commission')  
from employees

select employee_id,last_name,nvl2(Commission_pct,to_char(commission_pct),'Doesnt take Commission')  
from employees

/*nullif function takes two arguments , if both are same , then will return null , otherwise will
return the value of first argument*/
select nullif('Divya','Divya') from dual
select nullif('Divya','DivyaGarg') from dual
select nullif(0,10) from dual

/*WAQ to display the length of first name and last name , if both are equal then want to display 
Length is same otherwise want to display length is not same.*/
select first_name,last_name,nvl2(nullif(length(first_name),length(last_name)),'Length is not same',
'Length is same') Result from employees

/*coalesce function :- This function takes n no. of arguments ,and will return the first not null value*/
select coalesce(null,null,'Hello','0','20','30',null,'Bye',null) from dual

select last_name,commission_pct,manager_id,
coalesce(to_char(commission_pct),to_char(manager_id),'No Commission and No Manager') 
from employees


select last_name, commission_pct,salary,
coalesce(salary+commission_pct,salary+2000) from employees;

select last_name, commission_pct,salary,
coalesce(commission_pct,2000)+salary from employees;

/*
Case Expression :-

Syntax :-
CASE expr WHEN comparison_expr1 THEN return_expr1
[WHEN comparison_expr2 THEN return_expr2
WHEN comparison_exprn THEN return_exprn
ELSE else_expr]
END
*/
/*. If JOB_ID is IT_PROG, the
salary increase is 10%; if JOB_ID is ST_CLERK, the salary increase is 15%; if JOB_ID is
SA_REP, the salary increase is 20%. For all other job roles, there is no increase in salary.*/
select last_name,job_id,salary,
case job_id when 'IT_PROG' then salary*1.10
            when 'ST_CLERK' then salary*1.15
            when 'SA_REP' then salary*1.20
            else salary end "Revised Salary"
from employees
            
            
SELECT last_name,salary,
(
CASE WHEN salary<5000 AND salary<7000 THEN 'Low'
WHEN salary<10000 THEN 'Medium'
WHEN salary<20000 THEN 'Good'
ELSE 'Excellent'
END
) qualified_salary
FROM employees;


--Group functions
--You can use the AVG, SUM, MIN, and MAX functions against the columns that can store numeric data.
select avg(salary),min(salary),max(salary),sum(salary) from employees

--You can use the MAX and MIN functions for numeric, character, and date data types.
select min(hire_date),max(hire_date) from employees
select min(last_name),max(last_name) from employees    

select last_name from employees order by last_name

--count function
select count(*) from  employees
select count(manager_id) from employees
select count(commission_pct) from employees

--WAQ to count the total no. of employees in department 50
select count(*) from employees where department_id=50

select department_id from employees
select distinct department_id from employees

select count(distinct department_id) from employees -- will count the not null distinct department ids

select count(manager_id) from employees
select count(nvl(manager_id,0)) from employees

--Group By Cause
--WAQ to display the count of employees in each department



select department_id,count(employee_id) "No Of Employees" from employees 
group by department_id order by department_id

/*WAQ to count the no. of employees under each manager id */
select manager_id,count(employee_id) from employees group by manager_id order by manager_id

/*WAQ to display department id and sum of salary given for each department*/
select department_id,sum(salary) from employees group by department_id order by department_id

/*WAQ to display department id and sum of salary given for each department  but only for department
where deparment id is between 10 to 100*/
select department_id,sum(salary) from employees where (department_id between 10 and 100)
group by department_id order by department_id

/*WAQ to display department id and sum of salary given for each department  but only for department
where deparment id is between 10 to 100 and sum of salary must be greater than 10000*/
select department_id,sum(salary) from employees where (department_id between 10 and 100)
group by department_id having sum(salary)>10000 order by department_id

/*
Q 1 : displays the department numbers and average salaries for those departments
with a maximum salary greater than $10,000:
*/
select department_id,round(avg(salary),2) from employees group by department_id having max(salary) >10000;

/*
displays the job ID and total monthly salary for each job that has a total
payroll exceeding $13,000. The example excludes sales representatives and sorts the list by the total monthly salary.
*/
select job_id,sum(salary) from employees where job_id <> 'SA_REP' group by job_id
having sum(salary)>13000 order by sum(salary);

--Grouping on more than one column
SELECT department_id, job_id, sum(salary)
FROM employees
GROUP BY department_id, job_id
ORDER BY department_id;


/*
Create a report to display the manager number and the salary of the lowest-paid employee for that manager . Exclude anyone whose manager is not known . Exclude any groups where the minimum salary is 6000 or less . Sort the output in descending order of salary.  
*/
select manager_id,min(salary) from employees  where manager_id is not null group by manager_id
having min(salary)>6000 order by min(salary) desc

/*Write a query to display the number of people with the same job.*/
select job_id,count(job_id) from employees group by job_id

---------------------------------------------------------------------------------------------------------
/*Joins :- Joins are used to fetch data from more than one table at a time.*/

/*Natural Join will compare the value of all columns with same name in both the table and then 
will give the result. If columns having same name are having different data type then will give error*/
--1. First type of Join (Natural Join)
select employee_id,first_name,last_name,department_name from 
employees natural join departments

--OR

select employee_id,first_name,last_name,department_name from 
employees e , departments  d where e.department_id=d.department_id 
and e.manager_id=d.manager_id

--Using Clause (Equi Join) - Equijoins are also called simple joins or inner joins.
/*Natural joins use all columns with matching names and data types to join the tables. The USING
clause can be used to specify only those columns that should be used for an equijoin.
*/
--Old Syntax
select employee_id,first_name,last_name,department_name from employees e,
departments d where e.department_id=d.department_id

--New Syntax 
select e.employee_id,e.first_name,e.last_name,department_id,d.department_name 
from employees  e join departments d
using(department_id)

--Note :- Cannot use qualifier like e.department_id with the column which is the part of Using
--Clause

--ON Clause-The table alias is necessary to qualify thematching column_names.
select e.employee_id,e.first_name,e.last_name,d.department_id,d.department_name 
from employees  e join departments d
on(e.department_id=d.department_id) 

/*WAQ to display employee_id,last_name,department_name and city for al the employees*/
select employee_id,last_name,department_name,city
from employees join departments using(department_id)
join locations using(location_id)

select e.employee_id,e.last_name,d.department_name,l.city
from employees e join departments d on(e.department_id=d.department_id)
join locations l on(d.location_id=l.location_id) where l.city='Southlake'

--Self Join
select e.first_name EmpName,m.first_name MgrName  
from employees e join employees m
on(e.manager_id=m.employee_id)

--Nonequi Joins
select * from jobs
select * from employees

select employee_id,first_name,last_name,job_title,salary 
from employees join jobs
on (salary between min_salary and max_salary) where first_name='Nancy'











