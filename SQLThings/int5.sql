
/*
Interrugação 5:
    -> A freguesia de cada lar
*/

.mode	columns
.headers	on
.nullvalue	NULL

select
    nNAME,
    name
from
    (   
        (
        select 
            COVIDCase.nursingHomeID as nID,
            NursingHome.name as nNAME,
            COVIDCase.parishID as pID
        from 
            NursingHome
        Inner Join COVIDCase 
            on COVIDCase.nursingHomeID = NursingHome.nursingHomeID
        )
    Inner Join Parish
        on Parish.locID = pID
    )
group by
    nID;

