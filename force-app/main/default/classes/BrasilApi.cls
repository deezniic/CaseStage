@RestResource(urlMapping='/Lead')
global with sharing class BrasilApi {
    @httpGet
    global static List<Lead> getLead() {
        return [SELECT Id, Name, LastName, Company, CNPJ__c, Nome_Fantasia__c, Razao_Social__c FROM Lead ];
    }

    @httpPost
    global static Lead insertLead(Lead leads){
        //Aqui fazemos toda operação da regra de negócios
        insert leads;

        return leads;
    }

    @httpPut
    global static Lead upsertLead(Lead leads){
        //Aqui fazemos toda operação da regra de negócios
        upsert leads;

        return leads;
    }

    @httpPatch
    global static Lead updateLead(Lead leads){
        //Aqui fazemos toda operação da regra de negócios
        update leads;

        return leads;
    }
}