global class PIBVolNSR implements Database.Batchable<sObject> {

    public String qrystr;
    public Date myDate;
    public PIBVolNSR(String str)
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
        List<Invoice__c> invupdate = new List<Invoice__c>();
        List<PIB_Volume_NSR_Actuals__c> volnsrlist = new List<PIB_Volume_NSR_Actuals__c>();
        Map<String,Decimal> volMap = new Map<String,Decimal>();
        Map<String,Decimal> nsrMap = new Map<String,Decimal>();
        Map<String,String> pibMap = new Map<String,String>();
        Set<String> uniqcomb = new Set<String>();
        Set<String> uniqcomb1 = new Set<String>();
        for(Invoice__c inv : scope)
        {
            if(!volMap.containsKey(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c))
            {
                uniqcomb.add(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c);
                uniqcomb1.add(inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c);
                volMap.put(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c,inv.qty__c);
            }
            else
            {
                volMap.put(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c,volMap.get(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c)+inv.qty__c);
            }
            
            if(!nsrMap.containsKey(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c))
            {
                uniqcomb.add(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c);
                uniqcomb1.add(inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c);
                nsrMap.put(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c,inv.NSR_T_Value__c);
            }
            else
            {
                nsrMap.put(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c,nsrMap.get(inv.Employee_ID__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Sales_Office_Code__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c+':'+inv.Brand_Short_Form__c+':'+inv.Cust_Grp1_from_Master__c+':'+inv.Account__c)+inv.NSR_T_Value__c);
            }
        }
        
        List<PIB_SO_Targets__c> piblist = [Select id,Unique_ID__c from PIB_SO_Targets__c where Unique_ID__c IN: uniqcomb];
        for(PIB_SO_Targets__c pib : piblist)
        {
            pibMap.put(pib.Unique_ID__c,pib.id);
        }  
        
        for(String st : uniqcomb)
        {
            for(String st1 : uniqcomb1)
            {
                PIB_Volume_NSR_Actuals__c vn = new PIB_Volume_NSR_Actuals__c();
                vn.PIB_SO_Targets__c = pibMap.get(st);
                if(volMap.containsKey(st+':'+st1))
                    vn.QTY__c = volMap.get(st+':'+st1)==null ? 0 :volMap.get(st+':'+st1);
                if(nsrMap.containsKey(st+':'+st1))
                    vn.NSR_Value__c = nsrMap.get(st+':'+st1)==null ? 0 : nsrMap.get(st+':'+st1);
                vn.Territory_Code__c = st1.split(':')[0];
                vn.Date__c = Date.valueOF(st1.split(':')[1]);
                vn.Distribution_Channel__c = st1.split(':')[2];
                vn.Product_Group__c = st1.split(':')[3];
                vn.Cust_Grup_1__c = st1.split(':')[4];
                vn.Customer__c = st1.split(':')[5];
                if(vn.PIB_SO_Targets__c !=null)
                if(!(vn.QTY__c == null && vn.NSR_Value__c == null))
                volnsrlist.add(vn);
            }
        }
        insert volnsrlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
        
    }
}