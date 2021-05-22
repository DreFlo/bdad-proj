/*
Interrogação 4
    -> COVIDCases internados em comum
*/

.mode	columns
.headers	on
.nullvalue	NULL

CREATE VIEW COVIDCaseJoinHospitalization AS
SELECT *
FROM COVIDCase JOIN Hospitalization USING(caseID);

SELECT C1.caseID as 'Case 1', C1.startDate as 'Case 1 Hosp. Start', C1.endDate as 'Case 1 Hosp. End',
       C2.caseID as 'Case 2', C2.startDate as 'Case 2 Hosp. Start', C2.endDate as 'Case 2 Hosp. End',
       C1.hospitalID as 'Hospital'
FROM COVIDCaseJoinHospitalization AS C1 CROSS JOIN COVIDCaseJoinHospitalization AS C2
WHERE C1.hospitalID = C2.hospitalID AND C1.startDate <= C2.startDate AND C1.endDate >= C2.startDate AND C1.caseID <> C2.caseID;


DROP VIEW COVIDCaseJoinHospitalization;