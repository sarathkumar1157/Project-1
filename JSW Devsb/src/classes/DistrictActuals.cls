global class DistrictActuals implements Database.Batchable<sObject> 
{
    public String qrystr;
    public DistrictActuals(String str)
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
        List<Invoice__c > invupdate = new List<Invoice__c >();
        List<District_Actuals__c > dalist = new List<District_Actuals__c >();
        List<District_Actuals__c > templist = new List<District_Actuals__c >();
        Set<String> uniqcomb = new Set<String>();
        Set<String> uniqcomb1 = new Set<String>();
        Map<String,String> MRMMap = new Map<String,String>();
        Map<String,Double> TradeMap = new Map<String,Double>();
        Map<String,Double> NTradeMap = new Map<String,Double>();
        Map<String,Double> RailMap = new Map<String,Double>();
        Map<String,Double> RoadMap = new Map<String,Double>();
        Map<String,Double> DepotMap = new Map<String,Double>();
        Map<String,Double> DirectMap = new Map<String,Double>();
        Map<MRM_Targets__c,List<District_Actuals__c>> MasterMap = new Map<MRM_Targets__c,List<District_Actuals__c>>();
        
        for(Invoice__c inv : scope)
        {
            if(inv.Distribution_Channel__c == '10')
            if(!TradeMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId))
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                TradeMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,inv.Qty__c);
            }
            else
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                TradeMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,TradeMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId)+inv.Qty__c);
            }
            
            if(inv.Distribution_Channel__c == '20' || inv.Distribution_Channel__c == '50')
            if(!NTradeMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId))
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                NTradeMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,inv.Qty__c);
            }
            else
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                NTradeMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,NTradeMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId)+inv.Qty__c);
            }
            
            if(!inv.Road_Invoice__c)
            if(!RailMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId))
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                RailMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,inv.Qty__c);
            }
            else
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                RailMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,RailMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId)+inv.Qty__c);
            }
            
            if(inv.Road_Invoice__c)
            if(!RoadMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId))
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                RoadMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,inv.Qty__c);
            }
            else
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                RoadMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,RoadMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId)+inv.Qty__c);
            }
            
            if(inv.Depot_Invoice__c)
            if(!DepotMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId))
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                DepotMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,inv.Qty__c);
            }
            else
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                DepotMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,DepotMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId)+inv.Qty__c);
            }
            
            if(!inv.Depot_Invoice__c)
            if(!DirectMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId))
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                DirectMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,inv.Qty__c);
            }
            else
            {
                inv.District_Actuals_Process__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId);
                DirectMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId,DirectMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.OwnerId)+inv.Qty__c);
            }
            invupdate.add(inv);
        }
        
        System.debug('---uniqcomb---'+uniqcomb);
        System.debug('---uniqcomb1---'+uniqcomb1);
        System.debug('---TradeMap---'+TradeMap);
        List<MRM_Targets__c> mrmtgt = [Select id,Unique_Code__c from MRM_Targets__c where Unique_Code__c IN: uniqcomb];
        Set<MRM_Targets__c> mrmset = new Set<MRM_Targets__c>();
        List<MRM_Targets__c> mrmlist = new List<MRM_Targets__c>();
        for(MRM_Targets__c mrm : mrmtgt)
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
        for(String st : uniqcomb)
        {
            if(!MRMMap.containsKey(st))
            {
                MRM_Targets__c mrm = new MRM_Targets__c();
                mrm.Sales_Office__c = st.split(':')[0];
                mrm.Product__c = st.split(':')[1];
                mrm.Month__c = st.split(':')[2];
                mrm.Year__c = st.split(':')[3];
                mrm.Plant__c = st.split(':')[4];
                mrmset.add(mrm);
            }
        }      
        mrmlist.addAll(mrmset);
        insert mrmlist;
        for(MRM_Targets__c mrm : mrmlist)
        {
            MRMMap.put(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c,mrm.id);
        }
        for(String st : uniqcomb)
        {
            for(String st1 : uniqcomb1)
            {
                District_Actuals__c da = new District_Actuals__c();
                da.District_Actuals__c = MRMMap.get(st);
                if(TradeMap.containsKey(st+':'+st1))
                    da.Trade_Actuals__c = TradeMap.get(st+':'+st1)==null ? 0 :TradeMap.get(st+':'+st1);
                if(NTradeMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Non_Trade_Actuals__c = NTradeMap.get(st+':'+st1)==null ? 0 : NTradeMap.get(st+':'+st1);
                if(RailMap.containsKey(st+':'+String.valueOf(st1)))
                    da.District_Rail_Actuals__c = RailMap.get(st+':'+st1)==null ? 0 : RailMap.get(st+':'+st1);
                if(RoadMap.containsKey(st+':'+String.valueOf(st1)))
                    da.District_Road_Actuals__c = RoadMap.get(st+':'+st1)==null ? 0 : RoadMap.get(st+':'+st1);
                if(DepotMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Depot_Actuals__c = DepotMap.get(st+':'+st1)==null ? 0 : DepotMap.get(st+':'+st1);
                if(DirectMap.containsKey(st+':'+String.valueOf(st1)))
                    da.Direct_Actuals__c = DirectMap.get(st+':'+st1)==null ? 0 : DirectMap.get(st+':'+st1);
                da.Commercial_Invoice_Date__c = Date.valueOF(st1.split(':')[0]);
                //da.User__c = st1.split(':')[1];
                da.Product__c = st.split(':')[1];
                if(da.District_Actuals__c !=null)
                //if(!(da.Trade_Actuals__c==null &&  da.Non_Trade_Actuals__c ==null && da.District_Rail_Actuals__c ==null && da.District_Road_Actuals__c ==null && da.Depot_Actuals__c ==null && da.Direct_Actuals__c ==null))
                    dalist.add(da);
                /*else
                {
                    MRM_Targets__c mrm = new MRM_Targets__c();
                    mrm.District_Code__c = st.split(':')[0];
                    mrm.Product__c = st.split(':')[1];
                    mrm.Month__c = st.split(':')[2];
                    mrm.Year__c = st.split(':')[3];
                    mrm.Plant__c = st.split(':')[4];
                    mrmset.add(mrm);
                    if(MasterMap.containsKey(mrm)){
                        templist.add(da);
                        MasterMap.put(mrm,templist);
                    } else {
                        templist = new List<District_Actuals__c>();
                        templist.add(da);
                        MasterMap.put(mrm,templist);
                    }
                }*/
            }
        }
        /*System.debug(MasterMap+'@11111111111111@@');
        mrmlist.addAll(mrmset);
        insert mrmlist;
        
        System.debug(MasterMap+'@@@');
        
        for(MRM_Targets__c mrm : mrmlist){
            System.debug('@@@@'+mrm);
            for(District_Actuals__c da : MasterMap.get(mrm)){
                da.District_Actuals__c = mrm.id;
                dalist.add(da);
            }
        }
        */
        update invupdate;
        insert dalist;
    }
    
    global void finish(Database.BatchableContext BC) 
    {
    }
}