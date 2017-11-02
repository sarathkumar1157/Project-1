public class mktInfo 
{
    @AuraEnabled
    public static list<Market_Information__c> getRecord(string id1)
    {
        return [select id,name,Account__r.Name,Visit__r.Name,Lead__r.Name,Business_Partner__r.Name,Influencer__r.Name,Sites__r.Name,Product__r.Group__c,Comments__c,JSW_BP_Min__c,JSW_WSP_Min__c,JSW_WSP_Max__c,JSW_RSP_Min__c,JSW_RSP_Max__c,JSW_Average_Monthly_Volume__c from Market_Information__c where id=:id1];
    }
    @AuraEnabled
    public static list<Marketing_Info__c> getChdRecord(string id1)
    {
        return [select id,name,Account__r.Name,Business_Partner__r.Name,Influencer__r.Name,Sites__r.Name,BP_Min__c,Products__c,Brand__r.Name,Market_Information__r.Name,RSP_Max__c,RSP_Min__c,WSP_Max__c,WSP_Min__c from Marketing_Info__c where Market_Information__c=:id1];
    }
    @AuraEnabled
    public static list<mktinfowrapper> getAllwraps()
    {
        List<Marketing_Info__c> mkt = new List<Marketing_Info__c>();
        List<mktinfowrapper> mktwrap = new List<mktinfowrapper>();
        for(integer i=0;i<4;i++)
        {
            mktinfowrapper miw = new mktinfowrapper();
            mktwrap.add(miw);
        }
        return mktwrap;
    }
    @AuraEnabled
    public static list<Account> getAllAccounts(String idst)
    {
        if(idst == null)
            return [select id, name from Account where ownerID = :UserInfo.getUserId() Order By Name];
        else
            return [select id, name from Account where id=:idst]; 
    }
    @AuraEnabled
    public static list<District__c> getAllters()
    {
        return [select id, name from District__c Order By Name];
    }
    @AuraEnabled
    public static list<Brand__c> getAllBrands()
    {
        return [select id, name from Brand__c Order By Name];
    }
    @AuraEnabled
    public static list<Lead> getAllLeads(String idst)
    {
        system.debug('idst'+idst);
        if(idst == null)
            return [select id, name from Lead Order By Name];
        else
            return [select id, name from Lead where id=:idst]; 
    }
    @AuraEnabled
    public static list<Business_Partner__c> getAllbnspartns(String idst)
    {
        system.debug('idst'+idst);
        if(idst == null)
            return [select id, name from Business_Partner__c Order By Name];
        else
            return [select id, name from Business_Partner__c where id=:idst]; 
    }
    @AuraEnabled
    public static list<Influencer__c> getAllInfs(String idst)
    {
        system.debug('idst'+idst);
        if(idst == null)
            return [select id, name from Influencer__c Order By Name];
        else
            return [select id, name from Influencer__c where id=:idst]; 
    }
    @AuraEnabled
    public static list<Project_Site__c> getAllpjtsites(String idst)
    {
        system.debug('idst'+idst);
        if(idst == null)
            return [select id, name from Project_Site__c Order By Name];
        else
            return [select id, name from Project_Site__c where id=:idst]; 
    }
    @AuraEnabled
    public static list<Product2> getAllProducts()
    {
        list<Product2> prdlist = [select id,Group__c from Product2 Order By Name];
        map<String,Product2> prdmap = new map<String,Product2>();
        for(Product2 pd : prdlist)
            prdmap.put(pd.Group__c,pd);
        
        list<Product2> prdlst = new list<Product2>();
        for(String str:prdmap.keySet())
            prdlst.add(prdmap.get(str));
        return prdlst;
    }
    @AuraEnabled
    public static list<sObject> getAllVsts(String idst)
    {
        System.debug('----'+idst);
        if(idst == null)
            return null;
        else
        {
            Visit__c vst = [select id, name,Account__c,Lead__c,Business_Partner__c,Influencer__c,Project_Site__c from Visit__c Where id=:idst limit 1];
            if(vst.Account__c != null)
            {
                List<Account> ac = [select id, name from Account where id=:vst.Account__c];
                return ac;
            }
            else if(vst.Lead__c != null)
            {
                List<Lead> ld = [select id, name from Lead where id=:vst.Lead__c];
                return ld;
            }
            else if(vst.Business_Partner__c!= null)
            {
                List<Business_Partner__c> bp = [select id, name from Business_Partner__c where id=:vst.Business_Partner__c];
                return bp;
            }
            else if(vst.Influencer__c != null)
            {
                List<Influencer__c> inf = [select id, name from Influencer__c where id=:vst.Influencer__c];
                return inf;
            }
            else if(vst.Project_Site__c != null)
            {
                List<Project_Site__c> ps = [select id, name from Project_Site__c where id=:vst.Project_Site__c];
                return ps;
            }
            else
                return null;
        }   
    }
    @AuraEnabled
    public Static String getSave(Market_Information__c mktinfo,string newmkinfo,String acid,String ldid,String vstid,string bpid,String psid,String infid)
    {
        system.debug('--acid1--'+mktinfo.Lead__c);
        system.debug('--ldid1--'+mktinfo.Account__c);
        system.debug('--mktinfo--'+mktinfo);
        /*if(acid!=null)
            mktinfo.Account__c = acid;
        if(ldid!=null)
            mktinfo.Lead__c = ldid;*/
        if(!String.isBlank(vstid))
        {
            Visit__c vst = [select id, name,Account__c,Lead__c,Business_Partner__c,Influencer__c,Project_Site__c from Visit__c Where id=:vstid limit 1];
            if(vst.Account__c != null)
            {
                Account ac = [select id, name from Account where id=:vst.Account__c];
                mktinfo.Account__c = ac.id;
            }
            else if(vst.Lead__c != null)
            {
                Lead ld = [select id, name from Lead where id=:vst.Lead__c];
                mktinfo.Lead__c = ld.id;
            }
            else if(vst.Business_Partner__c!= null)
            {
                Business_Partner__c bp = [select id, name from Business_Partner__c where id=:vst.Business_Partner__c];
                mktinfo.Business_Partner__c = bp.id;
            }
            else if(vst.Influencer__c != null)
            {
                Influencer__c inf = [select id, name from Influencer__c where id=:vst.Influencer__c];
                mktinfo.Influencer__c = inf.id;
            }
            else if(vst.Project_Site__c != null)
            {
                Project_Site__c ps = [select id, name from Project_Site__c where id=:vst.Project_Site__c];
                mktinfo.Sites__c = ps.id;
            }
        }
        if(!String.isBlank(bpid))
            mktinfo.Business_Partner__c = bpid;
        if(!String.isBlank(psid))
            mktinfo.Sites__c = psid;
        if(!String.isBlank(infid))
            mktinfo.Influencer__c = infid;
        if(!(String.isBlank(mktinfo.Account__c) && String.isBlank(mktinfo.Lead__c) && String.isBlank(mktinfo.Business_Partner__c) && String.isBlank(mktinfo.Sites__c) && String.isBlank(mktinfo.Influencer__c)))
        {
            try
            {
                system.debug('--true--');
                insert mktinfo;
                system.debug('-----'+mktinfo.id);
                system.debug('-----'+newmkinfo);
                List<Marketing_Info__c> insertmi = new List<Marketing_Info__c>();
                mktinfowrapper[] values = (List<mktinfowrapper>) JSON.deserialize(newmkinfo,List<mktinfowrapper>.Class);
                system.debug('---values--'+values);
                for(mktinfowrapper wl:values)
                {
                    if(wl.Brand != null && wl.Brand != '')
                    {
                        system.debug('---values--'+wl.Brand);
                        Marketing_Info__c mi = new Marketing_Info__c();
                        mi.Market_Information__c = mktinfo.Id;
                        mi.Account__c=mktinfo.Account__c;
                        mi.Business_Partner__c = mktinfo.Business_Partner__c;
                        mi.Sites__c = mktinfo.Sites__c;
                        mi.Influencer__c = mktinfo.Influencer__c;
                        mi.Brand__c = wl.Brand;
                        mi.Products__c = wl.Product;
                        mi.BP_Min__c = wl.BPMin;
                        
                        mi.RSP_Min__c = wl.RSP;
                        
                        mi.WSP_Min__c = wl.WSP;
                        insertmi.add(mi);   
                    }
                }        
                insert insertmi;
                return 'success';
            }
            catch(exception e)
            {
                return e.getMessage();
            }
        }
        else
        {
            return 'Select Account or Lead to Save a record';
        }
    }
    //------------------Edit Market Info----------------//
    @AuraEnabled
    public static list<Marketing_Info__c> getallMi(String acnt,String tdate)
    {
        return [select id,name,Account__c,Business_Partner__r.Name,Influencer__r.Name,Sites__r.Name,Business_Partner__c,Influencer__c,Sites__c,Brand__c,Brand__r.name,RSP_Max__c,RSP_Min__c,WSP_Max__c,WSP_Min__c,BP_Min__c from Marketing_Info__c where Account__c =:acnt and DAY_ONLY(CreatedDate) =:date.valueof(tdate)];
    }
    @AuraEnabled
    public static list<Market_Information__c> getallMijsw(String acnt,String tdate)
    {
        return [select id,name,Account__c,Account__r.Name,Business_Partner__r.Name,Influencer__r.Name,Sites__r.Name,Business_Partner__c,Influencer__c,Sites__c,Comments__c,JSW_Average_Monthly_Volume__c,JSW_BP_Min__c,JSW_RSP_Max__c,JSW_RSP_Min__c,JSW_WSP_Max__c,JSW_WSP_Min__c,Product__c,Visit__c,Territory__c from Market_Information__c where Account__c =:acnt and DAY_ONLY(CreatedDate) =:date.valueof(tdate)];
    }
    @AuraEnabled
    public static void saveEdit(String mkinf,String mkjsw)
    {
        Marketing_Info__c[] values = (List<Marketing_Info__c>) JSON.deserialize(mkinf,List<Marketing_Info__c>.Class);
        Market_Information__c[] values1 = (List<Market_Information__c>) JSON.deserialize(mkjsw,List<Market_Information__c>.Class);
        update values;
        update values1;
    }
}