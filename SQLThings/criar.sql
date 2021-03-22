/* using number for dates */
/* derived atrributes not being calculated */
/* all FK delete and update actions set to cascade */


pragma foreign_keys = ON;

drop table if exists Country;

create table Country (
	locID number constraint Country_PK primary key not null,
	name text constraint Country_name_not_null not null,
	caseNumber number,
	noVaccinated number,
	population number
);

drop table if exists District;

create table District (
	locID number constraint District_PK primary key not null,
	name text constraint District_name_not_null not null,
	caseNumber number,
	noVaccinated number,
	population number,
	countryID number constraint District_FK references Country(locID) on delete cascade on update cascade not null
);

drop table if exists County;

create table County (
	locID number constraint Country_PK primary key not null,
	name text constraint County_name_not_null not null,
	caseNumber number,
	noVaccinated number,
	population number,
	districtID number constraint County_FK references District(locID) on delete cascade on update cascade not null 
);

drop table if exists Parish;

create table Parish (
	locID number constraint Parish_PK primary key not null,
	name text constraint Parish_name_not_null not null,
	caseNumber number,
	noVaccinated number,
	population number,
	countyID number constraint Parish_FK references County(locID) on delete cascade on update cascade not null 
);

drop table if exists Vaccine;

create table Vaccine (
	vacID number constraint Vaccine_PK primary key not null,
	name number constraint Vaccine_name_not_null not null,
	doseNumber number constraint Vaccine_doses_greater_than_one check(doseNumber >= 1) not null
);

drop table if exists VaccinationAmount;

create table VaccinationAmount (
	parishID number constraint VaccinationAmount_Parish_FK references Parish(locID) on delete cascade on update cascade not null,
	vacID number constraint VaccinationAmount_Vaccine_FK references Vaccine(vacID) on delete cascade on update cascade not null,
	vaccination number constraint VaccinationAmount_range check(vaccination >= 0),
	constraint VaccinationAmount_PK primary key(parishID, vacID)
);

drop table if exists Manufacturer;

create table Manufacturer (
	manID number constraint Manufacturer_PK primary key not null,
	name text constraint Manufacturer_name_not_null not null
);

drop table if exists VaccineManufacturer;

create table VaccineManufacturer (
	vacID number constraint VaccineManufacturer_Vaccine_FK references Vaccine(vacID) on delete cascade on update cascade not null,
	manID number constraint VaccineManufacturer_Manufacturer_FK references Manufacturer(manID) on delete cascade on update cascade not null,
	constraint VaccineManufacturer_PK primary key(vacID, manID)
);

drop table if exists Strain;

create table Strain (
	strainID number constraint Strain_PK primary key not null,
	designation text constraint Strain_name_not_null not null,
	countryID number constraint Strain_FK references Country(locID) on delete cascade on update cascade not null
);

drop table if exists NursingHome;

create table NursingHome (
	nursingHomeID number constraint NursingHome_PK primary key not null,
	name text
);

drop table if exists EmploymentSector;

create table EmploymentSector (
	sectorID number constraint EmploymentSector_PK primary key not null,
	name text,
	contactFrequency number,
	constraint contactFrequencyRange check((contactFrequency >= 0 and contactFrequency <= 5) or contactFrequency == null)
);

drop table if exists Ethnicity;

create table Ethnicity (
	etniID number constraint Ethnicity_PK primary key not null,
	name text constraint Ethnicity_name_not_null not null
);

drop table if exists COVIDCase;

create table COVIDCase (
	caseID number constraint COVIDCase_PK primary key not null,
	detectionDate number,
    endDate number,
	birthYear number,
	outcome number,
	parishID number constraint COVIDCase_Parish_FK references Parish(locID) on delete cascade on update cascade not null,
	strainID number constraint COVIDCase_Strain_FK references Strain(strainID) on delete cascade on update cascade not null,
	nursingHomeID number constraint COVIDCase_NursingHome_FK references NursingHome(nursingHomeID) on delete cascade on update cascade,
	constraint date_range check(detectionDate <= endDate),
	constraint outcome_range check(outcome >= 0 and outcome <= 2)
);

drop table if exists EthnicityCOVIDCase;

create table EthnicityCOVIDCase (
	caseID number constraint EthnicityCOVIDCase_COVIDCase_FK references COVIDCase(caseID) on delete cascade on update cascade not null,
	etniID number constraint EthnicityCOVIDCase_Ethnicity_FK references Ethnicity(etniID) on delete cascade on update cascade not null,
	constraint EthnicityCOVIDCase_PK primary key(caseID, etniID)
);

drop table if exists Hospital;

create table Hospital (
	hospitalID number constraint Hospital_PK primary key not null,
	name text,
	parishID constraint Hospital_FK references Parish(locID) on delete cascade on update cascade not null
);

drop table if exists Hospitalization;

create table Hospitalization (
	hospStayID number constraint Hospitalization_PK primary key not null,
	startDate number,
	endDate number,
	hospitalID number constraint Hospitalization_Hospital_FK references Hospital(hospitalID) on delete cascade on update cascade not null,
	caseID number constraint Hospitalization_COVIDCase_FK references COVIDCase(caseID) on delete cascade on update cascade not null,
	constraint date_range check(startDate <= endDate)
);

drop table if exists ICUStay;

create table ICUStay (
	ICUStayID number constraint ICUStay_PK primary key not null,
	startDate number,
	endDate number,
	hospStayID number constraint ICUStay_FK references Hospitalization(hospStayID) on delete cascade on update cascade not null,
	constraint date_range check(startDate <= endDate) 
);

drop table if exists Ventilation;

create table Ventilation (
	ventID number constraint Ventilation_PK primary key not null,
	startDate number,
	endDate number,
	ICUStayID number constraint Ventilation_FK references ICUStay(ICUStayID) on delete cascade on update cascade not null,
	constraint date_range check(startDate >= endDate)
);

drop table if exists EmployedIn;

create table EmployedIn (
	caseID number constraint EmployedIn_COVIDCase_FK references COVIDCase(caseID) on delete cascade on update cascade not null,
	sectorID number constraint EmployedIN_EmploymentSector_FK references EmploymentSector(sectorID) on delete cascade on update cascade not null,
	constraint EmployedIn_PK primary key(caseID, sectorID)
);

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

/* do not allow a NursingHome to be added to a COVIDCase with an already registered EmployementSector */
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
