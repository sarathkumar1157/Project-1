@RestResource(urlMapping='/MarketInfoManagement/*')
global with sharing class MarketInfoWebservice{

  @HttpPost
    global static List<Market_Information__c> doPost(String userId) {
        list<Market_Information__c> MarketInfoList= [SELECT Id,Name,Account__c,Account__r.name,Lead__c,Lead__r.name,Territory__c,Territory__r.name,Comments__c FROM Market_Information__c];
        return MarketInfoList;
    }
 
}