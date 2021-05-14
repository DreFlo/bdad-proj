.mode	columns
.headers	on
.nullvalue	NULL

-- Estirpe com mais casos por freguesia

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