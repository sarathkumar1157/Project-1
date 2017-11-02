@RestResource(urlMapping='/VisitInsertIds/*')
global with sharing class VisitDelWebservice{

  @HttpPost
    global static List<Visit__c> doPost(String userId) {
        
        List<Visit__c> visitList = [select id from Visit__c where ownerid =: userId and Visit_Completed__c = true];
        return visitList;
    }
 
}