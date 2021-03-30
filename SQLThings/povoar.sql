/* Country(locID, name, caseNumber, noVaccinated, population) */
insert into Country values
    (0, 'Country Example', 0, 0, 0),
    (1, 'Reino Unido', 0, 0, 0),
    (2, 'África do Sul', 0, 0, 0),
    (3, 'Brasil', 0, 0, 0),
    (4, 'China', 0, 0, 0)
;

/* District(locID, name, caseNumber, noVaccinated, population, coutryID) */
insert into District values
    (0, 'District A', 0, 0, 0, 0),
    (1, 'District B', 0, 0, 0, 0),
    (2, 'District C', 0, 0, 0, 0),
    (3, 'District D', 0, 0, 0, 0)
;

/* County(locID, name, caseNumber, noVaccinated, population, districtID) */
insert into County values
    (0, 'County A', 0, 0, 0, 0),
    (1, 'County B', 0, 0, 0, 0),
    (2, 'County C', 0, 0, 0, 1),
    (3, 'County D', 0, 0, 0, 1),
    (4, 'County E', 0, 0, 0, 2),
    (5, 'County F', 0, 0, 0, 2),
    (6, 'County G', 0, 0, 0, 3),
    (7, 'County H', 0, 0, 0, 3)
;

/* Parish(locID, name, caseNumber, noVaccinated, population, countyID) */
insert into Parish values
    (0, 'Parish A', 0, 0, 179, 0),
    (1, 'Parish B', 0, 0, 178, 0),
    (2, 'Parish C', 0, 0, 421, 1),
    (3, 'Parish D', 0, 0, 618, 1),
    (4, 'Parish E', 0, 0, 14, 2),
    (5, 'Parish F', 0, 0, 16, 2),
    (6, 'Parish G', 0, 0, 274, 3),
    (7, 'Parish H', 0, 0, 48, 3),
    (8, 'Parish I', 0, 0, 23, 4),
    (9, 'Parish J', 0, 0, 9, 4),
    (10, 'Parish K', 0, 0, 44, 5),
    (11, 'Parish M', 0, 0, 6, 5),
    (12, 'Parish N', 0, 0, 16, 6),
    (13, 'Parish O', 0, 0, 16, 6),
    (14, 'Parish P', 0, 0, 31, 7),
    (15, 'Parish Q', 0, 0, 21, 7)
;

/* Vaccine(vacID, name, doseNumber) */
insert into Vaccine values
    (0, 'BNT162b2', 2), /* BioNTech - Pfizer */
    (1, 'mRNA-1273', 2), /* Moderna */
    (2, 'JNJ-78436735', 1), /* Johnson & Johnson */
    (3, 'AZD1222', 2) /* AstraZeneca */
;

/* VaccinationAmount(parishID, vacID, vaccinationNumber) */
insert into VaccinationAmount values
    (0, 0, 10)
    (0, 3, 7)
    (1, 0, 8)
    (1, 3, 10)
    (2, 1, 18)
    (2, 3, 24)
    (3, 3, 29)
    (3, 1, 37)
    (4, 0, 1)
    (4, 1, 1)
    (5, 1, 1)
    (6, 0, 17)
    (6, 3, 10)
    (7, 3, 2)
    (7, 1, 3)
    (8, 1, 1)
    (8, 0, 2)
    (9, 3, 1)
    (10, 3, 1)
    (10, 1, 3)
    (12, 1, 2)
    (13, 0, 1)
    (13, 0, 1)
    (14, 0, 2)
    (14, 0, 1)
    (15, 0, 2)
;

/* Manufacturer(manID, name) */
insert into Manufacturer values
    (0, 'Pfizer'),
    (1, 'BioNTech'),
    (2, 'Moderna'),
    (3, 'Johnson & Johnson'),
    (4, 'Oxford'),
    (5, 'AstraZeneca')
;

/* VaccineManufacturer(vacID, manID) */
insert into VaccineManufacturer values
    (0, 0),
    (0, 1),
    (1, 2),
    (2, 3),
    (3, 4),
    (3, 5)
;


/* Strain(strainID, designation, countryID) */
insert into Strain values
    (0, 'SARS-CoV-2', 4),
    (1, 'SARS-CoV-2 B.1.1.7', 1),
    (2, 'SARS-CoV-2 B.1.351', 2),
    (3, 'SARS-CoV-2 P.1', 3)
;

/* NursingHome(nursingHomeID, name) */
insert into NursingHome values
    (0, 'Nursing Home A'),
    (1, 'Nursing Home B'),
    (2, 'Nursing Home C'),
    (3, 'Nursing Home D')
;

/* EmploymentSector(sectorID, name, contactFrequency) */
insert into EmploymentSector values
    (0, 'Desempregado', null),
    (1, 'Primário', 1),
    (2, 'Secundário', 3),
    (3, 'Terciário', 5),
    (4, 'Quaternário', 0)
;

/* Ethnicity(ethniID, name) */
insert into Ethnicity values
    (0, 'Branco/De origem europeia'),
    (1, 'Negro/Afro-descendente/De origem africana'),
    (2, 'Asiático/De origem asiática'),
    (3, 'Roma')
;

/* COVIDCase(caseID, detectionDate, endDate, birthYear, outcome, parishID, strainID, nursingHomeID) */
insert into COVIDCase values
    (0, '', '', 0, 0, 0, 0, null)
;

/* EthnicityCOVIDCase(caseID, ethniID) */
insert into EthnicityCOVIDCase values
    (0, 0)
;

/* Hospital(hospitalID, name, ParishID) */
insert into Hospital values
    (0, 'Hospital A', 10),
    (1, 'Hospital B', 3),
    (2, 'Hospital C', 6),
    (3, 'Hospital D', 14)
;

/* Hospitalization(hospStayID, startDate, endDate, hospitalID, caseID) */
insert into Hospitalization values
    (0, '', '', 0, 0)
;

/* ICUStay(ICUStayID, startDate, endDate, hospStayID) */
insert into ICUStay values
    (0, '', '', 0)
;

/* Ventilation(ventID, startDate, endDate, ICUStayID) */
insert into Ventilation values
    (0, '', '', 0)
;

/* EmployedIn(caseID, sectorID) */
insert into EmployedIn values
    (0, 0)
;