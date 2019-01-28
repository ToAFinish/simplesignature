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
                     var pvalue='backtoparent=1';                 
                    if(record.hasOwnProperty('Billing_Name__c')){
                         pvalue+='&defaultvalue_Billing_Name__c='+record['Billing_Name__c'].replace('&','');       				 
                    }
                    if(record.hasOwnProperty('AccountId')){
                         pvalue+='&defaultfilterfield_signature__Contact__c=AccountId';       				 
                    }
                    if(record.hasOwnProperty('AccountId')){
                         pvalue+='&defaultfiltervalue_signature__Contact__c='+record['AccountId'];       				 
                    }
                    
                    component.set("v.params",encodeURI(pvalue)); 
                    console.log(encodeURI(pvalue));
                }
            }else{               
            }
        });       
        $A.enqueueAction(action);                   
    }
})
