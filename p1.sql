-- Consider an Employee with a social security number (SSN) working on multiple projects with
-- definite hours for each. Each Employee belongs to a Department. Each project is associated with
-- some domain areas such as Database, Cloud and so on. Each Employee will be assigned to some
-- project. Assume the attributes for Employee and Project relations.
-- a) Mention the constraints neatly.
-- b) Design the ER diagram for the problem statement
-- c) State the schema diagram for the ER diagram.

-- CREATE table department(
--     Dno int primary key,
--     D_Name varchar(20)
-- );
CREATE TABLE employee
(
	SSN varchar(10) PRIMARY KEY,
	Name varchar(40) not null,
	DeptNo int
	-- references department(Dno) on delete cascade
);
CREATE TABLE project(
    p_no int primary key,
    p_name varchar(10),
    domain varchar(10)
    --dno int references department(Dno) on delete cascade
);

CREATE TABLE works_on(
    p_no int references project(p_no) on delete cascade ,
    ssn varchar(10) references employee(SSN) on delete cascade,
    hours int,
    primary key (p_no,ssn)
);

insert into employee values('1','Ram',1);
insert into employee values('2','Kam',2);
insert into employee values('3','Jam',3);
insert into employee values('4','Tam',4);

insert into project values(1,'ABC','Database');
insert into project values(2,'DEF','AIML');
insert into project values(3,'GHI','Blockchain');
insert into project values(4,'JKL','IOT');

insert into works_on values (1,1,3);
insert into works_on values (2,2,3);
insert into works_on values (3,3,3);
insert into works_on values (4,4,3);

select * from employee;
select * from project;
select * from works_on;

-- --1d) Create the tables, insert suitable tuples (min 6 each) and perform the following operations
-- in SQL
--  1. Obtain the details of employees assigned to “Database” project.
--  2. Find the number of employees working in each department with department
-- details.
--  3. Update the Project details of Employee bearing SSN = #SSN to ProjectNo =
-- #Project_No and display the same.
--  4. Retrieve the employee who has not been assigned more than two projects.

select  * from employee where ssn in
                              (select ssn from works_on where p_no in
                                                                      (select p_no from project where domain='Database'));
select count(ssn),DeptNo from employee
group by DeptNo;

update works_on set p_no = 3 where ssn='2';
select * from works_on;
select ssn,count(p_no)
from works_on
group by ssn
having count(p_no)<=3;
