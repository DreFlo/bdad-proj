/* Country(locID, name, caseNumber, noVaccinated, population) */
insert into Country values
    (0, 'Country Example', 183, 195, 1928),
    (1, 'United Kingdom', null, null, null),
    (2, 'South Africa', null, null, null),
    (3, 'Brazil', null, null, null),
    (4, 'China', null, null, null)
;

/* District(locID, name, caseNumber, noVaccinated, population, coutryID) */
insert into District values
    (0, 'District A', 107, 143, 1396, 0),
    (1, 'District B', 33, 35, 366, 0),
    (2, 'District C', 6, 8, 82, 0),
    (3, 'District D', 7, 9, 84, 0)
;

/* County(locID, name, caseNumber, noVaccinated, population, districtID) */
insert into County values
    (0, 'County A', 34, 35, 357, 0),
    (1, 'County B', 73, 108, 1039, 0),
    (2, 'County C', 2, 3, 30, 1),
    (3, 'County D', 31, 32, 336, 1),
    (4, 'County E', 2, 4, 32, 2),
    (5, 'County F', 4, 4, 50, 2),
    (6, 'County G', 2, 4, 32, 3),
    (7, 'County H', 5, 5, 52, 3)
;

/* Parish(locID, name, caseNumber, noVaccinated, population, countyID) */
insert into Parish values
    (0, 'Parish A', 17, 17, 179, 0),
    (1, 'Parish B', 17, 18, 178, 0),
    (2, 'Parish C', 42, 42, 421, 1),
    (3, 'Parish D', 61, 66, 618, 1),
    (4, 'Parish E', 1, 2, 14, 2),
    (5, 'Parish F', 1, 1, 16, 2),
    (6, 'Parish G', 27, 27, 274, 3),
    (7, 'Parish H', 4, 5, 48, 3),
    (8, 'Parish I', 2, 3, 23, 4),
    (9, 'Parish J', 0, 1, 9, 4),
    (10, 'Parish K', 4, 4, 44, 5),
    (11, 'Parish M', 0, 0, 6, 5),
    (12, 'Parish N', 1, 2, 16, 6),
    (13, 'Parish O', 1, 2, 16, 6),
    (14, 'Parish P', 3, 3, 31, 7),
    (15, 'Parish Q', 2, 2, 21, 7)
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
    (0, 0, 10),
    (0, 3, 7),
    (1, 0, 8),
    (1, 3, 10),
    (2, 1, 18),
    (2, 3, 24),
    (3, 3, 29),
    (3, 1, 37),
    (4, 0, 1),
    (4, 1, 1),
    (5, 1, 1),
    (6, 0, 17),
    (6, 3, 10),
    (7, 3, 2),
    (7, 1, 3),
    (8, 1, 1),
    (8, 0, 2),
    (9, 3, 1),
    (10, 3, 1),
    (10, 1, 3),
    (12, 1, 2),
    (13, 0, 1),
    (13, 3, 1),
    (14, 0, 2),
    (14, 1, 1),
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
    (0, 'No Ocupation', null),
    (1, 'Primary', 1),
    (2, 'Secondary', 3),
    (3, 'Tertiary', 5),
    (4, 'Quaternary', 0)
;

/* Ethnicity(ethniID, name) */
insert into Ethnicity values
    (0, 'White/Caucasian/Of european descent'),
    (1, 'Black/Of african descent'),
    (2, 'Asian/Of asian descent'),
    (3, 'Roma')
;

/* COVIDCase(caseID, detectionDate, endDate, birthYear, outcome, parishID, strainID, nursingHomeID) */
insert into COVIDCase values
    (0, '2020-01-01', '2020-01-19', 1980, 0, 3, 0, null),
    (1, '2020-01-04', '2020-01-15', 1980, 0, 1, 0, null),
    (2, '2020-01-06', '2020-01-26', 1997, 0, 2, 0, null),
    (3, '2020-01-07', '2020-02-02', 1979, 0, 1, 0, null),
    (4, '2020-01-08', '2020-01-24', 1991, 0, 2, 0, null),
    (5, '2020-01-11', '2020-01-30', 1989, 0, 3, 0, null),
    (6, '2020-01-14', '2020-02-04', 1960, 0, 2, 0, null),
    (7, '2020-01-24', '2020-02-12', 1973, 0, 0, 0, null),
    (8, '2020-01-25', '2020-02-08', 1922, 0, 3, 0, 1),
    (9, '2020-01-27', '2020-02-06', 1984, 0, 6, 0, null),
    (10, '2020-02-11', '2020-02-21', 1977, 2, 2, 0, null),
    (11, '2020-02-12', '2020-02-18', 2001, 2, 2, 0, null),
    (12, '2020-02-14', '2020-03-05', 1956, 2, 3, 0, 1),
    (13, '2020-02-17', '2020-02-29', 1972, 2, 1, 0, null),
    (14, '2020-02-18', '2020-03-06', 1999, 0, 3, 0, null),
    (15, '2020-02-21', '2020-02-27', 1979, 2, 2, 0, null),
    (16, '2020-02-28', '2020-03-03', 1996, 2, 6, 0, null),
    (17, '2020-03-01', '2020-03-15', 2001, 2, 1, 0, null),
    (18, '2020-03-01', '2020-03-16', 1988, 2, 2, 0, null),
    (19, '2020-03-04', '2020-03-18', 1992, 0, 3, 0, null),
    (20, '2020-03-07', '2020-03-15', 1980, 2, 2, 0, null),
    (21, '2020-03-10', '2020-03-22', 1975, 2, 0, 0, null),
    (22, '2020-03-11', '2020-03-21', 1967, 2, 3, 0, null),
    (23, '2020-03-13', '2020-03-17', 1981, 0, 2, 0, null),
    (24, '2020-03-15', '2020-03-28', 1966, 0, 10, 0, null),
    (25, '2020-03-16', '2020-03-30', 1955, 2, 3, 0, null),
    (26, '2020-03-17', '2020-03-24', 1942, 2, 1, 0, null),
    (27, '2020-03-18', '2020-03-31', 1999, 2, 3, 0, null),
    (28, '2020-03-20', '2020-03-29', 1977, 2, 2, 0, null),
    (29, '2020-03-21', '2020-05-04', 1944, 2, 3, 0, 1),
    (30, '2020-03-22', '2020-04-09', 1936, 0, 3, 0, 1),
    (31, '2020-03-23', '2020-04-05', 1976, 0, 2, 0, null),
    (32, '2020-03-24', '2020-04-01', 1964, 0, 3, 0, null),
    (33, '2020-03-25', '2020-04-08', 2004, 1, 10, 0, null),
    (34, '2020-03-27', '2020-04-11', 2010, 1, 3, 0, null),
    (35, '2020-03-28', '2020-04-10', 1969, 2, 6, 0, null),
    (36, '2020-03-30', '2020-04-15', 1970, 2, 3, 0, null),
    (37, '2020-04-01', '2020-04-13', 1981, 2, 1, 0, null),
    (38, '2020-04-01', '2020-04-19', 1994, 2, 0, 0, null),
    (39, '2020-04-04', '2020-04-21', 1963, 2, 2, 0, null),
    (40, '2020-04-05', '2020-04-17', 1930, 2, 3, 0, 1),
    (41, '2020-04-06', '2020-04-24', 1941, 2, 10, 0, null),
    (42, '2020-04-08', '2020-04-23', 1959, 2, 3, 0, null),
    (43, '2020-04-09', '2020-04-20', 1976, 2, 1, 0, null),
    (44, '2020-04-11', '2020-04-18', 2003, 2, 2, 0, null),
    (45, '2020-04-12', '2020-05-01', 1938, 0, 3, 0, null),
    (46, '2020-04-13', '2020-04-28', 1982, 0, 6, 0, null),
    (47, '2020-04-14', '2020-04-30', 1992, 0, 3, 0, null),
    (48, '2020-04-15', '2020-05-02', 1988, 0, 3, 0, null),
    (49, '2020-04-16', '2020-04-25', 1975, 2, 3, 0, null),
    (50, '2020-04-17', '2020-04-27', 1999, 2, 0, 0, null),
    (51, '2020-04-18', '2020-05-04', 1985, 2, 6, 0, null),
    (52, '2020-04-19', '2020-06-06', 1973, 2, 6, 0, null),
    (53, '2020-04-22', '2020-05-05', 1986, 2, 2, 0, null),
    (54, '2020-04-23', '2020-05-09', 1967, 2, 3, 0, null),
    (55, '2020-04-25', '2020-05-07', 1949, 0, 3, 0, null),
    (56, '2020-04-28', '2020-05-30', 1913, 2, 2, 0, 2),
    (57, '2020-04-29', '2020-05-10', 1981, 0, 0, 0, null),
    (58, '2020-04-30', '2020-05-14', 2002, 0, 0, 0, null),
    (59, '2020-05-01', '2020-05-12', 2015, 0, 3, 0, null),
    (60, '2020-05-05', '2020-05-15', 1995, 0, 5, 0, null),
    (61, '2020-05-07', '2020-05-17', 1972, 0, 1, 0, null),
    (62, '2020-05-09', '2020-05-26', 1953, 2, 2, 0, null),
    (63, '2020-05-14', '2020-05-18', 1974, 2, 3, 0, null),
    (64, '2020-05-17', '2020-05-24', 1980, 2, 3, 0, null),
    (65, '2020-05-20', '2020-05-30', 1988, 2, 2, 0, null),
    (66, '2020-05-21', '2020-06-07', 1962, 2, 3, 0, null),
    (67, '2020-05-24', '2020-06-05', 2002, 2, 10, 0, null),
    (68, '2020-05-25', '2020-06-11', 1968, 2, 1, 0, null),
    (69, '2020-05-29', '2020-06-09', 1944, 2, 3, 0, 1),
    (70, '2020-05-31', '2020-06-13', 1944, 2, 3, 1, null),
    (71, '2020-06-02', '2020-06-19', 1977, 2, 2, 1, null),
    (72, '2020-06-04', '2020-06-17', 1979, 2, 0, 1, null),
    (73, '2020-06-05', '2020-06-28', 1958, 2, 2, 1, null),
    (74, '2020-06-10', '2020-06-26', 1982, 0, 3, 1, null),
    (75, '2020-06-12', '2020-07-08', 1975, 2, 0, 1, null),
    (76, '2020-06-19', '2020-07-10', 1992, 2, 2, 1, null),
    (77, '2020-06-29', '2020-07-09', 1989, 2, 3, 1, null),
    (78, '2020-07-03', '2020-07-21', 1984, 2, 3, 1, null),
    (79, '2020-07-04', '2020-07-30', 1966, 2, 3, 1, null),
    (80, '2020-07-08', '2020-07-28', 1965, 2, 3, 1, null),
    (81, '2020-07-10', '2020-07-31', 1954, 2, 2, 1, 3),
    (82, '2020-07-13', '2020-08-07', 1975, 2, 0, 1, null),
    (83, '2020-07-20', '2020-08-13', 1986, 2, 0, 1, null),
    (84, '2020-07-23', '2020-08-06', 1983, 2, 3, 1, null),
    (85, '2020-07-24', '2020-08-04', 1990, 2, 0, 1, null),
    (86, '2020-08-01', '2020-08-08', 1972, 2, 3, 1, null),
    (87, '2020-08-04', '2020-08-19', 1969, 2, 2, 1, null),
    (88, '2020-08-06', '2020-08-16', 1972, 2, 3, 1, null),
    (89, '2020-08-12', '2020-08-27', 1977, 0, 1, 1, null),
    (90, '2020-08-14', '2020-08-26', 1983, 0, 12, 0, null),
    (91, '2020-08-15', '2020-08-22', 1984, 2, 2, 0, null),
    (92, '2020-08-19', '2020-08-28', 1979, 2, 2, 0, null),
    (93, '2020-08-20', '2020-08-29', 1970, 2, 3, 0, null),
    (94, '2020-08-22', '2020-09-05', 1989, 2, 3, 2, null),
    (95, '2020-08-26', '2020-09-08', 1991, 2, 3, 2, null),
    (96, '2020-08-27', '2020-09-02', 1943, 2, 0, 2, null),
    (97, '2020-08-29', '2020-09-14', 1967, 2, 3, 0, null),
    (98, '2020-08-31', '2020-09-10', 1966, 0, 2, 1, null),
    (99, '2020-09-01', '2020-09-21', 1965, 0, 0, 0, null),
    (100, '2020-09-05', '2020-09-15', 1969, 0, 1, 1, null),
    (101, '2020-09-10', '2020-09-26', 1986, 0, 3, 0, null),
    (102, '2020-09-11', '2020-09-30', 1999, 0, 2, 0, null),
    (103, '2020-09-14', '2020-09-23', 2000, 0, 13, 1, null),
    (104, '2020-09-20', '2020-10-01', 1988, 0, 3, 0, null),
    (105, '2020-09-22', '2020-10-05', 1988, 2, 3, 0, null),
    (106, '2020-09-23', '2020-10-01', 1988, 2, 14, 0, null),
    (107, '2020-09-25', '2020-10-09', 1973, 2, 2, 0, null),
    (108, '2020-09-29', '2020-10-06', 1973, 2, 14, 0, null),
    (109, '2020-10-03', '2020-10-16', 1973, 2, 1, 0, null),
    (110, '2020-10-04', '2020-10-15', 1975, 2, 2, 1, null),
    (111, '2020-10-05', '2020-10-20', 1975, 2, 3, 0, null),
    (112, '2020-10-06', '2020-10-18', 1975, 2, 14, 0, null),
    (113, '2020-10-07', '2020-10-21', 1975, 2, 3, 0, null),
    (114, '2020-10-08', '2020-10-24', 1975, 2, 2, 2, null),
    (115, '2020-10-09', '2020-10-19', 1973, 2, 7, 0, null),
    (116, '2020-10-10', '2020-10-22', 1973, 2, 2, 0, null),
    (117, '2020-10-11', '2020-10-25', 1973, 2, 1, 1, null),
    (118, '2020-10-12', '2020-10-26', 1964, 2, 3, 0, null),
    (119, '2020-10-13', '2020-10-28', 1964, 2, 2, 0, null),
    (120, '2020-10-14', '2020-10-29', 1964, 0, 15, 0, null),
    (121, '2020-10-19', '2020-10-27', 1964, 0, 3, 2, null),
    (122, '2020-10-21', '2020-10-30', 1964, 0, 2, 2, null),
    (123, '2020-10-22', '2020-11-02', 1964, 0, 3, 2, null),
    (124, '2020-10-23', '2020-10-31', 1964, 0, 3, 0, null),
    (125, '2020-10-24', '2020-11-05', 1964, 0, 6, 1, null),
    (126, '2020-10-25', '2020-11-01', 1964, 0, 6, 2, null),
    (127, '2020-10-26', '2020-11-07', 1964, 2, 1, 0, null),
    (128, '2020-10-27', '2020-11-06', 1967, 2, 2, 0, null),
    (129, '2020-10-28', '2020-11-12', 1967, 2, 7, 0, null),
    (130, '2020-10-29', '2020-11-10', 1967, 2, 3, 2, null),
    (131, '2020-10-30', '2020-11-08', 1967, 2, 3, 2, null),
    (132, '2020-10-31', '2020-11-14', 1967, 2, 6, 2, null),
    (133, '2020-11-01', '2020-11-13', 1983, 2, 6, 2, null),
    (134, '2020-11-02', '2020-11-22', 1983, 2, 1, 0, null),
    (135, '2020-11-03', '2020-11-17', 1983, 1, 2, 3, null),
    (136, '2020-11-05', '2020-11-27', 1983, 2, 3, 1, null),
    (137, '2020-11-06', '2020-11-23', 1986, 2, 3, 0, null),
    (138, '2020-11-09', '2020-11-18', 1986, 2, 3, 0, null),
    (139, '2020-11-10', '2020-11-30', 1986, 2, 2, 1, null),
    (140, '2020-11-11', '2020-11-28', 1986, 2, 6, 2, null),
    (141, '2020-11-13', '2020-12-04', 1977, 2, 3, 0, null),
    (142, '2020-11-14', '2020-11-29', 1977, 2, 3, 0, null),
    (143, '2020-11-15', '2020-12-09', 1957, 0, 2, 0, null),
    (144, '2020-11-17', '2020-12-11', 1977, 0, 6, 0, null),
    (145, '2020-11-18', '2020-12-06', 1977, 0, 6, 0, null),
    (146, '2020-11-20', '2020-12-10', 1967, 2, 1, 0, null),
    (147, '2020-11-23', '2020-12-08', 1988, 2, 7, 0, null),
    (148, '2020-11-28', '2020-12-15', 1975, 2, 6, 3, null),
    (149, '2020-11-30', '2020-12-12', 1974, 2, 7, 0, null),
    (150, '2020-12-01', '2020-12-13', 1942, 2, 3, 0, null),
    (151, '2020-12-05', '2021-01-02', 1940, 2, 3, 3, 3),
    (152, '2020-12-15', '2020-12-21', 1989, 2, 0, 0, null),
    (153, '2020-12-22', '2021-01-05', 1978, 2, 2, 2, null),
    (154, '2020-12-28', '2021-01-12', 1983, 2, 3, 0, null),
    (155, '2020-12-29', '2021-01-09', 1955, 2, 15, 0, null),
    (156, '2021-01-03', '2021-01-22', 1973, 2, 3, 0, null),
    (157, '2021-01-05', '2021-01-16', 1973, 0, 6, 0, null),
    (158, '2021-01-06', '2021-01-28', 1973, 0, 6, 1, null),
    (159, '2021-01-07', '2021-01-25', 1968, 2, 0, 0, null),
    (160, '2021-01-17', '2021-02-09', 1998, 2, 6, 0, null),
    (161, '2021-01-20', '2021-02-03', 1998, 2, 3, 0, null),
    (162, '2021-01-23', '2021-02-11', 1968, 2, 1, 0, null),
    (163, '2021-01-27', '2021-02-13', 1968, 2, 6, 0, null),
    (164, '2021-02-01', '2021-02-12', 1996, 2, 2, 0, null),
    (165, '2021-02-01', '2021-02-17', 1987, 2, 4, 2, null),
    (166, '2021-02-02', '2021-02-18', 1974, 2, 6, 3, null),
    (167, '2021-02-06', '2021-02-15', 1987, 2, 6, 0, null),
    (168, '2021-02-07', '2021-02-23', 1984, 2, 0, 0, null),
    (169, '2021-02-08', '2021-02-26', 1980, 0, 6, 0, null),
    (170, '2021-02-11', '2021-02-19', 1970, 2, 2, 0, null),
    (171, '2021-02-12', '2021-02-24', 1960, 2, 6, 0, null),
    (172, '2021-02-13', '2021-03-02', 1950, 2, 6, 0, null),
    (173, '2021-02-17', '2021-02-28', 1974, 2, 2, 3, null),
    (174, '2021-02-18', '2021-03-04', 1983, 0, 6, 0, null),
    (175, '2021-02-22', '2021-03-07', 1985, 2, 6, 1, null),
    (176, '2021-02-24', '2021-03-06', 1977, 2, 6, 0, null),
    (177, '2021-02-25', '2021-03-14', 1987, 2, 2, 2, null),
    (178, '2021-02-27', '2021-03-09', 1954, 2, 8, 0, null),
    (179, '2021-03-01', null, 1986, 2, 6, 0, null),
    (180, '2021-03-04', '2021-03-16', 1997, 2, 2, 0, null),
    (181, '2021-03-09', '2021-03-19', 2002, 2, 8, 3, null),
    (182, '2021-03-30', null, 2003, null, 0, 0, null)
;

/* EthnicityCOVIDCase(caseID, ethniID) */
insert into EthnicityCOVIDCase values
    (0, 0),
    (0, 1),
    (31, 0),
    (45, 0),
    (89, 0),
    (103, 0),
    (122, 0),
    (55, 1),
    (75, 0),
    (181, 0),
    (23, 1),
    (24, 1),
    (25, 1),
    (2, 1),
    (8, 2),
    (18, 2),
    (17, 2),
    (66, 2),
    (99, 2),
    (59, 0),
    (48, 0),
    (44, 3),
    (97, 3),
    (98, 3),
    (69, 0),
    (77, 0),
    (90, 0),
    (113, 0),
    (144, 0),
    (163, 2),
    (155, 0),
    (180, 0),
    (165, 1),
    (12, 0),
    (15, 0),
    (83, 0)
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
    (0, '2020-01-20', '2020-02-08', 1, 8),
    (1, '2020-02-17', '2020-02-29', 3, 13),
    (2, '2020-04-28', '2020-05-30', 2, 56),
    (3, '2020-09-08', '2020-09-15', 0, 100),
    (4, '2021-03-30', null, 0, 182),
    (5, '2021-03-02', null, 2, 179)
;

/* ICUStay(ICUStayID, startDate, endDate, hospStayID) */
insert into ICUStay values
    (0, '2020-01-23', '2020-02-08', 0),
    (1, '2020-02-18', '2020-02-25', 1),
    (2, '2020-09-10', '2020-09-12', 3),
    (3, '2021-04-01', null, 4),
    (4, '2021-03-09', '2021-03-17', 5)
;

/* Ventilation(ventID, startDate, endDate, ICUStayID) */
insert into Ventilation values
    (0, '2020-01-25', '2020-02-08', 0),
    (1, '2021-04-01', null, 3)
;

/* EmployedIn(caseID, sectorID) */
insert into EmployedIn values
    (178, 2),
    (50, 2),
    (165, 1),
    (18, 1),
    (138, 1),
    (133, 1),
    (158, 0),
    (57, 4),
    (70, 3),
    (125, 2),
    (145, 0),
    (76, 2),
    (44, 4),
    (141, 1),
    (35, 3),
    (2, 0),
    (93, 3),
    (92, 4),
    (4, 4),
    (136, 1),
    (130, 2),
    (4, 2),
    (57, 1),
    (88, 1),
    (148, 4),
    (122, 2),
    (154, 0),
    (120, 4),
    (28, 4),
    (121, 4),
    (109, 4),
    (99, 4),
    (164, 3),
    (128, 4),
    (124, 4),
    (1, 1),
    (59, 1),
    (114, 1),
    (28, 1),
    (99, 1),
    (182, 3),
    (98, 0),
    (64, 0),
    (65, 2),
    (113, 2),
    (34, 0),
    (59, 3),
    (134, 4),
    (180, 1),
    (58, 0),
    (62, 2),
    (25, 4),
    (49, 3),
    (112, 1),
    (180, 3),
    (126, 1),
    (161, 3),
    (31, 0),
    (33, 0),
    (124, 2),
    (141, 4),
    (122, 4),
    (152, 4),
    (124, 1),
    (102, 3),
    (137, 4),
    (3, 3),
    (163, 3),
    (170, 4),
    (169, 1),
    (64, 3),
    (73, 0),
    (52, 3),
    (155, 0),
    (6, 1),
    (117, 2),
    (80, 2),
    (45, 2),
    (42, 4)
;
