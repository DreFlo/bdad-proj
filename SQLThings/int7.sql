.mode	columns
.headers	on
.nullvalue	NULL

-- Casos detetados em Abril de 2020 ordenados pelo tipo de trabalho respetivo

SELECT caseID as "Case ID", Employment
FROM( SELECT detectionDate, caseID, EmploymentSector.name as Employment
      FROM EmploymentSector NATURAL JOIN EmployedIn NATURAL JOIN COVIDCase

      UNION

      SELECT detectionDate, caseID, "Nursing Home" as Employment
      FROM NursingHome NATURAL JOIN COVIDCase)
WHERE strftime('%Y', detectionDate) == '2020' AND strftime('%m', detectionDate) == '04'
ORDER BY Employment;