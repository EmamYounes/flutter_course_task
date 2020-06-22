import 'dart:async';
import 'dart:io';

import 'package:dio/dio.dart';
import 'network_error.dart';

enum ServerMethods { GET, POST, UPDATE, DELETE,PUT }
class Network with NetworkError {
  static final Network shared = new Network._private();
  Dio client = Dio();
  factory Network() {
    return shared;
  }

  Network._private(){
    (client.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate  = (_client) {
      _client.badCertificateCallback=(X509Certificate cert, String host, int port)=>true;
    };
  }

  Future performRequest(String endpoint, Map<String, dynamic> parms, ServerMethods method) async {

    return _performRequest(endpoint,
        queryParms: method == ServerMethods.GET||method ==ServerMethods.PUT ? parms : {},
        bodyParms: method != ServerMethods.GET||method ==ServerMethods.PUT ? parms : {},
        method: method.toString().split(".").last);
  }

  Future _performRequest(String endpoint,
      {Map<String, dynamic> bodyParms,
        Map<String, dynamic> queryParms,
        String method}) async {
    try {
      Response response = await client.request(endpoint,
          data: bodyParms,
          queryParameters: queryParms,
          options: Options(method: method ?? "GET"));

      return response;
    } on SocketException catch(e){
      throw {"code":500,"error":["لا يوجد اتصال بالانترنت"]};
    }
    catch (e) {
      print("errorrrrrr $e");
      throw e.response.data;
    }
  }
}
