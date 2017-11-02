trigger pdvalues on NSR_PD_Values__c (before insert,before update) 
{
    Set<String> pddistrict = new Set<String>();
    Set<String> pdprod = new Set<String>();
    Set<String> pddc = new Set<String>();
    Integer mnth = System.Today().MOnth();
    Integer lstmnth = mnth - 1;
    for(NSR_PD_Values__c pd : trigger.new)
    {
        pddistrict.add(pd.District_Code__c);
        pdprod.add(pd.Product__c);
        pddc.add(pd.distribution_Channel__c);
        //pdfrom.add(pd.From_Date__c);
        //pdto.add(pd.To_Date__c);
    }
   /* List<Invoice__c> invlist = [Select NSR_PD_Value__c,Sales_District__c,Brand_Short_Form__c,Distribution_Channel__c,Commercial_Invoice_Date_Formula__c from Invoice__c where Sales_District__c IN: pddistrict and Brand_Short_Form__c IN: pdprod ANd distribution_Channel__c IN: pddc AND (CALENDAR_MONTH(CreatedDate) = :mnth OR CALENDAR_MONTH(CreatedDate) = :lstmnth)];
    System.debug('----INVOICE---'+invlist);
    for(NSR_PD_Values__c pd : trigger.new)
    {
        for(Invoice__c inv : invlist)
        {
            if(inv.Sales_District__c == pd.district_code__c && inv.Brand_Short_Form__c == pd.Product__c && inv.distribution_Channel__c == pd.distribution_Channel__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                inv.NSR_PD_Value__c = pd.PD_Value__c;
        }
    }
    update invlist;*/
    if(Trigger.isBefore)
    {
        List<Districts__c> dstlst = [select id,District_Code__c from Districts__c where District_Code__c IN: pddistrict];
        List<product2> prodLists= [Select id,ProductCode from product2 where ProductCode IN: pdprod];
        
        for(product2 p:prodLists)
        {
            for(NSR_PD_Values__c ord:trigger.new)
            {
                if(ord.Product__c==p.ProductCode)
                {
                    ord.Product_L__c=p.id;
                }
            }
        }
        
        for(Districts__c p:dstlst)
        {
            for(NSR_PD_Values__c ord:trigger.new)
            {
                if(ord.District_Code__c==p.District_Code__c)
                {
                    ord.District__c=p.id;
                }
            }
        }
    }
    
}