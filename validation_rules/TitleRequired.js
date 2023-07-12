AND (
 signature__RequestedForm__c = 'Testing Req', // Replace with actual form name (must be included in the FieldSet being used)
  OR(
    AND(
     ISBLANK( signature__Title__c ),  // Replace with the field(s) that must be populated
     signature__IsRequest__c = True,
     ISPICKVAL(signature__Status__c, 'Signed')
    ),
   AND(
     ISBLANK( signature__Title__c ),  // Replace with the field(s) that must be populated
     NOT( signature__IsRequest__c )
    )
  ) 
)
