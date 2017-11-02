@RestResource(urlMapping='/InfluencerInsert/*')
global with sharing class InfluencerInsert{

  @HttpPost
    global static string doPost(InfluencerWrapper influencerWrapper,String userid) {
        Influencer__c inf = new Influencer__c();
        Schema.DescribeSObjectResult InfDest = Influencer__c.sObjectType.getDescribe();
        if(userId.startsWith(InfDest.getKeyPrefix())){
            inf = [SELECT Id,Name,Type__c,Account__c,Account__r.name,District__c,District__r.name,Inclination_to_JSW__c,
                            Phone__c,Email__c,Street__c,City__c,State_Province__c,Country__c,Zip_Postal_Code__c,No_of_sites_under_influencer__c,
                            Category__c,Volume_potential_in_MT__c,Site_Name__c,Site_Name__r.Name,Registered_with_JSW_ELP_program__c,Name_of_concerned_SO__c,
                            Name_of_concerned_SO__r.Name,Competitor_Brands__c,Contact_Person_1__c,Contact_Person_2__c,Contact_Person_3__c,
                            Contact_Email_1__c,Contact_Email_2__c,Contact_Email_3__c,Contact_Phone_1__c,Contact_Phone_2__c,Contact_Phone_3__c,
                            Contact_Role_1__c,Contact_Role_2__c,Contact_Role_3__c,ownerId,owner.name,Zone__c FROM Influencer__c where id =: userid];
            inf.Type__c = influencerWrapper.typeOfInfluencer;
            inf.Name = influencerWrapper.influencerName;
            inf.District__c = influencerWrapper.territory;
            inf.Phone__c = influencerWrapper.phone;
            inf.Email__c = influencerWrapper.email;
            inf.Street__c = influencerWrapper.street;
            inf.City__c = influencerWrapper.city;
            inf.State_Province__c = influencerWrapper.state;
            inf.Country__c = influencerWrapper.country;
            inf.Zip_Postal_Code__c = influencerWrapper.postalcode;
            inf.No_of_sites_under_influencer__c = influencerWrapper.sitecount;
            inf.Inclination_to_JSW__c = influencerWrapper.inclination;
            inf.Category__c = influencerWrapper.category;
            inf.Volume_potential_in_MT__c = influencerWrapper.volume;
            inf.Account__c = influencerWrapper.account;  
            inf.Site_Name__c = influencerWrapper.sitename;
            inf.Registered_with_JSW_ELP_program__c = influencerWrapper.isRegistered;
            inf.Name_of_concerned_SO__c = influencerWrapper.SOname;
            inf.Competitor_Brands__c = influencerWrapper.compbrands;
            inf.Contact_Person_1__c = influencerWrapper.person1;
            inf.Contact_Person_2__c = influencerWrapper.person2;
            inf.Contact_Person_3__c = influencerWrapper.person3;
            inf.Contact_Email_1__c = influencerWrapper.email1;
            inf.Contact_Email_2__c = influencerWrapper.email2;
            inf.Contact_Email_3__c = influencerWrapper.email3;
            inf.Contact_Phone_1__c = influencerWrapper.phone1;
            inf.Contact_Phone_2__c = influencerWrapper.phone2;
            inf.Contact_Phone_3__c = influencerWrapper.phone3;
            inf.Contact_Role_1__c = influencerWrapper.role1;
            inf.Contact_Role_2__c = influencerWrapper.role2;
            inf.Contact_Role_3__c = influencerWrapper.role3;
        } else {
            inf.Type__c = influencerWrapper.typeOfInfluencer;
            inf.Name = influencerWrapper.influencerName;
            inf.District__c = influencerWrapper.territory;
            inf.Phone__c = influencerWrapper.phone;
            inf.Email__c = influencerWrapper.email;
            inf.Street__c = influencerWrapper.street;
            inf.City__c = influencerWrapper.city;
            inf.State_Province__c = influencerWrapper.state;
            inf.Country__c = influencerWrapper.country;
            inf.Zip_Postal_Code__c = influencerWrapper.postalcode;
            inf.No_of_sites_under_influencer__c = influencerWrapper.sitecount;
            inf.Inclination_to_JSW__c = influencerWrapper.inclination;
            inf.Category__c = influencerWrapper.category;
            inf.Volume_potential_in_MT__c = influencerWrapper.volume;
            inf.Account__c = influencerWrapper.account;  
            inf.Site_Name__c = influencerWrapper.sitename;
            inf.Registered_with_JSW_ELP_program__c = influencerWrapper.isRegistered;
            inf.Name_of_concerned_SO__c = influencerWrapper.SOname;
            inf.Competitor_Brands__c = influencerWrapper.compbrands;
            inf.Contact_Person_1__c = influencerWrapper.person1;
            inf.Contact_Person_2__c = influencerWrapper.person2;
            inf.Contact_Person_3__c = influencerWrapper.person3;
            inf.Contact_Email_1__c = influencerWrapper.email1;
            inf.Contact_Email_2__c = influencerWrapper.email2;
            inf.Contact_Email_3__c = influencerWrapper.email3;
            inf.Contact_Phone_1__c = influencerWrapper.phone1;
            inf.Contact_Phone_2__c = influencerWrapper.phone2;
            inf.Contact_Phone_3__c = influencerWrapper.phone3;
            inf.Contact_Role_1__c = influencerWrapper.role1;
            inf.Contact_Role_2__c = influencerWrapper.role2;
            inf.Contact_Role_3__c = influencerWrapper.role3;
            inf.Location__Latitude__s = influencerWrapper.lat;
            inf.Location__Longitude__s = influencerWrapper.lon;
            inf.Ownerid = userid;
            insert inf;
            }
            return inf.id;
       }
       
       global class InfluencerWrapper{
           global String typeOfInfluencer {get; set;}
           global String influencerName {get; set;}
           String territory {get; set;}
           String phone {get; set;}
           String email {get; set;}
           String street {get; set;}
           String city {get; set;}
           String state {get; set;}
           String country {get; set;}
           String postalcode {get; set;}
           Double sitecount {get; set;}
           String inclination {get; set;}
           String category {get; set;}
           Double volume {get; set;}
           String account {get; set;}    
           String sitename {get; set;}
           String isRegistered {get; set;}
           String SOname {get; set;}
           String compbrands {get; set;}
           String person1 {get; set;}
           String person2 {get; set;}
           String person3 {get; set;}
           String email1 {get; set;}
           String email2 {get; set;}
           String email3 {get; set;}
           String phone1 {get; set;}
           String phone2 {get; set;}
           String phone3 {get; set;}
           String role1 {get; set;}
           String role2 {get; set;}
           String role3 {get; set;}
           Double lat {get; set;}
           Double lon {get; set;}
       }
}