import 'dart:convert';

import 'package:bingoadmin/models/sorteio.dart';
import 'package:bingoadmin/services/http_interceptors.dart';

import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';

class SorteioService {
  static const String url = "http://192.168.1.104:8080/";
  static const String resource = "sorteio/";

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
  );

  String getURL() {
    return "$url$resource";
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
}
