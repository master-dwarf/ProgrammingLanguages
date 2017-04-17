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

commit;
rollback;

