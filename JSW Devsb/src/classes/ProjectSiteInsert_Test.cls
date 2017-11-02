@isTest
Global class ProjectSiteInsert_Test {
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
      //InfluencerInsert infinsert = new InfluencerInsert();
      ProjectSiteInsert.ProjectSitesWraper infwp = new ProjectSiteInsert.ProjectSitesWraper();
      //InfluencerWrapper influencerWrapper=new InfluencerWrapper ();
   
         infwp.projectSiteName= 'Sample Account';
         infwp.type='Project Sites';
         infwp.customername='test';
         infwp.approval=true;   
         
         RestRequest req = new RestRequest(); 
         RestResponse res = new RestResponse();
    
         req.requestURI = '<a target="_blank" href="https://jswcements--jswuat.cs6.my.salesforce.com/services/apexrest/InfluencerInsert/" rel="nofollow">https://jswcements--jswuat.cs6.my.salesforce.com/services/apexrest/InfluencerInsert/</a>';
         req.httpMethod = 'POST';
         RestContext.request = req;
         RestContext.response = res;
       String a= ProjectSiteInsert.doPost(infwp,curusr.id);    
         }   
     } 
     
    
  
     
}