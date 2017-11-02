public class mktinfowrapper 
{
    @AuraEnabled public Decimal WSP{get;set;}
    @AuraEnabled public Decimal RSP{get;set;}
    @AuraEnabled public Decimal BPMin{get;set;}
    @AuraEnabled public string Brand{get;set;}
    @AuraEnabled public string Product{get;set;}
    public mktinfowrapper()
    {  
        Brand='';
        Product='';
        WSP=0.0;
        RSP=0.0;
        BPMin=0.0;
    }
    
}