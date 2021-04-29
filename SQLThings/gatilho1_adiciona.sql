
/* 
Gatilho 1
	->after a delete on Parish update corresponding County population 
*/

drop trigger if exists UpdateCountyPopulationAfterParishDelete;


create trigger UpdateCountyPopulationAfterParishDelete
after delete on Parish
begin
	update County
	set population = population - old.population
	where locID = old.countyID;
end;

