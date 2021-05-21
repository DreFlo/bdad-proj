pragma foreign_keys = ON;

drop table if exists Country;

create table Country (
	locID integer constraint Country_PK primary key,
	name text constraint Country_name_not_null not null,
	caseNumber integer default 0,
	noVaccinated integer default 0,
	population integer default 0
);

drop table if exists District;

create table District (
	locID integer constraint District_PK primary key,
	name text constraint District_name_not_null not null,
	caseNumber integer default 0,
	noVaccinated integer default 0,
	population integer default 0,
	countryID integer constraint District_FK references Country(locID) on delete cascade on update cascade not null
);

drop table if exists County;

create table County (
	locID integer constraint Country_PK primary key,
	name text constraint County_name_not_null not null,
	caseNumber integer default 0,
	noVaccinated integer default 0,
	population integer default 0,
	districtID integer constraint County_FK references District(locID) on delete cascade on update cascade not null 
);

drop table if exists Parish;

create table Parish (
	locID integer constraint Parish_PK primary key,
	name text constraint Parish_name_not_null not null,
	caseNumber integer default 0,
	noVaccinated integer default 0,
	population integer default 0,
	countyID integer constraint Parish_FK references County(locID) on delete cascade on update cascade not null 
);

drop table if exists Vaccine;

create table Vaccine (
	vacID integer constraint Vaccine_PK primary key,
	name integer constraint Vaccine_name_unique unique not null,
	doseNumber integer constraint Vaccine_doses_greater_than_one check(doseNumber >= 1) not null
);

drop table if exists VaccinationAmount;

create table VaccinationAmount (
	parishID integer constraint VaccinationAmount_Parish_FK references Parish(locID) on delete restrict on update cascade not null,
	vacID integer constraint VaccinationAmount_Vaccine_FK references Vaccine(vacID) on delete restrict on update cascade not null,
	vaccinationNumber integer constraint vaccinationNumber_range check(vaccinationNumber >= 0),
	constraint VaccinationAmount_PK primary key(parishID, vacID)
);

drop table if exists Manufacturer;

create table Manufacturer (
	manID integer constraint Manufacturer_PK primary key,
	name text constraint Manufacturer_name_not_null unique not null
);

drop table if exists VaccineManufacturer;

create table VaccineManufacturer (
	vacID integer constraint VaccineManufacturer_Vaccine_FK references Vaccine(vacID) on delete restrict on update cascade not null,
	manID integer constraint VaccineManufacturer_Manufacturer_FK references Manufacturer(manID) on delete restrict on update cascade not null,
	constraint VaccineManufacturer_PK primary key(vacID, manID)
);

drop table if exists Strain;

create table Strain (
	strainID integer constraint Strain_PK primary key,
	designation text constraint Strain_name_not_null unique not null,
	countryID integer constraint Strain_FK references Country(locID) on delete restrict on update cascade not null
);

drop table if exists NursingHome;

create table NursingHome (
	nursingHomeID integer constraint NursingHome_PK primary key,
	name text
);

drop table if exists EmploymentSector;

create table EmploymentSector (
	sectorID integer constraint EmploymentSector_PK primary key,
	name text constraint EmploymentSector_name_unique unique not null,
	contactFrequency integer,
	constraint contactFrequencyRange check((contactFrequency >= 0 and contactFrequency <= 5 and contactFrequency is not null and sectorID != 0) or (sectorID == 0 and contactFrequency is null))
);

drop table if exists Ethnicity;

create table Ethnicity (
	ethniID integer constraint Ethnicity_PK primary key,
	name text constraint Ethnicity_name_unique unique not null
);

drop table if exists COVIDCase;

create table COVIDCase (
	caseID integer constraint COVIDCase_PK primary key,
	detectionDate date,
    endDate date,
	birthYear integer,
	outcome integer,
	parishID integer constraint COVIDCase_Parish_FK references Parish(locID) on delete restrict on update cascade not null,
	strainID integer constraint COVIDCase_Strain_FK references Strain(strainID) on delete restrict on update cascade not null,
	nursingHomeID integer constraint COVIDCase_NursingHome_FK references NursingHome(nursingHomeID) on delete restrict on update cascade,
	constraint date_range check(detectionDate <= endDate),
	constraint outcome_range check(outcome >= 0 and outcome <= 2)
);

drop table if exists EthnicityCOVIDCase;

create table EthnicityCOVIDCase (
	caseID integer constraint EthnicityCOVIDCase_COVIDCase_FK references COVIDCase(caseID) on delete cascade on update cascade not null,
	ethniID integer constraint EthnicityCOVIDCase_Ethnicity_FK references Ethnicity(ethniID) on delete restrict on update cascade not null,
	constraint EthnicityCOVIDCase_PK primary key(caseID, ethniID)
);

drop table if exists Hospital;

create table Hospital (
	hospitalID integer constraint Hospital_PK primary key,
	name text,
	parishID constraint Hospital_FK references Parish(locID) on delete restrict on update cascade not null
);

drop table if exists Hospitalization;

create table Hospitalization (
	hospStayID integer constraint Hospitalization_PK primary key,
	startDate date,
	endDate date,
	hospitalID integer constraint Hospitalization_Hospital_FK references Hospital(hospitalID) on delete restrict on update cascade not null,
	caseID integer constraint Hospitalization_COVIDCase_FK references COVIDCase(caseID) on delete cascade on update cascade unique not null,
	constraint date_range check(startDate <= endDate)
);

drop table if exists ICUStay;

create table ICUStay (
	ICUStayID integer constraint ICUStay_PK primary key,
	startDate date,
	endDate date,
	hospStayID integer constraint ICUStay_FK references Hospitalization(hospStayID) on delete cascade on update cascade not null,
	constraint date_range check(startDate <= endDate) 
);

drop table if exists Ventilation;

create table Ventilation (
	ventID integer constraint Ventilation_PK primary key,
	startDate date,
	endDate date,
	ICUStayID integer constraint Ventilation_FK references ICUStay(ICUStayID) on delete cascade on update cascade not null,
	constraint date_range check(startDate <= endDate)
);

drop table if exists EmployedIn;

create table EmployedIn (
	caseID integer constraint EmployedIn_COVIDCase_FK references COVIDCase(caseID) on delete cascade on update cascade not null,
	sectorID integer constraint EmployedIN_EmploymentSector_FK references EmploymentSector(sectorID) on delete restrict on update cascade not null,
	constraint EmployedIn_PK primary key(caseID, sectorID)
);

/*
TRIGGERS-------------------------------------------------------------------------------------------------
*/

drop trigger if exists UpdateCountyPopulationAfterParishInsert;


create trigger UpdateCountyPopulationAfterParishInsert
after insert on Parish
begin
	update County
	set population = population + new.population
	where locID = new.countyID;
end;

drop trigger if exists CheckICUStayDates;

/* do not allow an ICUStay to start before or end after its corresponding Hospitalization */
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

drop trigger if exists CheckVentilationDates;

/* do not allow a Ventilation to start before or end after its corresponding ICUStay */
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

drop trigger if exists CheckAlreadyInNursingHome;

/* do not allow a COVIDCase already registered in a NursingHome to be added to EmployedIn */
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

drop trigger if exists CheckAlreadyEmployed;

/* do not allow a NursingHome to be added to a COVIDCase with an already registered EmploymentSector */
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

drop trigger if exists UpdateParishNoVaccinatedAfterVaccinationAmmountInsert;

create trigger UpdateParishNoVaccinatedAfterVaccinationAmmountInsert
after insert on VaccinationAmount
begin
	update Parish
	set noVaccinated = noVaccinated + new.vaccinationNumber
	where locID = new.parishID;
end;

drop trigger if exists UpdateParishNoVaccinatedAfterVaccinationAmmountDelete;

create trigger UpdateParishNoVaccinatedAfterVaccinationAmmountDelete
after delete on VaccinationAmount
begin
	update Parish
	set noVaccinated = noVaccinated - old.vaccinationNumber
	where locID = old.parishID;
end;

drop trigger if exists UpdateParishNoVaccinatedAfterVaccinationAmmountUpdate;

create trigger UpdateParishNoVaccinatedAfterVaccinationAmmountUpdate
after update on VaccinationAmount
begin
	update Parish
	set noVaccinated = noVaccinated + new.vaccinationNumber
	where locID = new.parishID;

	update Parish
	set noVaccinated = noVaccinated - old.vaccinationNumber
	where locID = old.parishID;
end;

drop trigger if exists UpdateParishCaseNumberAfterCaseInsert;

/* after insert on COVIDCase update corresponding Parish's caseNumber */
create trigger UpdateParishCaseNumberAfterCaseInsert
after insert on COVIDCase
begin
	update Parish
	set caseNumber = caseNumber + 1
	where locID = new.parishID;
end;

drop trigger if exists UpdateParishCaseNumberAfterCaseDelete;

/* after deletion on COVIDCase update corresponding Parish's caseNumber */
create trigger UpdateParishCaseNumberAfterCaseDelete
after delete on COVIDCase
begin
	update Parish
	set caseNumber = caseNumber - 1
	where locID = old.parishID;
end;

drop trigger if exists UpdateCountyAfterParishUpdate;

/* after update on Parish update corresponding County's caseNumber */
create trigger UpdateCountyAfterParishUpdate
after update on Parish
begin
	update County
	set caseNumber = caseNumber + new.caseNumber, noVaccinated = noVaccinated + new.noVaccinated, population = population + new.population
	where locID = new.countyID;

	update County
	set caseNumber = caseNumber - old.caseNumber, noVaccinated = noVaccinated - old.noVaccinated, population = population - old.population
	where locID = old.countyID;
end;

drop trigger if exists UpdateDistrictAfterCountyUpdate;

/* after update on County update corresponding District's caseNumber */
create trigger UpdateDistrictAfterCountyUpdate
after update on County
begin
	update District
	set caseNumber = caseNumber + new.caseNumber, noVaccinated = noVaccinated + new.noVaccinated, population = population + new.population
	where locID = new.districtID;

	update District
	set caseNumber = caseNumber - old.caseNumber, noVaccinated = noVaccinated - old.noVaccinated, population = population - old.population
	where locID = old.districtID;
end;

drop trigger if exists UpdateCountryAfterDistrictUpdate;

/* after update on County update corresponding District's caseNumber */
create trigger UpdateCountryAfterDistrictUpdate
after update on District
begin
	update Country
	set caseNumber = caseNumber + new.caseNumber, noVaccinated = noVaccinated + new.noVaccinated, population = population + new.population
	where locID = new.countryID;

	update Country
	set caseNumber = caseNumber - old.caseNumber, noVaccinated = noVaccinated - old.noVaccinated, population = population - old.population
	where locID = old.countryID;
end;
