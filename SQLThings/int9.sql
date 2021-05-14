.mode	columns
.headers	on
.nullvalue	NULL

-- Número de casos ativos em ICU por hospital

SELECT Hospital.name as "Hospital Name", count(*) as "Number of Cases"
FROM (ICUStay JOIN Hospitalization USING (hospStayID)) NATURAL JOIN Hospital
WHERE ICUStay.endDate IS NULL
GROUP BY ICUStayID;