import 'package:flutter_gank/network/http_manager.dart';

class GankApi {
  static const String API_GANK_HOST = 'http://gank.io';
  static const String API_SPECIAL_DAY = "$API_GANK_HOST/api/day/";
  static const String API_DATA = "$API_GANK_HOST/api/data/";
  static const String API_TODAY = "$API_GANK_HOST/api/today";

  static getCategoryData(String category, int page, {int count = 10}) async {
    String url = API_DATA + category + "/$count/$page";
    HttpResponse response = await HttpManager().get(url);
    return response;
  }

  static Future getTodayData() async {
    HttpResponse response = await HttpManager().get(API_TODAY);
    return response;
  }
}
