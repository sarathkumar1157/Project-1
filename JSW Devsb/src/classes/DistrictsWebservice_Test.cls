@isTest
public class DistrictsWebservice_Test {
  static testmethod void testDoPost(){
     
         Districts__c acc = new Districts__c();
        acc.Name = 'Sample Account';
      
      // acc.LastName='test';
     //  acc.Company='test';
        // acc.OwnerId = curusr.id;
         insert acc;
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
    
         req.requestURI = '<a target="_blank" href="https://jswcements--jswuat.cs6.my.salesforce.com/services/apexrest/DistrictsManagement/" rel="nofollow">https://jswcements--jswuat.cs6.my.salesforce.com/services/apexrest/DistrictsManagement/</a>';
         req.httpMethod = 'POST';
         RestContext.request = req;
         RestContext.response = res;
         List<Districts__c> results = DistrictsWebservice.doGet();    
         }   
     
     
     
  
     
}