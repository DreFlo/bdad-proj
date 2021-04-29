
/*
Interrugação 3
    -> Datas de inicio de deteçao e fim do caso dos casos hospitalizados
*/

.mode	columns
.headers	on
.nullvalue	NULL

select 
    COVIDCase.caseID,
    COVIDCase.detectionDate, 
    COVIDCase.endDate
from 
    COVIDCase
Inner Join Hospitalization
    on Hospitalization.caseID = COVIDCase.caseID;

