import 'dart:convert';

class EnderecoEntity {
  String cep;
  String rua;
  String bairro;
  String cidade;
  String uf;
  String ddd;
  
  EnderecoEntity({
    required this.cep,
    required this.rua,
    required this.bairro,
    required this.cidade,
    required this.uf,
    required this.ddd,
  });

  EnderecoEntity copyWith({
    String? cep,
    String? rua,
    String? bairro,
    String? cidade,
    String? uf,
    String? ddd,
  }) {
    return EnderecoEntity(
      cep: cep ?? this.cep,
      rua: rua ?? this.rua,
      bairro: bairro ?? this.bairro,
      cidade: cidade ?? this.cidade,
      uf: uf ?? this.uf,
      ddd: ddd ?? this.ddd,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'cep': cep,
      'rua': rua,
      'bairro': bairro,
      'cidade': cidade,
      'uf': uf,
      'ddd': ddd,
    };
  }

  factory EnderecoEntity.fromMap(Map<String, dynamic> map) {
    return EnderecoEntity(
      cep: map['cep'],
      rua: map['rua'],
      bairro: map['bairro'],
      cidade: map['cidade'],
      uf: map['uf'],
      ddd: map['ddd'],
    );
  }

  String toJson() => json.encode(toMap());

  factory EnderecoEntity.fromJson(String source) => EnderecoEntity.fromMap(json.decode(source));

  @override
  String toString() {
    return 'EnderecoEntity(cep: $cep, rua: $rua, bairro: $bairro, cidade: $cidade, uf: $uf, ddd: $ddd)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is EnderecoEntity &&
      other.cep == cep &&
      other.rua == rua &&
      other.bairro == bairro &&
      other.cidade == cidade &&
      other.uf == uf &&
      other.ddd == ddd;
  }

  @override
  int get hashCode {
    return cep.hashCode ^
      rua.hashCode ^
      bairro.hashCode ^
      cidade.hashCode ^
      uf.hashCode ^
      ddd.hashCode;
  }
}
