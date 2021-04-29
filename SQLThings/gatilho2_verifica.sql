

/* 
Gatilho 2:
    ->do not allow to be unemployed and employed in another sector 
*/

select * from EmployedIn;
insert into EmployedIn values(158, 1);
insert into EmployedIn values(133, 0);
select * from EmployedIn;
