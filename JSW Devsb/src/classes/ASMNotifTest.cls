@isTest
public class ASMNotifTest {
    public static testmethod void CustomerSharingRulesTest(){
        Profile sfp = [select id,name from Profile where name = 'JSW SO'];
        UserRole sfrl = [select id,name from UserRole where name = 'Vijayawada SO'];
        User sfusr = new User(Alias = 'standt', Email='standarduser@testorg.com', 
            EmailEncodingKey='UTF-8', LastName='Testing', LanguageLocaleKey='en_US', UserRoleId = sfrl.id,
            LocaleSidKey='en_IN', ProfileId = sfp.Id,
            TimeZoneSidKey='Asia/Kolkata', UserName='standardsfuser@testorg.com');
        insert sfusr;
        System.runAs(sfusr){
            Month_Plan__c pjp = new Month_Plan__c();
        	pjp.Status__c = 'New Request';
        	pjp.Start_Date__c = system.today();
        	pjp.OwnerId = sfusr.id;
        	insert pjp;
        }
        
        ASMNotifSchedule notif = new ASMNotifSchedule();
        String sch = '0 15 12 * * ?'; 
        Test.startTest();
        system.schedule('ASM Notification', sch, notif);
        Test.stopTest(); 
    }
}