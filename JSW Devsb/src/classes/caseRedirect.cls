public with sharing class caseRedirect {

private ApexPages.StandardController controller;
public String retURL {get; set;}
public String saveNewURL {get; set;}
public String rType {get; set;}
public String cancelURL {get; set;}
public String ent {get; set;}
public String confirmationToken {get; set;}
public String usrId {get; set;}
//public String accountID {get; set;}
//public String contactID {get; set;}

public caseRedirect(ApexPages.StandardController controller) {

  this.controller = controller;
    usrId = [Select id,Division from User where id=:UserInfo.getUserId()].Division;
    retURL = ApexPages.currentPage().getParameters().get('retURL');
    rType = ApexPages.currentPage().getParameters().get('RecordType');
    cancelURL = ApexPages.currentPage().getParameters().get('cancelURL');
    ent = ApexPages.currentPage().getParameters().get('ent');
    confirmationToken = ApexPages.currentPage().getParameters().get('_CONFIRMATIONTOKEN');
    saveNewURL = ApexPages.currentPage().getParameters().get('save_new_url');
    //accountID = ApexPages.currentPage().getParameters().get('def_account_id');
    //contactID = ApexPages.currentPage().getParameters().get('def_contact_id');

}

public PageReference redirect() {

    PageReference returnURL;

    // Redirect if Record Type corresponds to custom VisualForce page

    IF(usrId != 'Institutional Sales') {

        returnURL = new PageReference('/apex/NewMonthTarget');

    }

    ELSE {

        returnURL = new PageReference('/a0R/e?nooverride=1');
        //return null;
        //return new PageReference('/a01/e?nooverride=1');

    }

   /* returnURL.getParameters().put('retURL', retURL);
    returnURL.getParameters().put('RecordType', rType);
    returnURL.getParameters().put('cancelURL', cancelURL);
    returnURL.getParameters().put('ent', ent);
    returnURL.getParameters().put('_CONFIRMATIONTOKEN', confirmationToken);
    returnURL.getParameters().put('save_new_url', saveNewURL);
    returnURL.getParameters().put('nooverride', '1');
 */
    /*IF (accountID != null){

        returnURL.getParameters().put('def_account_id', accountID);

    }

    IF (contactID != null){

        returnURL.getParameters().put('def_contact_id', contactID);

    } */

    returnURL.setRedirect(true);
    return returnURL;
}
}