
/* Gatilho 1:
    -> do not allow a COVIDCase already registered in a NursingHome to be added to EmployedIn
*/

drop trigger if exists CheckAlreadyInNursingHome;

create trigger CheckAlreadyInNursingHome
before insert on EmployedIn
begin
	select 
		case 
		when nursingHomeID is not null
			then raise(abort, 'Cannot be employed and in nursing home')
		end
	from COVIDCase
    where caseID = new.caseID;
end;
