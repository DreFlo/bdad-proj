

drop trigger if exists insert_employed_in;

/* do not allow a COVIDCase already registered in a NursingHome to be added to EmployedIn */
create trigger insert_employed_in
before insert on EmployedIn
begin
	select 
		case 
		when nursingHomeID is not null
			then raise(abort, 'Cannot be employed and in nursing home')
		end
	from COVIDCase
    where caseID == new.caseID;
end;

drop trigger if exists update_COVIDCase;

/* do not allow a NursingHome to be added to a COVIDCase with an already registered EmploymentSector */
create trigger update_COVIDCase
before update on COVIDCase
begin
	select
		case
		when new.nursingHomeID not null
			then raise(abort, 'Cannot be employed and in nursing home')
		end
	from EmployedIn
	where caseID == new.caseID;
end;

drop trigger if exists insert_ICUStay;

/* do not allow an ICUStay to start before or end after its corresponding Hospitalization */
create trigger insert_ICUStay
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
	where hospStayID == new.hospStayID;
end;

drop trigger if exists insert_Ventilation;

/* do not allow a Ventilation to start before or end after its corresponding ICUStay */
create trigger insert_Ventilation
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
	where ICUStayID == new.ICUStayID;	
end;