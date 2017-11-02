global class TargetsUpdate implements Database.Batchable<sObject> 
{
    public String qrystr;
    public Date myDate;
    public TargetsUpdate(String str)
    {
        myDate = System.today()-1;
        //qrystr = str+String.valueOf(myDate).substring(0,10);
        qrystr = str;
        System.debug('----->'+qrystr);
    }
    
    global Database.QueryLocator start(Database.BatchableContext BC) 
    {
        String query = qrystr;
        System.debug('----->'+query);
        return Database.getQueryLocator(qrystr);
    }
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) 
    {
        Map<String,Double> invmap1 = new Map<String,Double>();
        Map<String,Double> invmap2 = new Map<String,Double>();
        Map<String,Double> invmap3 = new Map<String,Double>();
        List<Actuals__c> insertactls = new List<Actuals__c>();
        List<Invoice__c> invupdate = new List<Invoice__c>();
        for(Invoice__c inv : scope)
        {
            system.debug('--->inside');
            if(inv.Distribution_Channel__c=='10' || inv.Distribution_Channel__c=='20')
            {
                if(!invmap1.containsKey(inv.Year__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Distribution_Channel__c+':'+inv.Sold_To_Code__c+':'+(inv.Sales_Promoter__c==null?'':inv.Sales_Promoter__c)+':'+inv.Brand_Short_Form__c))
                {
                    inv.TGT_Process__c = true;
                    invmap1.put(inv.Year__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Distribution_Channel__c+':'+inv.Sold_To_Code__c+':'+(inv.Sales_Promoter__c==null?'':inv.Sales_Promoter__c)+':'+inv.Brand_Short_Form__c,inv.Qty__c);
                }
                else
                {
                    inv.TGT_Process__c = true;
                    invmap1.put(inv.Year__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Distribution_Channel__c+':'+inv.Sold_To_Code__c+':'+(inv.Sales_Promoter__c==null?'':inv.Sales_Promoter__c)+':'+inv.Brand_Short_Form__c,invmap1.get(inv.Year__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Distribution_Channel__c+':'+inv.Sold_To_Code__c+':'+(inv.Sales_Promoter__c==null?'':inv.Sales_Promoter__c)+':'+inv.Brand_Short_Form__c)+inv.Qty__c);
                }
            }
            
            /*if(inv.Distribution_Channel__c==20)(inv.Cust_Grp1_from_Master__c==null?'':inv.Cust_Grp1_from_Master__c)+':'
            {
                if(!invmap2.containsKey(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Sales_Promoter__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c))
                    invmap2.put(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Sales_Promoter__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c,inv.Qty__c);
                else
                    invmap2.put(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Sales_Promoter__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c,invmap2.get(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Sales_Promoter__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c)+inv.Qty__c);
            }*/
            
            invupdate.add(inv);
            system.debug('--->'+invmap1);
            system.debug('--->>>'+invupdate);
        }
        
        List<Actuals__c> actls = [Select Id,Actuals__c,Unique_ID__c,Customer_Code__c,Customer_Name__c,Distribution_Channel__c,District__c,Division__c,Employee_ID__c,Month__c,Product_Group__c,State__c,Target_Start_Date__c,Territory__c,Type__c,Year__c from Actuals__c where Unique_ID__c IN: invmap1.keySet()];
        
        for(Actuals__c act : actls)
        {
            if(invmap1.containsKey(act.Unique_ID__c))
            {
                act.Actuals__c = act.Actuals__c==null ? invmap1.get(act.Unique_ID__c) : act.Actuals__c + invmap1.get(act.Unique_ID__c);
                invmap1.remove(act.Unique_ID__c);
            }
        }
        
        for(String str : invmap1.keySet())
        {
            Actuals__c actl = new Actuals__c();
            actl.Year__c = str.split(':')[0];
            actl.Month__c = str.split(':')[1];
            actl.Distribution_Channel__c= str.split(':')[2];
            actl.Customer_Code__c = str.split(':')[3];
            actl.Sales_Promoter__c= str.split(':')[4];
            actl.Product_Group__c = str.split(':')[5];
            actl.Actuals__c = invmap1.get(str);
            insertactls.add(actl);
        }
        Insert insertactls;
        Update actls;
        update invupdate;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
    }
}