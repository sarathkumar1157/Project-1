@isTest
public class batchPJPReportTest {
    public static testmethod void unitTest(){
        Account acc = new Account();
        acc.Name = 'Sample Account';
        insert acc;
        
        Month_Plan__c pjp = new Month_Plan__c();
        insert pjp;
        
        /*Month_Plan__c pjp1 = new Month_Plan__c();
        insert pjp1;
        
        Month_Plan__c pjp2 = new Month_Plan__c();
        insert pjp2;
        
        Month_Plan__c pjp3 = new Month_Plan__c();
        insert pjp3;*/
        
        Day_Plan__c dp = new Day_Plan__c();
        dp.Month_Plan__c = pjp.id;
        insert dp;
        
        /*Day_Plan__c dp1 = new Day_Plan__c();
        dp1.Month_Plan__c = pjp1.id;
        insert dp1;
        
        Day_Plan__c dp2 = new Day_Plan__c();
        dp2.Month_Plan__c = pjp2.id;
        insert dp2;*/
        
        Visit__c vst = new Visit__c();
        vst.Day_Plan__c = dp.id;
        insert vst;
        
        Visit__c vst1 = new Visit__c();
        vst1.Day_Plan__c = dp.id;
        insert vst1;
        
        Visit__c vst2 = new Visit__c();
        vst2.Day_Plan__c = dp.id;
        vst2.Planned__c = true;
        vst2.Check_In__c = 'sample';
        insert vst2;
        
        Visit__c vst3 = new Visit__c();
        vst3.Name = 'Some text here';
        vst3.Day_Plan__c = dp.id;
        vst3.Check_In__c = 'sample';
        vst3.Account__c = acc.id;
        vst3.Planned_Date__c = system.today();
        insert vst3;
        
        /*Visit__c vst4 = new Visit__c();
        vst4.Day_Plan__c = dp1.id;
        vst4.Planned__c = true;
        vst4.Check_In__c = 'sample';
        insert vst4;
        
        Visit__c vst5 = new Visit__c();
        vst5.Name = 'Some text here';
        vst5.Day_Plan__c = dp2.id;
        vst5.Check_In__c = 'sample';
        vst5.Account__c = acc.id;
        vst5.Planned_Date__c = system.today();
        insert vst5;*/
        
        Market_Information__c mkt = new Market_Information__c();
        mkt.Visit__c = vst.id;
        insert mkt;
        
        Market_Information__c mkt1 = new Market_Information__c();
        mkt1.Visit__c = vst.id;
        insert mkt1;
        
        Marketing_Info__c mkinf = new Marketing_Info__c();
        mkinf.Market_Information__c = mkt.id;
        insert mkinf;
        
        Test.startTest();
        batchPJPReport pjprep = new batchPJPReport('select id,name,Total_No_of_Visits_Planned__c,Total_No_of_Visits_Check_In_Planned__c,Total_no_of_Visits_Unplanned__c,Market_Information_Count__c,Price_Reading_Count__c from Month_Plan__c where RecordType.Name = \'PJP\'');
    	Database.executeBatch(pjprep,1);
        Test.stopTest();
    }
}