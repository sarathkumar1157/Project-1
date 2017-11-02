global class PotentialLeadNotifScheduler implements Schedulable{
 
    global void execute(SchedulableContext sc){
        String query = 'select id,OwnerID,If_Potential_Lead_Share_with_Manager__c,Name,Type__c,Project_Site__c from Visit__c where If_Potential_Lead_Share_with_Manager__c = true and Check_In_Time__c = TODAY';

        PotentialLeadNotif leadnotif = new PotentialLeadNotif(query);
        database.ExecuteBatch(leadnotif);

    }
}