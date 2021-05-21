/*
Interrogação 1
    -> As três freguesias com mais casos dem usar max()
*/

.mode	columns
.headers	on
.nullvalue	NULL

CREATE VIEW ParishSmallest AS
SELECT P1.locID, P1.name as ParishName, P1.caseNumber as ParishCaseNumber
FROM Parish as P1, Parish as P2
WHERE P1.caseNumber < P2.caseNumber;

SELECT name as ParishName, caseNumber as ParishCaseNumber
FROM Parish

EXCEPT

SELECT DISTINCT ParishName, ParishCaseNumber
FROM ParishSmallest

UNION

SELECT ParishName, ParishCaseNumber
FROM (SELECT locID, ParishName, ParishCaseNumber, count(locID) as count
      FROM ParishSmallest
      GROUP BY locID)
WHERE count = 1 OR count = 2
ORDER BY ParishCaseNumber DESC;

DROP VIEW ParishSmallest;
