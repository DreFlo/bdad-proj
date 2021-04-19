
/* Gatilho 1:
    -> do not allow a COVIDCase already registered in a NursingHome to be added to EmployedIn
*/


drop trigger if exists CheckAlreadyInNursingHome;
