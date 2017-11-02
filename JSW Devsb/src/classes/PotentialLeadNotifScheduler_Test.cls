@isTest(SeeAllData = true)
public class PotentialLeadNotifScheduler_Test {
    public static testmethod void unitTest(){
        Profile msfp = [select id,name from Profile where name = 'JSW Sales'];
        Profile tsfp = [select id,name from Profile where name = 'JSW Technical Services'];
        
        UserRole msrl = [select id,name from UserRole where name = 'Vijayawada ASM'];
        UserRole tsrl = [select id,name from UserRole where name = 'Vijayawada TSO'];
        
        User mngusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = msfp.Id, UserRoleId = msrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardmnguser@testorg.com');
        insert mngusr;
        
        User tsfusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = tsfp.Id, ManagerId = mngusr.id, UserRoleId = tsrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardtsouser@testorg.com');
        insert tsfusr;
        
        User tsfusr1 = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', 
            LocaleSidKey='en_IN', ProfileId = tsfp.Id, ManagerId = mngusr.id, UserRoleId = tsrl.id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardtsouser1@testorg.com');
        insert tsfusr1;
        
        System.runAs(tsfusr){
            Project_Site__c prj = new Project_Site__c();
            prj.Name = 'Sample Project Site';
            prj.Type__c = 'Project Sites';
            prj.End_Customer_Name__c = 'Sample Customer Name';
            insert prj;
            
            Project_Site__c prj1 = new Project_Site__c();
            prj1.Name = 'Sample Project Site1';
            prj1.Type__c = 'Project Sites';
            prj1.End_Customer_Name__c = 'Sample Customer Name1';
            insert prj1;
            
            Month_Plan__c pjp = new Month_Plan__c();
            insert pjp;
            
            Day_Plan__c dp = new Day_Plan__c();
            dp.Month_Plan__c = pjp.id;
            insert dp;
            
            Visit__c vst = new Visit__c();
            vst.If_Potential_Lead_Share_with_Manager__c = true;
            vst.Check_In__c = String.valueOf(system.now());
            vst.Day_Plan__c = dp.id;
            vst.Project_Site__c = prj.id;
            insert vst;
            
            Visit__c vst1 = new Visit__c();
            vst1.If_Potential_Lead_Share_with_Manager__c = true;
            vst1.Check_In__c = String.valueOf(system.now());
            vst1.Day_Plan__c = dp.id;
            vst1.Project_Site__c = prj1.id;
            insert vst1;
        }
        
        System.runAs(tsfusr1){
            Project_Site__c prj2 = new Project_Site__c();
            prj2.Name = 'Sample Project Site';
            prj2.Type__c = 'Project Sites';
            prj2.End_Customer_Name__c = 'Sample Customer Name';
            insert prj2;
            
            Project_Site__c prj3 = new Project_Site__c();
            prj3.Name = 'Sample Project Site1';
            prj3.Type__c = 'Project Sites';
            prj3.End_Customer_Name__c = 'Sample Customer Name1';
            insert prj3;
            
            Month_Plan__c pjp1 = new Month_Plan__c();
            insert pjp1;
            
            Day_Plan__c dp1 = new Day_Plan__c();
            dp1.Month_Plan__c = pjp1.id;
            insert dp1;
            
            Visit__c vst2 = new Visit__c();
            vst2.If_Potential_Lead_Share_with_Manager__c = true;
            vst2.Check_In__c = String.valueOf(system.now());
            vst2.Day_Plan__c = dp1.id;
            vst2.Project_Site__c = prj2.id;
            insert vst2;
            
            Visit__c vst3 = new Visit__c();
            vst3.If_Potential_Lead_Share_with_Manager__c = true;
            vst3.Check_In__c = String.valueOf(system.now());
            vst3.Day_Plan__c = dp1.id;
            vst3.Project_Site__c = prj3.id;
            insert vst3;
        }
        
        String query = 'select id,OwnerID,If_Potential_Lead_Share_with_Manager__c,Name,Type__c,Project_Site__c from Visit__c where If_Potential_Lead_Share_with_Manager__c = true and Check_In_Time__c = TODAY';

        PotentialLeadNotifScheduler notif = new PotentialLeadNotifScheduler();
        String sch = '0 15 12 * * ?'; 
        Test.startTest();
        system.schedule('Potential Lead Notification', sch, notif);
        Test.stopTest();
    }
}