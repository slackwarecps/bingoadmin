import 'dart:convert';
import 'dart:io';
import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/services/web_client.dart';

import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class JournalService {
  static const String resource = "journals/";

  http.Client client = WebClient().client;

  String getURL() {
    return "${WebClient.url}$resource";
  }

  Uri getUri() {
    return Uri.parse(getURL());
  }

  Future<bool> register(Sorteio sorteio) async {
    String journalJSON = json.encode(sorteio.toMap());

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

  Future<bool> edit(String id, Sorteio journal) async {
    String journalJSON = json.encode(journal.toMap());

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

  Future<List<Sorteio>> getAll(String id) async {
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

    List<Sorteio> result = [];

    List<dynamic> jsonList = json.decode(response.body);
    for (var jsonMap in jsonList) {
      result.add(Sorteio.fromMap(jsonMap));
    }

    return result;
  }

  Future<bool> remove(String id) async {
    String token = await getToken();
    http.Response response = await client.delete(
      Uri.parse("${getURL()}$id"),
      headers: {
        'Content-type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode != 200) {
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
