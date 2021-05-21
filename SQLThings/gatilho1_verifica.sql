
/* 
Gatilho 1
	->after a delete on Parish update corresponding County population 
*/

.mode	columns
.headers	on
.nullvalue	NULL

Insert Into Parish Values(101, "Parish 101", 0, 0, 10, 4);
Update County Set population = population + 10 where locID = 4;

Select population From County Where locID = 4;

Delete From Parish Where locID = 101;

Select population From County Where locID = 4;
