/* Gatilho 4:
    ->do not allow an ICUStay to start before or end after its corresponding Hospitalization 
*/

/*
    Not checking dates of COVIDCase
*/

insert into Hospitalization values(6, '2020-04-03', '2020-04-05', 0, 35);

select * from ICUStay;
insert into ICUStay values(5, '2020-04-02', null, 6);
insert into ICUStay values(6, null, '2020-04-06', 6);
select * from ICUStay;

