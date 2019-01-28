/*
    TRIGGER TO CREATE SIGNATURE REQUEST IF A QUOTE, TYPE IS PDF, AND HAS NOTE YET BEEN SENT
    custom fields created: signature__Signature__c.DeliveredFinalPDF__c (checkbox)
                           Opportunity.SignatureRequestSent__c (checkbox)
*/
trigger CreateSignatureOnAttachment on Attachment (before insert, after insert) {    
    List<signature__Signature__c> signatures=new List<signature__Signature__c>();
    Map<Id,Opportunity> qMap = New Map<Id,Opportunity>();
    Set<Id> qIds = new Set<Id>();
    for(Attachment at:trigger.new){
        if(at.ContentType=='application/pdf' && String.valueof(at.parentid).startsWith('006')){
            if(!qIds.contains(at.parentid)) qIds.add(at.parentid);
        }
    }
    List<Opportunity> qList = [select Id, PrimaryContact__c, SignatureRequestSent__c from Opportunity where Id in:qIds Limit 200];
    for(Opportunity q:qList) qMap.put(q.Id,q);
    for(Attachment at:trigger.new){
        if(at.ContentType=='application/pdf' && String.valueof(at.parentid).startsWith('006') && qMap.containsKey(at.parentid)){
            if(!qMap.get(at.parentid).SignatureRequestSent__c) {
                if (Trigger.isAfter) {
                    signature__Signature__c sg=new signature__Signature__c();
                    sg.signature__AttachmentID__c=at.id;
                    sg.signature__Opportunity__c=at.parentid;
                    sg.signature__Status__c='Requested';
                    sg.signature__Requested__c=system.now();
                    sg.signature__EmailPDF__c=false;
                    sg.signature__Contact__c=qMap.get(at.parentid).PrimaryContact__c;
                    signatures.add(sg);
                }
            } else {
                if(Trigger.isBefore) {
                    at.Name = 'Signed_Agreement.pdf';
                } else {
                    List<signature__Signature__c> sigs = [select Id, DeliveredFinalPDF__c from signature__Signature__c
                                                            where signature__Opportunity__c!=null
                                                            and signature__Opportunity__c=:at.parentid
                                                            and signature__Status__c='Signed'
                                                            and DeliveredFinalPDF__c!=true
                                                            limit 200];
                    if(!sigs.isEmpty()) {
                        for(signature__Signature__c sign:sigs){
                            sign.DeliveredFinalPDF__c=true;
                            sign.signature__EmailPDF__c=true;
                            sign.signature__AttachmentID__c=at.id;
                        }
                        update sigs;
                    }
                }
            }
        }
    }
    if(!signatures.isEmpty()) insert signatures;
}
