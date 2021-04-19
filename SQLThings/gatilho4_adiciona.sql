

/* Gatilho 4:
    ->do not allow an ICUStay to start before or end after its corresponding Hospitalization 
*/

drop trigger if exists CheckICUStayDates;

create trigger CheckICUStayDates 
before insert on ICUStay
begin
	select
		case
		when new.startDate < startDate
			then raise(abort, 'ICUStay cannot start before Hospitalization')
		when new.endDate > endDate
			then raise(abort, 'ICUStay cannot end after Hospitalization')
		end
	from Hospitalization
	where hospStayID = new.hospStayID;
end;
