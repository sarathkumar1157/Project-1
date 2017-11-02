@isTest
public class VisitCheckIn_Test {
    public static testmethod void unitTest(){
        User thisUser = [SELECT Id FROM User WHERE Id = :UserInfo.getUserId()];
        System.runAs(thisUser){
            Profile sfp = [select id,name from Profile where name = 'JSW SO'];
            UserRole sfrl = [select id,name from UserRole where name = 'Vijayawada SO'];
            User curusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
                EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
                LocaleSidKey='en_IN', ProfileId = sfp.Id, UserRoleId = sfrl.id,
                TimeZoneSidKey='Asia/Kolkata', UserName='standardmnguser@testorg.com');
            insert curusr;
            
            Account acc = new Account();
            acc.Name = 'Sample Account';
            insert acc;
            
            Lead ld = new Lead();
            ld.LastName = 'Sample Lead';
            ld.Company = 'Sample Company';
            insert ld;
            
            Business_Partner__c bp = new Business_Partner__c();
            insert bp;
            
            Influencer__c inf = new Influencer__c();
            insert inf;
            
            Project_Site__c prj = new Project_Site__c();
            prj.Type__c = 'Project Sites';
            prj.End_Customer_Name__c = 'Sample End Customer';
            insert prj;
            
            Day_Plan__c dp = new Day_Plan__c();
            dp.Date__c = system.today();
            dp.Ownerid = curusr.id;
            insert dp;
            
            Visit__c vst = new Visit__c();
            vst.Planned_Date__c = system.today();
            vst.OwnerId = curusr.id;
            insert vst;
            
            VisitCheckIn.VisitWraper vstv = new VisitCheckIn.VisitWraper();
            vstv.potentiallead = false;
            
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.httpMethod = 'POST';
            RestContext.request = req;
            RestContext.response = res;
            String result = VisitCheckIn.doPost(vstv,vst.id);
        }        
    }
}