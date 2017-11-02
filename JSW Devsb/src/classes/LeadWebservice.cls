@RestResource(urlMapping='/LeadManagement/*')
global with sharing class LeadWebservice{

  @HttpPost
    global static List<Lead> doPost(String userId) {
        List<Lead> leadsList = new List<Lead>();
        String curRole = '';
        User mobusr = [select id,name,userroleid,userrole.name,Profile.Name from user where id =: userId];
        
        curRole = mobusr.UserRole.Name.split(' ')[0];
        curRole = curRole+'%';
        List<User> allusrs = [select id,name from User where UserRole.Name like : curRole];
        Set<Id> userset = new Set<Id>();
        for(User usr : allusrs){
            userset.add(usr.id);
        }
        if(!mobusr.UserRole.Name.contains(' TSO')){
        leadsList = [SELECT Id,Name,Type__c,ownerId,owner.name,Expected_Volume_Committment_to_JSW__c,Location__c,District__c, 
                     Status,Company,Lead_Response__c,Phone,KYC_Form_Filled__c,Potential__c,Blended_cement_potential_in_MT__c,
                     Catgegory_A_potential_in_MT__c,Wholesale_Percentage__c,No_of_Sub_Dealers__c,Street,City,State,Country,PostalCode 
                     FROM Lead where Ownerid in: userset];
        }
        return leadsList;
    }
 
}