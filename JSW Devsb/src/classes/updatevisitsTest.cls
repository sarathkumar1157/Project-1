@isTest
public class updatevisitsTest
{
public static testmethod void weekPlan()
{
    Set<String> wpsubids = new Set<String>();
    Set<String> wpunsubids = new Set<String>();
    Set<String> dpids = new Set<String>();
    List<Day_Plan__c> dplist = new List<Day_Plan__c>(); 
User u = [select firstname from user where id=:userinfo.getuserid()];
Account ac=new Account();
ac.Name='Acc';
insert ac;

Week_Plan__c WP=new Week_Plan__c();
WP.name='test';
WP.Start_Date__c=system.today();
WP.End_Date__c=system.today()+7;
Wp.Submitted_for_Approval__c =true;
WP.Status__c='Submitted';
insert WP;
    /*Week_Plan__c WP1=new Week_Plan__c();
WP1.name='test';
WP1.Start_Date__c=system.today();
WP1.End_Date__c=system.today()+7;
Wp1.Submitted_for_Approval__c =true;
WP1.Status__c='Approved';
insert WP1;*/
wpsubids.add(wp.id);
Day_Plan__c dp=new Day_Plan__c();
dp.Name='day';
    dp.Week_Plan__c = WP.Id;
insert dp;

Visit__c vc=new Visit__c();
vc.Account__c=ac.id;
vc.Week_Plan_Submitted__c=true;
vc.Day_Plan__c=dp.id;
insert vc;
    Week_Plan__c wkpln = [select id,Status__c,Submitted_for_Approval__c,End_Date__c,Start_Date__c,name from Week_Plan__c where id = :WP.id];
    wkpln.name = 'test edit';
        update wkpln;
    }
}