global class StateNSRActuals implements Database.Batchable<sObject> 
{
    public String qrystr;
    public StateNSRActuals(String str)
    {
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
        List<Invoice__c> nsrupdate = new List<Invoice__c>();
        List<State_NSR_Actuals__c> nsrlist = new List<State_NSR_Actuals__c>();
        Set<String> uniqcomb = new Set<String>();
        Set<String> uniqcomb1 = new Set<String>();
        Map<String,String> MRMMap = new Map<String,String>();
        Map<String,Double> TradeMap = new Map<String,Double>();
        Map<String,Double> NTradeMap = new Map<String,Double>();
        Map<String,Double> QtyMap = new Map<String,Double>();
        Map<String,Double> TBPMap = new Map<String,Double>();
        Map<String,Double> DiscValMap = new Map<String,Double>();
        Map<String,Double> PDSPLAALMap = new Map<String,Double>();
        Map<String,Double> OtherMap = new Map<String,Double>();
        Map<String,Double> MMCMap = new Map<String,Double>();
        Map<String,Double> CFMap = new Map<String,Double>();
        Map<String,Double> PFRTMap = new Map<String,Double>();
        Map<String,Double> PackCostMap = new Map<String,Double>();
        Map<String,Double> NSRValMap = new Map<String,Double>();
        
        
        for(Invoice__c nsr : scope)
        {
            if(nsr.Distribution_Channel__c == '10' || nsr.Distribution_Channel__c == '20' || nsr.Distribution_Channel__c == '50')
            {
                if(nsr.Brand_Short_Form__c=='PSC' || nsr.Brand_Short_Form__c=='CHD' || nsr.Brand_Short_Form__c=='GGBS' || nsr.Brand_Short_Form__c=='OPC')
                if(((nsr.Brand_Short_Form__c=='PSC' || nsr.Brand_Short_Form__c=='OPC' || nsr.Brand_Short_Form__c=='CHD') && nsr.Cust_Grp1_from_Master__c=='N01-Institutions') || nsr.Brand_Short_Form__c=='GGBS')
                {                    
                    System.debug('---NSR Null'+nsr.NSR_T_Value__c);
                    if(nsr.Qty__c!=null)
                    if(!QtyMap.containsKey(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
                    {
                        nsr.StateNSR_Targets_Proccessed__c = true;
                        uniqcomb.add(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
                        uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
                        QtyMap.put(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.Qty__c);
                    }
                    else
                    {
                        nsr.StateNSR_Targets_Proccessed__c = true;
                        QtyMap.put(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,QtyMap.get(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.Qty__c);
                    }
                    System.debug('---NSRValMap---'+NSRValMap);
                    if(nsr.NSR_T_Value__c!=null)
                    if(!NSRValMap.containsKey(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
                    {
                        nsr.StateNSR_Targets_Proccessed__c = true;
                        uniqcomb.add(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
                        uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
                        NSRValMap.put(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.NSR_T_Value__c);
                    }
                    else
                    {
                        nsr.StateNSR_Targets_Proccessed__c = true;
                        NSRValMap.put(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,NSRValMap.get(nsr.State_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.NSR_T_Value__c);
                    }
                }
                nsrupdate.add(nsr);
            }
        }
        System.debug('---uniqcomb---'+uniqcomb);
        List<State_MRM_Targets__c > mrmtgt = [Select id,Unique_Code__c from State_MRM_Targets__c  where Unique_Code__c IN: uniqcomb];
        for(State_MRM_Targets__c  mrm : mrmtgt)
        {
            MRMMap.put(mrm.Unique_Code__c,mrm.id);
        }        
        System.debug('---MRMMap---'+MRMMap);
        System.debug('---DiscValMap---'+DiscValMap);
        /*for(State_MRM_Targets__c  mrm : mrmtgt)
        {
            NSR_New_Actual__c da = new NSR_New_Actual__c();
            da.State_MRM_Targets__c  = mrm.Id;
            if(QtyMap.containsKey(mrm.Unique_Code__c))
                da.NSR_Qty_Actuals__c = QtyMap.get(mrm.Unique_Code__c)==null ? 0 :QtyMap.get(mrm.Unique_Code__c);
            if(TBPMap.containsKey(mrm.Unique_Code__c))
                da.NSR_Total_Basic_Price_Actuals__c = TBPMap.get(mrm.Unique_Code__c)==null ? 0 : TBPMap.get(mrm.Unique_Code__c);
            if(DiscValMap.containsKey(mrm.Unique_Code__c))
                da.NSR_Disc_value_Actuals__c = DiscValMap.get(mrm.Unique_Code__c)==null ? 0 : DiscValMap.get(mrm.Unique_Code__c);
            if(PDSPLAALMap.containsKey(mrm.Unique_Code__c))
                da.NSR_PD_SPL_ADDL_Actual__c = PDSPLAALMap.get(mrm.Unique_Code__c)==null ? 0 : PDSPLAALMap.get(mrm.Unique_Code__c);
            if(OtherMap.containsKey(mrm.Unique_Code__c))
                da.NSR_Other_Actuals__c = OtherMap.get(mrm.Unique_Code__c)==null ? 0 : OtherMap.get(mrm.Unique_Code__c);
            if(MMCMap.containsKey(mrm.Unique_Code__c))
                da.NSR_MMC_Actuals__c = MMCMap.get(mrm.Unique_Code__c)==null ? 0 : MMCMap.get(mrm.Unique_Code__c);
            if(CFMap.containsKey(mrm.Unique_Code__c))
                da.NSR_C_F_Actuals__c = CFMap.get(mrm.Unique_Code__c)==null ? 0 : CFMap.get(mrm.Unique_Code__c);
            if(PFRTMap.containsKey(mrm.Unique_Code__c))
                da.NSR_PRFT_Dump_Value_Actual__c = PFRTMap.get(mrm.Unique_Code__c)==null ? 0 : PFRTMap.get(mrm.Unique_Code__c);
            if(PackCostMap.containsKey(mrm.Unique_Code__c))
                da.NSR_Packing_Cost_Actual__c = PackCostMap.get(mrm.Unique_Code__c)==null ? 0 : PackCostMap.get(mrm.Unique_Code__c);
            if(NSRValMap.containsKey(mrm.Unique_Code__c))
                da.NSR_Value_Actual__c = NSRValMap.get(mrm.Unique_Code__c)==null ? 0 : NSRValMap.get(mrm.Unique_Code__c);
            nsrlist.add(da);
        }*/
        for(String st : uniqcomb)
        {
            for(String st1 : uniqcomb1)
            {
                State_NSR_Actuals__c da = new State_NSR_Actuals__c();
                da.State_MRM_Targets__c  = MRMMap.get(st);
                if(QtyMap.containsKey(st+':'+st1))
                    da.NSR_Qty_Actuals__c = QtyMap.get(st+':'+st1)==null ? 0 :QtyMap.get(st+':'+st1);    
                if(NSRValMap.containsKey(st+':'+st1))
                    da.NSR_Value_Actuals__c = NSRValMap.get(st+':'+st1)==null ? 0 : NSRValMap.get(st+':'+st1);
                da.Commercial_Invoice_Date__c = Date.valueOF(st1.split(':')[0]);
                da.Distribution_Channel__c = st1.split(':')[1];
                if(da.State_MRM_Targets__c !=null)
                if(!(da.NSR_Qty_Actuals__c ==null && da.NSR_Value_Actuals__c ==null))
                nsrlist.add(da);
            }
        }
        update nsrupdate;
        insert nsrlist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
    }
}