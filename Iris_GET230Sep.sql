--Writing Control Structures

set verify off
set serveroutput on

--e.g. 1
declare
    age number:=&age;
begin
    if age<15 then
        dbms_output.put_line('Hey U r a child');
    end if;
end;

--e.g. 2
declare
    age number:=&age;
begin
    if age<15 then
        dbms_output.put_line('Hey U r a child');
    else 
        dbms_output.put_line('U r not a child');
    end if;
end;

--e.g. 3
declare
    age number:=&age;
begin
    if age<15 then
        dbms_output.put_line('Hey U r a child');
    elsif age>15 and age<18 then
        dbms_output.put_line('U r young');
    elsif age>18 and age<35 then
        dbms_output.put_line('U r adult');    
    else 
        dbms_output.put_line('U r not a child');
    end if;
end;

/*If we are doing condition check on null variable then it will go to else condition*/

--e.g. of Case Expression
DECLARE
    grade CHAR(1) := UPPER('&grade');
    appraisal VARCHAR2(20);

BEGIN
    appraisal :=
    CASE grade
        WHEN 'A' THEN 'Excellent'
        WHEN 'B' THEN 'Very Good'
        WHEN 'C' THEN 'Good'
        ELSE 'No such grade'
    END;
    DBMS_OUTPUT.PUT_LINE ('Grade: '|| grade || ' Appraisal ' || appraisal);
END;

--e.g. 2 (Another version of Case Expression)
DECLARE
    grade CHAR(1) := UPPER('&grade');
    appraisal VARCHAR2(20);

BEGIN
    appraisal :=
    CASE 
        WHEN grade='A' THEN 'Excellent'
        WHEN grade in ('B','C') THEN 'Good'
        ELSE 'No such grade'
    END;
    DBMS_OUTPUT.PUT_LINE ('Grade: '|| grade || ' Appraisal ' || appraisal);
END;

/* Write  a PL\SQL block to take manager id from the user  . Now U have to fetch the department Id
and department name for that particular manager . U also need to find the total no of employees working
in that particularr manager's department.*/

declare 
    deptId departments.department_id%TYPE;
    deptName departments.department_name%TYPE;
    totalNoOfEmployees number;
    MgrId departments.manager_id%TYPE:=&ManagerId;
begin
    case MgrId 
        when 108 then
            select department_id,department_name into deptId,deptName
            from departments where manager_id=MgrId;
            select count(*) into totalNoOfEmployees from employees 
            where department_id=deptId;
     end case;
     dbms_output.put_line(totalNoOfEmployees|| ' working in department having department Id '||
     deptId||' and department name '||deptName);
end;
    
--e.g. of Basic Loop
declare 
    counter number:=1;
begin
    loop
        dbms_output.put_line('Hello I m Basic Loop');
        counter:=counter+1;
        exit when counter>5;;
    end loop;
end;

--If we wont specify the condition , then loop will execute only once ..

declare
    countryId locations.country_id%TYPE:='CA';
    locationId locations.location_id%TYPE;
    NewCity locations.city%TYPE:='Montreal';
    looper number:=1;
begin
    select max(location_id) into locationId from locations
    where country_id=countryId;
    loop
        insert into locations(location_id,city,country_id)
        values(locationId+looper,NewCity,countryId);
        looper:=looper+1;
        exit when looper>3;
    end loop;
end;


select * from locations

--e.g. of while loop
declare 
    counter number:=1;
begin
    while counter<=5 loop
        dbms_output.put_line('Hello I m Basic Loop');
        counter:=counter+1;
     end loop;
end;

--simple example of For Loop
begin
    for i IN  1..3  loop
    dbms_output.put_line('I m for loop '||i);
    end loop;
end;


begin
    for i IN REVERSE 1..3  loop
    dbms_output.put_line('I m for loop '||i);
    end loop;
end;

--With Exception Handling
declare
    l_name varchar2(20);
    f_name varchar2(20):='&name';
begin
    select last_name into l_name  from employees where first_name=f_name;
    dbms_output.put_line(f_name||' '||l_name);
Exception
    when TOO_MANY_ROWS OR NO_DATA_FOUND then
        dbms_output.put_line('Simple block can only fetch one row at a time');
    /*when NO_DATA_FOUND then
        dbms_output.put_line('Employee having first name '||f_name|| ' doesnt exist');*/
end;

--Exception Handling

--PRedefined Oracle Server Error'
declare
    ename varchar2(20);
begin
    select last_name into  ename from employees where employee_id in (101,105);
    exception 
    when TOO_MANY_ROWS then
    dbms_output.put_line('Query is returning more than 1 row '||SQLCODE||' '||SQLERRM);
end;


--Non Predefined Oracle Server Error
begin
    insert into Departments(Department_id,department_name) values(999,null);
    exception when others then
    dbms_output.put_line('Cant insert null into Department name');
end;

declare 
    myexcep EXCEPTION;
    PRAGMA EXCEPTION_INIT(myexcep,-01400);
begin
    insert into Departments(Department_id,department_name) values(999,null);
    exception when myexcep then
    dbms_output.put_line('Cant insert null into Department name '||SQLCODE||' '||SQLERRM);
    dbms_output.put_line(SQLERRM);
    
end;

--User definedd exception
declare
    age number:=&age;
    votingException exception;
begin
    if age>18 then
        dbms_output.put_line('U r eligible for voting');
    else 
         raise votingException;
    end if;
    exception
    when votingException then
        dbms_output.put_line('U r not eligible for voting');
end;
 
--e.g 2
declare
    deptNo number:=&DeptId;
    deptName varchar2(20):='GET';
    noDeptFoundExcep exception;
    pragma exception_init(noDeptFoundExcep,-01400);
begin
    Update Departments set department_name=deptName where department_id=deptNo;
    if SQL%NOTFOUND THEN
        raise noDeptFoundExcep;
    else 
        dbms_output.put_line('Department with Id '||deptNo||' updated');
    end if;
    exception
        when noDeptFoundExcep then
        dbms_output.put_line('No department found with Id '||deptNo);
        dbms_output.put_line('SQLCODE : '||SQLCODE);
end;

--raise_application_error
declare
    deptNo number:=&DeptId;
    deptName varchar2(20):='GET';
begin
    Update Departments set department_name=deptName where department_id=deptNo;
    if SQL%NOTFOUND THEN
        raise_application_error(-20201,'No Department exist');
    else 
        dbms_output.put_line('Department with Id '||deptNo||' updated');
    end if;
end;


--q 1
declare
    myexcep exception;
    pragma exception_init(myexcep,-02292);
begin
    delete from departments where department_id=40;
exception
    when myexcep then
    dbms_output.put_line('Department cant be deleted. bcz employees exist in that particular 
    department');
end;


--Q 2
DECLARE
    V_deptno number(2);
Begin
    V_deptno:='a';
exception 
    when VALUE_ERROR then
    dbms_output.put_line(SQLCODE||' '||SQLERRM);
End;

--Simple example of explicit cursor
declare
    empId number;
    lastName varchar2(20);
    cursor myCur is select Employee_Id,last_Name from employees;
begin
    open myCur;
    if myCur%isopen then
    loop
        fetch myCur into empId,lastName;
        exit when myCur%NOTFOUND;
        dbms_output.put_line(empId||' '||lastName);
    end loop;
    else dbms_output.put_line('Cursor is not opened');
    end if;
    close myCur;
end;

--e.g. 2 of cursor with Record type
declare
    cursor myCur is select Employee_Id,last_Name from employees;
    emp_data myCur%ROWTYPE;
begin
    open myCur;
    if myCur%isopen then
    loop
        fetch myCur into emp_data;
        exit when myCur%NOTFOUND;
        dbms_output.put_line(emp_data.employee_id||' '||emp_data.last_name);
    end loop;
    else dbms_output.put_line('Cursor is not opened');
    end if;
    close myCur;
end;




--e.g. 3 of Rowtype
declare
    emp employees%ROWTYPE;
begin
    select * into emp from employees where employee_id=101;
    dbms_output.put_line(emp.employee_id);
    dbms_output.put_line(emp.last_name);
end;

--e.g. 4 Cursor with For Loop
declare
    cursor myCur is select Employee_Id,last_Name from employees where employee_id between 101 and 105;
begin
    FOR emp_data IN myCur loop
        dbms_output.put_line(emp_data.employee_id||' '||emp_data.last_name);
    end loop;
end;












































--Record Type
Declare     
    TYPE emp_record_type IS RECORD
    (
    last_name varchar2(20),
    job_id varchar2(10),
    salary number(8,2)
    );
    emp_record emp_record_type;
begin 
    select last_name,job_id,salary into emp_record from employees where employee_id=&empId;
    dbms_output.put_line(emp_record.last_name||' '||emp_record.job_id||' '||emp_record.salary);
end;

--%ROWTYPE Attribute
Declare     
    emp_record employees%ROWTYPE;
begin 
    select * into emp_record from employees where employee_id=&empId;
    dbms_output.put_line(emp_record.last_name||' '||emp_record.job_id||' '||emp_record.salary);
end;

--Index By Tables or Associative Arrays
DECLARE
    TYPE ename_table Is TABLE of employees.last_name%TYPE 
    index BY PLS_INTEGER
    
    