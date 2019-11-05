import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gank/API/api_gank.dart';
import 'package:flutter_gank/model/gank_item.dart';
import 'package:flutter_gank/model/gank_post.dart';
import 'package:flutter_gank/network/http_manager.dart';
import 'package:flutter_gank/pages/webview_page.dart';
import 'package:flutter_gank/widget/gank_list_item.dart';
import 'package:flutter_gank/widget/gank_list_title.dart';
import 'package:flutter_swiper/flutter_swiper.dart';

class GankPage extends StatefulWidget {
  @override
  GankPageState createState() => GankPageState();
}

class GankPageState extends State<GankPage> {
  List<GankItem> _gankItems = [];
  List<GankItem> _girlItmes = [];

  @override
  void initState() {
    super.initState();
    _getGankData();
  }

  _getGankData() async {
    HttpResponse response = await GankApi.getTodayData();
    if (response.success) {
      var gankPost = GankPost.fromJson(response.data);
      setState(() {
        _gankItems = gankPost.gankItems;
        _girlItmes = gankPost.girlItems;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
          return [
            SliverAppBar(
              pinned: true,
              floating: true,
              expandedHeight: 260,
              elevation: 0,
              title: Text('今日推荐干货'),
              flexibleSpace: FlexibleSpaceBar(
                collapseMode: CollapseMode.pin,
                background:
                    _girlItmes.length == 0 ? SizedBox() : _buildSwiperWidget(),
              ),
            ),
          ];
        },
        body: ListView.builder(
          padding: EdgeInsets.all(0),
          itemCount: _gankItems.length,
          itemBuilder: (BuildContext context, int index) {
            var gankItem = _gankItems[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => WebViewPage(gankItem)),
                );
              },
              child: _buildListItem(gankItem),
            );
          },
        ),
      ),
    );
  }

  Widget _buildListItem(gankItem) {
    return gankItem.isTitle
        ? GankItemTitle(gankItem.category)
        : GankListItem(gankItem);
  }

  _buildSwiperWidget() {
    return Swiper(
      itemBuilder: (BuildContext context, int index) {
        GankItem ganItem = _girlItmes[index];
        return CachedNetworkImage(
          imageUrl: ganItem.url,
          fit: BoxFit.cover,
        );
      },
      itemCount: _girlItmes.length,
      pagination: SwiperPagination(),
    );
  }
}
