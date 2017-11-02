@RestResource(urlMapping='/AccountSync/*')
global with sharing class AccountSyncservice{

  @HttpPost
    global static List<Account> doPost(String userId,DateTime dte) {
        List<Account> accountList = new List<Account>();
        String curRole = '';
        User mobusr = [select id,name,userroleid,userrole.name,Profile.Name from user where id =: userId];
        curRole = mobusr.UserRole.Name.split(' ')[0];
        curRole = curRole+'%';
        List<User> allusrs = [select id,name from User where UserRole.Name like : curRole];
        Set<Id> userset = new Set<Id>();
        for(User usr : allusrs){
            userset.add(usr.id);
        }
        accountList = [SELECT Id,Name, Company_Code__c,DivistionDesc__c,Distribution_Channel_Descrption__c,recordtype.name,Sales_Office__c,
                       Sales_Office_text__c,ownerId,owner.name,Credit_Limit__c,SSD__c,Eligible_Credit_Period__c,Credit_Available__c,Overdue_Amount__c,
                       Credit_Last_Updated_Formula__c,Credit_Outstanding__c,Location__c,X365__c,X0_007__c,X008_015__c,X016_030__c,
                       X031_045__c,X046_060__c,X061_090__c,X091_180__c,X181_365__c,Packing_Type__c,Carpet_Area_Sqft__c,Ideal_Storage_Capacity_MT__c
                        FROM Account where Ownerid in:userset and LastModifiedDate >=: dte];        
        
        return accountList;
    }
 
}