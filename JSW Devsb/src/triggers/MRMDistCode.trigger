trigger MRMDistCode on MRM_Targets__c (before insert,before update) 
{
    Map<String,String> mhdstmap = new Map<String,String>();
    Map<String,String> dstmap = new Map<String,String>();
    Map<String,String> termap = new Map<String,String>();
    Map<String,String> lstmnthmap = new Map<String,String>();
    List<String> dstcode = new List<String>();
    List<String> tercode = new List<String>();
    Set<String> lstmnth = new Set<String>();
    Set<String> nxtmnth = new Set<String>();
    for(MRM_Targets__c mrm : trigger.new)
    {
        dstcode.add(mrm.District_Code__c);
        if(mrm.Sales_Office__c!=null)
            tercode.add(mrm.Sales_Office__c);
        if(mrm.Month__c=='January')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'December'+':'+String.valueOf(Integer.valueOf(mrm.Year__c)-1)+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'February'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='February')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'January'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'March'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='March')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'February'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'April'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='April')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'March'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'May'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='May')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'March'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'June'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='June')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'May'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'July'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='July')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'June'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'August'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='August')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'July'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'September'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='September')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'August'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'October'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='October')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'September'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'November'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='November')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'October'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'December'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='December')
        {
            lstmnth.add(mrm.Sales_Office__c+':'+mrm.Product__c+':'+'November'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.District_Code__c+':'+mrm.Product__c+':'+'January'+':'+String.valueOf(Integer.valueOf(mrm.Year__c)+1)+':'+mrm.Plant__c);
        }
    }
    System.debug('----lstmnth----'+lstmnth);
    List<Districts__c> dstlst = [Select Id,District_Code__c from Districts__c where District_Code__c IN: dstcode];
    List<District__c> terlst = [Select id,Territory_Code__c,Districts__c from District__c where Territory_Code__c IN: tercode];
    List<MRM_Targets__c> lstmnthactl = [Select id,Unique_Code_Next_Month__c,Depot_Actuals__c,Direct_Actuals__c,Non_Trade_Actuals__c,Rail_Actuals__c,Road_Actuals__c,Trade_Actuals__c,NSR_Overall_QTY_Actuals__c,NSR_Overall_Value_Actuals__c from MRM_Targets__c where Unique_Code__c IN:lstmnth];
    for(MRM_Targets__c mrm : lstmnthactl)
    {
        lstmnthmap.put(mrm.Unique_Code_Next_Month__c,String.valueOf(mrm.Depot_Actuals__c)+':'+String.valueOf(mrm.Direct_Actuals__c)+':'+String.valueOf(mrm.Non_Trade_Actuals__c)+':'+String.valueOf(mrm.Rail_Actuals__c)+':'+String.valueOf(mrm.Road_Actuals__c)+':'+String.valueOf(mrm.Trade_Actuals__c)+':'+String.valueOf(mrm.NSR_Overall_QTY_Actuals__c)+':'+String.valueOf(mrm.NSR_Overall_Value_Actuals__c));
    }
    System.debug('---map----'+lstmnthmap);
    for(Districts__c dst : dstlst)
    {
        mhdstmap.put(dst.District_Code__c,dst.id);
    }
    for(District__c dst : terlst)
    {
        termap.put(dst.Territory_Code__c,dst.id);
        dstmap.put(dst.Territory_Code__c,dst.Districts__c );
    }
    
    for(MRM_Targets__c mrm : trigger.new)
    {
        if(mhdstmap.containsKey(mrm.District_Code__c))
        {
            mrm.District__c = mhdstmap.get(mrm.District_Code__c);
        }
        
        if(dstmap.containsKey(mrm.Sales_Office__c))
        {
            mrm.District__c = dstmap.get(mrm.Sales_Office__c);
        }
        if(termap.containsKey(mrm.Sales_Office__c))
        {
            mrm.Territory__c = termap.get(mrm.Sales_Office__c);
        }
        
        if(lstmnthmap.containsKey(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c))
        {
            System.debug('Entered'+lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[0]);
            mrm.Last_Month_Depot_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[0]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[0]);
            mrm.Last_Month_Direct_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[1]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[1]);
            mrm.Last_Month_Non_Trade_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[2]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[2]);
            mrm.Last_Month_Rail_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[3]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[3]);
            mrm.Last_Month_Road_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[4]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[4]);
            mrm.Last_Month_Trade_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[5]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[5]);
            mrm.Last_Month_NSR_Qty_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[4]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[6]);
            mrm.Last_Month_NSR_Value_Actuals__c = lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[5]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.Sales_Office__c+':'+mrm.Product__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[7]);
        }
    }
}