trigger PRFTValues on NSR_PRFT_Values__c (before insert,before update) 
{
    Set<String> prftplant = new Set<String>();
    Set<String> prftprod = new Set<String>();
    for(NSR_PRFT_Values__c prft : trigger.new)
    {
        prftplant.add(prft.Plant__c);
        prftprod.add(prft.Product__c);
        //pdfrom.add(pd.From_Date__c);
        //pdto.add(pd.To_Date__c);
    }
    /*List<Invoice__c> invlist = [Select NSR_PRFT_Value__c,Plant__c,Sales_District__c,Brand_Short_Form__c,Commercial_Invoice_Date_Formula__c from Invoice__c where Plant__c IN: prftplant and Brand_Short_Form__c IN: prftprod];
    
    for(NSR_PRFT_Values__c prft : trigger.new)
    {
        for(Invoice__c inv : invlist)
        {
            if(inv.Plant__c == prft.Plant__c && inv.Brand_Short_Form__c == prft.Product__c && inv.Commercial_Invoice_Date_Formula__c >= prft.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= prft.To_Date__c)
                inv.NSR_PRFT_Value__c = prft.PRFT_Value__c;
        }
    }
    update invlist;*/
    if(trigger.isBefore)
    {
        List<Plant_Master__c> plantLists= [Select id,Plant_Code__c from Plant_Master__c where Plant_Code__c IN: prftplant];
        /*List<product2> prodLists= [Select id,ProductCode from product2 where ProductCode IN: prftprod];
        
        for(product2 p:prodLists)
        {
            for(NSR_PRFT_Values__c ord:trigger.new)
            {
                if(ord.Product__c==p.ProductCode)
                {
                    ord.Product_L__c=p.id;
                }
            }
        }
        */
        for(Plant_Master__c p:plantLists)
        {
            for(NSR_PRFT_Values__c ord:trigger.new)
            {
                if(ord.Plant__c==p.Plant_Code__c )
                {
                    ord.Plant_Master__c=p.id;
                }
            }
        }
    }
}