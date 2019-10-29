/*
Q 4 : The HR department wants to find the duration of employment for each employee . For each employee , display the last name and calculate the no. of months between today and the date on which the employee was hired . Label the column MONTHS_WORKED . Order your results by the number of months employed . Round the number of months up to the closest whole number. 
*/
select Last_name,round(Months_between(sysdate,Hire_date)) as Months_worked from employees 
order by Months_worked 

/*
Q 6 : Display each employee's last name , hire date and salary review date which is the first Monday 
after six months of service . Label the column Review . 
*/
select last_name,hire_date,next_day(add_months(hire_date,6),'mon') salary_review from employees

/*Q 5 : Create a query to display the last name and salary for all employees . Format the salary 
to be 15 characters long , left padded with the $ symbol. Label the column Salary.
*/


/*
Q 3 : Write a query that displays the last name (with the first letter uppercase and all other letters 
lowercase) and the length of the last name for all employees whose name starts with the letters J , A 
or M . Give each column an appropriate label . Sort the results by the last names of the employees.
*/

select initcap(last_name),length(last_name) from employees where last_name like 'J%' or last_name like 'A%' or 
first_name like 'M%' 
order by last_name desc;

/*Q 7 : Display the last name , hire date and day of the week on which an employee started . 
Label the column DAY . Order the results by the day of the week , starting with Monday.*/
select last_name,hire_date,to_char(hire_date,'Day') "DAY" ,to_char(hire_date-1,'d') "DayNo" 
from employees order by "DayNo"

--Using Conversion functions and Conditional Expressions

--Conversion Functions :- are used to convert the value of data type into another.
/*
Conversion is of two types:-
1. Implicit Conversion
2. Explicit Conversion
*/

select 2||3 from dual
select 2||'Hello' from dual
select '2'+25 from dual
select 25+'2' from dual

select * from employees where hire_date='17-JUN-03'

--Using to_char() function with Dates :-
select to_char(hire_date,'dd/MM/yyyy') from employees;
select to_char(sysdate,'dd/MM/yyyy hh:mm:ss') from dual;
select to_char(sysdate,'hh:mm:ss') from dual;
select to_char(sysdate,'Month dd,yyyy') from dual;
select to_char(sysdate,'month dd,yyyy') from dual;
select to_char(sysdate,'MON dd,yyyy') from dual;
select to_char(sysdate-4,'Ddspth Month , yyyy') from dual;
select to_char(sysdate,'dd "of" Month') from dual;

select last_name,to_char(hire_date,'fmDdspth "of" Month yyyy hh:mm:ss AM') from employees
select to_char(sysdate,'fmDdspth "of" Month yyyy fmhh:mi:ss AM') from dual


--to_char function with Numbers :-
select last_name,to_char(salary*12,'9,99,999') AnnualSal from employees
select last_name,to_char(salary*12,'$9,99,999') AnnualSal from employees
select last_name,to_char(salary*12,'0,00,000') AnnualSal from employees

--to_date - is used to convert character to the date
select employee_id,last_name,hire_date from employees where hire_date = 
to_date('June 17,03','Month dd,yy');

--to_number - Converts characters to number
select to_number('8,50,000','9,99,999')+100000 from dual


