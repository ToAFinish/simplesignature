({
	doInit : function(component, event, helper) {
        //THE NEW CODE IF COMPONENT NEEDED ON TAB
        if(component.get("v.pageReference")!=null){
            component.set('v.recordId', component.get("v.pageReference").state.c__recordid);
            //component.set('v.Experience', component.get("v.pageReference").state.c__Experience);
        }
        console.log(component.get('v.recordId'));
        console.log(component.get('v.Experience'));
        let mediaQuery = window.matchMedia('(max-width: 414px)');
        if(mediaQuery != undefined && mediaQuery.matches == true){
            component.set("v.FullWidth",'100%');
            component.set("v.overrideDensity",'compact:0');
        }else{
            component.set("v.FullWidth",'50%');
        }
	},
     onPageReferenceChange:function(component, event, helper) {
    	console.log('*** change in the URL change the variables **** ');
         if(component.get("v.pageReference")!=null){
             component.set('v.recordId', component.get("v.pageReference").state.c__recordid);
             //component.set('v.Experience', component.get("v.pageReference").state.c__Experience);
         }
         let mediaQuery = window.matchMedia('(max-width: 414px)');
         if(mediaQuery != undefined && mediaQuery.matches == true){
             component.set("v.FullWidth",'100%');
             component.set("v.overrideDensity",'compact:0');
         }else{
             component.set("v.FullWidth",'50%');
         }
	}
})
