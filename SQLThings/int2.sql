
/*
Interrugação 2
    -> A quantidade de pessoas infetadas num dado setor
*/

.mode	columns
.headers	on
.nullvalue	NULL

select 
    count(caseID)
from
    EmployedIn
where
    sectorID = 3;