
/* Gatilho 2:
    ->do not allow to be unemployed and employed in another sector 
*/

drop trigger if exists CheckNotUnemployed;

create trigger CheckNotUnemployed
before insert on EmployedIn
begin
	select
		case
		when (sectorID = 0 and new.sectorID <> 0) or (sectorID <> 0 and new.sectorID = 0)
			then raise(abort, 'Cannot be unemployed and employed in another sector')
		end
		from EmployedIn
	where caseID = new.caseID;
end;

