import 'package:http_interceptor/http_interceptor.dart';
import 'package:logger/web.dart';

class LoggingInterceptor implements InterceptorContract {
  Logger logger = Logger();

  @override
  Future<RequestData> interceptRequest({required RequestData data}) async {
    //print(data.toString());
   // logger.t( "Requisiçao: ${data.baseUrl}\nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    return data;
  }

  @override
  Future<ResponseData> interceptResponse({required ResponseData data}) async {
    //print(data.toString());

    // if (data.statusCode ~/ 100 == 2) {
    //   logger.i( "Resposta: ${data.url}\nStatus da Resposta:${data.statusCode} \nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    // } else {
    //   logger.e(  "Resposta: ${data.url}\nStatus da Resposta:${data.statusCode} \nCabeçalhos: ${data.headers}\nCorpo: ${data.body}");
    // }

    return data;
  }
}
