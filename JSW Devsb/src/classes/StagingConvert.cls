public class StagingConvert{
    public Schema.DescribeSObjectResult LeadDest {get; set;}
    public Schema.DescribeSObjectResult AccDest {get; set;}
    public Schema.DescribeSObjectResult BPartDest {get; set;}
    public Schema.DescribeSObjectResult PSiteDest {get; set;}
    public Schema.DescribeSObjectResult InfluDest {get; set;}
    public Schema.DescribeSObjectResult VisitDest {get; set;}
    public String qry {get; set;}
    public List<Staging__c> stglist {get; set;}
    public Visit__c vst {get; set;}
    
    public StagingConvert(String wherecon){
        LeadDest = Lead.sObjectType.getDescribe();
        AccDest = Account.sObjectType.getDescribe();
        BPartDest = Business_Partner__c.sObjectType.getDescribe();
        PSiteDest = Project_Site__c.sObjectType.getDescribe();
        InfluDest = Influencer__c.sObjectType.getDescribe();
        VisitDest = Visit__c.sObjectType.getDescribe();
        
        qry = 'select id, Name, Planned__c, External_Master_Id__c, External_Visit_Id__c, userid__c, Visit_Id__c,Damaged_Cement_MT_for_PSC__c, Planned_Date__c, Master__c, Ownerid, Purpose_of_Visit__c, Remarks__c, JSW_Shop_Board_Condition__c, JSW_Bag_Visibility__c, JSW_stock_level_number_of_bags__c, Payment_collected_in_current_visit__c, Pending_Payment_Committed_Date__c, Any_image_to_be_captured__c, If_Potential_Lead_Share_with_Manager__c, Visit_by_TSO_LATF__c, LATF_Name__c, Activity_Type__c, Activity_Sub_Type__c, Site_demo_type__c, Construction_Stage__c, Date_of_Inspection__c, Previous_Inspection__c, Product__c, Godown_stock_MT_for_CHD__c, Godown_stock_MT_for_composite_Cement__c, Godown_stock_MT_for_OPC__c, Godown_stock_MT_for_PSC__c, Godown_Stock_as_on_Month_end_MT_for_CHD__c, Godown_Stock_as_on_Month_end_MT_for_CC__c, Godown_Stock_as_on_Month_end_MT_PSC__c, Godown_Stock_as_on_Month_end_MT_for_OPC__c, Damaged_Cement_MT_for_CC__c, Damaged_Cement_MT_for_CHD__c, Damaged_Cement_MT_for_OPC__c, Damage_Stock_Ageing_for_CC__c, Damage_Stock_Ageing_for_CHD__c, Damage_Stock_Ageing_for_OPC__c, Damage_Stock_Ageing_for_PSC__c, Good_Stock_Ageing_for_CC__c, Good_Stock_Ageing_for_CHD__c, Good_Stock_Ageing_for_OPC__c, Good_Stock_Ageing_for_PSC__c, Condition_of_Godown__c, Seggregation_of_good_damaged_cement__c, Stacking_pattern_As_per_ISP__c, F_I_F_O_movement__c, Check_In__c, Check_Out__c, Visited_Location__Latitude__s, Visited_Location__Longitude__s from Staging__c where Converted__c = false and ';
        qry = qry + wherecon;
        stglist = Database.query(qry);
        
        for(Staging__c stg : stglist){
            if(stg.userid__c.startsWith(VisitDest.getKeyPrefix())){
                try{
                    vst = [select id,Purpose_of_Visit__c,Remarks__c,JSW_Shop_Board_Condition__c,JSW_Bag_Visibility__c,Stock_level_JSW__c,
                               Payment_Amount_Collected_by_SO__c,Pending_Payment_Amount_Committed_Date__c,Any_image_to_be_captured__c,
                               If_Potential_Lead_Share_with_Manager__c,Visit_by_TSO_LATF__c,Visited_Location__Latitude__s,Site_demo_type__c,
                               LATF_Name__c,Construction_Stage__c,Date_of_Inspection__c,Previous_Inspection__c,Check_In__c,Check_Out__c,
                               Godown_stock_MT_for_CHD__c,Godown_stock_MT_for_composite_Cement__c,Godown_stock_MT_for_OPC__c,Product__c,
                               Godown_stock_MT_for_PSC__c,Godown_Stock_on_Month_end_MT_for_CHD__c,Godown_Stock_as_on_Month_end_MT_for_CC__c,
                               Godown_Stock_as_on_Month_end_MT_for_PSC__c,Godown_Stock_as_on_Month_end_MT_for_OPC__c,Damaged_Cement_MT_for_CC__c,
                               Damaged_Cement_MT_for_CHD__c,Damaged_Cement_MT_for_OPC__c,Damaged_Cement_MT_for_PSC__c,Damage_Stock_Ageing_for_CC__c,
                               Damage_Stock_Ageing_for_CHD__c,Damage_Stock_Ageing_for_OPC__c,Activity_Type__c,Visited_Location__Longitude__s,
                               Damage_Stock_Ageing_for_PSC__c,Good_Stock_Ageing_for_CC__c,Good_Stock_Ageing_for_CHD__c,Activity_Sub_Type__c,
                               Good_Stock_Ageing_for_OPC__c,Good_Stock_Ageing_for_PSC__c,Condition_of_Godown__c,Seggregation_of_good_damaged_cement__c,
                               Stacking_pattern_As_per_ISP__c,F_I_F_O_movement__c,Offline_App_CheckIn__c from Visit__c where id =: stg.userid__c];
                    vst.Offline_App__c = true;
                    vst.Purpose_of_Visit__c = stg.Purpose_of_Visit__c;
                    vst.Remarks__c = stg.Remarks__c;
                    vst.JSW_Shop_Board_Condition__c = stg.JSW_Shop_Board_Condition__c;
                    vst.JSW_Bag_Visibility__c = stg.JSW_Bag_Visibility__c;
                    vst.Stock_level_JSW__c = stg.JSW_stock_level_number_of_bags__c;
                    vst.Payment_Amount_Collected_by_SO__c = stg.Payment_collected_in_current_visit__c;
                    vst.Pending_Payment_Amount_Committed_Date__c = stg.Pending_Payment_Committed_Date__c;
                    vst.Any_image_to_be_captured__c = stg.Any_image_to_be_captured__c;
                    vst.If_Potential_Lead_Share_with_Manager__c = stg.If_Potential_Lead_Share_with_Manager__c;
                    vst.Visit_by_TSO_LATF__c = stg.Visit_by_TSO_LATF__c;
                    vst.LATF_Name__c = stg.LATF_Name__c;
                    vst.Activity_Type__c = stg.Activity_Type__c;
                    vst.Activity_Sub_Type__c = stg.Activity_Sub_Type__c;
                    vst.Site_demo_type__c = stg.Site_demo_type__c;
                    vst.Construction_Stage__c = stg.Construction_Stage__c;
                    vst.Date_of_Inspection__c = stg.Date_of_Inspection__c;
                    vst.Previous_Inspection__c = stg.Previous_Inspection__c;
                    if(stg.Product__c != null){
                        if(stg.Product__c.contains(','))
                        vst.Product__c = stg.Product__c.replace(',',';');
                        else
                        vst.Product__c = stg.Product__c;
                    }
                    vst.Godown_stock_MT_for_CHD__c = stg.Godown_stock_MT_for_CHD__c;
                    vst.Godown_stock_MT_for_composite_Cement__c = stg.Godown_stock_MT_for_composite_Cement__c;
                    vst.Godown_stock_MT_for_OPC__c = stg.Godown_stock_MT_for_OPC__c;
                    vst.Godown_stock_MT_for_PSC__c = stg.Godown_stock_MT_for_PSC__c;
                    vst.Godown_Stock_on_Month_end_MT_for_CHD__c = stg.Godown_Stock_as_on_Month_end_MT_for_CHD__c;
                    vst.Godown_Stock_as_on_Month_end_MT_for_CC__c = stg.Godown_Stock_as_on_Month_end_MT_for_CC__c;
                    vst.Godown_Stock_as_on_Month_end_MT_for_PSC__c = stg.Godown_Stock_as_on_Month_end_MT_PSC__c;
                    vst.Godown_Stock_as_on_Month_end_MT_for_OPC__c = stg.Godown_Stock_as_on_Month_end_MT_for_OPC__c;
                    vst.Damaged_Cement_MT_for_CC__c = stg.Damaged_Cement_MT_for_CC__c;
                    vst.Damaged_Cement_MT_for_CHD__c = stg.Damaged_Cement_MT_for_CHD__c;
                    vst.Damaged_Cement_MT_for_OPC__c = stg.Damaged_Cement_MT_for_OPC__c;
                    vst.Damaged_Cement_MT_for_PSC__c = stg.Damaged_Cement_MT_for_PSC__c;
                    vst.Damage_Stock_Ageing_for_CC__c = stg.Damage_Stock_Ageing_for_CC__c;
                    vst.Damage_Stock_Ageing_for_CHD__c = stg.Damage_Stock_Ageing_for_CHD__c;
                    vst.Damage_Stock_Ageing_for_OPC__c = stg.Damage_Stock_Ageing_for_OPC__c;
                    vst.Damage_Stock_Ageing_for_PSC__c = stg.Damage_Stock_Ageing_for_PSC__c;
                    vst.Good_Stock_Ageing_for_CC__c = stg.Good_Stock_Ageing_for_CC__c;
                    vst.Good_Stock_Ageing_for_CHD__c = stg.Good_Stock_Ageing_for_CHD__c;
                    vst.Good_Stock_Ageing_for_OPC__c = stg.Good_Stock_Ageing_for_OPC__c;
                    vst.Good_Stock_Ageing_for_PSC__c = stg.Good_Stock_Ageing_for_PSC__c;
                    vst.Condition_of_Godown__c = stg.Condition_of_Godown__c;
                    vst.Seggregation_of_good_damaged_cement__c = stg.Seggregation_of_good_damaged_cement__c;
                    vst.Stacking_pattern_As_per_ISP__c = stg.Stacking_pattern_As_per_ISP__c;
                    vst.F_I_F_O_movement__c = stg.F_I_F_O_movement__c;
                    vst.Check_In__c = stg.Check_In__c;
                    vst.Check_Out__c = stg.Check_Out__c;
                    vst.Visited_Location__Latitude__s = stg.Visited_Location__Latitude__s;
                    vst.Visited_Location__Longitude__s = stg.Visited_Location__Longitude__s;
                    vst.Offline_App_CheckIn__c = true;
                    try{
                        update vst;
                        System.debug('Update Success: '+vst.id);
                        stg.Converted_Id__c = vst.id;
                        stg.Converted__c = true;
                    }catch(Exception ex){
                        Offline_Visits__c ofvst = new Offline_Visits__c();
                        ofvst.Name = stg.Name;
                        ofvst.Exception__c = ex.getMessage();
                        ofvst.Update__c = true;
                        ofvst.OwnerId = stg.OwnerId;
                        ofvst.Visit_Id__c = stg.Visit_Id__c;
                        ofvst.Planned_Date__c = stg.Planned_Date__c;
                        ofvst.Planned__c = stg.Planned__c;
                        ofvst.Master__c = stg.Master__c;
                        ofvst.Purpose_of_Visit__c = stg.Purpose_of_Visit__c;
                        ofvst.Remarks__c = stg.Remarks__c;
                        ofvst.JSW_Shop_Board_Condition__c = stg.JSW_Shop_Board_Condition__c;
                        ofvst.JSW_Bag_Visibility__c = stg.JSW_Bag_Visibility__c;
                        ofvst.JSW_stock_level_number_of_bags__c = stg.JSW_stock_level_number_of_bags__c;
                        ofvst.Payment_collected_in_current_visit__c = stg.Payment_collected_in_current_visit__c;
                        ofvst.Pending_Payment_Committed_Date__c = stg.Pending_Payment_Committed_Date__c;
                        ofvst.Any_image_to_be_captured__c = stg.Any_image_to_be_captured__c;
                        ofvst.If_Potential_Lead_Share_with_Manager__c = stg.If_Potential_Lead_Share_with_Manager__c;
                        ofvst.Visit_by_TSO_LATF__c = stg.Visit_by_TSO_LATF__c;
                        ofvst.LATF_Name__c = stg.LATF_Name__c;
                        ofvst.Activity_Type__c = stg.Activity_Type__c;
                        ofvst.Activity_Sub_Type__c = stg.Activity_Sub_Type__c;
                        ofvst.Site_demo_type__c = stg.Site_demo_type__c;
                        ofvst.Construction_Stage__c = stg.Construction_Stage__c;
                        ofvst.Date_of_Inspection__c = stg.Date_of_Inspection__c;
                        ofvst.Previous_Inspection__c = stg.Previous_Inspection__c;
                        ofvst.Product__c = stg.Product__c;
                        ofvst.Godown_stock_MT_for_CHD__c = stg.Godown_stock_MT_for_CHD__c;
                        ofvst.Godown_stock_MT_for_composite_Cement__c = stg.Godown_stock_MT_for_composite_Cement__c;
                        ofvst.Godown_stock_MT_for_OPC__c = stg.Godown_stock_MT_for_OPC__c;
                        ofvst.Godown_stock_MT_for_PSC__c = stg.Godown_stock_MT_for_PSC__c;
                        ofvst.Godown_Stock_as_on_Month_end_MT_for_CHD__c = stg.Godown_Stock_as_on_Month_end_MT_for_CHD__c;
                        ofvst.Godown_Stock_as_on_Month_end_MT_for_CC__c = stg.Godown_Stock_as_on_Month_end_MT_for_CC__c;
                        ofvst.Godown_Stock_as_on_Month_end_MT_PSC__c = stg.Godown_Stock_as_on_Month_end_MT_PSC__c;
                        ofvst.Godown_Stock_as_on_Month_end_MT_for_OPC__c = stg.Godown_Stock_as_on_Month_end_MT_for_OPC__c;
                        ofvst.Damaged_Cement_MT_for_CC__c = stg.Damaged_Cement_MT_for_CC__c;
                        ofvst.Damaged_Cement_MT_for_CHD__c = stg.Damaged_Cement_MT_for_CHD__c;
                        ofvst.Damaged_Cement_MT_for_OPC__c = stg.Damaged_Cement_MT_for_OPC__c;
                        ofvst.Damaged_Cement_MT_for_PSC__c = stg.Damaged_Cement_MT_for_PSC__c;
                        ofvst.Damage_Stock_Ageing_for_CC__c = stg.Damage_Stock_Ageing_for_CC__c;
                        ofvst.Damage_Stock_Ageing_for_CHD__c = stg.Damage_Stock_Ageing_for_CHD__c;
                        ofvst.Damage_Stock_Ageing_for_OPC__c = stg.Damage_Stock_Ageing_for_OPC__c;
                        ofvst.Damage_Stock_Ageing_for_PSC__c = stg.Damage_Stock_Ageing_for_PSC__c;
                        ofvst.Good_Stock_Ageing_for_CC__c = stg.Good_Stock_Ageing_for_CC__c;
                        ofvst.Good_Stock_Ageing_for_CHD__c = stg.Good_Stock_Ageing_for_CHD__c;
                        ofvst.Good_Stock_Ageing_for_OPC__c = stg.Good_Stock_Ageing_for_OPC__c;
                        ofvst.Good_Stock_Ageing_for_PSC__c = stg.Good_Stock_Ageing_for_PSC__c;
                        ofvst.Condition_of_Godown__c = stg.Condition_of_Godown__c;
                        ofvst.Seggregation_of_good_damaged_cement__c = stg.Seggregation_of_good_damaged_cement__c;
                        ofvst.Stacking_pattern_As_per_ISP__c = stg.Stacking_pattern_As_per_ISP__c;
                        ofvst.F_I_F_O_movement__c = stg.F_I_F_O_movement__c;
                        ofvst.Check_In__c = stg.Check_In__c;
                        ofvst.Check_Out__c = stg.Check_Out__c;
                        ofvst.Visited_Location__Latitude__s = stg.Visited_Location__Latitude__s;
                        ofvst.Visited_Location__Longitude__s = stg.Visited_Location__Longitude__s;
                        ofvst.Offline_App_CheckIn__c = true;
                        ofvst.External_Master_Id__c = stg.External_Master_Id__c;
                        ofvst.External_Visit_Id__c = stg.External_Visit_Id__c;
                        insert ofvst;
                        stg.Converted__c = true;
                        stg.Converted_Id__c = ofvst.id;
                        System.debug('Updation Unsuccessful'+ofvst.id);   
                    }
                } catch(Exception ex){
                    System.debug('Record not found');
                }
            } else {
                Visit__c vst = new Visit__c();  
                vst.Planned_Date__c = stg.Planned_Date__c;
                if(stg.userid__c.startsWith(VisitDest.getKeyPrefix()))
                vst.Planned__c = true;
                else
                vst.Planned__c = false;
                if(stg.Master__c != null){
                    if(stg.Master__c.startsWith(AccDest.getKeyPrefix()))
                    vst.Account__c = stg.Master__c;
                    else if(stg.Master__c.startsWith(LeadDest.getKeyPrefix()))
                    vst.Lead__c = stg.Master__c;
                    else if(stg.Master__c.startsWith(BPartDest.getKeyPrefix()))
                    vst.Business_Partner__c = stg.Master__c;
                    else if(stg.Master__c.startsWith(InfluDest.getKeyPrefix()))
                    vst.Influencer__c = stg.Master__c;
                    else if(stg.Master__c.startsWith(PSiteDest.getKeyPrefix()))
                    vst.Project_Site__c = stg.Master__c;
                }
                vst.Ownerid = stg.Ownerid;
                vst.Offline_App__c = true;
                vst.Purpose_of_Visit__c = stg.Purpose_of_Visit__c;
                vst.Remarks__c = stg.Remarks__c;
                vst.JSW_Shop_Board_Condition__c = stg.JSW_Shop_Board_Condition__c;
                vst.JSW_Bag_Visibility__c = stg.JSW_Bag_Visibility__c;
                vst.Stock_level_JSW__c = stg.JSW_stock_level_number_of_bags__c;
                vst.Payment_Amount_Collected_by_SO__c = stg.Payment_collected_in_current_visit__c;
                vst.Pending_Payment_Amount_Committed_Date__c = stg.Pending_Payment_Committed_Date__c;
                vst.Any_image_to_be_captured__c = stg.Any_image_to_be_captured__c;
                vst.If_Potential_Lead_Share_with_Manager__c = stg.If_Potential_Lead_Share_with_Manager__c;
                vst.Visit_by_TSO_LATF__c = stg.Visit_by_TSO_LATF__c;
                vst.LATF_Name__c = stg.LATF_Name__c;
                vst.Activity_Type__c = stg.Activity_Type__c;
                vst.Activity_Sub_Type__c = stg.Activity_Sub_Type__c;
                vst.Site_demo_type__c = stg.Site_demo_type__c;
                vst.Construction_Stage__c = stg.Construction_Stage__c;
                vst.Date_of_Inspection__c = stg.Date_of_Inspection__c;
                vst.Previous_Inspection__c = stg.Previous_Inspection__c;
                if(stg.Product__c != null){
                    if(stg.Product__c.contains(','))
                    vst.Product__c = stg.Product__c.replace(',',';');
                    else
                    vst.Product__c = stg.Product__c;
                }
                vst.Godown_stock_MT_for_CHD__c = stg.Godown_stock_MT_for_CHD__c;
                vst.Godown_stock_MT_for_composite_Cement__c = stg.Godown_stock_MT_for_composite_Cement__c;
                vst.Godown_stock_MT_for_OPC__c = stg.Godown_stock_MT_for_OPC__c;
                vst.Godown_stock_MT_for_PSC__c = stg.Godown_stock_MT_for_PSC__c;
                vst.Godown_Stock_on_Month_end_MT_for_CHD__c = stg.Godown_Stock_as_on_Month_end_MT_for_CHD__c;
                vst.Godown_Stock_as_on_Month_end_MT_for_CC__c = stg.Godown_Stock_as_on_Month_end_MT_for_CC__c;
                vst.Godown_Stock_as_on_Month_end_MT_for_PSC__c = stg.Godown_Stock_as_on_Month_end_MT_PSC__c;
                vst.Godown_Stock_as_on_Month_end_MT_for_OPC__c = stg.Godown_Stock_as_on_Month_end_MT_for_OPC__c;
                vst.Damaged_Cement_MT_for_CC__c = stg.Damaged_Cement_MT_for_CC__c;
                vst.Damaged_Cement_MT_for_CHD__c = stg.Damaged_Cement_MT_for_CHD__c;
                vst.Damaged_Cement_MT_for_OPC__c = stg.Damaged_Cement_MT_for_OPC__c;
                vst.Damaged_Cement_MT_for_PSC__c = stg.Damaged_Cement_MT_for_PSC__c;
                vst.Damage_Stock_Ageing_for_CC__c = stg.Damage_Stock_Ageing_for_CC__c;
                vst.Damage_Stock_Ageing_for_CHD__c = stg.Damage_Stock_Ageing_for_CHD__c;
                vst.Damage_Stock_Ageing_for_OPC__c = stg.Damage_Stock_Ageing_for_OPC__c;
                vst.Damage_Stock_Ageing_for_PSC__c = stg.Damage_Stock_Ageing_for_PSC__c;
                vst.Good_Stock_Ageing_for_CC__c = stg.Good_Stock_Ageing_for_CC__c;
                vst.Good_Stock_Ageing_for_CHD__c = stg.Good_Stock_Ageing_for_CHD__c;
                vst.Good_Stock_Ageing_for_OPC__c = stg.Good_Stock_Ageing_for_OPC__c;
                vst.Good_Stock_Ageing_for_PSC__c = stg.Good_Stock_Ageing_for_PSC__c;
                vst.Condition_of_Godown__c = stg.Condition_of_Godown__c;
                vst.Seggregation_of_good_damaged_cement__c = stg.Seggregation_of_good_damaged_cement__c;
                vst.Stacking_pattern_As_per_ISP__c = stg.Stacking_pattern_As_per_ISP__c;
                vst.F_I_F_O_movement__c = stg.F_I_F_O_movement__c;
                vst.Check_In__c = stg.Check_In__c;
                vst.Check_Out__c = stg.Check_Out__c;
                vst.Visited_Location__Latitude__s = stg.Visited_Location__Latitude__s;
                vst.Visited_Location__Longitude__s = stg.Visited_Location__Longitude__s;
                
                vst.Offline_App_CheckIn__c = true;
                try{
                    insert vst;
                    System.debug('Insert Success: '+vst.id);
                    stg.Converted_Id__c = vst.id;
                    stg.Converted__c = true;
                }catch(Exception ex){
                    Offline_Visits__c ofvst = new Offline_Visits__c();
                    ofvst.Name = stg.Name;
                    ofvst.Exception__c = ex.getMessage();
                    ofvst.OwnerId = stg.OwnerId;
                    ofvst.Visit_Id__c = stg.Visit_Id__c;
                    ofvst.Planned_Date__c = stg.Planned_Date__c;
                    ofvst.Planned__c = stg.Planned__c;
                    ofvst.Master__c = stg.Master__c;
                    ofvst.Purpose_of_Visit__c = stg.Purpose_of_Visit__c;
                    ofvst.Remarks__c = stg.Remarks__c;
                    ofvst.JSW_Shop_Board_Condition__c = stg.JSW_Shop_Board_Condition__c;
                    ofvst.JSW_Bag_Visibility__c = stg.JSW_Bag_Visibility__c;
                    ofvst.JSW_stock_level_number_of_bags__c = stg.JSW_stock_level_number_of_bags__c;
                    ofvst.Payment_collected_in_current_visit__c = stg.Payment_collected_in_current_visit__c;
                    ofvst.Pending_Payment_Committed_Date__c = stg.Pending_Payment_Committed_Date__c;
                    ofvst.Any_image_to_be_captured__c = stg.Any_image_to_be_captured__c;
                    ofvst.If_Potential_Lead_Share_with_Manager__c = stg.If_Potential_Lead_Share_with_Manager__c;
                    ofvst.Visit_by_TSO_LATF__c = stg.Visit_by_TSO_LATF__c;
                    ofvst.LATF_Name__c = stg.LATF_Name__c;
                    ofvst.Activity_Type__c = stg.Activity_Type__c;
                    ofvst.Activity_Sub_Type__c = stg.Activity_Sub_Type__c;
                    ofvst.Site_demo_type__c = stg.Site_demo_type__c;
                    ofvst.Construction_Stage__c = stg.Construction_Stage__c;
                    ofvst.Date_of_Inspection__c = stg.Date_of_Inspection__c;
                    ofvst.Previous_Inspection__c = stg.Previous_Inspection__c;
                    ofvst.Product__c = stg.Product__c;
                    ofvst.Godown_stock_MT_for_CHD__c = stg.Godown_stock_MT_for_CHD__c;
                    ofvst.Godown_stock_MT_for_composite_Cement__c = stg.Godown_stock_MT_for_composite_Cement__c;
                    ofvst.Godown_stock_MT_for_OPC__c = stg.Godown_stock_MT_for_OPC__c;
                    ofvst.Godown_stock_MT_for_PSC__c = stg.Godown_stock_MT_for_PSC__c;
                    ofvst.Godown_Stock_as_on_Month_end_MT_for_CHD__c = stg.Godown_Stock_as_on_Month_end_MT_for_CHD__c;
                    ofvst.Godown_Stock_as_on_Month_end_MT_for_CC__c = stg.Godown_Stock_as_on_Month_end_MT_for_CC__c;
                    ofvst.Godown_Stock_as_on_Month_end_MT_PSC__c = stg.Godown_Stock_as_on_Month_end_MT_PSC__c;
                    ofvst.Godown_Stock_as_on_Month_end_MT_for_OPC__c = stg.Godown_Stock_as_on_Month_end_MT_for_OPC__c;
                    ofvst.Damaged_Cement_MT_for_CC__c = stg.Damaged_Cement_MT_for_CC__c;
                    ofvst.Damaged_Cement_MT_for_CHD__c = stg.Damaged_Cement_MT_for_CHD__c;
                    ofvst.Damaged_Cement_MT_for_OPC__c = stg.Damaged_Cement_MT_for_OPC__c;
                    ofvst.Damaged_Cement_MT_for_PSC__c = stg.Damaged_Cement_MT_for_PSC__c;
                    ofvst.Damage_Stock_Ageing_for_CC__c = stg.Damage_Stock_Ageing_for_CC__c;
                    ofvst.Damage_Stock_Ageing_for_CHD__c = stg.Damage_Stock_Ageing_for_CHD__c;
                    ofvst.Damage_Stock_Ageing_for_OPC__c = stg.Damage_Stock_Ageing_for_OPC__c;
                    ofvst.Damage_Stock_Ageing_for_PSC__c = stg.Damage_Stock_Ageing_for_PSC__c;
                    ofvst.Good_Stock_Ageing_for_CC__c = stg.Good_Stock_Ageing_for_CC__c;
                    ofvst.Good_Stock_Ageing_for_CHD__c = stg.Good_Stock_Ageing_for_CHD__c;
                    ofvst.Good_Stock_Ageing_for_OPC__c = stg.Good_Stock_Ageing_for_OPC__c;
                    ofvst.Good_Stock_Ageing_for_PSC__c = stg.Good_Stock_Ageing_for_PSC__c;
                    ofvst.Condition_of_Godown__c = stg.Condition_of_Godown__c;
                    ofvst.Seggregation_of_good_damaged_cement__c = stg.Seggregation_of_good_damaged_cement__c;
                    ofvst.Stacking_pattern_As_per_ISP__c = stg.Stacking_pattern_As_per_ISP__c;
                    ofvst.F_I_F_O_movement__c = stg.F_I_F_O_movement__c;
                    ofvst.Check_In__c = stg.Check_In__c;
                    ofvst.Check_Out__c = stg.Check_Out__c;
                    ofvst.Visited_Location__Latitude__s = stg.Visited_Location__Latitude__s;
                    ofvst.Visited_Location__Longitude__s = stg.Visited_Location__Longitude__s;
                    ofvst.Offline_App_CheckIn__c = true;
                    ofvst.External_Master_Id__c = stg.External_Master_Id__c;
                    ofvst.External_Visit_Id__c = stg.External_Visit_Id__c;
                    insert ofvst;
                    stg.Converted__c = true;
                    stg.Converted_Id__c = ofvst.id;
                    System.debug('Insertion Unsuccessful'+ofvst.id);   
                }
            }
        }
        update stglist;
    }    
}