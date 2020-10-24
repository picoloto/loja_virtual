import 'package:loja_virtual/models/endereco/cepaberto_endereco_constants.dart';

class CepabertoEndereco {
  final double altitude;
  final String cep;
  final double latitude;
  final double longitude;
  final String logradouro;
  final String bairro;
  final CepabertoCidade cidade;
  final CepabertoEstado estado;

  CepabertoEndereco.fromMap(Map<String, dynamic> map)
      : altitude = map[cepabertoEnderecoAltitude] as double,
        cep = map[cepabertoEnderecoCep] as String,
        latitude = double.tryParse(map[cepabertoEnderecoLatitude] as String),
        longitude = double.tryParse(map[cepabertoEnderecoLongitude] as String),
        logradouro = map[cepabertoEnderecoLogradouro] as String,
        bairro = map[cepabertoEnderecoBairro] as String,
        cidade = CepabertoCidade.fromMap(
            map[cepabertoEnderecoCidade] as Map<String, dynamic>),
        estado = CepabertoEstado.fromMap(
            map[cepabertoEnderecoEstado] as Map<String, dynamic>);

  @override
  String toString() {
    return 'Endereco{altitude: $altitude, cep: $cep, latitude: $latitude, longitude: $longitude, logradouro: $logradouro, bairro: $bairro, cidade: $cidade, estado: $estado}';
  }
}

class CepabertoCidade {
  final int ddd;
  final String ibge;
  final String nome;

  CepabertoCidade.fromMap(Map<String, dynamic> map)
      : ddd = map[cepabertoCidadeDdd] as int,
        ibge = map[cepabertoCidadeIbge] as String,
        nome = map[cepabertoCidadeNome] as String;

  @override
  String toString() {
    return 'Cidade{ddd: $ddd, ibge: $ibge, nome: $nome}';
  }
}

class CepabertoEstado {
  final String sigla;

  CepabertoEstado.fromMap(Map<String, dynamic> map)
      : sigla = map[cepabertoEstadoSigla] as String;

  @override
  String toString() {
    return 'Estado{sigla: $sigla}';
  }
}
