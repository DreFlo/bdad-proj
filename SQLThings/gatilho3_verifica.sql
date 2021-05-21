
/* 
Gatilho 3
	->after an insert on Parish update corresponding County population 
*/
.mode	columns
.headers	on
.nullvalue	NULL

select locID, caseNumber from Parish where locID = 1 or locID = 2;

update COVIDCase set parishID = 2 where caseID = 1;

select locID, caseNumber from Parish where locID = 1 or locID = 2;

