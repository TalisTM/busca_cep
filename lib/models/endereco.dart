import 'dart:convert';

class EnderecoEntity {
  String cep;
  String rua;
  String bairro;
  String cidade;
  String uf;
  
  EnderecoEntity({
    this.cep = "",
    this.rua = "",
    this.bairro = "",
    this.cidade = "",
    this.uf = "",
  });

  EnderecoEntity copyWith({
    String? cep,
    String? rua,
    String? bairro,
    String? cidade,
    String? uf,
  }) {
    return EnderecoEntity(
      cep: cep ?? this.cep,
      rua: rua ?? this.rua,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'rua': rua,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
    };
  }

  factory EnderecoEntity.fromMap(Map<String, dynamic> map) {
    return EnderecoEntity(
      cep: map['cep'],
      rua: map['logradouro'],
      bairro: map['bairro'],
      cidade: map['localidade'],
      uf: map['uf'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoEntity.fromJson(String source) => EnderecoEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnderecoEntity(cep: $cep, rua: $rua, bairro: $bairro, cidade: $cidade, uf: $uf)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EnderecoEntity &&
      other.cep == cep &&
      other.rua == rua &&
      other.bairro == bairro &&
      other.cidade == cidade &&
      other.uf == uf;
  }

  @override
  int get hashCode {
    return cep.hashCode ^
      rua.hashCode ^
      bairro.hashCode ^
      cidade.hashCode ^
      uf.hashCode;
  }
}
