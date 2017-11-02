@isTest
public class VisitInsert_Test {
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
            
            VisitInsert.VisitWraperIns vstvpacc = new VisitInsert.VisitWraperIns();
            vstvpacc.plandate = system.today();
            vstvpacc.accid = acc.id;
            VisitInsert.VisitWraperIns vstvpld = new VisitInsert.VisitWraperIns();
            vstvpld.plandate = system.today();
            vstvpld.leadid = ld.id;
            VisitInsert.VisitWraperIns vstvpbp = new VisitInsert.VisitWraperIns();
            vstvpbp.plandate = system.today();
            vstvpbp.bpid = bp.id;
            VisitInsert.VisitWraperIns vstvpinf = new VisitInsert.VisitWraperIns();
            vstvpinf.plandate = system.today();
            vstvpinf.infid = inf.id;
            VisitInsert.VisitWraperIns vstvpprj = new VisitInsert.VisitWraperIns();
            vstvpprj.plandate = system.today();
            vstvpprj.prjid = prj.id;
            RestRequest req = new RestRequest(); 
            RestResponse res = new RestResponse();
            req.httpMethod = 'POST';
            RestContext.request = req;
            RestContext.response = res;
            String result = VisitInsert.doPost(vstvpacc,curusr.id);
            result = VisitInsert.doPost(vstvpld,curusr.id);
            result = VisitInsert.doPost(vstvpbp,curusr.id);
            result = VisitInsert.doPost(vstvpinf,curusr.id);
            result = VisitInsert.doPost(vstvpprj,curusr.id);
        }        
    }
}