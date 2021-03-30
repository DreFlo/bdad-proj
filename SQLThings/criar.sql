/* derived atrributes not being calculated */

pragma foreign_keys = ON;

drop table if exists Country;

create table Country (
	locID integer constraint Country_PK primary key,
	name text constraint Country_name_not_null not null,
	caseNumber integer,
	noVaccinated integer,
	population integer
);

drop table if exists District;

create table District (
	locID integer constraint District_PK primary key,
	name text constraint District_name_not_null not null,
	caseNumber integer,
	noVaccinated integer,
	population integer,
	countryID integer constraint District_FK references Country(locID) on delete cascade on update cascade not null
);

drop table if exists County;

create table County (
	locID integer constraint Country_PK primary key,
	name text constraint County_name_not_null not null,
	caseNumber integer,
	noVaccinated integer,
	population integer,
	districtID integer constraint County_FK references District(locID) on delete cascade on update cascade not null 
);

drop table if exists Parish;

create table Parish (
	locID integer constraint Parish_PK primary key,
	name text constraint Parish_name_not_null not null,
	caseNumber integer,
	noVaccinated integer,
	population integer,
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
	name text constraint Manufacturer_name_not_null not null
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
	designation text constraint Strain_name_not_null not null,
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
	name text constraint Ethnicity_name_not_null not null
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
	constraint date_range check(startDate >= endDate)
);

drop table if exists EmployedIn;

create table EmployedIn (
	caseID integer constraint EmployedIn_COVIDCase_FK references COVIDCase(caseID) on delete cascade on update cascade not null,
	sectorID integer constraint EmployedIN_EmploymentSector_FK references EmploymentSector(sectorID) on delete restrict on update cascade not null,
	constraint EmployedIn_PK primary key(caseID, sectorID)
);
