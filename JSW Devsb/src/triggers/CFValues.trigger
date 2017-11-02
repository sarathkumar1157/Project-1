trigger CFValues on NSR_C_F_Value_Changes__c (before insert,before update) 
{
    Set<String> cfplant = new Set<String>();
    Set<String> cfprod = new Set<String>();
    for(NSR_C_F_Value_Changes__c cf : trigger.new)
    {
        cfplant.add(cf.Plant__c);
        cfprod.add(cf.Product__c);
    }
    /*List<Invoice__c> invlist = [Select NSR_C_F_Value__c,Plant__c,Sales_District__c,Brand_Short_Form__c,Commercial_Invoice_Date_Formula__c from Invoice__c where Plant__c IN: cfplant and Brand_Short_Form__c IN: cfprod];
    
    for(NSR_C_F_Value_Changes__c cf : trigger.new)
    {
        for(Invoice__c inv : invlist)
        {
            if(inv.Plant__c == cf.Plant__c && inv.Brand_Short_Form__c == cf.Product__c && inv.Commercial_Invoice_Date_Formula__c >= cf.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= cf.To_Date__c)
                inv.NSR_C_F_Value__c = cf.Value__c;
        }
    }
    update invlist;*/
    if(trigger.isBefore)
    {
        List<Plant_Master__c> plantLists= [Select id,Plant_Code__c from Plant_Master__c where Plant_Code__c IN: cfplant];
        /*List<product2> prodLists= [Select id,ProductCode from product2 where ProductCode IN: cfprod];
        
        for(product2 p:prodLists)
        {
            for(NSR_C_F_Value_Changes__c ord:trigger.new)
            {
                if(ord.Product__c==p.ProductCode)
                {
                    ord.Product_L__c=p.id;
                }
            }
        }*/
        
        for(Plant_Master__c p:plantLists)
        {
            for(NSR_C_F_Value_Changes__c ord:trigger.new)
            {
                if(ord.Plant__c==p.Plant_Code__c )
                {
                    ord.Plant_Master__c=p.id;
                }
            }
        }
    }
}