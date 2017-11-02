@RestResource(urlMapping='/LeadInsert/*')
global with sharing class LeadInsert{

    @HttpPost
    global static String doPost(LeadWraper leadWraper,String userId) {
       Lead l = new Lead();
       Schema.DescribeSObjectResult LeadDest = Lead.sObjectType.getDescribe();
       if(userId.startsWith(LeadDest.getKeyPrefix())){
           l = [select id,Location__Latitude__s,Location__Longitude__s,firstName,lastName,Type__c,Status,Company,Lead_Response__c,Phone,
                KYC_Form_Filled__c,Potential__c,Blended_cement_potential_in_MT__c,Catgegory_A_potential_in_MT__c,Wholesale_Percentage__c,
                No_of_Sub_Dealers__c,District__c,Street,City,State,Country,PostalCode from Lead where id =: userId];
            l.firstName = leadWraper.firstname;
            l.lastName = leadWraper.Lastname;
            l.Type__c = leadWraper.type;
            l.Status = leadWraper.leadStatus;    
            l.Company = leadWraper.company;
            l.Lead_Response__c = leadWraper.lresponse;
            l.Phone = leadWraper.phone;
            l.KYC_Form_Filled__c = leadWraper.isfilled;
            l.Potential__c = leadWraper.potential;
            l.Blended_cement_potential_in_MT__c = leadWraper.BPotential;
            l.Catgegory_A_potential_in_MT__c = leadWraper.APotential;
            l.Wholesale_Percentage__c = leadWraper.wholesale;
            l.No_of_Sub_Dealers__c = leadWraper.subdealers;
            l.District__c = leadWraper.district;
            l.Street = leadWraper.street;
            l.City = leadWraper.city;
            l.State = leadWraper.state;
            l.Country = leadWraper.country;
            l.PostalCode = leadWraper.postalcode;
            //l.Location__Latitude__s = leadWraper.lat;
            //l.Location__Longitude__s = leadWraper.lon;
            update l;
       } else {
            l = new Lead();
            l.firstName = leadWraper.firstname;
            l.lastName = leadWraper.Lastname;
            l.Type__c = leadWraper.type;
            l.ownerId = userId;
            l.Status = leadWraper.leadStatus;    
            l.Company = leadWraper.company;
            l.Lead_Response__c = leadWraper.lresponse;
            l.Phone = leadWraper.phone;
            l.KYC_Form_Filled__c = leadWraper.isfilled;
            l.Potential__c = leadWraper.potential;
            l.Blended_cement_potential_in_MT__c = leadWraper.BPotential;
            l.Catgegory_A_potential_in_MT__c = leadWraper.APotential;
            l.Wholesale_Percentage__c = leadWraper.wholesale;
            l.No_of_Sub_Dealers__c = leadWraper.subdealers;
            l.District__c = leadWraper.district;
            l.Street = leadWraper.street;
            l.City = leadWraper.city;
            l.State = leadWraper.state;
            l.Country = leadWraper.country;
            l.PostalCode = leadWraper.postalcode;
            l.Location__Latitude__s = leadWraper.lat;
            l.Location__Longitude__s = leadWraper.lon;
            insert l;
       }
       
       return l.id;
    }
       
    global class LeadWraper {
       global String firstname{get; set;}
       global String Lastname{get; set;}
       global String type{get; set;}
       global String leadStatus{get; set;}
       global String company{get; set;}
       global String lresponse{get; set;}
       global String phone {get; set;}
       global Boolean isfilled {get; set;}
       String potential {get; set;}
       Double BPotential {get; set;}
       Double APotential {get; set;}
       Double wholesale {get; set;}
       Integer subdealers {get; set;}
       String district {get; set;}
       String street {get; set;}
       String city {get; set;}
       String state {get; set;}
       String country {get; set;}
       String postalcode {get; set;}
       Double lat {get; set;}
       Double lon {get; set;}
    }
}