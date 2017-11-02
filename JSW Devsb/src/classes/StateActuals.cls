global class StateActuals implements Database.Batchable<sObject> 
{
    public String qrystr;
    public StateActuals(String str)
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
        List<Invoice__c> invupdate = new List<Invoice__c>();
        List<State_Actuals__c> dalist = new List<State_Actuals__c>();
        Set<String> uniqcomb = new Set<String>();
        Set<String> uniqcomb1 = new Set<String>();
        Map<String,String> MRMMap = new Map<String,String>();
        Map<String,Double> TradeMap = new Map<String,Double>();
        Map<String,Double> NTradeMap = new Map<String,Double>();
        Map<String,Double> RailMap = new Map<String,Double>();
        Map<String,Double> RoadMap = new Map<String,Double>();
        Map<String,Double> DepotMap = new Map<String,Double>();
        Map<String,Double> DirectMap = new Map<String,Double>();
        
        for(Invoice__c inv : scope)
        {
            if(inv.Brand_Short_Form__c=='PSC' || inv.Brand_Short_Form__c=='OPC' || inv.Brand_Short_Form__c=='GGBS')
            if(((inv.Brand_Short_Form__c=='PSC' || inv.Brand_Short_Form__c=='OPC') && inv.Cust_Grp1_from_Master__c=='N01-Institutions') || inv.Brand_Short_Form__c=='GGBS')
            {
            if(inv.Distribution_Channel__c == '10')
            if(!TradeMap.containsKey(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)))
            {
                inv.State_Actuals_Process__c = true;
                uniqcomb.add(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10));
                TradeMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),inv.Qty__c);
            }
            else
            {
                inv.State_Actuals_Process__c = true;
                TradeMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),TradeMap.get(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10))+inv.Qty__c);
            }
            
            if(inv.Distribution_Channel__c == '20' || inv.Distribution_Channel__c == '50')
            if(!NTradeMap.containsKey(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)))
            {
                inv.State_Actuals_Process__c = true;
                uniqcomb.add(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10));
                NTradeMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),inv.Qty__c);
            }
            else
            {
                inv.State_Actuals_Process__c = true;
                NTradeMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),NTradeMap.get(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10))+inv.Qty__c);
            }
            
            if(!inv.Road_Invoice__c)
            if(!RailMap.containsKey(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)))
            {
                inv.State_Actuals_Process__c = true;
                uniqcomb.add(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10));
                RailMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),inv.Qty__c);
            }
            else
            {
                inv.State_Actuals_Process__c = true;
                RailMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),RailMap.get(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10))+inv.Qty__c);
            }
            
            if(inv.Road_Invoice__c)
            if(!RoadMap.containsKey(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)))
            {
                inv.State_Actuals_Process__c = true;
                uniqcomb.add(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10));
                RoadMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),inv.Qty__c);
            }
            else
            {
                inv.State_Actuals_Process__c = true;
                RoadMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),RoadMap.get(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10))+inv.Qty__c);
            }
            
            if(inv.Depot_Invoice__c)
            if(!DepotMap.containsKey(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)))
            {
                inv.State_Actuals_Process__c = true;
                uniqcomb.add(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10));
                DepotMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),inv.Qty__c);
            }
            else
            {
                inv.State_Actuals_Process__c = true;
                DepotMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),DepotMap.get(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10))+inv.Qty__c);
            }
            
            if(!inv.Depot_Invoice__c)
            if(!DirectMap.containsKey(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)))
            {
                inv.State_Actuals_Process__c = true;
                uniqcomb.add(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10));
                DirectMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),inv.Qty__c);
            }
            else
            {
                inv.State_Actuals_Process__c = true;
                DirectMap.put(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10),DirectMap.get(inv.State_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10))+inv.Qty__c);
            }
            invupdate.add(inv);
            }
        }
        
        System.debug('---uniqcomb---'+uniqcomb);
        System.debug('---uniqcomb1---'+uniqcomb1);
        System.debug('---TradeMap---'+TradeMap);
        List<State_MRM_Targets__c> mrmtgt = [Select id,Unique_Code__c from State_MRM_Targets__c where Unique_Code__c IN: uniqcomb];
        for(State_MRM_Targets__c mrm : mrmtgt)
        {
            MRMMap.put(mrm.Unique_Code__c,mrm.id);
        }
        System.debug('---MRMMap---'+MRMMap);
        System.debug('---TradeMap---'+TradeMap);
        System.debug('---NTradeMap---'+NTradeMap);
        System.debug('---RailMap---'+RailMap);
        System.debug('---RoadMap---'+RoadMap); 
        System.debug('---DepotMap---'+DepotMap);
        System.debug('---DirectMap---'+DirectMap);       
        /*for(MRM_Targets__c mrm : mrmtgt)
        {
            State_Actuals__c da = new State_Actuals__c();
            da.State_MRM_Targets__c = mrm.Id;
            if(TradeMap.containsKey(mrm.Unique_Code__c))
                da.Trade_Actuals__c = TradeMap.get(mrm.Unique_Code__c)==null ? 0 :TradeMap.get(mrm.Unique_Code__c);
            if(NTradeMap.containsKey(mrm.Unique_Code__c))
                da.Non_Trade_Actuals__c = NTradeMap.get(mrm.Unique_Code__c)==null ? 0 : NTradeMap.get(mrm.Unique_Code__c);
            if(RailMap.containsKey(mrm.Unique_Code__c))
                da.Depot_Actuals__c = RailMap.get(mrm.Unique_Code__c)==null ? 0 : RailMap.get(mrm.Unique_Code__c);
            if(RoadMap.containsKey(mrm.Unique_Code__c))
                da.Direct_Actuals__c = RoadMap.get(mrm.Unique_Code__c)==null ? 0 : RoadMap.get(mrm.Unique_Code__c);
            if(DepotMap.containsKey(mrm.Unique_Code__c))
                da.District_Rail_Actuals__c = DepotMap.get(mrm.Unique_Code__c)==null ? 0 : DepotMap.get(mrm.Unique_Code__c);
            if(DirectMap.containsKey(mrm.Unique_Code__c))
                da.District_Road_Actuals__c = DirectMap.get(mrm.Unique_Code__c)==null ? 0 : DirectMap.get(mrm.Unique_Code__c);
            dalist.add(da);
        }*/
        for(String st : uniqcomb)
        {
            for(String st1 : uniqcomb1)
            {
                State_Actuals__c da = new State_Actuals__c();
                da.State_MRM_Targets__c = MRMMap.get(st);
                if(TradeMap.containsKey(st+':'+st1))
                    da.Trade_Actuals__c = TradeMap.get(st+':'+st1)==null ? 0 :TradeMap.get(st+':'+st1);
                if(NTradeMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Non_Trade_Actuals__c = NTradeMap.get(st+':'+st1)==null ? 0 : NTradeMap.get(st+':'+st1);
                if(RailMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Rail_Actuals__c = RailMap.get(st+':'+st1)==null ? 0 : RailMap.get(st+':'+st1);
                if(RoadMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Road_Actuals__c = RoadMap.get(st+':'+st1)==null ? 0 : RoadMap.get(st+':'+st1);
                if(DepotMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Depot_Actuals__c = DepotMap.get(st+':'+st1)==null ? 0 : DepotMap.get(st+':'+st1);
                if(DirectMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Direct_Actuals__c = DirectMap.get(st+':'+st1)==null ? 0 : DirectMap.get(st+':'+st1);
                da.Commercial_Invoice_Date__c = Date.valueOF(st1);
                //da.Product__c = st.split(':')[1];
                if(da.State_MRM_Targets__c !=null)
                if(!(da.Trade_Actuals__c==null && da.Non_Trade_Actuals__c ==null && da.Rail_Actuals__c ==null && da.Road_Actuals__c ==null && da.Depot_Actuals__c ==null && da.Direct_Actuals__c ==null))
                dalist.add(da);
            }
        }
        update invupdate;
        insert dalist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
    }
}