@isTest
public class StagingConvertTest {
    public static testmethod void unitTest(){
        Month_Plan__c pjp = new Month_Plan__c();
        insert pjp;
        Day_Plan__c dp = new Day_Plan__c();
        dp.Date__c = system.today();
        dp.Month_Plan__c = pjp.id;
        insert dp;
        Visit__c vst = new Visit__c();
        vst.Planned_Date__c = system.today();
        insert vst;
        
        Staging__c stg = new Staging__c();
        stg.Check_In__c = 'Check In Time';
        stg.userid__c = 'Sample';
        stg.App_Version__c = 'Sample App Version';
        stg.External_Master_Id__c = 'Sample External Master';
        stg.Planned_Date__c = system.today()+1;
        insert stg;
        
        Staging__c stg1 = new Staging__c();
        stg1.Check_In__c = 'Check In Time';
        stg1.userid__c = vst.id;
        stg1.App_Version__c = 'Sample App Version';
        stg1.External_Master_Id__c = 'Sample External Master';
        insert stg1;
        
        Staging__c stg2 = new Staging__c();
        stg2.Check_In__c = 'Check In Time';
        stg2.userid__c = vst.id;
        stg2.Condition_of_Godown__c = 'Very Bad';
        stg2.App_Version__c = 'Sample App Version';
        stg2.External_Master_Id__c = 'Sample External Master';
        insert stg2;
        StagingConvert stgcon = new StagingConvert('Check_In__c != null');
    }
}