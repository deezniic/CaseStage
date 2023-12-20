public class CreateLeadHelper {

    @Future(callout=true)
    public static void fillCNPJ(String id){
        Lead lead = [SELECT Id, Name, LastName, Company, Phone, Fax, CNPJ__c, Situacao_Cadastral__c, Razao_Social__c, Nome_Fantasia__c
                    FROM Lead WHERE Id =: id];
        HttpRequest request = new HttpRequest();
        request.setMethod('GET');
        request.setEndpoint('https://brasilapi.com.br/api/cnpj/v1/'+lead.CNPJ__c+'');

        HttpResponse response = (new Http()).send(request);

        if (response.getStatusCode() == 200) {
            Map<String,Object> jsonResponse = (Map<String,Object>) JSON.deserializeUntyped(response.getBody());

            lead.Phone = String.valueOf(jsonResponse.get('ddd_telefone_1'));
            lead.Fax = String.valueOf(jsonResponse.get('ddd_fax'));
            lead.CNPJ__c = String.valueOf(jsonResponse.get('cnpj'));
            lead.Razao_Social__c = String.valueOf(jsonResponse.get('razao_social'));
            lead.Nome_Fantasia__c = String.valueOf(jsonResponse.get('nome_fantasia'));
            lead.Situacao_Cadastral__c = String.valueOf(jsonResponse.get('descricao_situacao_cadastral'));
            //lead.Company = String.valueOf(jsonResponse.get('descricao_matriz_filial'));
            lead.Description = String.valueOf(jsonResponse.get('cnae_fiscal_descricao'));
            
            update lead;
        }
    }
}