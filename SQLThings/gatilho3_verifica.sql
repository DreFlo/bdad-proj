
/* 
Gatilho 3
	->after an insert on Parish update corresponding County population 
*/


select population from County where locID = 1;

insert into Parish values(100, "Parish 100", 0, 0, 10, 1);

select population from County where locID = 1;

