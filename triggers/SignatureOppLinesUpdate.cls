/*
    LINKS THE NEW SIGNATURE (WHEN CONNECTED TO AN OPPORTUNITY) TO THE OPPORTUNITY PRODUCTS OF THAT OPP
*/
trigger SignatureOppLinesUpdate on signature__Signature__c(before insert, before update, after insert, after update) {

    Set<Id> oppIds = new Set<Id>();
    Map<Id,Id> oppSigMap = new Map<Id,Id>();
    String oppLookupField;

    // RUN DYNAMIC UPDATES OF OPPORTUNITY LINES IF THE LOOKUPS EXIST
    if(Trigger.isInsert && Trigger.isAfter) {

        oppLookupField = 'signature__Opportunity__c';

        if(oppLookupField!=null){
            for(signature__Signature__c s:Trigger.New) {
                if(oppLookupField!=null && s.get(oppLookupField) != null) {
                    oppIds.add((id)s.get(oppLookupField));
                    oppSigMap.put((id)s.get(oppLookupField), s.Id);
                }
            }
        }

        // UPDATE OPPORTUNITY LINES
        if(!oppIds.isEmpty()) {

            String refField='Signature__c';  // this is the name of the Signature lookup field in the Opportunity Products object

            if(refField!=null){
                String qry='select Id, OpportunityId,'+refField+' from OpportunityLineItem where OpportunityId in:oppIds Limit 1000';
                list<sobject> oliList = Database.query(qry);
                if(!oliList.isEmpty()) {
                    for(sObject oli:oliList) {
                        oli.put(refField,oppSigMap.get((id)oli.get('OpportunityId')));
                    }
                    SObjectAccessDecision securityDecision = Security.stripInaccessible(
                    AccessType.UPDATABLE, oliList);
                    oliList = securityDecision.getRecords();
                    update  oliList;
                }
            }
        }
    }
}
