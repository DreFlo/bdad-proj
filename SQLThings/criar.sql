pragma foreign_keys = ON;

drop table if exists Country;

create table Country (
	locID number primary key not null,
	name text not null,
	caseNumber number,
	noVaccinated number,
	population number
);

drop table if exists District;

create table District (
	locID number primary key not null,
	name text not null,
	caseNumber number,
	noVaccinated number,
	population number,
	countryID number references Country(locID) not null
);

drop table if exists County;

create table County (
	locID number primary key not null,
	name text not null,
	caseNumber number,
	noVaccinated number,
	population number,
	districtID number references District(locID) not null
);

drop table if exists Parish;

create table Parish (
	locID number primary key not null,
	name text not null,
	caseNumber number,
	noVaccinated number,
	population number,
	countyID number references County(locID) not null
);

drop table if exists Vaccine;

create table Vaccine (
	vacID number primary key not null,
	name number not null,
	doseNumber number,
	check(doseNumber >= 1)
);

drop table if exists VaccinationAmount;

create table VaccinationAmount (
	parishID number references Parish(locID),
	vacID number references Vaccine(vacID),
	vaccination number,
	primary key(parishID, vacID)
);

drop table if exists Manufacturer;

create table Manufacturer (
	manID number primary key not null,
	name not null
);

drop table if exists VaccineManufacturer;

create table VaccineManufacturer (
	vacID number references Vaccine(vacID) not null,
	manID number references Manufacturer(manID) not null,
	primary key(vacID, manID)
);

drop table if exists Strain;

create table Strain (
	strainID number primary key not null,
	designation text not null,
	countryID number references Country(locID) not null
);

drop table if exists NursingHome;

create table NursingHome (
	nursingHomeID number primary key not null,
	name text
);

drop table if exists EmploymentSector;

create table EmploymentSector (
	sectorID number primary key not null,
	name text,
	contactFrequency number,
	check((contactFrequency >= 0 and contactFrequency <= 5) or contactFrequency == null)
);

drop table if exists Ethnicity;

create table Ethnicity (
	etniID number primary key not null,
	name text not null
);

drop table if exists COVIDCase;

create table COVIDCase (
	caseID number primary key not null,
	detectionDate number,
       	endDate number,
	birthYear number,
	outcome number,
	parishID number references Parish(locID) not null,
	strainID number references Strain(strainID) not null,
	nursingHomeID number references NursingHome(nursingHomeID),
	check(detectionDate <= endDate),
	check(outcome == 0 or outcome == 1 or outcome == 2)
);

drop table if exists EthnicityCOVIDCase;

create table EthnicityCOVIDCase (
	caseID number references COVIDCase(caseID) not null,
	etniID number references Ethnicity(etniID) not null
);

drop table if exists Hospital;

create table Hospital (
	hospitalID number primary key not null,
	name text,
	parishID references Parish(locID) not null
);

drop table if exists Hospitalization;

create table Hospitalization (
	hospStayID number primary key not null,
	startDate number,
	endDate number,
	hospitalID number references Hospital(hospitalID) not null,
	caseID number references COVIDCase(caseID) not null,
	check(startDate <= endDate)
);

drop table if exists ICUStay;

create table ICUStay (
	ICUStayID number primary key not null,
	startDate number,
	endDate number,
	hospStayID number references Hospitalization(hospStayID) not null,
	check(startDate <= endDate) 
);

drop table if exists Ventilation;

create table Ventilation (
	ventID number primary key not null,
	startDate number,
	endDate number,
	ICUStayID number references ICUStay(ICUStayID) not null,
	check(startDate >= endDate)
);

drop table if exists EmployedIn;

create table EmployedIn (
	caseID number references COVIDCase(caseID) not null,
	sectorID number references EmploymentSector(sectorID) not null,
	primary key(caseID, sectorID)
);

drop trigger if exists insert_employed_in;

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
