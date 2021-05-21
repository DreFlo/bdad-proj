
/*
Interrogação 2
    -> Taxa de mortalidade de pessoas que foram hospitalizadas e que não foram
*/

.mode	columns
.headers	on
.nullvalue	NULL

CREATE VIEW V AS
select count(caseID) as count
      from
      COVIDCase join Hospitalization
      using (caseID)
      where 
      outcome = 0

      UNION

      SELECT count(caseID) as count
      FROM COVIDCase JOIN Hospitalization USING (caseID);

CREATE VIEW T AS
SELECT count(caseID) as count
FROM COVIDCase
WHERE outcome = 0

EXCEPT

SELECT caseID
FROM Hospitalization

UNION

SELECT count(caseID) as count
FROM COVIDCase

EXCEPT

SELECT caseID
FROM Hospitalization;


SELECT "Yes" as "Hospitalization?", (V1.count * 1.0) / (V2.count * 1.0) * 100 as "Mortality Rate"
FROM V as V1, V as V2
WHERE V1.count < V2.count

UNION

SELECT "No", (T1.count * 1.0) / (T2.count * 1.0) * 100
FROM T as T1, T as T2
WHERE T1.count < T2.count;

