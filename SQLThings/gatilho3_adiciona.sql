
/* 
Gatilho 3
	->after an update on COVIDCase update Parish caseNumber 
*/

/* after update on COVIDCase update corresponding Parish's caseNumber */
create trigger UpdateParishCaseNumberAfterCaseUpdate
after update on COVIDCase
begin
	update Parish
	set caseNumber = caseNumber + 1
	where locID = new.parishID;

	update Parish
	set caseNumber = caseNumber - 1 
	where locID = old.parishID;
end;


