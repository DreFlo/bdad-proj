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
	vacID number references Vaccine(vacID),
	manID number references Manufacturer(manID),
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
	check(detectionDate <= endDate),
	check(outcome == 0 or outcome == 1 or outcome == 2)
);

drop table if exists EthnicityCOVIDCase;

create table EthnicityCOVIDCase (
	caseID number references COVIDCase(caseID),
	etniID number references Ethnicity(etniID)
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
	hospitalID number references Hospital(hospitalID),
	caseID number references COVIDCase(caseID),
	check(startDate <= endDate)
);

drop table if exists ICUStay;

create table ICUStay (
	ICUStayID number primary key not null,
	startDate number,
	endDate number,
	hStayID number references Hospitalization(hospStayID) not null,
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
