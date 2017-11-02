global class NSRCalculations implements Database.Batchable<sObject> {

    public String qrystr;
    public Date myDate;
    public NSRCalculations(String str)
    {
        myDate = System.today()-1;
        //qrystr = str+String.valueOf(myDate).substring(0,10);
        qrystr = str;
        System.debug('----->'+qrystr);
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        //String query = 'Select id,name,Plant_Name__c,Sales_Office_Description__c,Account__c,Commercial_Invoice_Date_Formula__c,Qty__c from Invoice__c where Commercial_Invoice_Date_Formula__c in (2016-12-23,2016-12-24,2016-12-25,2016-12-26,2016-12-27,2016-12-28,2016-12-29,2016-12-30,2016-12-31) and Account__c != null';
        String query = qrystr;
        System.debug('----->'+query);
        return Database.getQueryLocator(qrystr);
    }
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) 
    {
        Set<String> DistProd = new Set<String>();
        Set<String> CustIncv = new Set<String>();
        Set<String> MfgPlntSLoc = new Set<string>();
        Set<String> PlntSLoc = new Set<string>();
        Set<String> cominvnumb = new Set<string>();
        List<Invoice__c > invlist = new List<Invoice__c >();
        
        for(Invoice__c inv : scope)
        {
            DistProd.add(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Distribution_channel__c);
            MfgPlntSLoc.add(inv.Plant_Short_Form__c+':'+inv.Plant__c+':'+inv.SLOC__c+':'+inv.Brand_Short_Form__c);
            PlntSLoc.add(inv.Plant__c+':'+inv.SLOC__c+':'+inv.Brand_Short_Form__c);
            CustIncv.add(inv.Sold_To_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.distribution_Channel__c);
            cominvnumb.add(inv.Commercial_Invoice_Number__c);
        }
        System.debug('----->'+DistProd);
        List<NSR_PD_Values__c> nsrpdvalues = [Select Code_Formula__c,From_Date__c,PD_Value__c,distribution_Channel__c,district_code__c,Product__c,To_Date__c from NSR_PD_Values__c where Code_Formula__c IN: DistProd];
        List<NSR_Other_Values__c> nsrothrvalues = [Select distribution_Channel__c,Code_Formula__c,From_Date__c,Other_Value__c,district_code__c,Product__c,To_Date__c from NSR_Other_Values__c where Code_Formula__c IN: DistProd];
        List<NSR_PRFT_Values__c> nsrprftvalues = [Select Code_Formula__c,From_Date__c,PRFT_Value__c,Plant__c,Product__c,To_Date__c,Storage_Location__c,MFG_Plant__c from NSR_PRFT_Values__c where Code_Formula__c IN: MfgPlntSLoc];
        List<NSR_C_F_Value_Changes__c> nsrcfvalues = [Select Code_Formula__c,From_Date__c,Value__c,Plant__c,Product__c,To_Date__c,Storage_Location__c,MFG_Plant__c from NSR_C_F_Value_Changes__c where Code_Formula__c IN: PlntSLoc];
        List<Adhoc_Incentive__c> adhocvalues = [Select Code_Formula__c,From_Date__c,Value__c,distribution_Channel__c,district_code__c,Product__c,To_Date__c from Adhoc_Incentive__c where Code_Formula__c IN: DistProd];
        List<Customer_Incentive__c> custvalues = [Select Customer_Code__c,Customer__c,Code_Formula__c,From_Date__c,Value__c,distribution_Channel__c,district_code__c,Product__c,To_Date__c from Customer_Incentive__c where Code_Formula__c IN: CustIncv];
        List<Invoice_Discounts__c> invdiscs = [Select Commercial_Invoice_Number__c,Invoice_Discount_Value__c from Invoice_Discounts__c where Commercial_Invoice_Number__c IN: cominvnumb];
        System.debug('----->'+nsrpdvalues);
        for(Invoice__c inv : scope)
        {
            for(NSR_PD_Values__c pd : nsrpdvalues)
            {
                if(inv.Sales_District__c == pd.district_code__c && inv.distribution_Channel__c==pd.distribution_Channel__c && inv.Brand_Short_Form__c == pd.Product__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                {
                    System.debug('---Enter1---');
                    inv.NSR_PD_Value__c = pd.PD_Value__c;
                }
                    
            }
            
            for(NSR_Other_Values__c pd : nsrothrvalues)
            {
                if(inv.Sales_District__c == pd.district_code__c && inv.Brand_Short_Form__c == pd.Product__c && inv.distribution_Channel__c==pd.distribution_Channel__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                {
                    System.debug('---Enter2---');
                    inv.NSR_Other_Value__c = pd.Other_Value__c;
                }
                    
            }
            
            for(NSR_PRFT_Values__c pd : nsrprftvalues)
            {
                if(inv.Plant_Short_Form__c == pd.MFG_Plant__c && inv.Brand_Short_Form__c == pd.Product__c && inv.Plant__c == pd.Plant__c && inv.SLOC__c == pd.Storage_Location__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                {
                    System.debug('---Enter3---');
                    inv.NSR_PRFT_Value__c = pd.PRFT_Value__c;
                }
                    
            }
            
            for(NSR_C_F_Value_Changes__c pd : nsrcfvalues)
            {
                if(inv.Plant__c == pd.Plant__c && inv.Brand_Short_Form__c == pd.Product__c && inv.SLOC__c == pd.Storage_Location__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                {
                    System.debug('---Enter4---');
                    inv.NSR_C_F_Value__c = pd.Value__c;
                }
                    
            }
            
            for(Adhoc_Incentive__c pd : adhocvalues)
            {
                if(inv.Sales_District__c == pd.district_code__c && inv.Brand_Short_Form__c == pd.Product__c && inv.distribution_Channel__c == pd.Distribution_Channel__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                {
                    System.debug('---Enter5---');
                    inv.Adhoc_Incentive_Value__c = pd.Value__c;
                }
                    
            }
            
            for(Customer_Incentive__c pd : custvalues)
            {
                if(inv.Sold_To_Code__c == pd.Customer_Code__c && inv.Brand_Short_Form__c == pd.Product__c && inv.distribution_Channel__c == pd.Distribution_Channel__c && inv.Commercial_Invoice_Date_Formula__c >= pd.From_Date__c && inv.Commercial_Invoice_Date_Formula__c <= pd.To_Date__c)
                {
                    System.debug('---Enter6---');
                    inv.Customer_Incentive_Value__c = pd.Value__c;
                }
                    
            }
            
            for(Invoice_Discounts__c pd : invdiscs)
            {
                if(inv.Commercial_Invoice_Number__c== pd.Commercial_Invoice_Number__c)
                {
                    System.debug('---Enter7---');
                    inv.Invoice_Discount_Value__c = pd.Invoice_Discount_Value__c;
                }
                    
            }
            inv.Invoice_NSR_Processed__c = True;
            invlist.add(inv);
        }
        Update invlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}