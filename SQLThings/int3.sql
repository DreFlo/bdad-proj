
/*
Interrogação 3:
    -> Hospitais que apenas tem casos da sua propria freguesia
*/

.mode	columns
.headers	on
.nullvalue	NULL

CREATE VIEW HospitalToCaseEqual AS
SELECT Hospital.name
FROM 
    Hospital
JOIN 
    Hospitalization, COVIDCase 
ON 
    Hospital.hospitalID = Hospitalization.hospitalID AND COVIDCase.caseID = Hospitalization.caseID AND Hospital.parishID = COVIDCase.parishID
GROUP BY Hospital.hospitalID;

CREATE VIEW HospitalToCaseDifferent AS
SELECT Hospital.name
FROM 
    Hospital 
JOIN 
    Hospitalization, COVIDCase 
ON 
    Hospital.hospitalID = Hospitalization.hospitalID AND COVIDCase.caseID = Hospitalization.caseID AND Hospital.parishID <> COVIDCase.parishID
GROUP BY Hospital.hospitalID;

SELECT name AS "Hospital"
FROM 
    (SELECT * 
    FROM HospitalToCaseEqual

    EXCEPT

    SELECT * 
    FROM HospitalToCaseDifferent
    );

DROP VIEW HospitalToCaseEqual;
DROP VIEW HospitalToCaseDifferent;

