global class NSRActualsSchedule Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Integer mnth = (System.today()-1).month();
        String query = 'Select id,Account__c,Account_Text__c,C_F_Value__c,Cancelled_Invoice__c,Category__c,Commercial_Invoice_Date__c,Commercial_Invoice_Number__c,Cust_Grp1_from_Master__c,Customer_Code__c,Discount__c,Discount_Value__c,Distribution_Channel__c,Distribution_Channel_Description__c,District_Code__c,Districts__c,District_Text__c,Division_Description__c,Frieght__c,Middle_Man_Commission__c,MMC__c,Month__c,NSR_T__c,NSR_Targets_Processed__c,NSR_Value__c,Other__c,Packing_Cost__c,PD_SPL_ADDL__c,Plant__c,Plant_Name__c,Plant_Short_Form__c,Portal_Value__c,PRFT_Dump_Value__c,Product_Group__c,Quantity__c,Rate_MT__c,Ship_to_District__c,Ship_to_State__c,Storage_Location__c,Territory__c,Territory_Code__c,Toatl_Value__c,Total_Basic_Price__c,Year__c from NSR_New_Targets__c where Commercial_Invoice_Date__c>2017-05-31 AND Commercial_Invoice_Date__c<TODAY AND NSR_Targets_Processed__c=false';
        
        System.debug('----'+query);
        NSRActuals nsr = new NSRActuals(query); //ur batch class
        database.executebatch(nsr);        
    }
}