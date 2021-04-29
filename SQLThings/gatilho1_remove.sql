
/* 
Gatilho 1
	->after a delete on Parish update corresponding County population 
*/

drop trigger if exists UpdateCountyPopulationAfterParishDelete;
