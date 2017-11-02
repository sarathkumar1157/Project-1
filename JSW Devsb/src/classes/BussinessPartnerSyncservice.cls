@RestResource(urlMapping='/BussinessPartnerSync/*')
global with sharing class BussinessPartnerSyncservice{

    @HttpPost
    global static List<Business_Partner__c> doPost(String userId,DateTime dte) {
        List<Business_Partner__c> bussinessPartnersList = new List<Business_Partner__c>();
        String curRole = '';
        User mobusr = [select id,name,userroleid,userrole.name,Profile.Name from user where id =: userId];
        
        curRole = mobusr.UserRole.Name.split(' ')[0];
        curRole = curRole+'%';
        List<User> allusrs = [select id,name from User where UserRole.Name like : curRole];
        Set<Id> userset = new Set<Id>();
        for(User usr : allusrs){
            userset.add(usr.id);
        }
        bussinessPartnersList = [SELECT Id,Name,Customer_No_Bussiness__c,Distribution_Channel__c,Division__c,Sold_to_Code__c,Address__c,Phone__c,Sales_Office__c,Customer_Code__c,
                                Sales_Office_Text__c,recordtypeId,recordtype.name,ownerId,owner.name,Location__c FROM Business_Partner__c where Ownerid in: userset and LastModifiedDate >=: dte];
        return bussinessPartnersList;
    }
 
}