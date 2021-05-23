
/*
Interrogação 5:
    -> Numero de novas hospitalizações por mês
*/

.mode	columns
.headers	on
.nullvalue	NULL

SELECT strftime('%m', startDate) as Month, strftime('%Y', startDate) as Year, count(*) as "Number of New Hospitalizations"
FROM Hospitalization
GROUP BY strftime('%m', startDate)
ORDER BY strftime('%Y', startDate), strftime('%m', startDate) ASC;
