global class RouteMapExtension {

    public RouteMapExtension(ApexPages.StandardController controller) {

    }
    
    @RemoteAction
    // Find warehouses nearest a geolocation
    global static List<Day_Plan__c> getDetails(String strId) {

        String queryString =
        'SELECT Id, Location__Latitude__s,Account__r.Name,Lead__r.Name,Name__c,Location__Longitude__s,Address__c ' +
           'FROM Visit__c WHERE Day_Plan__c  ='+ '\'' + strId + '\' Order By Planned_Date__c ASC';
                     
        System.debug('queryString = ' +queryString);
      //  List<Task> listt=database.Query(queryString);
        // Run and return the query results
        system.debug('*******List'+database.Query(queryString));
        return(database.Query(queryString));
    }


  @RemoteAction
    // Find warehouses nearest a geolocation
    global static List<Day_Plan__c> getDetailsBasedOnCreatedDate(String strId) {

        String queryString =
        'SELECT Id, Location__Latitude__s,Account__r.Name,Lead__r.Name,Name__c,Location__Longitude__s,Address__c ' +
           'FROM Visit__c WHERE   Day_Plan__c='+ '\'' + strId + '\' Order By Check_In__c ASC';
                     
        System.debug('queryString = ' +queryString);
        // Run and return the query results
        return database.Query(queryString);
    }


}