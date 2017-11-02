@RestResource(urlMapping='/MarketInfoInsert/*')
global with sharing class MarketInfoInsert{

  @HttpPost
    global static void doPost(MarketInfoWrapper marketInfoWrapper) {
       Market_Information__c l=new Market_Information__c();
       l.Account__c=marketInfoWrapper.account;
       l.Lead__c=marketInfoWrapper.lead;
       l.Territory__c=marketInfoWrapper.territory;    
       l.Comments__c=marketInfoWrapper.comments;    
       l.Visit__c=marketInfoWrapper.visit;
       l.ownerId=marketInfoWrapper.owner;
       insert l;
       
       Marketing_Info__c mInfo = new Marketing_Info__c();
        mInfo.Brand__c=marketInfoWrapper.brand;
        mInfo.Products__c=marketInfoWrapper.product;
        mInfo.WSP_Min__c=marketInfoWrapper.wsp;
        mInfo.RSP_Min__c=marketInfoWrapper.rsp;
        mInfo.BP_Min__c=marketInfoWrapper.bp;
        mInfo.Account__c=marketInfoWrapper.account;
        mInfo.Market_Information__c=l.id;
        insert mInfo;
       
       }
       
       global class MarketInfoWrapper {
       String  account{get; set;}
       String lead{get; set;}
       String territory{get; set;}
       String comments{get; set;}
       String brand{get; set;}
       String  product{get; set;}
       Double  wsp{get; set;}
       Double  rsp{get; set;}
       Double  bp{get; set;}
       String  visit{get; set;}
       global String  owner{get; set;}
       }
}