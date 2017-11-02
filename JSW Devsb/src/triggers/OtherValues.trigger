trigger OtherValues on NSR_Other_Values__c (before insert,before update) 
{
    Set<String> othrdistrict = new Set<String>();
    Set<String> othrprod = new Set<String>();
    for(NSR_Other_Values__c othr : trigger.new)
    {
        othrdistrict.add(othr.District_Code__c);
        othrprod.add(othr.Product__c);
        //pdfrom.add(pd.From_Date__c);
        //pdto.add(pd.To_Date__c);
    }
    /*List<Invoice__c> invlist = [Select NSR_Other_Value__c,Sales_District__c,Brand_Short_Form__c,Commercial_Invoice_Date_Formula__c from Invoice__c where Sales_District__c IN: othrdistrict and Brand_Short_Form__c IN: othrprod];
    
    for(NSR_Other_Values__c othr : trigger.new)
    {
        for(Invoice__c inv : invlist)
        {
            if(inv.Sales_District__c == othr.district_code__c && inv.Brand_Short_Form__c == othr.Product__c && inv.Commercial_Invoice_Date_Formula__c >= othr.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= othr.To_Date__c)
                inv.NSR_Other_Value__c = othr.Other_Value__c;
        }
    }
    update invlist;*/
    if(trigger.isBefore)
    {
        List<Districts__c> dstlst = [select id,District_Code__c from Districts__c where District_Code__c IN: othrdistrict];
        List<product2> prodLists= [Select id,ProductCode from product2 where ProductCode IN: othrprod];
        
        for(product2 p:prodLists)
        {
            for(NSR_Other_Values__c ord:trigger.new)
            {
                if(ord.Product__c==p.ProductCode)
                {
                    ord.Product_L__c=p.id;
                }
            }
        }
        
        for(Districts__c p:dstlst)
        {
            for(NSR_Other_Values__c ord:trigger.new)
            {
                if(ord.District_Code__c==p.District_Code__c)
                {
                    ord.Districts__c=p.id;
                }
            }
        }
    }
}