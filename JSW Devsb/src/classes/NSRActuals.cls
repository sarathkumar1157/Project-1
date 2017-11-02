global class NSRActuals implements Database.Batchable<sObject> 
{
    public String qrystr;
    public NSRActuals(String str)
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
        List<NSR_New_Actual__c> nsrlist = new List<NSR_New_Actual__c>();
        Set<String> uniqcomb = new Set<String>();
        Set<String> uniqcomb1 = new Set<String>();
        Map<String,String> MRMMap = new Map<String,String>();
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
        Map<String,Double> QtyMap = new Map<String,Double>();
        Map<String,Double> NSRValMap = new Map<String,Double>();
        
        
        for(Invoice__c nsr : scope)
		{
			if(nsr.Distribution_Channel__c == '10' || nsr.Distribution_Channel__c == '20' || nsr.Distribution_Channel__c == '50')
			{
				if(nsr.Total_value__c != null)
				if(!TVMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					TVMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.Total_value__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					TVMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,TVMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.Total_value__c);
				}
				
				if(nsr.NSR_PD_Value__c != null)
				if(!NSRPDMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					NSRPDMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.NSR_PD_Value__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					NSRPDMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,NSRPDMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.NSR_PD_Value__c);
				}
				
				if(nsr.NSR_Other_Discount__c != null)
				if(!NSROtherMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					NSROtherMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.NSR_Other_Discount__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					NSROtherMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,NSROtherMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.NSR_Other_Discount__c);
				}
				
				if(nsr.NSR_PRFT_Dump_Discout__c != null)
				if(!NSRPRFTMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					NSRPRFTMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.NSR_PRFT_Dump_Discout__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					NSRPRFTMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,NSRPRFTMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.NSR_PRFT_Dump_Discout__c);
				}
				
				if(nsr.NSR_C_F_Discount__c != null)
				if(!NSRCFMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					NSRCFMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.NSR_C_F_Discount__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					NSRCFMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,NSRCFMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.NSR_C_F_Discount__c);
				}
				
				if(nsr.Packing_Cost__c!=null)
				if(!PackCostMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					PackCostMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.Packing_Cost__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					PackCostMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,PackCostMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.Packing_Cost__c);
				}
				
				if(nsr.Freight__c!=null)
				if(!FreightMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					FreightMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.Freight__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					FreightMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,FreightMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.Freight__c);
				}
				
				if(nsr.Total_Tax__c!=null)
				if(!TTMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					TTMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.Total_Tax__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					TTMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,TTMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.Total_Tax__c);
				}
				
				if(nsr.NSR_Rake_Discount__c!=null)
				if(!RakeMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					RakeMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.NSR_Rake_Discount__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					RakeMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,RakeMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.NSR_Rake_Discount__c);
				}
				
				if(nsr.Adhoc_Incentive_Value__c!=null)
				if(!AdhocMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					AdhocMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.Adhoc_Incentive_Value__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					AdhocMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,AdhocMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.Adhoc_Incentive_Value__c);
				}
				
				if(nsr.MMC__c!=null)
				if(!MMCMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					MMCMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.MMC__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					MMCMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,MMCMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.MMC__c);
				}     
				
				if(nsr.Qty__c!=null)
				if(!QtyMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					QtyMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.Qty__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					QtyMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,QtyMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.Qty__c);
				}
				
				if(nsr.NSR_T_Value__c!=null)
				if(!NSRValMap.containsKey(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c))
				{
					nsr.NSR_Targets_Processed__c = true;
					uniqcomb.add(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c);
					uniqcomb1.add(String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c);
					NSRValMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,nsr.NSR_T_Value__c);
				}
				else
				{
					nsr.NSR_Targets_Processed__c = true;
					NSRValMap.put(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c,NSRValMap.get(nsr.Sales_Office_Code__c+':'+nsr.Brand_Short_Form__c+':'+nsr.Month_of_Commercial_Invoice_Date__c+':'+nsr.Year__c+':'+nsr.Plant_Short_Form__c+':'+String.valueOf(nsr.Commercial_Invoice_Date_Formula__c).right(10)+':'+nsr.Distribution_Channel__c)+nsr.NSR_T_Value__c);
				}
				nsrupdate.add(nsr);
			}
		}
        System.debug('---uniqcomb---'+uniqcomb);
        List<MRM_Targets__c> mrmtgt = [Select id,Unique_Code__c from MRM_Targets__c where Unique_Code__c IN: uniqcomb];
        for(MRM_Targets__c mrm : mrmtgt)
        {
            MRMMap.put(mrm.Unique_Code__c,mrm.id);
        }        
        System.debug('---MRMMap---'+MRMMap);
        System.debug('---NSRValMap---'+NSRValMap);
		
        for(String st : uniqcomb)
        {
            for(String st1 : uniqcomb1)
            {
                NSR_New_Actual__c da = new NSR_New_Actual__c();
                da.MRM_Targets__c = MRMMap.get(st);
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
				if(QtyMap.containsKey(st+':'+st1))
                    da.Quantity__c = QtyMap.get(st+':'+st1)==null ? 0 : QtyMap.get(st+':'+st1);
				if(NSRValMap.containsKey(st+':'+st1))
                    da.NSR_Value__c = NSRValMap.get(st+':'+st1)==null ? 0 : NSRValMap.get(st+':'+st1);
                da.Commercial_Invoice_Date__c = Date.valueOF(st1.split(':')[0]);
                da.Distribution_Channel__c = st1.split(':')[1];
                if(da.MRM_Targets__c !=null)
                if(!(da.Total_Value__c ==null &&  da.PD_Values__c ==null && da.Other_Discount__c ==null && da.PRFT_Dump_Discount__c ==null && da.CF_Discount__c ==null && da.Packing_Cost__c ==null &&  da.Frieght__c ==null && da.Total_Tax__c ==null && da.Rake_Discount__c ==null && da.Adhoc_Incentive_Value__c ==null &&  da.MMC__c ==null && da.Quantity__c ==null && da.NSR_Value__c ==null))
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