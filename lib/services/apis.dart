import 'package:busca_cep/services/buscar_cep.dart';

class Api {
  Api._();

  static buscarCep (String cep) => ApiBuscarCep.buscarCep(cep);
}