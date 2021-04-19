
/* Gatilho 3:
    ->do not allow a NursingHome to be added to a COVIDCase with an already registered EmploymentSector 
*/

drop trigger if exists CheckAlreadyEmployed;
