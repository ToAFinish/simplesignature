({
	doInit : function(component, event, helper) {
        var action = component.get("c.getrecordValues");
        action.setParams({
            recordid:component.get("v.recordId")
        });
        action.setCallback(this,function(res){
            var state = res.getState();
            if(state==="SUCCESS"){              
               var record=res.getReturnValue();
                if(record!=null && record!='' && record!=undefined){
                    if(record.hasOwnProperty('FirstName')){
                         var pvalue='fieldset=SignatureFields&attachpdf=1&backtoparent=1&defaultvalue_signature__Name__c='+record['FirstName'];
        				 component.set("v.params",pvalue); 
                    }
                }
            }else{               
            }
        });       
        $A.enqueueAction(action);                   
    }
})
