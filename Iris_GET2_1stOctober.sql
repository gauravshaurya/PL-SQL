set serveroutput on

--Creating a function
Create or replace function getEmpSalary(eId employees.employee_id%TYPE) Return number IS
    eSal employees.salary%TYPE;
begin
    select salary into eSal from employees where employee_id=eId;
    return eSal;
end;

--Invoke function
execute dbms_output.put_line(getEmpSalary(100))
exec dbms_output.put_line(getEmpSalary(100))

--another way of invoking function
set autoprint on
Variable Salary number
execute :Salary:=getEmpSalary(101)

--Invoking function in PLSQL Block
declare
    sal employees.salary%TYPE;
begin
    sal:=getEmpSalary(102);
    dbms_output.put_line('Salary '||sal);
end;

--Calling a function in SQL Query...
select employee_id,last_name,getEmpSalary(employee_id) from employees

execute dbms_output.put_line(SUM1(56,5));
select sum1(56,5) from dual

select * from User_1

---
create or replace function dml_call_sql(p_sal NUMBER) RETURN NUMBER IS
BEGIN
    insert into employees(employee_id,last_name,hire_date,job_id,salary)
    values(1,'Frost',sysdate,'SA_MAN',p_sal);
    return (p_sal+100);
END;

--want to call this function in the DML Statement
Update employees set salary=dml_call_sql(100) where employee_id=170


drop function SUM1
select SUM1(78,9) from dual

DESCRIBE USER_SOURCE
select * from USER_SOURCE where name='GETEMPSALARY'

--Stored Procedure 
Create or replace procedure raise_salary(
    empId IN employees.employee_id%TYPE,
    NewSal IN employees.salary%TYPE
)
Is
begin
    Update employees set salary=(salary+NewSal) 
    where employee_id=empId;
end;

--Invoke
execute raise_salary(&empID,&NewSal)

--eg. 2
create or replace procedure create or replace procedure getEmployeeById(
    EmpId IN employees.employee_id%TYPE,
    LName OUT employees.last_name%TYPE,
    doj OUT employees.hire_date%TYPE
)
IS
begin
    select last_name,hire_date into LName,doj from employees
    where employee_id=empId;
end;
(
    EmpId IN employees.employee_id%TYPE,
    LName OUT employees.last_name%TYPE,
    doj OUT employees.hire_date%TYPE
)
IS
begin
    select last_name,hire_date into LName,doj from employees
    where employee_id=empId;
end;


--Invoke 1 way
declare
    eId number:=&employeeId;
    last_Name employees.last_name%TYPE;
    dateOfJoining employees.hire_date%TYPE;
begin
    getEmployeeById(eId,last_Name,dateOfJoining);
    dbms_output.put_line('Employee Id : '||eId );
    dbms_output.put_line('Employee Name : '||last_Name );
    dbms_output.put_line('Employee DOJ : '||dateOfJoining );
end;


--Invoke 2 way
VARIABLE ename varchar2(25)
variable edate varchar2(25)
set autoprint on

execute getEmployeeById(&EmpId,lastName=>:ename,doj=>:edate)

--e.g. 3
Create or replace procedure formatPhone(
    phNO IN OUT varchar2 
)
IS
begin
    phNo:='+91'||phNo;
end;

VARIABLE Ph_No VARCHAR2(25)
EXECUTE :Ph_No:='&phNo';

execute formatPhone(:Ph_No)

--Example of Default
Create or replace procedure addDeptProc (
    deptname departments.department_name%TYPE:='ABC Department',
    loc departments.location_id%TYPE DEFAULT 1700
)
Is
begin
    insert into Departments(department_id,department_name,location_id)
    values(15,deptname,loc);
end;

execute addDeptProc('ADVERTISING',1200)
execute addDeptProc(deptName=>'ADVERTISING New')
execute addDeptProc()
rollback
select * from departments


--e.g.
Create procedure addDept(
    DeptName Departments.Department_name%TYPE,
    MgrId Departments.Manager_Id%TYPE,
    LocId Departments.Location_Id%TYPE
)
Is
begin

    insert into Departments values(
    Departments_seq.nextval,DeptName,MgrId,LocId);
    dbms_output.put_line('Department with name '||deptName||' added');
exception
    when others then
        dbms_output.put_line('Ex in adding department '||deptName);
end;

create procedure addDeptCall Is
begin
    addDept('Media',100,1800);
    addDept('Editing',99,1800);
    addDept('Advertising',101,1800);
end;

execute addDeptCall

--e.g.1
Create or replace Trigger secure_emp
BEFORE
INSERT 
ON Employees
begin
    if(to_char(sysdate,'DY') IN ('MON','TUE')) THEN
        raise_application_Error(-20500,'U can insert in fix days.');
    end if;
end;

--e.g. 2
Create or replace Trigger secure_emp_2
BEFORE
INSERT OR UPDATE OR DELETE
ON Employees
begin
    if(to_char(sysdate,'DY') IN ('MON','TUE')) THEN
        if DELETING then 
            raise_application_error(-20500,'U cant delete employees on Mon and Tues');
        elsif INSERTING then  
            raise_application_error(-20500,'U cant insert employees on Mon and Tues');
        elsif UPDATING then  
        raise_application_error(-20500,'U cant update employees on Mon and Tues');
        end if;
    end if;
end;



insert into Employees(employee_id,last_name) values(1012,'ABC')
delete from employees
Update employees set employee_id=102

--eg 3
create or replace trigger tr3
before
insert or update
on employees
for each row
begin
    dbms_output.put_line('New Job Id : '||:New.job_id);
    dbms_output.put_line('Old Job Id : '||:Old.job_id);
end;

insert into employees(employee_id,last_name,job_id) values(1525,'Garg','ABC JOB')
Update employees set Job_id='Trainer' where employee_id=101 



--eg 4
create or replace trigger tr4
before
insert or update
on employees
for each row
begin
    if (:New.salary > 35000) and (NOT :New.job_id in ('AD_VP','AD_PRES'))then
        raise_application_error(-20500,'No employee can have salary greater than 35000');
    end if;
end;

insert into employees(employee_id,last_name,job_id,salary,
email,hire_date) values(1525,'Garg','AD',45000,'a@gmail.com',sysdate)
Update employees set salary=45000 where employee_id=101 



--e.g. 5
Create table Audit_emp
(
    performedBy varchar2(100),
    performedOn date,
    OldJobId varchar2(20),
    NewJobId varchar2(20)
)

create trigger auditTr 
after insert or update or delete
on employees
for each row
begin
    insert into audit_emp values(User,sysdate,:Old.job_id,:New.job_id);
end;


insert into employees(employee_id,last_name,job_id,salary,
email,hire_date) values(1526,'Garg','AD_PRES',45000,'a1@gmail.com',sysdate)
Update employees set Job_id='ST_CLERK' where employee_id=1526
delete from employees where employee_id=1526



select * from Audit_emp





