trigger MRMStateCode on State_MRM_Targets__c (before insert,before update) 
{
    Map<String,String> stmap = new Map<String,String>();
    Map<String,String> lstmnthmap = new Map<String,String>();
    List<String> stcode = new List<String>();
    Set<String> lstmnth = new Set<String>();
    Set<String> nxtmnth = new Set<String>();
    for(State_MRM_Targets__c mrm : trigger.new)
    {
        stcode.add(String.valueOf(mrm.State_Code_Text__c));
        if(mrm.Month__c=='January')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'December'+':'+String.valueOf(mrm.Year__c-1)+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'February'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='February')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'January'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'March'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='March')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'February'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'April'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='April')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'March'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'May'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='May')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'March'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'June'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }   
        if(mrm.Month__c=='June')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'May'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'July'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='July')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'June'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'August'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='August')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'July'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'September'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='September')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'August'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'October'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='October')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'September'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'November'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='November')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'October'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'December'+':'+mrm.Year__c+':'+mrm.Plant__c);
        }
        if(mrm.Month__c=='December')
        {
            lstmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'November'+':'+mrm.Year__c+':'+mrm.Plant__c);
            nxtmnth.add(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+'January'+':'+String.valueOf(mrm.Year__c+1)+':'+mrm.Plant__c);
        }
    }
    System.debug('---'+stcode);
    List<State__c> stlst = [Select Id,State_Code__c from State__c where State_Code__c IN: stcode];
    List<State_MRM_Targets__c> lstmnthactl = [Select id,Unique_Code_Next_Month__c,Depot_Actuals__c,Direct_Actuals__c,Non_Trade_Actuals__c,Rail_Actuals__c,Road_Actuals__c,Trade_Actuals__c,NSR_Qty_Actuals__c,NSR_Value_Actuals__c from State_MRM_Targets__c where Unique_Code__c IN:lstmnth];
    for(State_MRM_Targets__c mrm : lstmnthactl)
    {
        lstmnthmap.put(mrm.Unique_Code_Next_Month__c,String.valueOf(mrm.Depot_Actuals__c)+':'+String.valueOf(mrm.Direct_Actuals__c)+':'+String.valueOf(mrm.Non_Trade_Actuals__c)+':'+String.valueOf(mrm.Rail_Actuals__c)+':'+String.valueOf(mrm.Road_Actuals__c)+':'+String.valueOf(mrm.Trade_Actuals__c)+':'+String.valueOf(mrm.NSR_Qty_Actuals__c)+':'+String.valueOf(mrm.NSR_Value_Actuals__c));
    }
    for(State__c st : stlst)
    {
        stmap.put(st.State_Code__c,st.id);
    }
    
    for(State_MRM_Targets__c mrm : trigger.new)
    {
        if(stmap.containsKey(mrm.State_Code_Text__c))
        {
            mrm.state__c = stmap.get(mrm.State_Code_Text__c);
        }
        if(lstmnthmap.containsKey(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c))
        {
            System.debug('Entered'+lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[0]);
            mrm.Last_Month_Depot_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[0]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[0]);
            mrm.Last_Month_Direct_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[1]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[1]);
            mrm.Last_Month_Non_Trade_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[2]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[2]);
            mrm.Last_Month_Rail_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[3]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[3]);
            mrm.Last_Month_Road_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[4]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[4]);
            mrm.Last_Month_Trade_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[5]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[5]);
            mrm.Last_Month_NSR_Qty_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[4]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[6]);
            mrm.Last_Month_NSR_Value_Actuals__c = lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+mrm.Year__c+':'+mrm.Plant__c).split(':')[5]==null ? 0 : Decimal.valueOf(lstmnthmap.get(mrm.State_Code_Text__c+':'+mrm.Product_Group__c+':'+mrm.Month__c+':'+String.valueOf(mrm.Year__c)+':'+mrm.Plant__c).split(':')[7]);
        }
    }
}