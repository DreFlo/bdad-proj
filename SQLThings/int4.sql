
/*
Interrogação 4
    -> Caso de covid de uma certa freguesia ordenado por tempo infetado
*/  

.mode	columns
.headers	on
.nullvalue	NULL

select
    caseID,
    julianday(endDate) - julianday(detectionDate)
from
    COVIDCase
where
    parishID = 1
order by
    julianday(endDate) - julianday(detectionDate) asc;