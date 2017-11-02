trigger MasterFieldUpdate on District_Actuals__c (before insert) 
{
	for(District_Actuals__c da : trigger.new)
    {
        if(da.District_Actuals__c ==null)
        {
            MRM_Targets__c mrm = new MRM_Targets__c();
        }
    }
}