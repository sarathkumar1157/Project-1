@RestResource(urlMapping='/InfluencersSync/*')
global with sharing class InfluencersSyncservice{

    @HttpPost
    global static List<Influencer__c> doPost(String userId,DateTime dte) {
        
        List<Influencer__c> InfluencersList = new List<Influencer__c>();
        String curRole = '';
        User mobusr = [select id,name,userroleid,userrole.name,Profile.Name from user where id =: userId];
        
        curRole = mobusr.UserRole.Name.split(' ')[0];
        curRole = curRole+'%';
        List<User> allusrs = [select id,name from User where UserRole.Name like : curRole];
        Set<Id> userset = new Set<Id>();
        for(User usr : allusrs){
            userset.add(usr.id);
        }
        
        InfluencersList = [SELECT Id,Name,Type__c,Account__c,Account__r.name,District__c,District__r.name,Inclination_to_JSW__c,
                            Phone__c,Email__c,Street__c,City__c,State_Province__c,Country__c,Zip_Postal_Code__c,No_of_sites_under_influencer__c,
                            Category__c,Volume_potential_in_MT__c,Site_Name__c,Site_Name__r.Name,Registered_with_JSW_ELP_program__c,Name_of_concerned_SO__c,
                            Name_of_concerned_SO__r.Name,Competitor_Brands__c,Contact_Person_1__c,Contact_Person_2__c,Contact_Person_3__c,
                            Contact_Email_1__c,Contact_Email_2__c,Contact_Email_3__c,Contact_Phone_1__c,Contact_Phone_2__c,Contact_Phone_3__c,
                            Contact_Role_1__c,Contact_Role_2__c,Contact_Role_3__c,ownerId,owner.name,Zone__c FROM Influencer__c where Ownerid in: userset and LastModifiedDate >=: dte];
        
        return InfluencersList;
    }
 
}