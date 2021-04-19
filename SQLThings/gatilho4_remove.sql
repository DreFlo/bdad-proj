/* Gatilho 4:
    ->do not allow an ICUStay to start before or end after its corresponding Hospitalization 
*/

drop trigger if exists CheckICUStayDates;
