import 'dart:convert';
import 'dart:io';

import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/services/http_interceptors.dart';
import 'package:bingoadmin/services/web_client.dart';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'package:logger/logger.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SorteioService {
  
  http.Client client = WebClient().client;
  
  static const String resource = "sorteio";

final Logger logger = Logger();

  String getURL() {
    return "${WebClient.url}$resource";
  }

  Uri getUri() {
    return Uri.parse(getURL());
  }

  void get() async {
    http.Response response = await client.get(Uri.parse(getURL()));
  }



  // 01 ADICIONA UM SORTEIO
  Future<bool> adicionarSorteio(Sorteio sorteio) async {
    String jsonSorteio = json.encode(sorteio.toMap());

   // jsonSorteio = '{"nomex": null, "localx": null}';


    http.Response response = await client.post(Uri.parse(getURL()),
        headers: {'Content-type': 'application/json'}, body: jsonSorteio);
    if (response.statusCode != 201) {
      return false;
    }
    return true;
  }






 

 
  Future<List<Sorteio>> buscaTodos() async {
        String token = await getToken();
        http.Response response = await client.get(
          Uri.parse("${WebClient.url}$resource"),
          headers: {
            'Content-type': 'application/json',
            'Authorization': 'Bearer $token',
          },
        );

        if (response.statusCode != 200) {
          verifyException(json.decode(response.body));
        }
        //inicializa a lista
        List<Sorteio> result = [];

        //busca na api
        List<dynamic> jsonList = json.decode(response.body);

        //converte para objeto
        for (var jsonMap in jsonList) {       
          //adiciona na lista 
          // converte o json para um objeto Sorteio
          result.add(Sorteio.fromMap(jsonMap));
        }
        //retorna a lista preenchida
        return result;
  }



  Future<bool> updateSorteio(String id, Sorteio sorteio) async {
          String token = await getToken();
          String jsonSorteio = json.encode(sorteio.toMap());

         // await Future.delayed(Duration(seconds: 30));

          //quebra o json              
          //jsonSorteio = '{"nomex": "asd", "localx": "sabao"}';

              http.Response response = await client.put(
                Uri.parse("${getURL()}/$id"),
                headers: {
                  'Content-type': 'application/json',
                  'Authorization': 'Bearer $token',
                },
                body: jsonSorteio,
              );

        if (response.statusCode != 200) {
          throw HttpException("Code: ${response.statusCode} \nMessage: ${response.body}");

        } 
        return true;
  }

  Future<Sorteio?> getSorteioById(String id) async {
    String token = await getToken();
    http.Response response = await client.get(
      Uri.parse("${getURL()}/$id"),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      Map<String, dynamic> jsonMap = json.decode(response.body);
      return Sorteio.fromMap(jsonMap);
    } else {
      verifyException(json.decode(response.body));
      return null;
    }
  }



  Future<bool> removerSorteioPorId(String id) async {
    String token = await getToken();
    logger.i("removendo ${getURL()}/$id ");
    http.Response response = await client.delete(
      Uri.parse("${getURL()}/$id"),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 204) {
      verifyException(json.decode(response.body));
    }

    return true;
  }

  Future<String> getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? token = prefs.getString('accessToken');
    if (token != null) {
      return token;
    }
    return '';
  }

  verifyException(String error) {
    switch (error) {
      case 'jwt expired':
        throw TokenExpiredException();
    }

    throw HttpException(error);
  }
}

class TokenExpiredException implements Exception {}

class DeuRuimNaAPIException implements Exception {}
