@IsTest
public class CreateLeadHelperTest {

    @TestSetup
    static void makeData(){
        Lead leadTest = new Lead(LastName='lead Test', Company='lead Test', Status='Open - Not Contacted');
        insert leadTest;
    }
    
    @IsTest
    static void tesCreateLeads(){

        Lead lead = [SELECT Id FROM Lead LIMIT 1];
        
        Test.startTest();
            CreateLeadHelper.createLead(new List<Id>{lead.Id});
            List<Lead> leadBeforeExecute = [SELECT Id FROM Lead WHERE LeadId =: lead.Id];

            System.assert(leadBeforeExecute.isEmpty());
        Test.stopTest();

        List<Lead> leadAfterExecute = [SELECT Id FROM Lead WHERE LeadId =: lead.Id];
            System.assert(!leadAfterExecute.isEmpty());

    }

}