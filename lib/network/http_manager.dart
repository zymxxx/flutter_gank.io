import 'package:dio/dio.dart';

class HttpResponse {
  int code;
  var data;
  bool success;

  HttpResponse(this.data, this.success, this.code);
}

class HttpManager {
  Dio dio;

  factory HttpManager() => _getInstance();
  static HttpManager get sharedInstance => _getInstance();
  static HttpManager _instance;

  HttpManager._internal() {
    if (dio == null) {
      dio = Dio();
    }
  }

  static HttpManager _getInstance() {
    if (_instance == null) {
      _instance = HttpManager._internal();
    }
    return _instance;
  }

  Future<HttpResponse> post(url, {Map<String, dynamic> params}) async =>
      _request(dio.post(url, data: params));

  Future<HttpResponse> get(url, {Map<String, dynamic> params}) async =>
      _request(dio.get(url, queryParameters: params));

  Future<HttpResponse> _request(f) async {
    Response response;
    try {
      response = await f;
    } on DioError catch (e) {
      Response errorR = e.response ?? Response();
      return HttpResponse(e.message, false, errorR.statusCode);
    }

    try {
      if (response.statusCode == 200 || response.statusCode == 201) {
        return HttpResponse(response.data, true, 200);
      }
    } catch (e) {
      return HttpResponse(e.toString(), false, response.statusCode);
    }
    return HttpResponse('未知错误', false, response.statusCode);
  }
}
