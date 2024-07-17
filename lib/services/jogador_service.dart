import 'dart:convert';
import 'dart:io';

import 'package:bingoadmin/models/vendedor.dart';
import 'package:bingoadmin/services/web_client.dart';

import 'package:http/http.dart' as http;
import 'package:logger/web.dart';
import 'package:shared_preferences/shared_preferences.dart';

class JogadorService {
  static const String resource = "jogador";

  http.Client client = WebClient().client;

  final Logger logger = Logger();

  String getURL() {
    return "${WebClient.url}$resource";
  }

  Uri getUri() {
    return Uri.parse(getURL());
  }

  Future<bool> adiciona(Vendedor vendedor) async {
    logger.i("Adicionando vendedor $getUri()");
    vendedor.id = "";
    String journalJSON = json.encode(vendedor.toMap());
    logger.i(journalJSON);

    String token = await getToken();
    http.Response response = await client.post(
      getUri(),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: journalJSON,
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    return true;
  }

    Future<bool> register(Vendedor vendedor) async {
    String journalJSON = json.encode(vendedor.toMap());

    String token = await getToken();
    http.Response response = await client.post(
      getUri(),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: journalJSON,
    );

    if (response.statusCode != 201) {
      verifyException(json.decode(response.body));
    }

    return true;
  }

  Future<bool> edit(String id, Vendedor vendedor) async {
    String journalJSON = json.encode(vendedor.toMap());

    String token = await getToken();
    http.Response response = await client.put(
      Uri.parse("${getURL()}$id"),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
      body: journalJSON,
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    return true;
  }

  Future<List<Vendedor>> getAll(String id) async {
    String token = await getToken();
    http.Response response = await client.get(
      Uri.parse("${WebClient.url}users/$id/$resource"),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
      verifyException(json.decode(response.body));
    }

    List<Vendedor> result = [];

    List<dynamic> jsonList = json.decode(response.body);
    for (var jsonMap in jsonList) {
      result.add(Vendedor.fromMap(jsonMap));
    }

    return result;
  }

    Future<List<Vendedor>> getVendedores() async {
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

    List<Vendedor> result = [];

    List<dynamic> jsonList = json.decode(response.body);
    for (var jsonMap in jsonList) {
      result.add(Vendedor.fromMap(jsonMap));
    }

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
