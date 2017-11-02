public with sharing class CustomLookup_ctrl {      
    public String fieldTypeForSelectedField {get;set;}     
      public list<Material_Source__c > accname{get;set;}     
    public list<PhoneNumberDetail> listOfLookupsElement {get;set;}
    public String objectName {get;set;}
    public String fieldName {get;set;}
    public String i{get;set;}
    public String searchByName{get;set;}
    public String searchByPhone{get;set;}
    public boolean isChecked {get;set;}
   public String phoneNumberPassToTextBox {get;set;}
    public String phoneNamePassToHdn {get;set;}
        public String acctsid{get;set;}
            public String plant{get;set;}
    
    
    public boolean isAllSelectCheckBox {get;set;}
    /*Controller*/
    public CustomLookup_ctrl (){
    
        accname=[select Material_Code__c ,id from Material_Source__c limit 1000];
        
        listOfLookupsElement = new list<PhoneNumberDetail>();        
     //   objectName = String.escapeSingleQuotes(ApexPages.CurrentPage().getParameters().get('oN'));
     //   fieldName = String.escapeSingleQuotes(ApexPages.CurrentPage().getParameters().get('fN'));
        isAllSelectCheckBox = false;
        searchByPhone = '';
        searchByName ='';
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
        getlistOfLookupsElement();
   }
  
   /*to get list of lookup element*/
   public void getlistOfLookupsElement(){
        try{ 
            listOfLookupsElement = new list<PhoneNumberDetail>();
              String saleDistct= apexpages.currentPage().getParameters().get('saleDistct');
              String taxType= apexpages.currentPage().getParameters().get('taxType');
              String shipmentType= apexpages.currentPage().getParameters().get('shipmentType');
              String packingType= apexpages.currentPage().getParameters().get('packingType');
              String productCode= apexpages.currentPage().getParameters().get('productCode');
                i= apexpages.currentPage().getParameters().get('i');
              //if(String.isNotBlank(saleDistct)&&String.isNotBlank(taxType)&&String.isNotBlank(saleDistct)&&String.isNotBlank(shipmentType)&&String.isNotBlank(packingType)&&String.isNotBlank(productCode))        
             system.debug('====@@@@'+saleDistct);
            
            String query = 'SELECT Material_Code__c,Pref__c,Source__c,COD__c,id from Material_Source__c';
          if(!taxType.equals(''))
          {
          query+=' where Tax_Cat__c LIKE \''+String.escapeSingleQuotes(taxType)+'%\''; 
          }
          if(!saleDistct.equals(''))
          {
           query+=' and City_code__c LIKE \''+String.escapeSingleQuotes(saleDistct)+'%\'';
          }
           if(!shipmentType.equals(''))
          {
           query+=' and shipping_type__c LIKE \''+String.escapeSingleQuotes(shipmentType)+'%\'';
          }
           if(!packingType.equals(''))
          {
           query+=' and Packing_Type__c LIKE \''+String.escapeSingleQuotes(packingType)+'%\'';
          }
            if(!productCode.equals(''))
          {
           query+=' and SFDC_Product_Code__c LIKE \''+String.escapeSingleQuotes(productCode)+'%\'';
          }
          query+=' limit 1000';
             system.debug('====@@@@'+query);
            list<SObject> s = Database.query(query);
           // String CountryCode = null; 
          //  boolean isCountryCodeAlreadyExist;   
          
            for(sObject sObj:s){ 
               
                    listOfLookupsElement.add(new PhoneNumberDetail(String.valueOf(sObj.get('Material_Code__c')),String.valueOf(sObj.get('Source__c')),String.valueOf(sObj.get('Pref__c')),String.valueOf(sObj.get('COD__c'))));   
                                   
                }
            } 
        catch(Exception ex){
             apexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Parameter is not defined, Please contact your Administrator!'));
        }       
    }
    /*Search event*/
    public void onSearch(){
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
        isAllSelectCheckBox = false;
        listOfLookupsElement = new list<PhoneNumberDetail>();
        String byName = '\'%'+String.escapeSingleQuotes(searchByName) + '%\'';
        String byPhone = '\'%'+String.escapeSingleQuotes(searchByPhone) + '%\'';
        String CountryCode = null;
        boolean isCountryCodeAlreadyExist;
         system.debug('====@@@@byName****'+byName);
        try{
            String query ='SELECT Material_Code__c,Pref__c,Source__c,COD__c,id from Material_Source__c WHERE  Material_Code__c Like  '+byName+' limit 1000';
             system.debug('====@@@@query ****'+query );
            list<SObject> s = Database.query(query); 
            for(sObject sObj:s){
                
                    listOfLookupsElement.add(new PhoneNumberDetail(String.valueOf(sObj.get('Material_Code__c')),String.valueOf(sObj.get('Source__c')),String.valueOf(sObj.get('Pref__c')),String.valueOf(sObj.get('COD__c'))));   
                }
                 system.debug('====@@@@listOfLookupsElement****'+listOfLookupsElement);
            } 
        
        catch(Exception ex){
            apexPages.addMessage(new ApexPages.message(ApexPages.severity.ERROR,'Illegal Search parameter!'));
        }       
    }
    /*Event for check box checked*/
    public void onCheck(){
  
      String source= apexpages.currentPage().getParameters().get('hid1');
      String acName= apexpages.currentPage().getParameters().get('hid2');
      String pref= apexpages.currentPage().getParameters().get('hid3');
      String cod= apexpages.currentPage().getParameters().get('hid4');
    
          system.debug('====@@@@source***'+source);
        phoneNumberPassToTextBox = '';
        phoneNamePassToHdn  = '';
         acctsid = '';
        String CountryCode  = '';
         phoneNumberPassToTextBox = acName;
                        phoneNamePassToHdn = acName;
                       
                        plant=source;
                          system.debug('====@@@@plant***'+plant);
       /* for(PhoneNumberDetail pn:listOfLookupsElement){
            if(acid.equals(pn.accId)){
               if(pn.accname== null || pn.accname== ''){            
                    phoneNumberPassToTextBox += pn.accname+';'; 
                    phoneNamePassToHdn +=  pn.accname+';';                   
                    //apexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning,'Default Country code selected to phone number "'+pn.sObjectPhone+'"!'));
                    //apexPages.addMessage(new ApexPages.message(ApexPages.severity.Warning,'Please select a country for "'+pn.sObjectNameField +'" Name and Phone Number "'+pn.sObjectPhone+'"'));
               }else{                              
                        phoneNumberPassToTextBox += pn.accname+';';
                        phoneNamePassToHdn += pn.accname+';';
                        acctsid =pn.accId;
                    }
                    system.debug('===='+phoneNamePassToHdn+'@@@@'+phoneNumberPassToTextBox );
               }
            }*/
        }
    
   
    
    /*P2l Detail wrapper*/
    public class PhoneNumberDetail{
        
        public string accname{get;set;}
         public string source{get;set;}
          public string pref{get;set;}
         public string cod{get;set;}
        
        public PhoneNumberDetail(string accname,String source,string pref,String cod){
            this.accname= accname;
            this.source= source;
            this.pref= pref;
            this.cod= cod;
           }        
    }     

}