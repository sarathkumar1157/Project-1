public class batchCalls
{
    public date fromdate{set;get;}
    public date todate{set;get;}
    public String classnames{set;get;}
    public String convertparam{set;get;}
    public boolean tobeprocessed{set;get;}
    public String dc{set;get;}
    public String prod{set;get;}
    public String salesdistrict{set;get;}
    public String soldcode{set;get;}
    public String plant{set;get;}
    public String plantshrt{set;get;}
    public String sloc{set;get;}
    public String salesofccode{set;get;}
    public String shptodist{set;get;}
    public String statcode{set;get;}
    
    public void defaultvals()
    {
        dc = 'None';
        prod = 'None';
        salesdistrict = null;
        soldcode = null;
        plant = null;
        plantshrt = null;
        sloc = null;
        statcode = null;
        shptodist = null;
        salesofccode = null;
    }
    public pagereference runbatch()
    {
        system.debug('1'+fromdate);
        system.debug('2'+todate);
        system.debug('3'+classnames);
        system.debug('4'+tobeprocessed);
        if(classnames=='PDClass')
        {
            String query = 'Select district_code__c,Product__c,distribution_Channel__c,From_Date__c,To_Date__c,PD_Value__c,To_Be_Processed__c from NSR_PD_Values__c where From_Date__c>='+String.valueOf(fromdate).substring(0,10)+' AND To_Date__c<='+String.valueOf(todate).substring(0,10)+' AND To_Be_Processed__c='+tobeprocessed+'';
            if(prod != 'None')
                query = query + ' AND Product__c = \''+prod+'\'';
            if(dc != 'None')
                query = query + ' AND distribution_Channel__c = \''+dc+'\'';
            if(!String.isBlank(salesdistrict))
                query = query + ' AND district_code__c = \''+salesdistrict+'\'';
            system.debug('query'+query);
            NSRPDValues bat = new NSRPDValues(query);
            Database.executeBatch(bat,1); 
        }
        else if(classnames=='OtherClass')
        {
            String query = 'Select distribution_Channel__c,District_Code__c,From_Date__c,Other_Value__c,Product__c,To_Be_Processed__c,To_Date__c from NSR_Other_Values__c where From_Date__c>='+String.valueOf(fromdate).substring(0,10)+' AND To_Date__c<='+String.valueOf(todate).substring(0,10)+' AND To_Be_Processed__c='+tobeprocessed+'';
            if(prod != 'None')
                query = query + ' AND Product__c = \''+prod+'\'';
            if(dc != 'None')
                query = query + ' AND distribution_Channel__c = \''+dc+'\'';
            if(!String.isBlank(salesdistrict))
                query = query + ' AND district_code__c = \''+salesdistrict+'\'';
            NSROtherValues bat = new NSROtherValues(query);
            Database.executeBatch(bat,1);
        }
        else if(classnames=='PRFTClass')
        {
            String query = 'Select From_Date__c,MFG_Plant__c,Plant__c,PRFT_Value__c,Product__c,Storage_Location__c,To_Be_Processed__c,To_Date__c from NSR_PRFT_Values__c where From_Date__c>='+String.valueOf(fromdate).substring(0,10)+' AND To_Date__c<='+String.valueOf(todate).substring(0,10)+' AND To_Be_Processed__c='+tobeprocessed+'';
            if(prod != 'None')
                query = query + ' AND Product__c = \''+prod+'\'';
            if(!String.isBlank(plantshrt))
                query = query + ' AND MFG_Plant__c = \''+plantshrt+'\'';
            if(!String.isBlank(plant))
                query = query + ' AND Plant__c = \''+plant+'\'';
            NSRPRFTValues bat = new NSRPRFTValues(query);
            Database.executeBatch(bat,1);
        }
        else if(classnames=='CFClass')
        {
            String query = 'Select From_Date__c,MFG_Plant__c,Plant__c,Product__c,Storage_Location__c,To_Be_Processed__c,To_Date__c,Value__c from NSR_C_F_Value_Changes__c where From_Date__c>='+String.valueOf(fromdate).substring(0,10)+' AND To_Date__c<='+String.valueOf(todate).substring(0,10)+' AND To_Be_Processed__c='+tobeprocessed+'';
            if(prod != 'None')
                query = query + ' AND Product__c = \''+prod+'\'';
            if(!String.isBlank(plant))
                query = query + ' AND Plant__c = \''+plant+'\'';
            if(!String.isBlank(sloc))
                query = query + ' AND Storage_Location__c = \''+sloc+'\'';
            NSRCFValues bat = new NSRCFValues(query);
            Database.executeBatch(bat,1);
        }
        else if(classnames=='CIClass')
        {
            String query = 'Select Customer_Code__c,Distribution_Channel__c,District_Code__c,From_Date__c,Product__c,To_Date__c,To_Be_Processed__c,Value__c from Customer_Incentive__c where From_Date__c>='+String.valueOf(fromdate).substring(0,10)+' AND To_Date__c<='+String.valueOf(todate).substring(0,10)+' AND To_Be_Processed__c='+tobeprocessed+'';
            if(prod != 'None')
                query = query + ' AND Product__c = \''+prod+'\'';
            if(dc != 'None')
                query = query + ' AND distribution_Channel__c = \''+dc+'\'';
            if(!String.isBlank(soldcode))
                query = query + ' AND Customer_Code__c = \''+soldcode+'\'';
            NSRCIValues bat = new NSRCIValues(query);
            Database.executeBatch(bat,1);
        }
        else if(classnames=='AdhocClass')
        {
            String query = 'Select district_code__c,Product__c,distribution_Channel__c,From_Date__c,To_Date__c,Value__c,To_Be_Processed__c from Adhoc_Incentive__c where From_Date__c>='+String.valueOf(fromdate).substring(0,10)+' AND To_Date__c<='+String.valueOf(todate).substring(0,10)+' AND To_Be_Processed__c='+tobeprocessed+'';
            if(prod != 'None')
                query = query + ' AND Product__c = \''+prod+'\'';
            if(dc != 'None')
                query = query + ' AND distribution_Channel__c = \''+dc+'\'';
            if(!String.isBlank(salesdistrict))
                query = query + ' AND district_code__c = \''+salesdistrict+'\'';
            NSRAdhocValues bat = new NSRAdhocValues(query);
            Database.executeBatch(bat,1);
        }
        else if(classnames=='IDClass')
        {
            String query = 'Select Commercial_Invoice_Number__c,Invoice_Discount_Value__c,To_Be_Processed__c from Invoice_Discounts__c where To_Be_Processed__c='+tobeprocessed+'';
            NSRIDValues bat = new NSRIDValues(query);
            Database.executeBatch(bat);
        }
        else if(classnames=='DistrictActualsClass')
        {
            String query = 'Select Distribution_Channel__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,District_Actuals_Process__c,Qty__c,Road_Invoice__c,Depot_Invoice__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'CHD\' OR Brand_Short_Form__c=\'OPC\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\'';
            System.debug('----'+query);
            if(prod != 'None')
                query = 'Select Distribution_Channel__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,District_Actuals_Process__c,Qty__c,Road_Invoice__c,Depot_Invoice__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\'';
            /*if(!String.isBlank(salesofccode))
                query = 'Select Distribution_Channel__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,District_Actuals_Process__c,Qty__c,Road_Invoice__c,Depot_Invoice__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'CHD\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\' AND Sales_Office_Code__c=\''+salesofccode+'\'';
            if(prod != 'None' && !String.isBlank(salesofccode))
                query = 'Select Distribution_Channel__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,District_Actuals_Process__c,Qty__c,Road_Invoice__c,Depot_Invoice__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\' AND Sales_Office_Code__c=\''+salesofccode+'\'';*/
            DistrictActualsDelete distact = new DistrictActualsDelete(query); //ur batch class
            Database.executebatch(distact); 
  
        }
        else if(classnames=='DistrictNSRClass')
        {
            String query = 'Select Distribution_Channel__c,Qty__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'CHD\' OR Brand_Short_Form__c=\'OPC\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\'';
            System.debug('----'+query);
            if(prod != 'None')
                query = 'Select Distribution_Channel__c,Qty__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c= \''+prod+'\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\'';
            /*if(!String.isBlank(salesofccode))
                query = 'Select Distribution_Channel__c,Qty__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'CHD\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\' AND Sales_Office_Code__c=\''+salesofccode+'\'';
            if(prod != 'None' && !String.isBlank(salesofccode))
                query = 'Select Distribution_Channel__c,Qty__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c= \''+prod+'\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\' AND Sales_Office_Code__c=\''+salesofccode+'\'';*/
            NSRDelete nsr = new NSRDelete(query); //ur batch class
            database.executebatch(nsr,100);   
        }
        else if(classnames=='StateActualsClass')
        {
            String query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,State_Actuals_Process__c,Qty__c,Road_Invoice__c,Depot_Invoice__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' and Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'OPC\' OR Brand_Short_Form__c=\'GGBS\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') ';
            System.debug('----'+query);
            if(prod != 'None')
                query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\')';
            if(!String.isBlank(statcode))
                query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'OPC\' OR Brand_Short_Form__c=\'GGBS\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\''+statcode+'\'';
            if(prod != 'None' && !String.isBlank(statcode))
                query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\''+statcode+'\'';
            System.debug('----'+query);
            StateActualsDelete bat1 = new StateActualsDelete(query);
            Database.executeBatch(bat1,100); 
        }
        else if(classnames=='StateNSRClass')
        {
            String query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'OPC\' OR Brand_Short_Form__c=\'GGBS\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\')';
            System.debug('----'+query);
            if(prod != 'None')
                query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\')';
            if(!String.isBlank(statcode))
                query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'OPC\' OR Brand_Short_Form__c=\'GGBS\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\''+statcode+'\'';
            if(prod != 'None' && !String.isBlank(statcode))
                query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\''+statcode+'\'';
            System.debug('----'+query);
            StateNSRDelete nsr = new StateNSRDelete(query); //ur batch class
            database.executebatch(nsr,100); 
        }
        else if(classnames=='MHClass')
        {
            String query = 'Select Distribution_Channel__c,Ship_To_District__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,Qty__c,MH_Actuals_Processed__c,Road_Invoice__c,Depot_Invoice__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'CHD\' OR Brand_Short_Form__c=\'OPC\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\'13\'';
            if(prod != 'None')
                query = 'Select Distribution_Channel__c,Ship_To_District__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,Qty__c,MH_Actuals_Processed__c,Road_Invoice__c,Depot_Invoice__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\'13\'';
            /*if(!String.isBlank(shptodist))
                query = 'Select Distribution_Channel__c,Ship_To_District__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,Qty__c,MH_Actuals_Processed__c,Road_Invoice__c,Depot_Invoice__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'CHD\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\'13\' AND Ship_To_District__c=\''+shptodist+'\'';
            if(prod != 'None' && !String.isBlank(shptodist))
                query = 'Select Distribution_Channel__c,Ship_To_District__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,Qty__c,MH_Actuals_Processed__c,Road_Invoice__c,Depot_Invoice__c,NSR_T_Value__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+' AND (Brand_Short_Form__c=\''+prod+'\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c=\'13\' AND Ship_To_District__c=\''+shptodist+'\'';*/
            System.debug('----'+query);
            MaharashtraActualsDelete distact = new MaharashtraActualsDelete(query); //ur batch class
            database.executebatch(distact,100); 
        }
        else if(classnames=='DistTargets')
        {
            String query = 'Select Brand_Short_Form__c,Distribution_Channel__c,Division__c,Sales_District__c,Month_of_Commercial_Invoice_Date__c,Year__c,District_Inv_Process__c,Qty__c,Cust_Grp1_from_Master__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+'';
            if(prod != 'None')
                query = query + ' AND Brand_Short_Form__c = \''+prod+'\'';
            batchDistrictUpdateDelete bat = new batchDistrictUpdateDelete(query); //ur batch class
            database.executebatch(bat);    
        }
        else if(classnames=='CustTargets')
        {
            String query = 'Select Sold_To_Code__c,Distribution_Channel__c,Division__c,Plant__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Month_of_Commercial_Invoice_Date__c,Year__c,Qty__c,Invoice_Processed__c,Plant_Short_Form__c,Sales_District__c,Commercial_Invoice_Date_Formula__c from Invoice__c where Commercial_Invoice_Date_Formula__c>='+String.valueOf(fromdate).substring(0,10)+' AND Commercial_Invoice_Date_Formula__c<='+String.valueOf(todate).substring(0,10)+'';
            System.debug('----'+query);
            if(prod != 'None')
                query = query + ' AND Brand_Short_Form__c = \''+prod+'\'';
            batchTargetsUpdateDelete bat = new batchTargetsUpdateDelete(query); //ur batch class
            database.executebatch(bat);        
        }
        else if(classnames=='Staging')
        {
            StagingConvert stgcon = new StagingConvert('RecordType.Name = \'Visit\' and Master__c != null and (NOT Master__c LIKE \'a1S%\') LIMIT 30');
        }
        
        if(classnames=='Staging'){
            return null;
        } else {
            pagereference pr = new pagereference('/apexpages/setup/listAsyncApexJobs.apexp?setupid=AsyncApexJobs&retURL=%2Fui%2Fsetup%2FSetup%3Fsetupid%3DJobs&thePage%3AtheTemplate%3Aj_id18%3Afcf=00B2800000AmLCp');
            pr.setRedirect(false);
            return pr;
        }
        
    }
}