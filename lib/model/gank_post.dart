import 'package:flutter_gank/model/gank_item.dart';

class GankPost {
  List<String> category;
  Map<String, List<GankItem>> itemDataMap = Map();
  List<GankItem> girlItems = [];
  List<GankItem> gankItems = [];

  GankPost();

  GankPost.fromJson(Map<String, dynamic> json) {
    category = json['category']?.map<String>((c) => c.toString())?.toList();
    Map<String, dynamic> results = json['results'];
    
    for (String key in results.keys) {
      var value = results[key];
      if (key != '福利') {
        itemDataMap[key] = _createGankItemListFromJson(key, value);
      } else {
        girlItems = _createGankItemListFromJson(key, value);
      }
    }
  }
  List<GankItem> _createGankItemListFromJson(String name, List value) {
    var gankItemList = value
        .map<GankItem>((item) => GankItem.fromJson(item, category: name))
        .toList();
    gankItems.add(GankItem.title(true, name));
    gankItems.addAll(gankItemList);
    return gankItemList;
  }
}
