import 'dart:io';

import 'package:dio/dio.dart';
import 'package:loja_virtual/models/endereco/cepaberto_endereco.dart';

const token = '1d1ad5f51adeb61132a0066f338bab83';

class CepAbertoService {
  Future<CepabertoEndereco> getAddressFromCep(String cep) async {
    final cleanCep = cep.replaceAll('.', '').replaceAll('-', '');
    final url = "https://www.cepaberto.com/api/v3/cep?cep=$cleanCep";
    final Dio dio = Dio();

    dio.options.headers[HttpHeaders.authorizationHeader] = 'Token token=$token';

    try {
      final response = await dio.get<Map<String, dynamic>>(url);

      if (response.data.isEmpty) {
        return Future.error('CEP Inválido');
      }

      final CepabertoEndereco endereco =
          CepabertoEndereco.fromMap(response.data);
      return endereco;
    } on DioError catch (e) {
      return Future.error('Erro ao buscar CEP');
    }
  }
}
