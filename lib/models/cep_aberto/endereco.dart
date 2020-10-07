import 'package:loja_virtual/models/cep_aberto/endereco_constants.dart';

class Endereco {
  final double altitude;
  final String cep;
  final double latitude;
  final double longitude;
  final String logradouro;
  final String bairro;
  final Cidade cidade;
  final Estado estado;

  Endereco.fromMap(Map<String, dynamic> map)
      : altitude = map[enderecoAltitude] as double,
        cep = map[enderecoCep] as String,
        latitude = double.tryParse(map[enderecoLatitude] as String),
        longitude = double.tryParse(map[enderecoLatitude] as String),
        logradouro = map[enderecoLogradouro] as String,
        bairro = map[enderecoBairro] as String,
        cidade = Cidade.fromMap(map[enderecoCidade] as Map<String, dynamic>),
        estado = Estado.fromMap(map[enderecoEstado] as Map<String, dynamic>);

  @override
  String toString() {
    return 'Endereco{altitude: $altitude, cep: $cep, latitude: $latitude, longitude: $longitude, logradouro: $logradouro, bairro: $bairro, cidade: $cidade, estado: $estado}';
  }
}

class Cidade {
  final int ddd;
  final String ibge;
  final String nome;

  Cidade.fromMap(Map<String, dynamic> map)
      : ddd = map[cidadeDdd] as int,
        ibge = map[cidadeIbge] as String,
        nome = map[cidadeNome] as String;

  @override
  String toString() {
    return 'Cidade{ddd: $ddd, ibge: $ibge, nome: $nome}';
  }
}

class Estado {
  final String sigla;

  Estado.fromMap(Map<String, dynamic> map) : sigla = map[estadoSigla] as String;

  @override
  String toString() {
    return 'Estado{sigla: $sigla}';
  }
}
