@RestResource(urlMapping='/TerritoriesSync/*')
global with sharing class TerritoriesSyncservice{

  @HttpPost
    global static List<District__c> doPost(String userId,DateTime dte) {
        list<District__c> TerritoriesList = new List<District__c>();
        String curRole = '';
        User mobusr = [select id,name,userroleid,userrole.name,Profile.Name from user where id =: userId];
        
        curRole = mobusr.UserRole.Name.split(' ')[0];
        curRole = curRole+'%';
        List<User> allusrs = [select id,name from User where UserRole.Name like : curRole];
        Set<Id> userset = new Set<Id>();
        for(User usr : allusrs){
            userset.add(usr.id);
        }
        TerritoriesList = [SELECT Id,Name,Territory_Code__c,Districts__c,Districts__r.name,State_Master__c,State_Master__r.name,Zone__c FROM District__c where Ownerid in: userset and LastModifiedDate >=: dte];
        return TerritoriesList;
    }
 
}