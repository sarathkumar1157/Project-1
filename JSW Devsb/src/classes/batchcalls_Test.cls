@isTest
public class batchcalls_Test 
{
	public static testmethod void batchcalltest()
    {
        batchcalls bc = new batchcalls();
        bc.defaultvals();
        bc.tobeprocessed = False;
        bc.fromdate = System.today()-5;
        bc.todate = System.today()-1;
        bc.classnames = 'PDClass';
        bc.runbatch();
        bc.classnames = 'OtherClass';
        bc.runbatch();
        bc.classnames = 'PRFTClass';
        bc.runbatch();
        bc.classnames = 'CFClass';
        bc.runbatch();
        bc.classnames = 'CIClass';
        bc.runbatch();
        bc.classnames = 'AdhocClass';
        bc.runbatch();
        bc.classnames = 'IDClass';
        bc.runbatch();
        bc.classnames = 'DistrictActualsClass';
        bc.runbatch();
        bc.classnames = 'DistrictNSRClass';
        bc.runbatch();
        bc.classnames = 'StateActualsClass';
        bc.runbatch();
        bc.classnames = 'StateNSRClass';
        bc.runbatch();
        bc.classnames = 'MHClass';
        bc.runbatch();
        bc.classnames = 'DistTargets';
        bc.runbatch();
        bc.classnames = 'CustTargets';
        bc.runbatch();
    }
}