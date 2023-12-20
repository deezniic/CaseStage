public class LeadTriggerHandler {
    
    public static void onBeforeInsert(List<Lead> newLeadList, Map<Id,Lead> newLeadMap){
        for(Lead newLead : newLeadList){
            if(newLead.CNPJ__c == null) {
                newLead.addError('Por favor informar o CNPJ');
            }
        }
    }

    public static void onAfterInsert(List<Lead> newLeadList, Map<Id,Lead> newLeadMap){

        List<String> createLeadList = new List<String>();

        for(Lead newLead : newLeadList){
            createLeadList.add(newLead.Id);
            CreateLeadHelper.fillCNPJ(newLead.Id);
        }
    }
}