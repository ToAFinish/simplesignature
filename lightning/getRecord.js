global class getRecord{
    @auraEnabled
    global static sobject getrecordValues(string recordid){
        try{
            if(recordid!=null && recordid!=''){
                String sobjectType = id.valueof(recordid).getSObjectType().getDescribe().getName(); 
                
                string allfields='';
                
                Map<String,Schema.SObjectField> fields = Schema.getGlobalDescribe().get(sobjectType).getDescribe().fields.getMap();
                          
                for(Schema.SObjectField fieldRef : fields.values()) {
                    Schema.DescribeFieldResult fieldResult = fieldRef.getDescribe();   
                    allfields+=fieldResult.getname()+',';        
                }   
                allfields=allfields.removeEnd(',');
                
                string query='select '+allfields+' from '+sobjectType+' where id=:recordid';
                
                sobject obj=database.query(query);
                return obj;
            }
            return null;
        }catch(exception e){
             return null;
        }
    }
}
