/* Gatilho 3:
    ->do not allow a NursingHome to be added to a COVIDCase with an already registered EmploymentSector 
*/

insert into COVIDCase(caseID, parishID, strainID) values(184, 0, 0);
select * from COVIDCase;
insert into EmployedIn values (184, 1);
update COVIDCase set nursingHomeID = 0 where caseID = 184;
select * from COVIDCase;
