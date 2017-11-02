public class MktInfoEdit 
{
    @AuraEnabled
    public static list<Account> getAllAccounts()
    {
        return [select id, name from Account Order By Name];
    }
    @AuraEnabled
    public static list<Brand__c> getAllBrands()
    {
        return [select id, name from Brand__c];
    }
    @AuraEnabled
    public static list<Product2> getAllProducts()
    {
        return [select id, name from Product2];
    }
    @AuraEnabled
    public static list<Visit__c> getAllVsts()
    {
        return [select id, name from Visit__c];
    }
    @AuraEnabled
    public static list<Marketing_Info__c> getallMi(String acnt,String tdate)
    {
        return [select id,name,Account__c,Brand__c,Brand__r.name,RSP_Max__c,RSP_Min__c,WSP_Max__c,WSP_Min__c,BP_Min__c from Marketing_Info__c where Account__c =:acnt and DAY_ONLY(CreatedDate) =:date.valueof(tdate)];
    }
    @AuraEnabled
    public static list<Market_Information__c> getallMijsw(String acnt,String tdate)
    {
        return [select id,name,Account__c,Account__r.Name,Comments__c,JSW_Average_Monthly_Volume__c,JSW_BP_Min__c,JSW_RSP_Max__c,JSW_RSP_Min__c,JSW_WSP_Max__c,JSW_WSP_Min__c,Product__c,Visit__c,Territory__c from Market_Information__c where Account__c =:acnt and DAY_ONLY(CreatedDate) =:date.valueof(tdate)];
    }
    @AuraEnabled
    public static void saveEdit(String mkinf,String mkjsw)
    {
        Marketing_Info__c[] values = (List<Marketing_Info__c>) JSON.deserialize(mkinf,List<Marketing_Info__c>.Class);
        Market_Information__c[] values1 = (List<Market_Information__c>) JSON.deserialize(mkjsw,List<Market_Information__c>.Class);
        update values;
        update values1;
    }
}