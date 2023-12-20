public with sharing class BrasilApiService {
    private final static String serviceUrl = 'https://brasilapi.com.br/api/cnpj/v1/{cnpj}';

    public static List<BrasilApiList> getBrasilApi(String CNPJ){
        String endpoint = serviceUrl.replace('{cnpj}', CNPJ);

        Http http = new Http();
        HttpRequest request = new HttpRequest();
        request.setEndpoint(endpoint);
        request.setMethod('GET');
        request.setTimeout(12000);
        request.setHeader('Content-Type', 'application/json');

        HttpResponse response = http.send(request);

        if (response.getStatusCode() == 200) {
            String jsonString = response.getBody();

            return BrasilApiList.parse(jsonString);
        } else {
            Map<String, Object> error = new Map<String, Object>();
            error.put('statusCode', response.getStatusCode());
            error.put('status', response.getStatus());
            error.put('body', response.getBody());

            throw new BrasilApiServiceException(JSON.serialize(error));
        }
    }

    public void test() {
        List<BrasilApiList> result = BrasilApiService.getBrasilApi('CNPJ');
        System.debug(result);
    }

    public class BrasilApiServiceException extends Exception {}
}