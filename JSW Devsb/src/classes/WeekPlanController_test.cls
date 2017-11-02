@istest
public class WeekPlanController_test{
public static testmethod void WeekPlanController_method(){
User u = [select firstname from user where id=:userinfo.getuserid()];
Month_Plan__c MPC=new Month_Plan__c();
MPC.Name='plan';
MPC.Start_Date__c=system.today()-30;
MPC.End_Date__c=system.today();
MPC.User__c=u.id;
MPC.Year__c ='2016';
insert MPC;

Week_Plan__c WP=new Week_Plan__c();
WP.name='test';
WP.Start_Date__c=system.today();
WP.End_Date__c=system.today()+7;
WP.Month_Plan__c=MPC.id;
Wp.Submitted_for_Approval__c =true;
WP.Status__c='New Request';
insert WP;
    
Day_Plan__c DP= new Day_Plan__c();
DP.name='test dayplan';
DP.Week_Plan__c=wp.id;
insert DP;

Visit__c VS=new Visit__c();
VS.Name='Test visit';
VS.Day_Plan__c=dp.id;
insert VS;

ApexPages.StandardController sc = new ApexPages.StandardController(WP);
apexpages.currentpage().getparameters().put('id', wp.id);
 WeekPlanController WPC=new WeekPlanController(Sc);
 PageReference ref =  new PageReference('/a05/o');
 test.setCurrentPage(ref); 
 WPC.pjptab();
 pagereference pg=page.dailyvisitplan;
 Test.setCurrentPage(pg);
 WPC.monthtab();
 apexpages.currentpage().getparameters().put('id', wp.id);

 WPC.directApprove();
 WPC.directReject();
}
}