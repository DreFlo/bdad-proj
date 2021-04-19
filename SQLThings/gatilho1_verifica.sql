
/* Gatilho 1:
    -> do not allow a COVIDCase already registered in a NursingHome to be added to EmployedIn
*/

insert into COVIDCase(caseID, parishID, strainID, nursingHomeID) values(183, 0, 0, 0); 
select * from EmployedIn;
insert into EmployedIn values(183, 1);
select * from EmployedIn;
