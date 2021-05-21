.mode	columns
.headers	on
.nullvalue	NULL

-- 1. Estirpe com mais casos por freguesia

/*
CREATE VIEW PS AS
SELECT Parish.name as PName, Strain.designation as SName, count(*) as PSCount
FROM (Parish JOIN COVIDCase ON parishID = locID) NATURAL JOIN Strain
GROUP BY Parish.name, Strain.designation;

SELECT PName as "Parish Name", Sname as "Strain Designation"
FROM PS
WHERE PSCount in ( SELECT max(PSCount) 
                   FROM PS 
                   GROUP BY PName
                   HAVING PName = "Parish Name");

DROP VIEW PS;
*/


-- 2. Casos detetados em Abril de 2020 ordenados pelo tipo de trabalho respetivo

/*
SELECT caseID as "Case ID", Employment
FROM( SELECT detectionDate, caseID, EmploymentSector.name as Employment
      FROM EmploymentSector NATURAL JOIN EmployedIn NATURAL JOIN COVIDCase

      UNION

      SELECT detectionDate, caseID, "Nursing Home" as Employment
      FROM NursingHome NATURAL JOIN COVIDCase)
WHERE strftime('%Y', detectionDate) == '2020' AND strftime('%m', detectionDate) == '04'
ORDER BY Employment;
*/

-- 3. Cidade mais afetada em 2021

/*
CREATE VIEW CC AS
SELECT County.name as CName, count(*) as Count
FROM COVIDCase JOIN (Parish JOIN County ON Parish.countyID = County.locID) ON parishID = Parish.locID
WHERE strftime('%Y', COVIDCase.detectionDate) = '2021'
GROUP BY County.locID;

SELECT CName as "County Name", max(Count) as "Number of Cases"
FROM CC;

DROP VIEW CC;
*/

-- 4. Número de casos ativos em ICU por hospital

/*
SELECT Hospital.name as "Hospital Name", count(*) as "Number of Cases"
FROM (ICUStay JOIN Hospitalization USING (hospStayID)) NATURAL JOIN Hospital
WHERE ICUStay.endDate IS NULL
GROUP BY ICUStayID;
*/

-- 5. Média de vacinados em cidades com hospitais vs cidades sem hospitais

/*
CREATE VIEW CountyWithHosp AS
SELECT countyID
FROM Parish JOIN Hospital ON locID = parishID;

SELECT "No" as "Hospitals In County?", avg(noVaccinated) as "Vaccination Average"
FROM (SELECT countyID
      FROM Parish

      EXCEPT

      SELECT *
      FROM CountyWithHosp) as NoHospParish JOIN County ON NoHospParish.countyID = County.locID

UNION

SELECT "Yes" as "Hospitals In County?", avg(noVaccinated) as "Vaccination Average"
FROM CountyWithHosp JOIN County ON countyID = locID;

DROP VIEW CountyWithHosp;
*/

-- 6. 3 Freguesias com mais casos sem usar max()

/*
CREATE VIEW ParishSmallest AS
SELECT P1.locID, P1.name, P1.caseNumber
FROM Parish as P1, Parish as P2
WHERE P1.caseNumber < P2.caseNumber;

SELECT locID, name, caseNumber
FROM Parish

EXCEPT

SELECT DISTINCT *
FROM ParishSmallest

UNION

SELECT locID, name, caseNumber
FROM (SELECT locID, name, caseNumber, count(*) as count
      FROM ParishSmallest
      GROUP BY locID)
WHERE count = 1 OR count = 2
ORDER BY caseNumber DESC;

DROP VIEW ParishSmallest;
*/

-- 7. Novas hospitalizações por mês

/*
SELECT strftime('%m', startDate) as Month, strftime('%Y', startDate) as Year, count(*) as "Number of New Hospitalizations"
FROM Hospitalization
GROUP BY strftime('%m', startDate)
ORDER BY strftime('%Y', startDate), strftime('%m', startDate) ASC;
*/

-- EXTRAS --

-- Etnias ordenadas por número de casos descendente

/*
SELECT Ethnicity.name, count(*)
FROM COVIDCase NATURAL JOIN EthnicityCOVIDCase NATURAL JOIN Ethnicity
GROUP BY Ethnicity.name
ORDER BY count(*) DESC;
*/

-- Média de tempo infetado em casos de COVID 

/*
SELECT avg(julianday(COVIDCase.endDate) - julianday(COVIDCase.detectionDate))
FROM COVIDCase
WHERE COVIDCase.endDate IS NOT NULL
*/