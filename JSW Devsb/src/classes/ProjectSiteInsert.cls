@RestResource(urlMapping='/ProjectSiteInsert/*')
global with sharing class ProjectSiteInsert{
    @HttpPost
    global static string doPost(ProjectSitesWraper projectSitesWraper,String userid) {
        Project_Site__c prj = new Project_Site__c();
        Schema.DescribeSObjectResult PrjDest = Project_Site__c.sObjectType.getDescribe();
        if(userId.startsWith(PrjDest.getKeyPrefix())){
            prj = [SELECT Id,Name,Account__c,Account__r.name,Type__c,Territory__c,Territory__r.name,ownerId,owner.name,
                   End_Customer_Name__c,Phone_Number__c,Site_Sub_Type__c,Product__c,Product_Quantity_Required__c,Site_Status__c,
                   Location__c,Customer_Email__c,Street__c,City__c,State__c,Country__c,Zip_Postal_Code__c,Engineer__c,Architect__c,
                   Structural_Consultant__c,JSW_Cement_Approval__c,Volume_Potential_in_MT__c,Construction_Stage__c,Project_Start_Date__c,
                   Project_End_Date__c,Competitor_Brands__c,Name_of_Concerned_SO__c,Name_of_Concerned_SO__r.Name,Contact_Person_1__c,
                   Contact_Person_2__c,Contact_Person_3__c,Contact_Email_1__c,Contact_Email_2__c,Contact_Email_3__c,Contact_Phone_1__c,
                   Contact_Phone_2__c,Contact_Phone_3__c,Contact_Role_1__c,Contact_Role_2__c,Contact_Role_3__c,Location__Latitude__s,
                   Location__Longitude__s FROM Project_Site__c where id =: userid];
            prj.name = projectSitesWraper.projectSiteName;
            prj.Type__c = projectSitesWraper.type;
            prj.Site_Sub_Type__c = projectSitesWraper.subtype;
            prj.Territory__c = projectSitesWraper.district;
            prj.Account__c = projectSitesWraper.account;
            prj.End_Customer_Name__c = projectSitesWraper.customername;
            prj.Phone_Number__c = projectSitesWraper.phone;
            prj.Customer_Email__c = projectSitesWraper.customeremail;
            prj.Street__c = projectSitesWraper.street;
            prj.City__c = projectSitesWraper.city;
            prj.State__c = projectSitesWraper.state;
            prj.Country__c = projectSitesWraper.country;
            prj.Zip_Postal_Code__c = projectSitesWraper.postalcode;
            if(projectSitesWraper.engineer != null)
            prj.Engineer__c = projectSitesWraper.engineer;
            if(projectSitesWraper.architect != null)
            prj.Architect__c = projectSitesWraper.architect;
            if(projectSitesWraper.stconsultant != null)
            prj.Structural_Consultant__c = projectSitesWraper.stconsultant;
            prj.JSW_Cement_Approval__c = projectSitesWraper.approval;
            prj.Volume_Potential_in_MT__c = projectSitesWraper.volume;
            prj.Construction_Stage__c = projectSitesWraper.stage;
            prj.Project_Start_Date__c = projectSitesWraper.startdt;
            prj.Project_End_Date__c = projectSitesWraper.enddt;
            prj.Competitor_Brands__c = projectSitesWraper.compbrands;
            prj.Name_of_Concerned_SO__c = projectSitesWraper.SOname;
            prj.Contact_Person_1__c = projectSitesWraper.person1;
            prj.Contact_Person_2__c = projectSitesWraper.person2;
            prj.Contact_Person_3__c = projectSitesWraper.person3;
            prj.Contact_Email_1__c = projectSitesWraper.email1;
            prj.Contact_Email_2__c = projectSitesWraper.email2;
            prj.Contact_Email_3__c = projectSitesWraper.email3;
            prj.Contact_Phone_1__c = projectSitesWraper.phone1;
            prj.Contact_Phone_2__c = projectSitesWraper.phone2;
            prj.Contact_Phone_3__c = projectSitesWraper.phone3;
            prj.Contact_Role_1__c = projectSitesWraper.role1;
            prj.Contact_Role_2__c = projectSitesWraper.role2;
            prj.Contact_Role_3__c = projectSitesWraper.role3;
            update prj;
        } else {
            prj = new Project_Site__c();
            prj.name = projectSitesWraper.projectSiteName;
            prj.Type__c = projectSitesWraper.type;
            prj.Site_Sub_Type__c = projectSitesWraper.subtype;
            prj.Territory__c = projectSitesWraper.district;
            prj.Account__c = projectSitesWraper.account;
            prj.End_Customer_Name__c = projectSitesWraper.customername;
            prj.Phone_Number__c = projectSitesWraper.phone;
            prj.Customer_Email__c = projectSitesWraper.customeremail;
            prj.Street__c = projectSitesWraper.street;
            prj.City__c = projectSitesWraper.city;
            prj.State__c = projectSitesWraper.state;
            prj.Country__c = projectSitesWraper.country;
            prj.Zip_Postal_Code__c = projectSitesWraper.postalcode;
            if(projectSitesWraper.engineer != null)
            prj.Engineer__c = projectSitesWraper.engineer;
            if(projectSitesWraper.architect != null)
            prj.Architect__c = projectSitesWraper.architect;
            if(projectSitesWraper.stconsultant != null)
            prj.Structural_Consultant__c = projectSitesWraper.stconsultant;
            prj.JSW_Cement_Approval__c = projectSitesWraper.approval;
            prj.Volume_Potential_in_MT__c = projectSitesWraper.volume;
            prj.Construction_Stage__c = projectSitesWraper.stage;
            prj.Project_Start_Date__c = projectSitesWraper.startdt;
            prj.Project_End_Date__c = projectSitesWraper.enddt;
            prj.Competitor_Brands__c = projectSitesWraper.compbrands;
            prj.Name_of_Concerned_SO__c = projectSitesWraper.SOname;
            prj.Contact_Person_1__c = projectSitesWraper.person1;
            prj.Contact_Person_2__c = projectSitesWraper.person2;
            prj.Contact_Person_3__c = projectSitesWraper.person3;
            prj.Contact_Email_1__c = projectSitesWraper.email1;
            prj.Contact_Email_2__c = projectSitesWraper.email2;
            prj.Contact_Email_3__c = projectSitesWraper.email3;
            prj.Contact_Phone_1__c = projectSitesWraper.phone1;
            prj.Contact_Phone_2__c = projectSitesWraper.phone2;
            prj.Contact_Phone_3__c = projectSitesWraper.phone3;
            prj.Contact_Role_1__c = projectSitesWraper.role1;
            prj.Contact_Role_2__c = projectSitesWraper.role2;
            prj.Contact_Role_3__c = projectSitesWraper.role3;
            prj.Location__Latitude__s = projectSitesWraper.lat;
            prj.Location__Longitude__s = projectSitesWraper.lon;
            prj.Ownerid = userid;
            insert prj;
        }
        return prj.id;
    }
       
    global class ProjectSitesWraper {
       global String projectSiteName {get; set;}
        global String type {get; set;}
        String subtype {get; set;}
        String district {get; set;}
        String account {get; set;}
        global String customername {get; set;}
        String phone {get; set;}
        String customeremail {get; set;}
        String street {get; set;}
        String city {get; set;}
        String state {get; set;}
        String country {get; set;}
        String postalcode {get; set;}
        String engineer {get; set;}
        String architect {get; set;}
        String stconsultant {get; set;}
        global Boolean approval {get; set;}
        Double volume {get; set;}
        String stage {get; set;}
        Date startdt {get; set;}
        Date enddt {get; set;}
        String compbrands {get; set;}
        String SOname {get; set;}
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