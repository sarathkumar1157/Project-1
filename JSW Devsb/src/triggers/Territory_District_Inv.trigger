trigger Territory_District_Inv on Invoice__c (before insert,before update) 
{
    Map<String,String> dstmap = new Map<String,String>();
    Map<String,String> termap = new Map<String,String>();
    List<String> dststr = new List<String>();
    List<String> terstr = new List<String>();
    
    for(Invoice__c inv : trigger.new)
    {
        dststr.add(inv.Sales_District__c);
        terstr.add(inv.Sales_District__c);
    }
    
    List<Districts__c> dstlst = [select id,District_Code__c from Districts__c where District_Code__c IN: dststr];
    List<District__c> terlst = [Select id,Territory_Code__c from District__c where Territory_Code__c IN: terstr];
    
    for(Districts__c dst : dstlst)
    {
        dstmap.put(dst.District_Code__c, dst.id);
    }
    for(District__c ter : terlst)
    {
        termap.put(ter.Territory_Code__c, ter.id);
    }
    
    for(Invoice__c inv : trigger.new)
    {
        inv.Districts__c = dstmap.get(inv.Sales_District__c);
        inv.Territory__c = termap.get(inv.Sales_District__c);
    }
}