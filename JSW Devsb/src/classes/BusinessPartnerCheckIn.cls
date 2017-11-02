@RestResource(urlMapping='/BusinessPartnerCheckIn/*')
global with sharing class BusinessPartnerCheckIn{

    @HttpPost
    global static String doPost(BusinessPartnerWraper bpwp,String bpid) {
       Business_Partner__c bp = [select id,Name,Geolocation__Latitude__s,Geolocation__Longitude__s from Business_Partner__c where id =: bpid];
       bp.Geolocation__Latitude__s = bpwp.lat;
       bp.Geolocation__Longitude__s = bpwp.lon;
       update bp;
       return bp.id;
    }
       
    global class BusinessPartnerWraper {
       Double lat {get; set;}
       Double lon {get; set;}
    }
}