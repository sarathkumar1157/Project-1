trigger updateVisitAdress on Visit__c (before insert,before delete,after insert,after update) {
    if(trigger.isAfter && trigger.isUpdate){
        Set<String> masterids = new Set<String>();
        String currentid = '';
        System.debug('Inside after update');
        for(Visit__c vst : trigger.new){
            if(vst.Planned_Co_ordinates__c == true && vst.Visited_Location__Latitude__s != null && vst.Visited_Location__Longitude__s != null){
                currentid = currentid + String.valueOf(vst.Account__c != null ? String.valueOf(vst.Account__c) : '');
                currentid = currentid + String.valueOf(vst.Depot__c != null ? String.valueOf(vst.Depot__c) : '');
                currentid = currentid + String.valueOf(vst.Business_Partner__c != null ? String.valueOf(vst.Business_Partner__c) : '');
                System.debug(currentid+'@@@currentid');
                masterids.add(currentid+'@'+String.valueOf(vst.Visited_Location__Latitude__s)+'@'+String.valueOf(vst.Visited_Location__Longitude__s));
            }
            System.debug('masterids: @@@'+masterids);
            if(!masterids.isEmpty())
            FutureOps.GeoLocation(masterids);
        }
    }
    if(trigger.isAfter && trigger.isInsert){
        Set<String> vpids = new Set<String>();
        for(Visit__c vst : trigger.new){
            if(vst.Planned__c == true)
            vpids.add(vst.id);
        }
        if(!vpids.isEmpty())
        FutureOps.PlannedNames(vpids);
    }
    if(trigger.isBefore){
        if(trigger.isdelete){
            Set<String> vstids = new Set<String>();
            List<Visit__c> vstlist = new List<Visit__c>();
            String ownername = '';
            
            for(Visit__c vst : trigger.old){
                vstids.add(vst.Parent_Visit__c);
                ownername = vst.Ownerid;
            }
            User usr = [select id,name from User where id =: ownername];
            ownername = usr.name;
            vstlist = [select id,name,Attendees__c from Visit__c where id in: vstids];
            for(Visit__c vst : vstlist){
                if(vst.Attendees__c.contains(ownername+', ')){
                    vst.Attendees__c = vst.Attendees__c.replace(ownername+', ','');
                } else if(vst.Attendees__c.contains(ownername)){
                    vst.Attendees__c = vst.Attendees__c.replace(ownername,'');
                }
            }
            update vstlist;
        }
        if(trigger.isinsert){
            Map<Integer,String> monthmap = new Map<Integer,String>();
            String vname = '';
            
            monthmap.put(1,'January');
            monthmap.put(2,'February');
            monthmap.put(3,'March');
            monthmap.put(4,'April');
            monthmap.put(5,'May');
            monthmap.put(6,'June');
            monthmap.put(7,'July');
            monthmap.put(8,'August');
            monthmap.put(9,'September');
            monthmap.put(10,'October');
            monthmap.put(11,'November');
            monthmap.put(12,'December');
            
            for(Visit__c vst:trigger.new){
                if(vst.Planned__c == false){
                    if(vst.Planned_Date__c == null)
                        vst.Planned_Date__c = system.today();
                    if(vst.Name__c != null){
                        vname = vst.Name__c + ' ' + UserInfo.getLastName() + ' ' + vst.Planned_Date__c.day() + ' ' + monthmap.get(vst.Planned_Date__c.month()) + ' ' + vst.Planned_Date__c.year();
                    }
                    if(vst.Name != vname)
                        vst.Name = vname;
                    if(vst.Planned_Date__c != null && vst.Start__c == null && vst.End__c == null){
                        vst.Start__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),vst.Planned_Date__c.day(),9,0,0);
                        vst.End__c = DateTime.newInstance(vst.Planned_Date__c.year(),vst.Planned_Date__c.month(),vst.Planned_Date__c.day(),10,0,0);
                    }
                }
                if(vst.Depot_Visit__c == true){
                    vst.Depot__c = vst.Account__c;
                    vst.Account__c = null;
                }
                try{
                    if(vst.Day_Plan__c == null && vst.Planned_Date__c!=null && vst.Month_Plan__c == null){
                        Day_Plan__c dplan = [select id,name from Day_Plan__c where Date__c =: vst.Planned_Date__c and Ownerid =: vst.Ownerid];
                        if(dplan.id!=null)
                        vst.Day_Plan__c = dplan.id;
                    }
                }catch(Exception ex){
                    vst.adderror('PJP does not exist for the selected date');
                }
            }    
        }
    }
}