@RestResource(urlMapping='/VisitCheckIn/*')
global with sharing class VisitCheckIn{

    @HttpPost
    global static String doPost(VisitWraper vp,String visitid) {
       Visit__c vst = [select id,Purpose_of_Visit__c,Remarks__c,JSW_Shop_Board_Condition__c,JSW_Bag_Visibility__c,Stock_level_JSW__c,
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
                       Stacking_pattern_As_per_ISP__c,F_I_F_O_movement__c,Offline_App_CheckIn__c from Visit__c where id =: visitid];
       vst.Purpose_of_Visit__c = vp.purposeofvisit;
       vst.Remarks__c = vp.visitdetails;
       vst.JSW_Shop_Board_Condition__c = vp.JSWShopBoardCondition;
       vst.JSW_Bag_Visibility__c = vp.JSWBagVisibility;
       vst.Stock_level_JSW__c = vp.StocklevelJSW;
       vst.Payment_Amount_Collected_by_SO__c = vp.PaymentAmountCollectedbySO;
       vst.Pending_Payment_Amount_Committed_Date__c = vp.PendingPaymentAmountCommittedDate;
       vst.Any_image_to_be_captured__c = vp.Anyimagetobecaptured;
       vst.If_Potential_Lead_Share_with_Manager__c = vp.potentiallead;
       vst.Visit_by_TSO_LATF__c = vp.visitby;
       vst.LATF_Name__c = vp.latfname;
       vst.Activity_Type__c = vp.ActType;
       vst.Activity_Sub_Type__c = vp.ActSType;
       vst.Site_demo_type__c = vp.sdemotype;
       vst.Construction_Stage__c = vp.constage;
       vst.Date_of_Inspection__c = vp.dofinsp;
       vst.Previous_Inspection__c = vp.prvinsp;
       vst.Product__c = vp.prodtype;
       vst.Godown_stock_MT_for_CHD__c = vp.GDSTKforCHD;
       vst.Godown_stock_MT_for_composite_Cement__c = vp.GDSTKforCC;
       vst.Godown_stock_MT_for_OPC__c = vp.GDSTKforOPC;
       vst.Godown_stock_MT_for_PSC__c = vp.GDSTKforPSC;
       vst.Godown_Stock_on_Month_end_MT_for_CHD__c = vp.GDMTforCHD;
       vst.Godown_Stock_as_on_Month_end_MT_for_CC__c = vp.GDMTforCC;
       vst.Godown_Stock_as_on_Month_end_MT_for_PSC__c = vp.GDMTforPSC;
       vst.Godown_Stock_as_on_Month_end_MT_for_OPC__c = vp.GDMTforOPC;
       vst.Damaged_Cement_MT_for_CC__c = vp.DCMTforCC;
       vst.Damaged_Cement_MT_for_CHD__c = vp.DCMTforCHD;
       vst.Damaged_Cement_MT_for_OPC__c = vp.DCMTforOPC;
       vst.Damaged_Cement_MT_for_PSC__c = vp.DCMTforPSC;
       vst.Damage_Stock_Ageing_for_CC__c = vp.DSAforCC;
       vst.Damage_Stock_Ageing_for_CHD__c = vp.DSAforCHD;
       vst.Damage_Stock_Ageing_for_OPC__c = vp.DSAforOPC;
       vst.Damage_Stock_Ageing_for_PSC__c = vp.DSAforPSC;
       vst.Good_Stock_Ageing_for_CC__c = vp.GSAforCC;
       vst.Good_Stock_Ageing_for_CHD__c = vp.GSAforCHD;
       vst.Good_Stock_Ageing_for_OPC__c = vp.GSAforOPC;
       vst.Good_Stock_Ageing_for_PSC__c = vp.GSAforPSC;
       vst.Condition_of_Godown__c = vp.godowncondition;
       vst.Seggregation_of_good_damaged_cement__c = vp.segg;
       vst.Stacking_pattern_As_per_ISP__c = vp.stackpattern;
       vst.F_I_F_O_movement__c = vp.fifo;
       vst.Check_In__c = vp.checkin;
       vst.Check_Out__c = vp.checkout;
       vst.Visited_Location__Latitude__s = vp.lat;
       vst.Visited_Location__Longitude__s = vp.lon;
       vst.Offline_App_CheckIn__c = true;
       update vst;
       return vst.id;
    }
       
    global class VisitWraper {
       String purposeofvisit {get; set;}
       String visitdetails {get; set;}
       String JSWShopBoardCondition{get; set;}
       String JSWBagVisibility{get; set;}
       Double StocklevelJSW{get; set;}
       Double PaymentAmountCollectedbySO{get; set;}
       Date PendingPaymentAmountCommittedDate{get; set;}
       String Anyimagetobecaptured{get; set;}
       String checkin {get; set;}
       String checkout {get; set;}
       Double lat {get; set;}
       Double lon {get; set;}
       global Boolean potentiallead {get; set;}
       String visitby {get; set;}
       String latfname {get; set;}
       String ActType {get; set;}
       String ActSType {get; set;}
       String sdemotype {get; set;}
       String constage {get; set;}
       Date dofinsp {get; set;}
       Date prvinsp {get; set;}
       String prodtype {get; set;}
       Double GDSTKforPSC {get; set;}
       Double GDSTKforOPC {get; set;}
       Double GDSTKforCC {get; set;}
       Double GDSTKforCHD {get; set;}
       Double GDMTforPSC {get; set;}
       Double GDMTforOPC {get; set;}
       Double GDMTforCC {get; set;}
       Double GDMTforCHD {get; set;}
       Double DCMTforPSC {get; set;}
       Double DCMTforOPC {get; set;}
       Double DCMTforCC {get; set;}
       Double DCMTforCHD {get; set;}
       Date DSAforPSC {get; set;}
       Date DSAforOPC {get; set;}
       Date DSAforCC {get; set;}
       Date DSAforCHD {get; set;}
       Date GSAforPSC {get; set;}
       Date GSAforOPC {get; set;}
       Date GSAforCC {get; set;}
       Date GSAforCHD {get; set;}
       String godowncondition {get; set;}
       String segg {get; set;}
       String stackpattern {get; set;}
       String fifo {get; set;}
    }
}