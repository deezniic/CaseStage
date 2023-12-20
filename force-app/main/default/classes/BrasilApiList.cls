public with sharing class BrasilApiList {
    public String cnpj;
    public String email;
    public String ddd_fax;
    public String razao_social; 
    public String nome_fantasia; 
    public String ddd_telefone_1;
    public String descricao_situacao_cadastral;

    public static List<BrasilApiList> parse(String jsonString){
        return (List<BrasilApiList>)JSON.deserialize(jsonString, List<BrasilApiList>.class);
    }
}