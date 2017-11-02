@RestResource(urlMapping='/ProjectSitesManagement/*')
global with sharing class ProjectSitesWebservice{

    @HttpPost
    global static List<Project_Site__c> doPost(String userId) {
        List<Project_Site__c> projectSitesList = new List<Project_Site__c>();
        String curRole = '';
        User mobusr = [select id,name,userroleid,userrole.name,Profile.Name from user where id =: userId];
        
        curRole = mobusr.UserRole.Name.split(' ')[0];
        curRole = curRole+'%';
        List<User> allusrs = [select id,name from User where UserRole.Name like : curRole];
        Set<Id> userset = new Set<Id>();
        for(User usr : allusrs){
            userset.add(usr.id);
        }
        projectSitesList = [SELECT Id,Name,Account__c,Account__r.name,Type__c,Territory__c,Territory__r.name,ownerId,owner.name,
                            End_Customer_Name__c,Phone_Number__c,Site_Sub_Type__c,Product__c,Product_Quantity_Required__c,Site_Status__c,
                            Location__c,Customer_Email__c,Street__c,City__c,State__c,Country__c,Zip_Postal_Code__c,Engineer__c,Architect__c,
                            Structural_Consultant__c,JSW_Cement_Approval__c,Volume_Potential_in_MT__c,Construction_Stage__c,Project_Start_Date__c,
                            Project_End_Date__c,Competitor_Brands__c,Name_of_Concerned_SO__c,Name_of_Concerned_SO__r.Name,Contact_Person_1__c,
                            Contact_Person_2__c,Contact_Person_3__c,Contact_Email_1__c,Contact_Email_2__c,Contact_Email_3__c,Contact_Phone_1__c,
                            Contact_Phone_2__c,Contact_Phone_3__c,Contact_Role_1__c,Contact_Role_2__c,Contact_Role_3__c FROM Project_Site__c where ownerid in: userset];
        return projectSitesList;
    }
 
}