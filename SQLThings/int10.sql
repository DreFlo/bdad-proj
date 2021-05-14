.mode	columns
.headers	on
.nullvalue	NULL

-- Média de vacinados em cidades com hospitais vs cidades sem hospitais

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