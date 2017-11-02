@RestResource(urlMapping='/AccountCheckIn/*')
global with sharing class AccountCheckIn{

    @HttpPost
    global static String doPost(AccountWraper accwp,String accid) {
       Account acc = [select id,Name,Location__Latitude__s,Location__Longitude__s from Account where id =: accid];
       acc.Location__Latitude__s = accwp.lat;
       acc.Location__Longitude__s = accwp.lon;
       update acc;
       return acc.id;
    }
       
    global class AccountWraper {
       Double lat {get; set;}
       Double lon {get; set;}
    }
}