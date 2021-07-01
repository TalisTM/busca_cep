import 'dart:convert';

import 'package:http/http.dart' as http;

class ApiBuscarCep {
  ApiBuscarCep._();

  static buscarCep (String cep) async {
    try {
      http.Response response = await http.get(Uri.parse("viacep.com.br/ws/$cep/json/"));

      if(response.body.isNotEmpty) 
        return json.decode(response.body);
      else return "404";
    } catch (e) {
      return "404";
    }
  }  
}