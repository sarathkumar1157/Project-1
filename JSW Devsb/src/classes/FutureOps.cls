public class FutureOps{
    @Future
    public static void Geolocation(Set<String> mastermap){
        Schema.DescribeSObjectResult AccDest = Account.sObjectType.getDescribe();
        Schema.DescribeSObjectResult BPartDest = Business_Partner__c.sObjectType.getDescribe();
        Map<String,List<Double>> accmap = new Map<String,List<Double>>();
        Map<String,List<Double>> bpmap = new Map<String,List<Double>>();
        List<String> currentmap = new List<String>();
        List<Account> acclist = new List<Account>();
        List<Business_Partner__c> bplist = new List<Business_Partner__c>();
        List<Double> newcoord = new List<Double>();
        
        for(String masterid : mastermap){
            currentmap = masterid.split('@');
            if(currentmap[0].startswith(AccDest.getKeyPrefix()))
                accmap.put(currentmap[0],new List<Double>{Decimal.valueOf(currentmap[1]),Decimal.valueOf(currentmap[2])});
            else if(currentmap[0].startswith(BPartDest.getKeyPrefix()))
                bpmap.put(currentmap[0],new List<Double>{Decimal.valueOf(currentmap[1]),Decimal.valueOf(currentmap[2])});
        }
        acclist = [select id,name,Location__Latitude__s,Location__Longitude__s from Account where id in: accmap.keySet()];
        bplist = [select id,name,Geolocation__Latitude__s,Geolocation__Longitude__s from Business_Partner__c where id in: bpmap.keySet()];
        if(acclist.size()>0){
            for(Account acc : acclist){
                newcoord = accmap.get(acc.id);
                acc.Location__Latitude__s = newcoord[0];
                acc.Location__Longitude__s = newcoord[1];
            }
        }
        update acclist;
        if(bplist.size()>0){
            for(Business_Partner__c bp : bplist){
                newcoord = bpmap.get(bp.id);
                bp.Geolocation__Latitude__s = newcoord[0];
                bp.Geolocation__Longitude__s = newcoord[1];
            }
        }
        update bplist;
    }
    @Future
    public static void PlannedNames(Set<String> vids){
        set<String> accIds = new set<String>();
        set<String> LeadIds = new set<String>();
        set<String> TerritIds = new set<String>();
        set<String> PSIds = new set<String>();
        set<String> evntIds = new set<String>();
        set<String> InfIds = new set<String>();
        set<String> BPIds = new set<String>();
        set<String> DPIds = new set<String>();
        
        Map<Id,LIst<Double>> mapaddress = new Map<Id,List<Double>>();
        Map<Id,String> mapfields = new Map<Id,String>();
        
        List<Account> acclist = new List<Account>();
        List<Lead> leadlist = new List<Lead>();
        List<District__c> areaList = new List<District__c>();
        List<Project_Site__c> projectSiteList = new List<Project_Site__c>();
        List<Event__c> eventList = new List<Event__c>();
        List<Influencer__c> inList = new List<Influencer__c>();
        List<Business_Partner__c> busList = new List<Business_Partner__c>();
        List<Task> tsklist = new List<Task>();
        List<Day_Plan__c> dplist = new List<Day_Plan__c>();    
            
        List<Visit__c> vstlist = [select id,name,Day_Plan__c,Name__c,Planned_Date__c,Account__c,Lead__c,Territory__c,Project_Site__c,Influencer__c,Business_Partner__c,Depot__c,Event__c from Visit__c where id in: vids];
        String[] vnames = new List<String>();
        Integer size = 0;
        
        for(Visit__c vst : vstlist){
            DPIds.add(vst.Day_Plan__c);
            if(vst.Account__c != null){
                accIds.add(vst.Account__c);
            } else if(vst.Depot__c != null){
                accIds.add(vst.Depot__c);
            } else if(vst.Lead__c != null){
                LeadIds.add(vst.Lead__c);
            } else if(vst.Territory__c != null){
                TerritIds.add(vst.Territory__c);
            } else if(vst.Project_Site__c != null){
                PSIds.add(vst.Project_Site__c);
            } else if(vst.Event__c != null){
                evntIds.add(vst.Event__c);
            } else if(vst.Influencer__c != null){
                InfIds.add(vst.Influencer__c);
            } else if(vst.Business_Partner__c != null){
                BPIds.add(vst.Business_Partner__c);
            }
        }
        
        if(DPIds.size() > 0){
            dplist = [select id,name,Month_Plan__r.Status__c from Day_Plan__c where id in: DPIds];
            if(dplist.size() > 0){
                for(Day_Plan__c dp : dplist){
                    mapfields.put(dp.id,dp.Name+'@'+dp.Month_Plan__r.Status__c);
                }
            }
        }
        if(accIds.size() > 0){
            acclist = [select id,Location__Latitude__s,Location__Longitude__s,Carpet_Area_Sqft__c,Ideal_Storage_Capacity_MT__c from account where id in:accIds];
            if(acclist.size() > 0){
                for(Account acc : acclist){
                    //mapaddress.put(acc.id,acc.BillingStreet+', '+acc.BillingCity+', '+acc.BillingPostalCode+', '+acc.BillingCountry);
                    mapaddress.put(acc.id,new List<Double>{acc.Location__Latitude__s,acc.Location__Longitude__s,acc.Carpet_Area_Sqft__c,acc.Ideal_Storage_Capacity_MT__c});
                }
            }
        }
        
        if(LeadIds.size() > 0){
            leadlist = [select id,Location__Latitude__s,Location__Longitude__s,KYC_Form_Filled__c,Status,Type__c from Lead where id in:LeadIds];
            if(leadlist.size() > 0){
                for(Lead ld : leadlist){
                  //mapaddress.put(ld.id,ld.Street+', '+ld.City+', '+ld.PostalCode+', '+ld.Country);
                  mapaddress.put(ld.id,new List<Double>{ld.Location__Latitude__s,ld.Location__Longitude__s});
                  mapfields.put(ld.id,String.valueOf(ld.KYC_Form_Filled__c)+'@'+ld.Status+'@'+ld.Type__c);
                }
            }
        }
        
        if(TerritIds.size() > 0){
            areaList = [select id,Location__Latitude__s,Location__Longitude__s from District__c where id in:TerritIds];
            if(areaList.size() > 0){
                for(District__c ar : areaList){
                    //mapaddress.put(ar.id,ar.Billing_Street__c+', '+ar.Billing_City__c+', '+ar.Billing_Postal_Code__c+', '+ar.Billing_Country__c);
                    mapaddress.put(ar.id,new List<Double>{ar.Location__Latitude__s,ar.Location__Longitude__s});
                }
            }
        }
        
        if(PSIds.size() > 0){
            projectSiteList = [select id,Location__Latitude__s,Location__Longitude__s,Name,Type__c from Project_Site__c where id in:PSIds];
            if(projectSiteList.size() > 0){
                for(Project_Site__c ps : projectSiteList){
                    //mapaddress.put(ps.id,ps.Street__c+', '+ps.City__c+', '+ps.Zip_Postal_Code__c+', '+ps.State__c+', '+ps.Country__c);
                    mapaddress.put(ps.id,new List<Double>{ps.Location__Latitude__s,ps.Location__Longitude__s});
                    mapfields.put(ps.id,ps.Name+'@'+ps.Type__c);
                }
            }
        }
        
        if(evntIds.size() > 0){
          eventList = [select id,Location__Latitude__s,Location__Longitude__s from Event__c where id in:evntIds];
          if(eventlist.size() > 0){
              for(Event__c ev : eventlist){
                  //mapaddress.put(ev.id,ev.Street__c+', '+ev.City__c+', '+ev.Zip_Postal_Code__c+', '+ev.State_Province__c+', '+ev.Country__c);
                  mapaddress.put(ev.id,new List<Double>{ev.Location__Latitude__s,ev.Location__Longitude__s});
              }
          }
        }
        if(InfIds.size() > 0){
            inList = [select id,Location__Latitude__s,Location__Longitude__s,Type__c,Registered_with_JSW_ELP_program__c from Influencer__c where id in:InfIds];
            if(inList.size() > 0){
                for(Influencer__c inf : inList){
                    //mapaddress.put(inf.id,inf.Street__c+', '+inf.City__c+', '+inf.Zip_Postal_Code__c+', '+inf.State_Province__c+', '+inf.Country__c);
                    mapaddress.put(inf.id,new List<Double>{inf.Location__Latitude__s,inf.Location__Longitude__s});
                    mapfields.put(inf.id,inf.Type__c+'@'+inf.Registered_with_JSW_ELP_program__c);
                }
            }
        }
        if(BPIds.size() > 0){
            busList = [select id,Geolocation__Latitude__s,Geolocation__Longitude__s,City__c,Country__c,State_Province__c,Street__c,Zip_Postal_Code__c from Business_Partner__c where id in:BPIds];
            if(busList.size() > 0){
                for(Business_Partner__c bp : busList){
                    //mapaddress.put(bp.id,bp.Street__c+', '+bp.City__c+', '+bp.Zip_Postal_Code__c+', '+bp.State_Province__c+', '+bp.Country__c);
                    mapaddress.put(bp.id,new List<Double>{bp.Geolocation__Latitude__s,bp.Geolocation__Longitude__s});
                }
            }
        }
        
        for(Visit__c vst : vstlist){
            vnames = vst.Name.split(' ');
            size = vnames.size();
            if(size > 2){
                vst.Name = vst.Name__c + ' ' + vnames[size - 3] + ' ' + vnames[size - 2] + ' ' + vnames[size - 1];
            }
            if(vst.Day_Plan__c != null){
                vst.PJP_Month_Plan1__c = mapfields.get(vst.Day_Plan__c).split('@')[0];
                vst.PJP_Status1__c = mapfields.get(vst.Day_Plan__c).split('@')[1];
            }
            if(vst.Account__c != null){
                //vst.Address__c = mapaddress.get(vst.Account__c);
                vst.Location__Latitude__s = mapaddress.get(vst.Account__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Account__c)[1];
            } else if(vst.Depot__c != null){
                vst.Location__Latitude__s = mapaddress.get(vst.Depot__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Depot__c)[1];
                vst.Carpet_Area_Sqft1__c = mapaddress.get(vst.Depot__c)[2];
                vst.Ideal_Storage_Capacity_MT1__c = mapaddress.get(vst.Depot__c)[3];
            } else if(vst.Lead__c != null){
                //vst.Address__c = mapaddress.get(vst.Lead__c);
                vst.Location__Latitude__s = mapaddress.get(vst.Lead__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Lead__c)[1];
                if(mapfields.get(vst.Lead__c).split('@')[0] == 'true')
                vst.KYC_form_filled1__C = true;
                else
                vst.KYC_form_filled1__c = false;
                vst.Lead_Status1__c = mapfields.get(vst.Lead__c).split('@')[1];
                vst.Lead_Type1__c = mapfields.get(vst.Lead__c).split('@')[2];
            } else if(vst.Territory__c != null){
                //vst.Address__c = mapaddress.get(vst.Territory__c);
                vst.Location__Latitude__s = mapaddress.get(vst.Territory__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Territory__c)[1];
            } else if(vst.Project_Site__c != null){
                //vst.Address__c = mapaddress.get(vst.Project_Site__c);
                vst.Location__Latitude__s = mapaddress.get(vst.Project_Site__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Project_Site__c)[1];
                vst.Site_Name1__c = mapfields.get(vst.Project_Site__c).split('@')[0];
                vst.Site_Type1__c = mapfields.get(vst.Project_Site__c).split('@')[1];
            } else if(vst.Event__c != null){
                //vst.Address__c = mapaddress.get(vst.Event__c);
                vst.Location__Latitude__s = mapaddress.get(vst.Event__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Event__c)[1];
            } else if(vst.Influencer__c != null){
                //vst.Address__c = mapaddress.get(vst.Influencer__c);
                vst.Location__Latitude__s = mapaddress.get(vst.Influencer__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Influencer__c)[1];
                vst.Influencer_Type1__c = mapfields.get(vst.Influencer__c).split('@')[0];
                vst.Registered_with_JSW_ELP_program1__c = mapfields.get(vst.Influencer__c).split('@')[1];
            } else if(vst.Business_Partner__c != null){
                //vst.Address__c = mapaddress.get(vst.Business_Partner__c);
                vst.Location__Latitude__s = mapaddress.get(vst.Business_Partner__c)[0];
                vst.Location__Longitude__s = mapaddress.get(vst.Business_Partner__c)[1];
            }
        }
        update vstlist;
    }
}