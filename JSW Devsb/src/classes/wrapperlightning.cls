public class wrapperlightning 
{
    @AuraEnabled public String dealer;
    @AuraEnabled public String dealerid;
    @AuraEnabled public Decimal LYSMactual;
    @AuraEnabled public Decimal LMactual;
    @AuraEnabled public Double dlractual;
    @AuraEnabled public Double dlrqty;
    @AuraEnabled public Decimal dlrtrget;
    
    public wrapperlightning()
    {
        dealer = '';
        dlractual=0.00;
        dlrqty=0.00;
        dlrtrget = 0.0;
        LYSMactual = 0.0;
        LMactual = 0.0;
    }
}