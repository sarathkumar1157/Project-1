global class batchDistrictUpdateDelete implements Database.Batchable<sObject> 
{
    public String qrystr;
    public Date myDate;
    public batchDistrictUpdateDelete(String str)
    {
        myDate = System.today()-1;
        //qrystr = str+String.valueOf(myDate).substring(0,10);
        qrystr = str;
        System.debug('----->'+qrystr);
    }
    global Database.QueryLocator start(Database.BatchableContext BC) {
        
        return Database.getQueryLocator(qrystr);
    }
    
    global void execute(Database.BatchableContext BC, List<Invoice__c> scope) 
    {
        Map<String,Double> dstrgtmap = new Map<String,Double>();
        Map<String,Double> dstrgtmap1 = new Map<String,Double>();
        Map<String,Double> dstrgtmap2 = new Map<String,Double>();
        Map<String,Double> dstrgtmap3 = new Map<String,Double>();
        Map<String,Double> dstrgtmap4 = new Map<String,Double>();
        List<Invoice__c > invlist = new List<Invoice__c >();
        List<District_Targets__c> dstgtlst = new List<District_Targets__c>();
        for(Invoice__c inv : scope)
        {
            if(inv.Brand_Short_Form__c == 'PSC' || inv.Brand_Short_Form__c == 'CHD')
            {
            if(inv.Distribution_Channel__c == '10' && (inv.Division__c == '50' || inv.Division__c == '53'))
                if(!dstrgtmap.containsKey(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c))
                {
                    dstrgtmap.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,inv.Qty__c);
                }
                else
                {
                    dstrgtmap.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,dstrgtmap.get(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c)+inv.Qty__c);
                }
            
            /*if((inv.Distribution_Channel__c == '20' || inv.Distribution_Channel__c == '50') && (inv.Division__c == '50' || inv.Division__c == '53') && inv.Cust_Grp1_from_Master__c == 'N01-INSTITUTIONS')
                if(!dstrgtmap1.containsKey(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c))
                    dstrgtmap1.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,inv.Qty__c);
                else
                    dstrgtmap1.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,dstrgtmap1.get(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c)+inv.Qty__c);*/
            
            if(inv.Distribution_Channel__c == '20' && (inv.Division__c == '50' || inv.Division__c == '53') && inv.Cust_Grp1_from_Master__c != 'N01-INSTITUTIONS')
                if(!dstrgtmap2.containsKey(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c))
                {
                    dstrgtmap2.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,inv.Qty__c);
                }
                else
                {
                    dstrgtmap2.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,dstrgtmap2.get(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c)+inv.Qty__c);
                }
            
            if(inv.Distribution_Channel__c == '50' && (inv.Division__c == '50' || inv.Division__c == '53') && inv.Cust_Grp1_from_Master__c != 'N01-INSTITUTIONS')
                if(!dstrgtmap4.containsKey(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c))
                {
                    dstrgtmap4.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,inv.Qty__c);
                }
                else
                {
                    dstrgtmap4.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,dstrgtmap4.get(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c)+inv.Qty__c);
                }
            /*if(inv.Division__c == '52')
                if(!dstrgtmap3.containsKey(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c))
                    dstrgtmap3.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,inv.Qty__c);
                else
                    dstrgtmap3.put(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c,dstrgtmap3.get(inv.Sales_District__c+':'+inv.Brand_Short_Form__c+':'+inv.Month_of_Commercial_Invoice_Date__c+':'+inv.Division__c+':'+inv.Year__c)+inv.Qty__c);*/
            
            //inv.District_Inv_Process__c = true;
            }
            System.debug('------>'+dstrgtmap);
        }
        
        List<District_Targets__c> dstgtlst1 = [Select id,Distribution_Channel__c,SEZ_Actuals__c,District_Code__c,GGBS_Actuals__c,District_Non_Trade_Actuals__c,District_Trade_Actuals__c,Institutional_Actuals__c,Division__c,Month__c,Product_Group__c,Targets__c,Code_DT__c,Target_Start_Date__c,No_of_Days_in_a_Month__c from District_Targets__c where Code_DT__c IN: dstrgtmap.keySet() OR Code_DT__c IN: dstrgtmap2.keySet() OR Code_DT__c IN: dstrgtmap4.keySet()];
        
        //District Targets Update
        for(District_Targets__c dt : dstgtlst1)
        {
            if(dstrgtmap.containsKey(dt.Code_DT__c))
            {
                dt.District_Trade_Actuals__c = 0;
                dstrgtmap.remove(dt.Code_DT__c);
            }
            /*if(dstrgtmap1.containsKey(dt.Code_DT__c))
            {
                dt.Institutional_Actuals__c = dt.Institutional_Actuals__c ==null ? dstrgtmap1.get(dt.Code_DT__c) : dt.Institutional_Actuals__c + dstrgtmap1.get(dt.Code_DT__c);
                dstrgtmap1.remove(dt.Code_DT__c);
            }*/
            if(dstrgtmap2.containsKey(dt.Code_DT__c))
            {
                dt.District_Non_Trade_Actuals__c = 0;
                dstrgtmap2.remove(dt.Code_DT__c);
            }
            /*if(dstrgtmap3.containsKey(dt.Code_DT__c))
            {
                dt.GGBS_Actuals__c = dt.GGBS_Actuals__c ==null ? dstrgtmap3.get(dt.Code_DT__c) : dt.GGBS_Actuals__c + dstrgtmap3.get(dt.Code_DT__c);
                dstrgtmap3.remove(dt.Code_DT__c);
            }*/
            if(dstrgtmap4.containsKey(dt.Code_DT__c))
            {
                dt.SEZ_Actuals__c = 0;
                dstrgtmap4.remove(dt.Code_DT__c);
            }
        }
        //District Targets Insert
        /*for(String str : dstrgtmap.keySet())
        {
            District_Targets__c dst = new District_Targets__c();
            dst.District_Code__c = str.split(':')[0];
            dst.Product_Group__c = str.split(':')[1];
            dst.Month__c = str.split(':')[2];
            dst.Division__c = str.split(':')[3];
            dst.Year__c = str.split(':')[4];
            if(str.split(':')[2]=='January')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),1,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='February')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),2,1);
                if(math.mod(Integer.valueOf(str.split(':')[4]),4) == 0)
                    dst.No_of_Days_in_a_Month__c = 29;
                else
                    dst.No_of_Days_in_a_Month__c = 28;
            }
            if(str.split(':')[2]=='March')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),3,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='April')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),4,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='May')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),5,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='June')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),6,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='July')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),7,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='August')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),8,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='September')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),9,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='October')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),10,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='November')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),11,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='December')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),12,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            dst.District_Trade_Actuals__c = dstrgtmap.get(str);
            dstgtlst.add(dst);
        }*/
        /*for(String str : dstrgtmap1.keySet())
        {
            District_Targets__c dst = new District_Targets__c();
            dst.District_Code__c = str.split(':')[0];
            dst.Product_Group__c = str.split(':')[1];
            dst.Month__c = str.split(':')[2];
            dst.Division__c = str.split(':')[3];
            dst.Year__c = str.split(':')[4];
            dst.Institutional_Actuals__c = dstrgtmap1.get(str);
            dstgtlst.add(dst);
        }*/
        /*for(String str : dstrgtmap2.keySet())
        {
            District_Targets__c dst = new District_Targets__c();
            dst.District_Code__c = str.split(':')[0];
            dst.Product_Group__c = str.split(':')[1];
            dst.Month__c = str.split(':')[2];
            dst.Division__c = str.split(':')[3];
            dst.Year__c = str.split(':')[4];
            if(str.split(':')[2]=='January')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),1,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='February')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),2,1);
                if(math.mod(Integer.valueOf(str.split(':')[4]),4) == 0)
                    dst.No_of_Days_in_a_Month__c = 29;
                else
                    dst.No_of_Days_in_a_Month__c = 28;
            }
            if(str.split(':')[2]=='March')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),3,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='April')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),4,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='May')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),5,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='June')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),6,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='July')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),7,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='August')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),8,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='September')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),9,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='October')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),10,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='November')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),11,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='December')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),12,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            dst.District_Non_Trade_Actuals__c = dstrgtmap2.get(str);
            dstgtlst.add(dst);
        }*/
        /*for(String str : dstrgtmap3.keySet())
        {
            District_Targets__c dst = new District_Targets__c();
            dst.District_Code__c = str.split(':')[0];
            dst.Product_Group__c = str.split(':')[1];
            dst.Month__c = str.split(':')[2];
            dst.Division__c = str.split(':')[3];
            dst.Year__c = str.split(':')[4];
            dst.GGBS_Actuals__c = dstrgtmap3.get(str);
            dstgtlst.add(dst);
        }*/
        /*for(String str : dstrgtmap4.keySet())
        {
            District_Targets__c dst = new District_Targets__c();
            dst.District_Code__c = str.split(':')[0];
            dst.Product_Group__c = str.split(':')[1];
            dst.Month__c = str.split(':')[2];
            dst.Division__c = str.split(':')[3];
            dst.Year__c = str.split(':')[4];
            if(str.split(':')[2]=='January')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),1,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='February')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),2,1);
                if(math.mod(Integer.valueOf(str.split(':')[4]),4) == 0)
                    dst.No_of_Days_in_a_Month__c = 29;
                else
                    dst.No_of_Days_in_a_Month__c = 28;
            }
            if(str.split(':')[2]=='March')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),3,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='April')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),4,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='May')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),5,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='June')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),6,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='July')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),7,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='August')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),8,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='September')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),9,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='October')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),10,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            if(str.split(':')[2]=='November')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),11,1);
                dst.No_of_Days_in_a_Month__c = 30;
            }
            if(str.split(':')[2]=='December')
            {
                dst.Target_Start_Date__c = date.newInstance(Integer.valueOf(str.split(':')[4]),12,1);
                dst.No_of_Days_in_a_Month__c = 31;
            }
            dst.SEZ_Actuals__c = dstrgtmap4.get(str);
            dstgtlst.add(dst);
        }
        Insert dstgtlst;*/
        update dstgtlst1;
    }
    
    global void finish(Database.BatchableContext BC) {
    
        batchDistrictUpdate bdu = new batchDistrictUpdate(qrystr);
        database.executebatch(bdu);
    }
}