@RestResource(urlMapping='/EventoComunidade/Leads/*')

global with sharing class LeadApi {
    
    @HttpGet
    global static void getLeads(){

        RestResponse resultRest = RestContext.response;
        RestRequest Request = RestContext.request;

        String firstName = request.requestURI.substring(request.requestURI.lastIndexOf('/')+1);

        List<Lead> leadsList = String.isNotBlank(firstName) ? [SELECT Id, Name, Email, Phone FROM Lead 
        WHERE FirstName = :firstName] : [SELECT Id, Name, Email, Phone FROM Lead];

        resultRest.responseBody = Blob.valueOf(JSON.serializePretty(leadsList));
        resultRest.statusCode = 200;
    }

    @HttpPost
    global static void UpdateLeads(List<UpdateLeadWrapper> leadList)
    {

        RestResponse resultRest = RestContext.response;

        List<Lead> leadInsertList = new List<Lead>();

        for(UpdateLeadWrapper l : leadList){
            Lead leadInsert = new Lead(
                LastName = l.sobrenome,
                Company = l.nome_empresa,
                Status = l.status_do_lead,
                Email = l.email,
                FirstName = l.nome,
                CNPJ__c = l.cnpj,
                Nome_Fantasia__c = l.nome_fantasia,
                Razao_Social__c = l.razao_social
            );
            leadInsertList.add(leadInsert);
        }

        List<String> idsResponse = new List<String>();

        if (leadInsertList.size() > 0) {

            Database.UpsertResult[] results = Database.upsert(leadInsertList);
            
            for(Integer index = 0 , size = results.size(); index < size; index++){
                if(results[index].isSuccess()){
                    idsResponse.add(results[index].Id);
                }else{
                    idsResponse.add('ERROR');
                }
            }
        }

        resultRest.responseBody = Blob.valueOf(JSON.serializePretty(idsResponse));
        resultRest.statusCode = 200;

    }
}