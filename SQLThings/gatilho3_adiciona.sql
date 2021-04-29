
/* 
Gatilho 3
	->after an insert on Parish update corresponding County population 
*/

drop trigger if exists UpdateCountyPopulationAfterParishInsert;


create trigger UpdateCountyPopulationAfterParishInsert
after insert on Parish
begin
	update County
	set population = population + new.population
	where locID = new.countyID;
end;


