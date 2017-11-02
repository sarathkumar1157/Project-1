@isTest
public class VisitsWebservice_Test {
  static testmethod void testDoPost(){
      User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
       // Insert account as current user
        System.runAs (thisUser){
         Profile sfp = [select id,name from Profile where name = 'JSW SO'];
         UserRole sfrl = [select id,name from UserRole where name = 'Vijayawada SO'];
         User curusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = sfp.Id, UserRoleId = sfrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardmnguser@testorg.com');
         insert curusr;
      
         Month_Plan__c pjp = new Month_Plan__c();
         insert pjp;
         
         Day_Plan__c dp = new Day_Plan__c();
         dp.Month_Plan__c = pjp.id;
         insert dp;
         Visit__c acc = new Visit__c();
         acc.Day_Plan__c = dp.id;
      // acc.Name = 'Sample Account';
      
      
         acc.OwnerId = curusr.id;
         insert acc;
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
    
         req.requestURI = '<a target="_blank" href="https://jswcements--jswuat.cs6.my.salesforce.com/services/apexrest/AccountManagement/" rel="nofollow">https://jswcements--jswuat.cs6.my.salesforce.com/services/apexrest/AccountManagement/</a>';
         req.httpMethod = 'POST';
         RestContext.request = req;
         RestContext.response = res;
         List<Visit__c> results = VisitsWebservice.doPost(curusr.id);    
         }   
     } 
     
     
  
     
}