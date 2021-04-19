
/* Gatilho 5:
    ->do not allow a Ventilation to start before or end after its corresponding ICUStay 
*/

drop trigger if exists CheckVentilationDates;

create trigger CheckVentilationDates 
before insert on Ventilation
begin
	select
		case                                                                                                      
		when new.startDate < startDate
			then raise(abort, 'Ventilation cannot start before ICUStay')
		when new.endDate > endDate
			then raise(abort, 'Ventilation cannot end after ICUStay')
		end 
	from ICUStay
	where ICUStayID = new.ICUStayID;	
end;

