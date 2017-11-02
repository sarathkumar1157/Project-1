@isTest
public class RemoveRelatedVisitsTest {
    public static testmethod void month(){

User u = [select firstname from user where id=:userinfo.getuserid()];
Account ac=new Account();
ac.name='Mohan';
insert ac;
 
Month_Plan__c MPC=new Month_Plan__c();
MPC.Name='plan';
MPC.Start_Date__c=system.today()-30;
MPC.End_Date__c=system.today();
MPC.User__c=u.id;
MPC.Year__c ='2016';
insert MPC;
delete  MPC;   

    }
}