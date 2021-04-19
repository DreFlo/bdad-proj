
/* Gatilho 5:
    ->do not allow a Ventilation to start before or end after its corresponding ICUStay 
*/


select * from ICUStay;
insert into Ventilation values(5, '2021-03-08', null, 4);
insert into Ventilation values(6, null, '2021-03-18', 4);
select * from ICUStay;


