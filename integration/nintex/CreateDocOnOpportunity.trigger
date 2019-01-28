/*
    TRIGGER TO COPY SIGNATURE IMAGE TO OPPORTUNITY AND LAUNCH NINTEX DRAWLOOP INTEGRATION
    custom fields created: signature__Signature__c.DeliveredFinalPDF__c (checkbox)
                           Opportunity.SignatureRequestSent__c (checkbox)
                           Opportunity.Signature__c (rich text)
*/
trigger CreateDocOnOpportunity on signature__Signature__c (after update) {
    
    set<id> opportunityIds =new set<id>();
    map<Id, signature__Signature__c> oppSignatureMap = New map<Id, signature__Signature__c>();
    
    for(signature__Signature__c sign:trigger.new){
        if(sign.signature__Opportunity__c!=null && sign.signature__Status__c=='Signed' && 
            sign.DeliveredFinalPDF__c!=true){
            opportunityIds.add(sign.signature__Opportunity__c);
            oppSignatureMap.put(sign.signature__Opportunity__c, sign);
        }
    }
    
    if(opportunityIds.size()>0 && UserInfo.getUserType()!='Guest'){
        List<Opportunity> opps = [Select Id, SignatureRequestSent__c, Signature__c from Opportunity where Id in:opportunityIds Limit 200];

        if(!opps.isEmpty()) {
            for(Opportunity o:opps) {
                o.SignatureRequestSent__c = true;
                o.Signature__c = oppSignatureMap.get(o.Id).signature__Signature__c;
            }
            update opps;
        }

        if(!System.isBatch() && !System.isFuture()){
            NintexIntegration.GenerateDoc(opportunityIds);
        }
    }
}
