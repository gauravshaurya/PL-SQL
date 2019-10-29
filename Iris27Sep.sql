/*Q 1 : Write a query for the HR department to produce the addresses of all the departments . User the 
Locations and Countries table. Show the Location Id , street address , city , state_province and 
country in the output. Use a natural join to produce the result.*/

select location_id,street_address,city,state_province,country_name 
from locations natural join countries


/*Q 2 : The HR department needs a report of all the employees . write a query to display the last name, 
department number and department name for all employees.*/


select e.last_name,department_id,d.department_name from employees e join departments d 
using(department_id)



/*Q 3 : The HR department needs a report of employees in Toronto . Display the last name ,job ,
department number and department name for all employees who work in Toronto.*/

select last_name,job_id,department_id,department_name from 
employees join departments
using(department_id) join locations using (location_id) where city='Toronto'



/*Q 4 : Create a report to display the last name and employee number of employees along with their
manager's last name and manager number . Label the columns Employee , Emp# , Manager and Mgr# 
respectively.*/


select e.last_name Employee ,e.employee_id Emp#,m.last_name "Manager" ,m.manager_id Mgr# from employees e join
employees m on(e.manager_id=m.employee_id)

/*Q 5 : Create a report for the HR Department that displays the employee last names , department 
numbers , and all the employees who work in the same department as a given employee .
Give each column an appropriate label. [Use substitution variable]*/

select e.last_name, e.department_id from employees e join employees e2 
on (e.department_id=e2.department_id)
where e2.last_name='&name';



/*Q 6 : The HR department wants to determine the names of all employees who were hired after Davies . 
Create a query to display the last name and hire date of any employee hired after employee Davies.*/

select e.last_name,e.hire_date from employees e join employees e2
on(e.hire_date>e2.hire_date) where e2.last_name='Davies'

/*Q 7 : The HR department needs to find the names and hire dates for all employees who were hired 
before their managers , along with their manager's names and hire dates .*/

select e.last_name,e.hire_date,m.last_name,m.hire_date from employees e join employees m 
on(e.manager_id=m.employee_id)
where  e.hire_date<m.hire_date


/*Q 8 : WAQ to display Department name and total no. of employees in that department.
/*Q 9 : WAQ to display Department name and total no. of employees in that department . excluding those departments 
where count of employees is less than 5*/

--Decode
/*
DECODE(col|expression, search1, result1
[, search2, result2,...,]
[, default])
*/

SELECT last_name, job_id, salary,
DECODE(job_id, 'IT_PROG', 'U r an IT Professional',
'ST_CLERK', 'Hey U r a clerk',
'SA_REP', 'U r very cruical',
'U r gud for nothing')
REVISED_SALARY
FROM employees;

--Outer Join
create table Dept_1
(
DeptId varchar2(20) primary key,
DeptName varchar2(20)
)

create table Emp_1
(
EmpId int primary key,
EmpName varchar2(20),
DepartmentId varchar2(20) references Dept_1(DeptId)
)

insert into Dept_1 values('IT','Information');
insert into Dept_1 values('Admin','Administration');
insert into Dept_1 values('HR','Human Resource');
insert into Dept_1 values('Acc','Accounts');
insert into Dept_1 values('Sales','Sales  Marketing');

select * from Dept_1
select * from Emp_1

insert into Emp_1 values(1,'Shubhangi','HR');
insert into Emp_1 values(2,'Aakriti','HR');
insert into Emp_1 values(3,'Uroosa','IT');
insert into Emp_1 values(4,'Ayush','Acc')
insert into Emp_1 values(5,'Himanshu',null)

/*WAQ to display Employee Id , Name and DeptName*/
select EmpId,EmpName,DeptName from emp_1 join dept_1 on(DepartmentId=deptId)

--Outer Join
--right outer join
select EmpId,EmpName,DeptName from emp_1 right outer join dept_1 on(DepartmentId=deptId)

--left outer join
select EmpId,EmpName,DeptName from emp_1 left outer join dept_1 on(DepartmentId=deptId)

--full outer join
select EmpId,EmpName,DeptName from emp_1 full outer join dept_1 on(DepartmentId=deptId)

--Cross (Cartesian) Product
select empname,deptname from emp_1
cross join
dept_1

--Using Subqueries to Solve Queries :-
/*WAQ to display the last_name and hire_date of the employees who were hired after Davies*/

select last_name,hire_date from employees where hire_date>
(
select hire_date from employees where last_name='Davies'
)

--WHo has salary greater then Abel's salary
select * from employees where salary > (select salary from employees where last_name='Abel')
order by salary desc

--WAQ to display the second largest salary
select max(salary) from employees where salary < (select max(salary) from employees)

/*
Subqueries are of two types -
1. Single row subquery :-  If subquery is returning only row as result
2. Multi row subquery :- IF subquery is returning more than one row as result
*/

--WAQ to display the details of those employees whose salary is greater than all the Steven salary
select * from employees where salary > all (select salary from employees where first_name='Steven')

--Query to display details of those employees whose saary is greater  than any of the Steven's salary
select * from employees where salary > any (select salary from employees where first_name='Steven')

--Query to display details of those employees whose saary is equal to the any of the Steven's salary
select * from employees where salary in (select salary from employees where first_name='Steven')

--Multirow subquery :-
/*WAQ to display the details of those employees whose hire date is less than Steven's hire date*/
   select * from employees where hire_date<= all (select hire_date from employees where last_name='Steven')
select * from employees where hire_date<  any (select hire_date from employees where last_name='Steven')
select * from employees where hire_date in (select hire_date from employees where last_name='Steven')

/*
IN - Used for equality condition in Multi row subqueries
ANY ALL 
*/
  
--Details of those employees whose salary is equal to the minimum salary of each department.
select department_id,last_name,salary from employees where salary in (
  select min(salary) from employees group by department_id 
)

--Find the job with the minimum average salary
select job_id,avg(salary) from employees group by job_id 
having avg(salary)=(select min(avg(salary)) from employees group by job_id)


select * from employees where employee_id  not in 
(select manager_id from employees where manager_id is not null)

--Questions on Subqueries given in class :- 

--Insert 
select * from Dept_1

insert into Dept_1(DeptId,DeptName) values('HK','House Keeping')

--If u r inserting the data in columns of the table and u r inserting in the same order as that of
--column , no need to write column name
insert into Dept_1 values('Sec','Security')

--But if u want to insert the data only for the 1 or 2 columns not in all the columns of table
-- then u have to specify column name
insert into Dept_1(DeptId) values('Test Dept Id');
insert into Dept_1  values('Test Dept Id 1',null);

insert into DeptCopy values(30,'Purchasing',null,null)
select * from deptCopy

select * from emp_1

insert into Emp_1 values(6,'Yash','IT','24-Sep-2019')
insert into Emp_1 values(7,'Himanshu','Sales',sysdate)
insert into Emp_1 values(8,'Vikram','IT',to_date('Sep 24 , 2019','Mon dd , YYYY'))
insert into Emp_1 values(&EmpId,'&EmpName','&Department',sysdate)

--Copy the records from one table to another
insert into Emp_1(EmpId,EmpName,hire_date) select employee_id,last_name,hire_date from employees
where employee_id between 101 and 105

select * from EMp_1

--Update 
--Update tableName set columnName=value [where condition]
--Update tableName set columnName=value,columnName2=value,columnName=value [where condition]

Update Emp_1 set hire_date='24-Sep-2019' where empid in (2,3,4)
Update Emp_1 set hire_date=sysdate,departmentid='Admin' where empid=5
select * from Emp_1


create table EmployeesCopy as select * from employees

--Update employee 114’s job and salary to match that ofemployee 205.
--(Subquery in Update statement)
Update EmployeesCopy set job_id=(select job_id from EmployeesCopy where employee_id=205),
salary=(select salary from EmployeesCopy where employee_id=205) where employee_id=114

--Removing Rows from a table
select * from Emp_1

--will delete all the rows from the table
delete from Emp_1
delete from Emp_1 where departmentid is null

/*WAQ to delete all the employees who are working in the same as the department where 
department name consist of word Public*/

delete from employeescopy where department_id=(select department_id from departments where 
department_name like '%Public%')

--Truncate Statement 
Truncate table EmployeesCopy

insert into employeescopy select * from employees
commit


delete from employeescopy where employee_id between 100  and 200
savepoint deletedone

insert into employeescopy values(207,'A','B','kzdn','3242',sysdate,'hjfd',772,null,null,null)

savepoint insertdne

update employeescopy set hire_date=sysdate

rollback to insertdne --(rollback all the statement after insertdne)
select * from employeescopy

drop table stud_1

Create table Stud_1
(
StudentId int constraint spk primary key,
StudentName varchar2(50) not null,
JoiningDate date default sysdate,
Age number(2) constraint agecheck check(age>0),
AadharNumber int not null,
constraint uk unique(AadharNumber) --Table level constraint
) 

insert into Stud_1(StudentId,StudentName,Age) values(101,'Anshul',25);
insert into Stud_1(StudentId,StudentName,Age) values(102,'Abdul',21);
insert into Stud_1(StudentId,Age) values(103,21);

select * from User_Constraints where Table_NAME='STUD_1'

create table Item_1
(
ItemId number(6) constraint ipkk primary key,
ItemName varchar2(50) not null,
CostPrice number(5,2) constraint cpcheckk check(CostPrice>0),
SalesPrice number(5,2) ,
constraint spcheckk check(SalesPrice>CostPrice)
)
/*
Note :-If constraint is making involvment of another column , then Column level constraint is not
applicable , u have to go for Table  level constraint
*/

drop table Teacher_1
drop table Student_1

create table Teacher_1
(
TeacherId int constraint tpk primary key,
TecherName varchar2(20) not null
)

create table Student_1
(
StudentId int constraint spkk primary key,
StudentName varchar2(20) not null,
TeacherId int,
--constraint sfk foreign key(TeacherId) references Teacher_1(TeacherId)
--constraint sfk foreign key(TeacherId) references Teacher_1(TeacherId) on delete set null
constraint sfk foreign key(TeacherId) references Teacher_1(TeacherId) on delete cascade
)

insert into Teacher_1 values(&id,'&name')

insert into Student_1 values(&id,'&name',&tid)

select * From Student_1
select * from TEacher_1

delete from Teacher_1 where TeacherId=102



