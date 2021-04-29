/*
Interrugação 1
    -> Freguesia com mais casos num pais
*/

.mode	columns
.headers	on
.nullvalue	NULL

select
    pNAME,
    Max(pCNUM)
from
    (
        select
            Parish.name as pNAME,
            Parish.caseNumber as pCNUM
        from
            (
                select
                    County.locID as cID
                from
                    (
                        select
                            District.locID as dID
                        from
                            (
                                select 
                                    Country.locID as CID
                                from 
                                    Country
                                where Country.locID = 0
                            )
                        inner join District
                        on District.countryID = CID
                    )
                inner join County
                on County.DistrictID = dID
            )
        inner join Parish
        on Parish.CountyID = cID
    );