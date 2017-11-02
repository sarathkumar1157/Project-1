global class batchTargetsUpdateDelete implements Database.Batchable<sObject> {

    public String qrystr;
    public Date myDate;
    public batchTargetsUpdateDelete(String str)
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
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) {
        Map<String,Double> invmap = new Map<String,Double>();
        Map<String,String> acmap = new Map<String,String>();
        Map<String,Double> actrgtmap = new Map<String,Double>();
        Map<String,Double> nsrtrgtmap = new Map<String,Double>();
        List<Daily_Sales__c> sslist = new List<Daily_Sales__c>();
        Set<String> accode = new Set<String>();
        List<Invoice__c > invlist = new List<Invoice__c >();
        
        for(Invoice__c inv : scope)
        {
            System.debug('------>'+inv);
            accode.add(inv.Sold_To_Code__c+inv.Distribution_Channel__c+inv.Division__c);
            
            if(inv.Plant__c!='3399')
            if(inv.Distribution_Channel__c == '20' || inv.Distribution_Channel__c == '10' || inv.Distribution_Channel__c == '50')
            if(inv.Brand_Short_Form__c == 'PSC' || inv.Brand_Short_Form__c == 'CHD' || inv.Brand_Short_Form__c == 'GGBS' || inv.Brand_Short_Form__c == 'OPC')
            if(!(inv.Distribution_Channel__c == '20' && inv.Division__c== '50' && inv.Cust_Grp1_from_Master__c!= 'N01-INSTITUTIONS'))
                if(!actrgtmap.containsKey(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c))
                {
                    nsrtrgtmap.put(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.NSR_T_Value__c);
                    actrgtmap.put(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,inv.Qty__c);
                }
                else
                {
                    nsrtrgtmap.put(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,actrgtmap.get(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.NSR_T_Value__c);
                    actrgtmap.put(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c,actrgtmap.get(inv.Sold_To_Code__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Brand_Short_Form__c)+inv.Qty__c);
                }
            
            if(!invmap.containsKey((inv.Plant_Short_Form__c==null?'':inv.Plant_Short_Form__c)+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c))
                invmap.put((inv.Plant_Short_Form__c==null?'':inv.Plant_Short_Form__c)+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c,inv.Qty__c);
            else
                invmap.put((inv.Plant_Short_Form__c==null?'':inv.Plant_Short_Form__c)+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c,invmap.get((inv.Plant_Short_Form__c==null?'':inv.Plant_Short_Form__c)+':'+inv.Sales_District__c+':'+inv.Sold_To_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).substring(0,10)+':'+inv.Brand_Short_Form__c+':'+inv.Distribution_Channel__c+':'+inv.Division__c)+inv.Qty__c);
            
            System.debug('------>'+invmap);
            System.debug('------>'+actrgtmap);
        }
        
        
        List<Account> aclist = [Select id,Name,External_ID__c,OwnerId,Owner.FirstName,Owner.LastName,Sales_Office_text__c,Customer_Code__c from Account where External_ID__c IN :accode]; 
        List<Target__c> trgtlst = [Select id,Code_Target__c,Dealer_Actuals__c from Target__c where Code_Target__c IN :actrgtmap.keySet()];
        
        //map with account code and account id
        for(Account ac : aclist)
        {
            acmap.put(ac.Customer_Code__c,ac.id);
        }
        //Target records to update
        for(Target__c tgt : trgtlst)
        {
            if(actrgtmap.containsKey(tgt.Code_Target__c))
            {
                tgt.Dealer_Actuals__c = 0;
                tgt.NSR_Actuals__c = 0;
                actrgtmap.remove(tgt.Code_Target__c);
                nsrtrgtmap.remove(tgt.Code_Target__c);
            }
        }
        //Target records to insert
        /*for(String str : actrgtmap.keySet())
        {
                Target__c tgt = new Target__c();
                tgt.Customer_Code__c = str.split(':')[0];
                tgt.Distribution_Channel__c = str.split(':')[1];
                tgt.Division__c = str.split(':')[2];
                tgt.Month__c = str.split(':')[3];
                tgt.Year__c = str.split(':')[4];
                tgt.Product__c = str.split(':')[5];
                if(str.split(':')[3]=='January')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),1,1);
                //tgt.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[3]=='February')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),2,1);
                if(math.mod(Integer.valueOf(str.split(':')[4]),4) == 0)
                    tgt.No_of_Days_in_a_Month__c = 29;
                else
                    tgt.No_of_Days_in_a_Month__c = 28;
            }
            if(str.split(':')[3]=='March')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),3,1);
                //tgt.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[3]=='April')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),4,1);
                //tgt.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[3]=='May')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),5,1);
                //tgt.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[3]=='June')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),6,1);
                //tgt.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[3]=='July')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),7,1);
                //tgt.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[3]=='August')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),8,1);
                //tgt.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[3]=='September')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),9,1);
                //tgt.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[3]=='October')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),10,1);
                //tgt.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[3]=='November')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),11,1);
                //tgt.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[3]=='December')
            {
                tgt.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),12,1);
                //tgt.No_of_Days_in_a_Month__c = 31;
            }
                
                tgt.Dealer_Actuals__c = actrgtmap.get(str);
                trgtlst.add(tgt);
        }
        */
        upsert trgtlst;
            
    }   
    
    global void finish(Database.BatchableContext BC) {
    
        batchTargetsUpdate btu = new batchTargetsUpdate(qrystr);
        database.executebatch(btu);
    }
}