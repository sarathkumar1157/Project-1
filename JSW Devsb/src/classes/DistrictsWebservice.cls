@RestResource(urlMapping='/DistrictsManagement/*')
global with sharing class DistrictsWebservice{

  @HttpGet
    global static List<Districts__c> doGet() {
        list<Districts__c> DistrictsList= [SELECT Id,Name,District_Code__c,State__c,Zone__c FROM Districts__c];
        return DistrictsList;
    }
 
}