global class StateNSRActualsSchedule Implements Schedulable
{
    global void execute(SchedulableContext sc)
    {
        Integer mnth = (System.today()-1).month();
        Integer yer = (System.today()-1).year();
        String query = 'Select Distribution_Channel__c,Brand_Short_Form__c,Cust_Grp1_from_Master__c,Qty__c,State_Code__c,Month_of_Commercial_Invoice_Date__c,Year__c,Plant_Short_Form__c,Commercial_Invoice_Date_Formula__c,NSR_Targets_Processed__c,NSR_T_Value__c from Invoice__c where CALENDAR_MONTH(Commercial_Invoice_Date_Formula__c)='+mnth+' AND CALENDAR_YEAR(Commercial_Invoice_Date_Formula__c)='+yer+' and Commercial_Invoice_Date_Formula__c<TODAY AND (Brand_Short_Form__c=\'PSC\' OR Brand_Short_Form__c=\'OPC\' OR Brand_Short_Form__c=\'GGBS\') AND Cust_Grp1_from_Master__c=\'N01-Institutions\' AND (Distribution_Channel__c=\'10\' OR Distribution_Channel__c=\'20\' OR Distribution_Channel__c=\'50\') AND StateNSR_Targets_Proccessed__c = False';
        System.debug('----'+query);
        StateNSRActuals nsr = new StateNSRActuals(query); //ur batch class
        database.executebatch(nsr);       
    }
}