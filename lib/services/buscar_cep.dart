import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiBuscarCep {
  ApiBuscarCep._();

  static buscarCep (String cep) async {
    try {
      http.Response response = await http.get(
        Uri.parse("https://viacep.com.br/ws/$cep/json/"),
        headers: {
          'Content-Type': 'application/json',
        }
      );

      if(response.body.isNotEmpty)
        return json.decode(response.body);
      else return {"erro" : true};
    } catch (e) {
      return {"erro" : true};
    }
  }  
}