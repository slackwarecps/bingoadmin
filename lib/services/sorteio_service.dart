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



  //TODO: Substituir getURL por getURI
  Future<bool> register(Sorteio sorteio) async {
    String jsonJournal = json.encode(sorteio.toMap());

    http.Response response = await client.post(Uri.parse(getURL()),
        headers: {'Content-type': 'application/json'}, body: jsonJournal);
    if (response.statusCode == 201) {
      return true;
    }
    return false;
  }

  void get() async {
    http.Response response = await client.get(Uri.parse(getURL()));
  }

 


  Future<List<Sorteio>> getSorteios() async {
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
          logger.i(jsonMap);
           if ( jsonMap['updatedAt']==null) {
            print (DateTime.now());
              print("NULLO");
           }
        
          //adiciona na lista 
          // converte o json para um objeto Sorteio
          result.add(Sorteio.fromMap(jsonMap));
        }

        //retorna a lista preenchida
        return result;
  }



  Future<bool> remove(String id) async {
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
