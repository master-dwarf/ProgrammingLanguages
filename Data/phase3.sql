use hilgeg46;

-- Query for use case 1
-- The Query below illistrates how a staff member could display names
-- and email addresses of all Hessen students, ordered by the home Hessen
-- institute along with their frist and second choice for a UW system campus

select '***' from dual;
select 'Use Case 1' from dual;
select '***' from dual;

select t4.email,t4.first_name,t4.last_name,t4.institue_name as firstChoice,t5.institue_name as secondChoice
from institutes as t5 inner join
	(select t3.email,t3.first_name,t3.last_name,t3.sending_institute_id,t4.institue_name,t3.institute_id_2
	from institutes as t4 inner join
		(select t1.email, t1.first_name,t1.last_name,t1.sending_institute_id,t2.institute_id_1,t2.institute_id_2
		from student_choice_of_schools as t2 inner join
			(select t1.email, t1.first_name, t1.last_name, t1.sending_institute_id
				from student_names as t1
				where t1.citizenship <> "United States") as t1
		where t2.students_email = t1.email) as t3
	where t4.institute_ID = t3.institute_id_1) as t4
where t5.institute_ID = t4.institute_id_2
order by t4.sending_institute_id;

use hilgeg46;

-- Query for use case 2
-- The Query below illistrates how a staff member could display names
-- and email addresses of all UW students, ordered by the home UW institute
-- along with their frist and second choice for a Hessen system campus

select '***' from dual;
select 'Use Case 2' from dual;
select '***' from dual;

select t4.email,t4.first_name,t4.last_name,t4.institue_name as firstChoice,t5.institue_name as secondChoice
from institutes as t5 inner join
	(select t3.email,t3.first_name,t3.last_name,t3.sending_institute_id,t4.institue_name,t3.institute_id_2
	from institutes as t4 inner join
		(select t1.email, t1.first_name,t1.last_name,t1.sending_institute_id,t2.institute_id_1,t2.institute_id_2
		from student_choice_of_schools as t2 inner join
			(select t1.email, t1.first_name, t1.last_name, t1.sending_institute_id
				from student_names as t1
				where t1.citizenship = "United States") as t1
		where t2.students_email = t1.email) as t3
	where t4.institute_ID = t3.institute_id_1) as t4
where t5.institute_ID = t4.institute_id_2
order by t4.sending_institute_id;

use hilgeg46;

-- Query for use case 3
-- The Query below illistrates how a staff member could display the 
-- names and email addresses of all UW students ordered by the term
-- they are applying for study.


select '***' from dual;
select 'Use Case 3' from dual;
select '***' from dual;

Select t1.first_name, t1.last_name, t1.email
from student_names as t1
where t1.citizenship = "United States"
order by t1.term_id;

use hilgeg46;

-- Query for use case 4
-- The Query below illistrates how a staff member could display 
-- the requested courses for a peticular student

select '***' from dual;
select 'Use Case 4' from dual;
select '***' from dual;

(select one,two,three,four,five,six,seven,t10.course_name as eight
from course as t10 inner join
	(select one,two,three,four,five,six,t9.course_name as seven,t8.course_id_8
	from course as t9 inner join
		(select one,two,three,four,five,t8.course_name as six,t7.course_id_7,t7.course_id_8
		from course as t8 inner join
			(select one,two,three,four,t7.course_name as five,t6.course_id_6,t6.course_id_7,t6.course_id_8
			from course as t7 inner join
				(select one,two,three,t6.course_name as four,t5.course_id_5,t5.course_id_6,t5.course_id_7,t5.course_id_8
				from course as t6 inner join
					(select one,two,t5.course_name as three,t4.course_id_4,t4.course_id_5,t4.course_id_6,t4.course_id_7,t4.course_id_8
					from course as t5 inner join
						(select one,t4.course_name as two,t3.course_id_3,t3.course_id_4,t3.course_id_5,t3.course_id_6,t3.course_id_7,t3.course_id_8
						from course as t4 inner join
							(select t3.course_name as one,t2.course_id_2,t2.course_id_3,t2.course_id_4,t2.course_id_5,t2.course_id_6,t2.course_id_7,t2.course_id_8
							from course as t3 inner join
								(select t1.course_id_1,t1.course_id_2,t1.course_id_3,t1.course_id_4,t1.course_id_5,t1.course_id_6,t1.course_id_7,t1.course_id_8
								from student_requests_courses as t1
								where t1.student_email = "et.arcu@elitNulla.ca") as t2
							where t3.course_ID = t2.course_id_1) as t3
						where t4.course_ID = t3.course_id_2) as t4
					where t5.course_ID = t4.course_id_3) as t5
				where t6.course_ID = t5.course_id_4) as t6
			where t7.course_ID = t6.course_id_5) as t7
		where t8.course_ID = t7.course_id_6) as t8
	where t9.course_ID = t8.course_id_7) as t9
where t10.course_ID = t9.course_id_8);

use hilgeg46;

-- Query for use case 5
-- The Query below illistrates how a staff member could display
-- the name and role of a UW staff member grouped by their home campus 

select '***' from dual;
select 'Use Case 5' from dual;
select '***' from dual;

select t1.name, t1.position as role
from adviser as t1
where t1.position like "UW%"
order by t1.institute_id;

use hilgeg46;

-- Query for use case 6
-- The Query below illistrates how a staff member could display
-- the first and last names of UW students who have a certain adviser

select '***' from dual;
select 'Use Case 6' from dual;
select '***' from dual;

select t3.first_name, t3.last_name
from student_names as t3 inner join	
    (select t2.student_email
	from student_has_adviser as t2 inner join
		(select t1.email
		from adviser as t1
		where t1.position like "UW%" 
		and t1.email = "pellentesque.Sed.dictum@molestietellus.net") as t1
	where t1.email = t2.adviser_email) as t2
where t2.student_email = t3.email;

use hilgeg46;

-- Query for use case 7
-- The Query below illistrates how a staff member could display
-- the email and cell phone number of students who have not yet
-- completed their application.

select '***' from dual;
select 'Use Case 7' from dual;
select '***' from dual;

select t1.email, t1.cell_phone, t1.institue_name,t2.completed
from application as t2 inner join
	(Select t1.first_name, t1.last_name, t1.email,t1.institue_name, t1.application_number, t2.cell_phone
	from student_has_cellphone as t2 inner join
		(select t1.first_name, t1.last_name, t1.email, t2.institue_name, t1.application_number
		from institutes as t2 inner join
			(select t1.email, t1.first_name, t1.last_name, t1.sending_institute_id, t1.application_number
			from student_names as t1) as t1
		where t2.institute_ID = t1.sending_institute_id) as t1
	where t2.student_email = t1.email) as t1
where t2.application_number = t1.application_number
having t2.completed = "False"
and t1.institue_name like "UW L%"
order by t1.institue_name;

use hilgeg46;

-- Query for use case 9
-- The Query below illistrates how a staff member could display
-- the email and cell phone number of students who have not yet
-- completed their application.

select '***' from dual;
select 'Use Case 9' from dual;
select '***' from dual;

begin;

select t2.first_name, t2.last_name
from student_names as t2 inner join
	(select t1.application_number
	from application as t1
	where t1.completed = "False") as t1
where t2.application_number = t1.application_number
and t2.application_number = 3;

update application
set completed = "True"
where application_number = 3;

select t2.first_name, t2.last_name
from student_names as t2 inner join
	(select t1.application_number
	from application as t1
    where t1.completed = "True") as t1
where t2.application_number = t1.application_number
and t2.application_number = 3;

rollback;

use hilgeg46;

-- Query for use case 10
-- The Query below illistrates how a staff member could display
-- the name of a student who got accepted by a school of their choice

select '***' from dual;
select 'Use Case 10' from dual;
select '***' from dual;

begin;

select t2.first_name, t2.last_name
from student_names as t2 inner join
	(select t1.application_number
	from application as t1
	where t1.accepted = "False") as t1
where t2.application_number = t1.application_number
and t2.application_number = 37;

update application
set accepted = "True"
where application_number = 37;

select t2.first_name, t2.last_name
from student_names as t2 inner join
	(select t1.application_number
	from application as t1) as t1
where t2.application_number = t1.application_number
and t2.application_number = 37;

rollback;

use hilgeg46;

-- Query for use case 12
-- The Query below illistrates how a staff member could display
-- the number of applicants and seats remaining for a given year 
-- for institutes students applied to

select '***' from dual;
select 'Use Case 12' from dual;
select '***' from dual;

select count(t1.applicant) as applicants, (t2.seats - count(t1.applicant)) as remainingSeats
from institutes as t2 inner join
	(select t1.year, t1.receiving_institute_id, t1.receiving_institute_id as applicant
	from student_names as t1
	where t1.year = 2013) as t1
where t2.institute_ID = t1.receiving_institute_id
group by t1.receiving_institute_id;

use hilgeg46;

-- Query for use case 13
-- The Query below illistrates how a staff member could display
-- names of students from UW system schools who's applications 
-- have been denied

select '***' from dual;
select 'Use Case 13' from dual;
select '***' from dual;

select t2.first_name, t2.last_name
from student_names as t2 inner join
	(select t1.application_number
	from application as t1
	where t1.accepted = "False") as t1
where t2.application_number = t1.application_number
and t2.citizenship = "United States";

use hilgeg46;

-- Query for use case 14
-- The Query below illistrates how a staff member could display
-- the total number of students from Hessen who are going for a
-- bachelors or undergraduate degree and a masters or graduate degree
-- for a given term.

select '***' from dual;
select 'Use Case 14' from dual;
select '***' from dual;

select bachelors, masters
from 
(select count(t1.undergrad_or_grad) as bachelors
	from student_names as t1
    where undergrad_or_grad = "UG"
    and t1.citizenship <> "United States"
	and term_id = 2) as t1 join 
(select count(t2.undergrad_or_grad) as masters
		from student_names as t2
		where undergrad_or_grad = "G"
        and t2.citizenship <> "United States"
        and term_id = 2) as t2;

use hilgeg46;        
        
-- Query for use case 15
-- The Query below illistrates how a staff member could display
-- the total number of students from the UW system who are going for a
-- bachelors or undergraduate degree and a masters or graduate degree
-- for a given term
        
select '***' from dual;
select 'Use Case 15' from dual;
select '***' from dual;
        
select bachelors, masters
from 
(select count(t1.undergrad_or_grad) as bachelors
	from student_names as t1
    where undergrad_or_grad = "UG"
    and t1.citizenship = "United States"
	and term_id = 2) as t1 join 
(select count(t2.undergrad_or_grad) as masters
		from student_names as t2
		where undergrad_or_grad = "G"
        and t2.citizenship = "United States"
        and term_id = 2) as t2;
        
use hilgeg46;        
        
-- Query for use case 16
-- The Query below illistrates how a staff member could display
-- the FTE status for the Hessen students who are going for a
-- bachelors degree and masters degree given for a given term
        
select '***' from dual;
select 'Use Case 16' from dual;
select '***' from dual;
        
select round(bachelors,4) as bachelorFTE, round(masters,4) as mastersFTE
from 
(select sum(t1.undergrad_FTE) as bachelors
	from student_names as t1
    where t1.citizenship <> "United States"
	and term_id = 2) as t1 join 
(select sum(t2.G_FTE_withdrawl) as masters
		from student_names as t2
        where t2.citizenship<> "United States"
        and term_id = 2) as t2;
        
use hilgeg46;        
        
-- Query for use case 17
-- The Query below illistrates how a staff member could display
-- the FTE status for all the UW system students for a given term
        
select '***' from dual;
select 'Use Case 17' from dual;
select '***' from dual;
        
select round(bachelors,4) as bachelorFTE, round(masters,4) as mastersFTE
from 
(select sum(t1.undergrad_FTE) as bachelors
	from student_names as t1
    where t1.citizenship = "United States"
	and term_id = 2) as t1 join 
(select sum(t2.G_FTE_withdrawl) as masters
		from student_names as t2
        where t2.citizenship = "United States"
        and term_id = 2) as t2;
        
use hilgeg46;        
        
-- Query for use case 18
-- The Query below illistrates how a staff member could update
-- the state of which the student has been accepted,rejected or withdrawn

select '***' from dual;
select 'Use Case 18' from dual;
select '***' from dual;

begin;

select t1.first_name, t1.last_name, t1.accepted
from institutes as t2 inner join
	(select t2.first_name, t2.last_name, t2.sending_institute_id, t1.accepted
	from student_names as t2 inner join
		(select t1.application_number, t1.accepted
		from application as t1
		where accepted <> "withdraw"
		and t1.application_number = 11) as t1
	where t1.application_number = t2.application_number) as t1
where t1.sending_institute_id = t2.institute_ID;

update application
set application.accepted = "withdraw"
where application.application_number = 11;

select t1.first_name, t1.last_name, t1.accepted
from institutes as t2 inner join
	(select t2.first_name, t2.last_name, t2.sending_institute_id, t1.accepted
	from student_names as t2 inner join
		(select t1.application_number, t1.accepted
		from application as t1
		where t1.application_number = 11) as t1
	where t1.application_number = t2.application_number) as t1
where t1.sending_institute_id = t2.institute_ID;

rollback;
        
use hilgeg46;        
        
-- Query for use case 21
-- The Query below illistrates how a staff member could update
-- the fee that the UW student has to pay for the application.
        
select '***' from dual;
select 'Use Case 21' from dual;
select '***' from dual;
        
begin;

select t1.institue_name, t1.fee
from institutes as t1
where t1.institue_name = "UW Madison";

update institutes
set fee = 350
where institutes.institue_name = "UW Madison"
and institute_ID = 9;

select t1.institue_name, t1.fee
from institutes as t1
where t1.institue_name = "UW Madison";

rollback;