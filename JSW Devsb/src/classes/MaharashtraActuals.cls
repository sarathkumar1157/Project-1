global class MaharashtraActuals implements Database.Batchable<sObject> 
{
    public String qrystr;
    public MaharashtraActuals(String str)
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
        List<Maharashtra_Actuals__c> dalist = new List<Maharashtra_Actuals__c>();
        Set<String> uniqcomb = new Set<String>();
        Set<String> uniqcomb1 = new Set<String>();
        Map<String,String> MRMMap = new Map<String,String>();
        Map<String,Double> TradeMap = new Map<String,Double>();
        Map<String,Double> NTradeMap = new Map<String,Double>();
        Map<String,Double> RailMap = new Map<String,Double>();
        Map<String,Double> RoadMap = new Map<String,Double>();
        Map<String,Double> DepotMap = new Map<String,Double>();
        Map<String,Double> DirectMap = new Map<String,Double>();
        Map<String,Double> NSRMap = new Map<String,Double>();
        Map<String,Double> TVMap = new Map<String,Double>();
        Map<String,Double> NSRPDMap = new Map<String,Double>();
        Map<String,Double> NSROtherMap = new Map<String,Double>();
        Map<String,Double> NSRPRFTMap = new Map<String,Double>();
        Map<String,Double> NSRCFMap = new Map<String,Double>();
        Map<String,Double> PackCostMap = new Map<String,Double>();
        Map<String,Double> FreightMap = new Map<String,Double>();
        Map<String,Double> TTMap = new Map<String,Double>();
        Map<String,Double> RakeMap = new Map<String,Double>();
        Map<String,Double> AdhocMap = new Map<String,Double>();
        Map<String,Double> MMCMap = new Map<String,Double>();
        
        for(Invoice__c inv : scope)
        {
            if(inv.Distribution_Channel__c == '10')
            if(!TradeMap.containsKey(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                TradeMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Qty__c);
            }
            else
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                TradeMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,TradeMap.get(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Qty__c);
            }
            
            if(inv.Distribution_Channel__c == '20' || inv.Distribution_Channel__c == '50')
            if(!NTradeMap.containsKey(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NTradeMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Qty__c);
            }
            else
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NTradeMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,NTradeMap.get(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Qty__c);
            }
            
            if(!inv.Road_Invoice__c)
            if(!RailMap.containsKey(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                RailMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Qty__c);
            }
            else
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                RailMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,RailMap.get(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Qty__c);
            }
            
            if(inv.Road_Invoice__c)
            if(!RoadMap.containsKey(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                RoadMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Qty__c);
            }
            else
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                RoadMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,RoadMap.get(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Qty__c);
            }
            
            if(inv.Depot_Invoice__c)
            if(!DepotMap.containsKey(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                DepotMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Qty__c);
            }
            else
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                DepotMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,DepotMap.get(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Qty__c);
            }
            
            if(!inv.Depot_Invoice__c)
            if(!DirectMap.containsKey(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                DirectMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Qty__c);
            }
            else
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                DirectMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,DirectMap.get(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Qty__c);
            }
            if(inv.NSR_T_Value__c!=null)
            if(!NSRMap.containsKey(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NSRMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.NSR_T_Value__c);
            }
            else
            {
                inv.MH_Actuals_Processed__c = true;
                uniqcomb.add(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NSRMap.put(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,NSRMap.get(inv.Ship_To_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.NSR_T_Value__c);
            }
            if(inv.Total_value__c != null)
            if(!TVMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                TVMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Total_value__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                TVMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,TVMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Total_value__c);
            }
            
            if(inv.NSR_PD__c!= null)
            if(!NSRPDMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NSRPDMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.NSR_PD__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                NSRPDMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,NSRPDMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.NSR_PD__c);
            }
            
            if(inv.NSR_Other_Discount__c != null)
            if(!NSROtherMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NSROtherMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.NSR_Other_Discount__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                NSROtherMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,NSROtherMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.NSR_Other_Discount__c);
            }
            
            if(inv.NSR_PRFT_Dump_Discout__c != null)
            if(!NSRPRFTMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NSRPRFTMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.NSR_PRFT_Dump_Discout__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                NSRPRFTMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,NSRPRFTMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.NSR_PRFT_Dump_Discout__c);
            }
            
            if(inv.NSR_C_F_Discount__c != null)
            if(!NSRCFMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                NSRCFMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.NSR_C_F_Discount__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                NSRCFMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,NSRCFMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.NSR_C_F_Discount__c);
            }
            
            if(inv.Packing_Cost__c!=null)
            if(!PackCostMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                PackCostMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Packing_Cost__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                PackCostMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,PackCostMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Packing_Cost__c);
            }
            
            if(inv.Freight__c!=null)
            if(!FreightMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                FreightMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Freight__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                FreightMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,FreightMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Freight__c);
            }
            
            if(inv.Total_Tax__c!=null)
            if(!TTMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                TTMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Total_Tax__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                TTMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,TTMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Total_Tax__c);
            }
            
            if(inv.NSR_Rake_Discount__c!=null)
            if(!RakeMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                RakeMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.NSR_Rake_Discount__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                RakeMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,RakeMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.NSR_Rake_Discount__c);
            }
            
            if(inv.Total_Adhoc_Discount__c!=null)
            if(!AdhocMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                AdhocMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.Total_Adhoc_Discount__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                AdhocMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,AdhocMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.Total_Adhoc_Discount__c);
            }
            
            if(inv.MMC__c!=null)
            if(!MMCMap.containsKey(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c))
            {
                inv.NSR_Targets_Processed__c = true;
                uniqcomb.add(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c);
                uniqcomb1.add(String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c);
                MMCMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,inv.MMC__c);
            }
            else
            {
                inv.NSR_Targets_Processed__c = true;
                MMCMap.put(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c,MMCMap.get(inv.Sales_Office_Code__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Year__c+':'+inv.Plant_Short_Form__c+':'+String.valueOf(inv.Commercial_Invoice_Date_Formula__c).right(10)+':'+inv.Distribution_Channel__c)+inv.MMC__c);
            }  
            invupdate.add(inv);
        }
        
        System.debug('---uniqcomb---'+uniqcomb);
        System.debug('---uniqcomb1---'+uniqcomb1);
        System.debug('---TradeMap---'+TradeMap);
        List<MRM_Targets__c> mrmtgt = [Select id,MH_Unique_Code__c from MRM_Targets__c where MH_Unique_Code__c IN: uniqcomb];
        for(MRM_Targets__c mrm : mrmtgt)
        {
            MRMMap.put(mrm.MH_Unique_Code__c,mrm.id);
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
            for(String st1 : uniqcomb1)
            {
                Maharashtra_Actuals__c da = new Maharashtra_Actuals__c();
                da.MRM_Target__c = MRMMap.get(st);
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
                if(NSRMap.containsKey(st+':'+String.valueOf(st1)))
                    da.NSR_Value_Actuals__c = NSRMap.get(st+':'+st1)==null ? 0 : NSRMap.get(st+':'+st1);
                if(TVMap.containsKey(st+':'+st1))
                    da.Total_Value__c = TVMap.get(st+':'+st1)==null ? 0 :TVMap.get(st+':'+st1);
                if(NSRPDMap.containsKey(st+':'+st1))
                    da.PD_Values__c = NSRPDMap.get(st+':'+st1)==null ? 0 : NSRPDMap.get(st+':'+st1);
                if(NSROtherMap.containsKey(st+':'+st1))
                    da.Other_Discount__c = NSROtherMap.get(st+':'+st1)==null ? 0 : NSROtherMap.get(st+':'+st1);
                if(NSRPRFTMap.containsKey(st+':'+st1))
                    da.PRFT_Dump_Discount__c = NSRPRFTMap.get(st+':'+st1)==null ? 0 : NSRPRFTMap.get(st+':'+st1);
                if(NSRCFMap.containsKey(st+':'+st1))
                    da.CF_Discount__c = NSRCFMap.get(st+':'+st1)==null ? 0 : NSRCFMap.get(st+':'+st1);
                if(PackCostMap.containsKey(st+':'+st1))
                    da.Packing_Cost__c = PackCostMap.get(st+':'+st1)==null ? 0 : PackCostMap.get(st+':'+st1);
                if(FreightMap.containsKey(st+':'+st1))
                    da.Frieght__c = FreightMap.get(st+':'+st1)==null ? 0 : FreightMap.get(st+':'+st1);
                if(TTMap.containsKey(st+':'+st1))
                    da.Total_Tax__c = TTMap.get(st+':'+st1)==null ? 0 : TTMap.get(st+':'+st1);
                if(RakeMap.containsKey(st+':'+st1))
                    da.Rake_Discount__c = RakeMap.get(st+':'+st1)==null ? 0 : RakeMap.get(st+':'+st1);
                if(AdhocMap.containsKey(st+':'+st1))
                    da.Adhoc_Incentive_Value__c = AdhocMap.get(st+':'+st1)==null ? 0 : AdhocMap.get(st+':'+st1);
                if(MMCMap.containsKey(st+':'+st1))
                    da.MMC__c = MMCMap.get(st+':'+st1)==null ? 0 : MMCMap.get(st+':'+st1);
                da.Commercial_Invoice_Date__c = Date.valueOF(st1.split(':')[0]);
                da.Product__c = st.split(':')[1];
                da.Distribution_Channel__c = st1.split(':')[1];
                if(da.MRM_Target__c !=null)
                if(!(da.Trade_Actuals__c ==null &&  da.Non_Trade_Actuals__c ==null && da.Rail_Actuals__c ==null && da.Road_Actuals__c ==null && da.Depot_Actuals__c ==null && da.Direct_Actuals__c==null && da.NSR_Value_Actuals__c ==null))
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