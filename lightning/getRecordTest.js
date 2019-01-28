@isTest(SeeAllData=false)
public class getRecordTest{
 
    @isTest static void getRecordTestMethod(){
        Signature__Signature__c sig = new Signature__Signature__c();
        insert sig;
        
        Test.startTest();
        Signature__Signature__c sig1 = new Signature__Signature__c();
        
        sig1 = (Signature__Signature__c)getRecord.getrecordValues(sig.id);
        System.assertEquals(sig.id, sig1.id);
        
        Test.stopTest();
    }
    
    
}
