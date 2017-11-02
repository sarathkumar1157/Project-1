@istest
public class createPJP_test{
	public static testMethod void createPJPtest(){
        
        User u = [select firstname from user where id=:userinfo.getuserid()];
        id rtype = Schema.SObjectType.Month_Plan__c.getRecordTypeInfosByName().get('PJP').getRecordTypeId();
        
        Month_Plan__c MPC = new Month_Plan__c();
        MPC.Name = UserInfo.getFirstName()!=null?UserInfo.getFirstName()+' ':'';
        MPC.Name = MPC.Name + UserInfo.getLastName() + ' January 2017';
        MPC.Start_Date__c = Date.newInstance(2017, 1, 1);
        MPC.End_Date__c = Date.newInstance(2017, 1, 31);
        MPC.User__c = u.id;
        MPC.Year__c = '2016';
        MPC.RecordTypeId = rtype;
        insert MPC;
        
        Apexpages.standardcontroller cont = new apexpages.standardcontroller(MPC);
        createPJP CPJP = new createPJP(cont);
        PageReference pageRef = Page.DailyVisitPlan;
        pageRef.getParameters().put('id',MPC.id);
        Test.setCurrentPage(pageRef);
        CPJP.year='2017';
        CPJP.month='January';
        CPJP.createRecs();
        CPJP.pjptab();
        
        CPJP.year='2016';
        CPJP.month='February';
        CPJP.createRecs();
        
        CPJP.year='2016';
        CPJP.month='March';
        CPJP.createRecs();
        
        CPJP.year='2017';
        CPJP.month='March';
        CPJP.createRecs();
        
        CPJP.year='2016';
        CPJP.month='December';
        CPJP.createRecs();
        
        CPJP.year='2016';
        CPJP.month='July';
        CPJP.createRecs();
        
        CPJP.year='2016';
        CPJP.month='October';
        CPJP.createRecs();
        
        delete MPC;
	}
}