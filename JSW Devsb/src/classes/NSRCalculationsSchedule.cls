global class NSRCalculationsSchedule Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        String query = 'Select Sales_District__c,Brand_Short_Form__c,Distribution_channel__c,Plant_Short_Form__c,Plant__c,SLOC__c,Sold_To_Code__c,Commercial_Invoice_Number__c,NSR_PD_Value__c,Commercial_Invoice_Date_Formula__c,NSR_Other_Value__c,NSR_PRFT_Value__c,NSR_C_F_Value__c,Adhoc_Incentive_Value__c,Customer_Incentive_Value__c,Invoice_Discount_Value__c,Invoice_NSR_Processed__c from Invoice__c where Commercial_Invoice_Date_Formula__c > 2017-06-30 AND Commercial_Invoice_Date_Formula__c < TODAY AND Invoice_NSR_Processed__c=False';
        NSRCalculations bat = new NSRCalculations(query); //ur batch class
        
        database.executebatch(bat);        
    }
}