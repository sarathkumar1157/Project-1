global class DistrictActualsSchedule Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Integer mnth = (System.today()-1).month();
        Integer yer = (System.today()-1).year();
        String query = 'Select Distribution_Channel__c,Sales_Office_Code__c,Brand_Short_Form__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,District_Actuals_Process__c,Qty__c,Road_Invoice__c,Depot_Invoice__c from Invoice__c where CALENDAR_MONTH(Commercial_Invoice_Date_Formula__c)='+mnth+' AND CALENDAR_YEAR(Commercial_Invoice_Date_Formula__c)='+yer+' and Commercial_Invoice_Date_Formula__c<TODAY AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'CHD\' OR Brand_Short_Form__c=\'OPC\') AND Cust_Grp1_from_Master__c!=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND State_Code__c!=\'13\' AND District_Actuals_Process__c = False';
        System.debug('----'+query);
        DistrictActuals distact = new DistrictActuals(query); //ur batch class
        database.executebatch(distact);        
    }
}