trigger LeadTrigger on Lead (before insert, after insert) {

    if(Trigger.operationType == System.TriggerOperation.BEFORE_INSERT){

        LeadTriggerHandler.onBeforeInsert(Trigger.new,Trigger.newMap);
    }
    if(Trigger.operationType == System.TriggerOperation.AFTER_INSERT){

        LeadTriggerHandler.onAfterInsert(Trigger.new,Trigger.newMap);
    }
    
} 