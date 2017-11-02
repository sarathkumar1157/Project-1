global with sharing class AutoCheckInController {

    //public static Visit__c recAccount;
   // public static string id;
    public string Latitude{get; set;}
    
    public AutoCheckInController (ApexPages.StandardController controller) { 
        //recAccount = (Visit__c)Controller.getRecord();
        //id='/'+recAccount.id;
    }

    @RemoteAction
    // Auto checkin the user if the current user's location is in and around 0.5 kms radius of Account/Lead/Retailer address
    global static User_Tracking__c autoCheckIn(string lat, string lon, string accntLat, string accntLng, String strAccntName) {
       String strAcc = strAccntName; 
       Visit__c acc=[select id,Visited_Location__Latitude__s,Visited_Location__Longitude__s from Visit__c where id=:strAcc]; 
       string id='/'+acc.id;
       acc.id = strAcc;
       acc.Visited_Location__Latitude__s =Decimal.valueOf(lat);
       acc.Visited_Location__Longitude__s =Decimal.valueOf(lon);
       acc.Visited__c = true;
       //acc.check_in__c = system.now();
       upsert acc;            
       System.debug('Account Lat Long =' +acc.Visited_Location__c);
        System.debug('User Latitude =' +lat);
        System.debug('User Longitude =' +lon);
        
        System.debug('Account Name=' + strAccntName);
        System.debug('Account Latitude =' +accntLat);
        System.debug('Account Longitude =' +accntLng);
        
       return null;
        
    }
    
    @RemoteAction
    global static void autoCheckInAcc(string lat, string lon, string accntLat, string accntLng, String strAccntName) {
       String strAcc = strAccntName; 
       Account acc=[select id,Location__Latitude__s,Location__Longitude__s from Account where id=:strAcc]; 
       string id='/'+acc.id;
       acc.id = strAcc;
       acc.Location__Latitude__s = Decimal.valueOf(accntLat);
       acc.Location__Longitude__s = Decimal.valueOf(accntLng);
       upsert acc; 
    }
    
   @RemoteAction
    global static void autoCheckInLd(string lat, string lon, string Ldlat, string Ldlng, String strLdName) {
       String strLd = strLdName; 
       Lead ld=[select id,Location__Latitude__s,Location__Longitude__s from Lead where id=:strLd]; 
       string id='/'+ld.id;
       ld.id = strLd;
       ld.Location__Latitude__s = Decimal.valueOf(ldLat);
       ld.Location__Longitude__s = Decimal.valueOf(ldLng);
       upsert ld; 
    }
    
    @RemoteAction
    global static void autoCheckInPS(string lat, string lon, string pslat, string pslng, String strPSName) {
       String strPS = strPsName; 
       Project_Site__c ps=[select id,Location__Latitude__s,Location__Longitude__s from Project_Site__c where id=:strPs]; 
       string id='/'+ps.id;
       ps.id = strPS;
       ps.Location__Latitude__s = Decimal.valueOf(pslat);
       ps.Location__Longitude__s = Decimal.valueOf(pslng);
       upsert ps; 
    }
    
    /*@RemoteAction
    global static void autoCheckInMMC(string lat, string lon, string pslat, string pslng, String strPSName) {
       String strPS = strPsName; 
       Project_Site__c ps=[select id,Location__Latitude__s,Location__Longitude__s from Project_Site__c where id=:strPs]; 
       string id='/'+ps.id;
       ps.id = strPS;
       ps.Location__Latitude__s = Decimal.valueOf(pslat);
       ps.Location__Longitude__s = Decimal.valueOf(pslng);
       upsert ps; 
    }*/
    
    @RemoteAction
    global static void autoCheckInInfnc(string lat, string lon, string inflat, string inflng, String strInfName) {
       String strinf = strInfName; 
       Influencer__c inf=[select id,Location__Latitude__s,Location__Longitude__s from Influencer__c where id=:strinf]; 
       string id='/'+inf.id;
       inf.id = strinf;
       inf.Location__Latitude__s = Decimal.valueOf(inflat);
       inf.Location__Longitude__s = Decimal.valueOf(inflng);
       upsert inf; 
    }
    
    @RemoteAction
    global static void autoCheckInEvnt(string lat, string lon, string evntlat, string evntlng, String strEvntName) {
       String strEvnt = strEvntName; 
       Event__c evnt=[select id,Location__Latitude__s,Location__Longitude__s from Event__c where id=:strEvnt]; 
       string id='/'+evnt.id;
       evnt.id = strEvnt;
       evnt.Location__Latitude__s = Decimal.valueOf(evntlat);
       evnt.Location__Longitude__s = Decimal.valueOf(evntlng);
       upsert evnt; 
    }
    
    @RemoteAction
    global static void autoCheckInBP(string lat, string lon, string bplat, string bplng, String strBPName) {
       String strBP = strBPName; 
       Business_Partner__c bp=[select id,Geolocation__Latitude__s,Geolocation__Longitude__s from Business_Partner__c where id=:strBP]; 
       string id='/'+bp.id;
       bp.id = strBP;
       bp.Geolocation__Latitude__s = Decimal.valueOf(bplat);
       bp.Geolocation__Longitude__s = Decimal.valueOf(bplng);
       upsert bp; 
    }
    
    @RemoteAction
    global static void autoCheckInVisit(string vstlat, string vstlng, String strVstName) {
       String strVST = strVstName; 
       Visit__c vst = [select id,Visited_Location__Latitude__s,Visited_Location__Longitude__s from Visit__c where id=:strVST]; 
       string id='/'+vst.id;
       vst.id = strVstName;
       vst.Visited_Location__Latitude__s = Decimal.valueOf(vstlat);
       vst.Visited_Location__Longitude__s = Decimal.valueOf(vstlng);
       vst.Check_In__c = String.valueOf(system.now());
       vst.Check_Out__c = String.valueOf(system.now());
       upsert vst; 
    }
    
    @RemoteAction
    global static string autoCheckdistance(String chk,String lat,String lon,String strVtName) {
       System.debug('Inside visit remote action');
       DateTime dt = system.now();
       String day = dt.day() <= 9 && dt.day() >= 0 ? '0'+String.valueOf(dt.day()) : String.valueOf(dt.day());
       String month = dt.month() <= 9 && dt.month() >= 0 ? '0'+String.valueOf(dt.month()) : String.valueOf(dt.month());
       String year = String.valueof(dt.year());
       String hour = dt.hour() <= 9 && dt.hour() >= 0 ? '0'+String.valueOf(dt.hour()) : String.valueOf(dt.hour());
       String minute = dt.minute() <= 9 && dt.minute() >= 0 ? '0'+String.valueOf(dt.minute()) : String.valueOf(dt.minute());
       String second = dt.second() <= 9 && dt.second() >= 0 ? '0'+String.valueOf(dt.second()) : String.valueOf(dt.second());
       String strvt = strVtName; 
       Visit__c vst=[select id,Location__Latitude__s,Location__Longitude__s,Visited_Location__Longitude__s,Visited_Location__Latitude__s from Visit__c where id=:strvt]; 
       vst.Visited_Location__Latitude__s = Decimal.valueOf(lat);
       vst.Visited_Location__Longitude__s = Decimal.valueOf(lon);
       if(chk == 'Check In'){
           vst.Check_In__c = day + '/' + month + '/' + year + ' ' + hour + ':' + minute + ':' + second; 
       }
       if(chk == 'Check Out'){
           vst.Check_Out__c = day + '/' + month + '/' + year + ' ' + hour + ':' + minute + ':' + second; 
       }
       System.debug(vst.Check_In__c+'@@@'+vst.Check_Out__c);
       //vst.Check_In__c = String.valueOf(system.now());
       upsert vst;
       
       return strvt;
       /*string id='/'+bp.id;
       vst.Geolocation__Latitude__s = Decimal.valueOf(bplat);
       vst.Geolocation__Longitude__s = Decimal.valueOf(bplng);
       upsert vst; 
       
       system.debug('11111111'+lat);
       system.debug('22222222'+lon);
       system.debug('33333333'+vst.Location__Latitude__s);
       system.debug('44444444'+vst.Location__Longitude__s);
       Double dDepartLat = Double.valueOf(lat) * 3.14159 / 180;
        Double dDepartLong = Double.valueOf(lon) * 3.14159 / 180;
        Double dArrivalLat = vst.Location__Latitude__s * 3.14159 / 180;
        Double dArrivalLong = vst.Location__Longitude__s * 3.14159 / 180;
        
        Double dDeltaLong = dArrivalLong - dDepartLong;
        Double dDeltaLat = dArrivalLat - dDepartLat;
        
        // calculate angle using the haversine formula
        Double dHaversineResult = Math.Sin( dDeltaLat / 2 ) * Math.Sin( dDeltaLat / 2 ) 
                                  + Math.Cos( dDepartLat ) * Math.Cos( dArrivalLat ) 
                                    * Math.Sin( dDeltaLong / 2 ) * Math.Sin( dDeltaLong / 2 );
        
        // calculate distance by multiplying arc-tangent by the planet radius in miles
        Double dDistance = 1.60934 * 3958.76 * 2 * Math.Atan2( Math.Sqrt( dHaversineResult ), Math.Sqrt( 1 - dHaversineResult ) );
        
        System.debug('Distance = ' + dDistance);
        
        GeoTagging_Distance__c gtd = GeoTagging_Distance__c.getValues('Geo Tagging');
        
        System.debug('Configured Distance = ' +gtd.Distance__c);*/
    }
}