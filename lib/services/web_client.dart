import 'package:http/http.dart' as http;
import 'package:http_interceptor/http/http.dart';
import 'http_interceptors.dart';

class WebClient {
  //TODO: Adicionar seu IP aqui, use "ipconfig" no Windows ou "ifconfig" no Linux.
  //static const String url = "http://192.168.1.103:8080/";
   // static const String url = "https://62eaf501705264f263d17c49.mockapi.io/bingo/v1/";
    static const String url = "https://bingo-brasil-sorteio-core-prd.up.railway.app/sorteio-core/v1/";
    // https://bingo-brasil-sorteio-core-prd.up.railway.app

  // https://open-bingo.wiremockapi.cloud/

  http.Client client = InterceptedClient.build(
    interceptors: [LoggingInterceptor()],
    requestTimeout: const Duration(seconds: 5),
  );
}
