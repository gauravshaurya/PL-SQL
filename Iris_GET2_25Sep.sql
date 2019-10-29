select * from Cat


select * from employees

select employee_id,first_name,last_name from employees

//What do u mean by SQL.

SELECT employee_id,
    first_name,
        last_name from EMPLOYEES 
        where first_name='Steven';
        
--Arithmetic Expressions - 
/*
Operators allowed :- + , - , * , /
Data type :- number , date
*/

describe employees

/*WAQ to display employee Id , first_name , last_name, monthly salary and annual salary for all the employees*/

select employee_id,first_name,last_name,salary,salary*12 from employees

/*Operator Precedence*/

select last_name,salary from employees
select last_name,salary,12*salary+100,12*(salary+100) from employees

/*not null*/
select employee_id,last_name,salary,commission_pct,salary+commission_pct from employees

--Alias
select employee_id EmpId,salary,salary*12 AnnualSal from employees
select employee_id as EmpId,salary,salary*12 as AnnualSal from employees

--Use double qutoes if column heading is having space in between..
select employee_id as EmpId,salary,salary*12 as "Annual Sal" from employees


--Concatenation Operator 
select employee_id,first_name||last_name from employees
select employee_id as EmpId,first_name||' '||last_name as "Emp+Name" from employees
select 'Divya'||' '||'Garg' from employees

/*WAQ which can display data in below format
Divya Garg is having employee Id = 101
*/
select first_name||' '||last_name||' is having employee Id = '||employee_id as EmpData
from employees

select employee_id||salary from employees

select first_name||' '||last_name|| q'['s employee Id is ]'||employee_id as EmpData
from employees

select first_name||' '||last_name|| q'["s" employee Id is ]'||employee_id as EmpData
from employees

select department_id from employees

--want to fetch the unique values from a particular column
select distinct department_id from employees
select distinct(department_id) from employees


--where clause
select * from employees where department_id=90
select employee_id,last_name,department_id from employees where department_id=90

select employee_id,first_name,last_name,department_id,hire_date from employees where first_name='Steven'

select employee_id,first_name,last_name,department_id,hire_date from employees
where hire_date='08-MAR-2008'

select employee_id,first_name,last_name,department_id,hire_date from employees
where hire_date <> '08-MAR-2008'

select employee_id,first_name,last_name,department_id,hire_date from employees
where first_name <> 'Steven'

select employee_id,first_name,last_name,department_id,hire_date from employees
where employee_id <> 101

select employee_id,first_name,last_name,department_id,hire_date from employees
where employee_id between 101 and 105

select employee_id,first_name,last_name,department_id,hire_date from employees
where employee_id not between 101 and 105

select employee_id,first_name,last_name,department_id,hire_date from employees
where employee_id>=101 and employee_id<=105

--IN
want to fetch the details of those employees whose first_name is equal to Neena , Lex , Alexander,David
select employee_id,first_name,last_name,department_id,hire_date from employees
where first_name='Lex' or first_name='Alexander' or first_name='Neena' or first_name='David'

select employee_id,first_name,last_name,department_id,hire_date from employees
where first_name in ('Lex','Alexander','Neena','David')


select employee_id,first_name,last_name,department_id,hire_date from employees
where first_name not in ('Lex','Alexander','Neena','David')


--IsNULL
select employee_id,first_name,last_name,department_id,hire_date,commission_pct from employees
where commission_pct is null

select employee_id,first_name,last_name,department_id,hire_date,commission_pct from employees
where commission_pct is not null

--Using the LIKE Condition :-

select * from employees where first_name like 'S%'
select * from employees where first_name like '%a'
select * from employees where first_name like 'N%a'
select * from employees where first_name like 'N____'

--Practice Questions :-
/*
Syntax :-
select [distinct] [columnsList] from tableName where condition
select [distinct] [columnsList] from tableName where (condition1) AND/OR (condition2)

*/
/*Q 1 : Write a query to display the last name and salary of employees who earn more than 12000 . */
select last_name,salary from employees where salary>12000



--Q 2 : Write a query to display the last name and department number for employee 176.
select last_name,department_id from employees where employee_id=176

/*Q 3 : Write a query to display the last name and salary for any employee whose salary 
is not in the 5000-12000 range.*/
select last_name,salary from employees where salary between 5000 and 12000
select last_name,salary from employees where salary not between 5000 and 12000


/*Q 4 : Create a report to display the last name , jobId and start date for the employees whose last 
names are Matos and Taylor . Order the query in ascending order by start date.*/

select last_name,job_id,hire_date from employees where (last_name='Matos') or (last_name='Taylor')
select last_name,job_id,hire_date from employees where (last_name <> 'Matos') or (last_name <> 'Taylor')
select last_name,job_id,hire_date from employees where last_name in ('Matos','Taylor')
select last_name,job_id,hire_date from employees where last_name not in ('Matos','Taylor')

--Q 5 : Display the last name and department number of all the employees in departments 20 or 50 
--in ascending alphabetical order by name.
select last_name,department_id from employees where department_id=20 or department_id=50
select last_name,department_id from employees where department_id in (20,50)



/*Q 6 : Display the last name and salary of employees who earn between 5000 and 12000
and are in department 20 or 50. */
select last_name,salary from employees where (salary between 5000 and 12000) and 
(department_id in (20,50))

select last_name,salary from employees where (salary between 5000 and 12000) and 
(department_id=20 or department_id=50)


--Q 7 : Create a report that displays the last name and hire date for all employees who were hired in 2004
select last_name,hire_date from employees where hire_date like '%04'
select last_name,hire_date from employees where hire_date between '01-Jan-04' and '31-Dec-04'

/*Q 8 : Create a report to display the last name and job title of all employees who
dont have a manager.*/
select last_name,job_id from employees where manager_id is null
select last_name,job_id from employees where manager_id is not null


/*Q 9 : Create a report to display the last name , salary and commission of all employees
who earn commissions . Sort the data in descending order of salary and 
commissions.*/
select last_name,salary,commission_pct from employees where commission_pct is not null


--Q 10 : Display all employee last names in which the third letter of the name is "a".
select last_name from employees where last_name like '__a%'

Q 11: Display the last name of all employees who have both a and e in their last name.
select last_name from employees where last_name like '%a%e%' or last_name like '%A%e%' or last_name like '%E%a%'

Q 12 : Display the last name , job and salary for all employees 
whose jobs are either that of a sales representative or a stock clerk , and whose salaries are not 
equal to 2500 , 3500 or 7000

select last_name,job_id ,salary from employees 
where (job_id in ('SA_REP','ST_CLERK')) 
and (salary not in (2500,3500,7000)) 


select last_name,job_id,salary from employees where job_id = 'SA_REP' or job_id='AD_PRES' and salary>15000
select last_name,job_id,salary from employees where (job_id = 'SA_REP' or job_id='AD_PRES') and salary>15000

--Using the Order By Clause :-
select last_name,salary,hire_date from employees
select last_name,salary,hire_date from employees order by last_name asc
select last_name,salary,hire_date from employees order by last_name desc

--Sorting by column alias
select last_name,salary,salary*12 from employees order by salary*12 desc
select last_name,salary,salary*12 as AnnualSal from employees order by AnnualSal desc

--Sorting Multiple columns
/*Create a report to display the last name , salary and commission of all employees
who earn commissions . Sort the data in descending order of salary and 
commissions.*/
select last_name,salary,commission_pct from employees where commission_pct is not null 
order by salary desc , commission_pct

--WAQ to display department_id and salary of the employees . Display the result in sorted order of department
--_id and salary

select department_id,salary from employees order by department_id,salary desc

--Substitution variable
select employee_id,last_name ,salary from employees where employee_id=&empid
select employee_id,last_name ,salary from employees where last_name='&empname'
select employee_id,last_name ,salary,hire_date from employees where hire_date like '%&inp'
select employee_id,last_name ,salary,hire_date from employees where &ColumnName=&inp2
select &ColList from &tableName where &ColumnName=&inp2

--Using the double ampersand

select &&ColumnName2 from employees order by &columnName2
Undefine ColumnName2


select &&myVar from employees order by &myVar
Undefine ColumnName3

set verify off
select employee_id,last_name,salary from employees where employee_id=&empid

--Single Row functions 

--Character Functions

--Case Manipulation function

select upper(last_name) as "Upper",lower(last_name) as "Lower",initcap(last_name) as "InitCap",
last_name  "Original"
from employees

select upper('Divya gARG') from dual
select lower('Divya gARG') from dual

select employee_id,last_name from employees where last_name=initcap('&name')


--concat function
/*WAQ to display first_name and last_name as FullName from the employees table*/

select first_name||' '||last_name from employees

select concat(first_name,last_name) FullName from employees
select concat(concat(first_name,' '),last_name) FullName from employees

select concat('Divya ','Garg') from dual

--substr function
select length(substr('Hello World',2,6)) from dual
/*Here 2 is the starting index , and 6 is the total no. of characters to extract . index starts from
1 here*/

select last_name,substr(last_name,2,3) from employees

--length
select last_name,length(last_name) from employees

--instr
select instr('Hello World','W') from dual
select instr('Hello World','a') from dual

--lpad
select salary, lpad(salary,5,'*'),rpad(salary,5,'*') from employees

--replace
select replace(replace('Jack and Jue','J','Bl'),'a','p') from dual

--Trim
select trim('J' from 'Jack and JueJ') from dual
select trim(' ' from '   Jack and JueJ  ') from dual


--Number function
--round function

select round(45.926,2) , round(45.926),round(45.926,1),round(45.926,-1) ,
round(42.926,-1),round(342.926,-1),round(342.926,-2),round(45.926,-2) 
from dual

select trunc(45.926,2) , trunc(45.926),trunc(45.926,1)
from dual

select mod(25,5) from dual

--Working With Dates
select sysdate from dual
select sysdate+2 from dual
select sysdate-737300 from dual
select sysdate+10 from dual


select sysdate-to_date('15-Sep-1990','dd-Mon-yyyy') from dual
    select sysdate+48/24 from dual
    
    select next_day(sysdate,'Wed') from dual
    select add_months(sysdate,3) from dual
    select months_between(add_months(sysdate,3),sysdate) from dual
    select last_day(sysdate) from dual
    select to_char(sysdate,'DAY') from dual