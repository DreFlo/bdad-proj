
/* Gatilho 3:
    ->do not allow a NursingHome to be added to a COVIDCase with an already registered EmploymentSector 
*/

drop trigger if exists CheckAlreadyEmployed;


create trigger CheckAlreadyEmployed 
before update on COVIDCase
begin
	select
		case
		when new.nursingHomeID not null
			then raise(abort, 'Cannot be employed and in nursing home')
		end
	from EmployedIn
	where caseID = new.caseID;
end;

