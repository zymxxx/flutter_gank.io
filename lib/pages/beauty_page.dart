import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_gank/API/api_gank.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class BeautyPage extends StatefulWidget {
  @override
  _BeautyPageState createState() => _BeautyPageState();
}

class _BeautyPageState extends State<BeautyPage> {
  List _gankItems = [];
  int _page = 1;
  bool isOneColumn = false;
  RefreshController _refreshController;

  @override
  void initState() {
    super.initState();
    _refreshController = RefreshController(initialRefresh: true);
    _refreshController.loadComplete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Beauty'),
        actions: <Widget>[
          IconButton(
            icon: Icon(
              Icons.sort,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                isOneColumn = !isOneColumn;
              });
            },
          ),
        ],
      ),
      body: SmartRefresher(
        controller: _refreshController,
        enablePullUp: true,
        onRefresh: _onRefresh,
        onLoading: _onLoading,
        child: _body(),
      ),
    );
  }

  void _onRefresh() async {
    _page = 1;
    var response = await GankApi.getCategoryData('福利', _page);
    if (response.success) {
      var gankItems = response.data['results'];
      _refreshController.refreshCompleted();
      setState(() {
        _gankItems = gankItems;
      });
    } else {
      _refreshController.refreshFailed();
    }
  }

  void _onLoading() async {
    _page++;
    var response = await GankApi.getCategoryData('福利', _page);
    if (response.success) {
      var gankItems = response.data['results'];
      _refreshController.loadComplete();
      setState(() {
        _gankItems.addAll(gankItems);
      });
    } else {
      _page--;
      _refreshController.loadFailed();
    }
  }

  Widget _body() {
    return GridView.builder(
      padding: EdgeInsets.all(10),
      physics: BouncingScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: isOneColumn ? 1 : 2,
          childAspectRatio: 0.7,
          crossAxisSpacing: 10),
      itemCount: _gankItems.length,
      itemBuilder: (BuildContext context, int index) {
        var gankItem = _gankItems[index];
        var mw690Url = gankItem['url'].replaceFirst("large", "mw690");
        return Padding(
          padding: EdgeInsets.only(bottom: 10),
          child: _imageItem(mw690Url),
        );
      },
    );
  }

  Widget _imageItem(String url) {
    return ClipRRect(
      borderRadius: BorderRadius.all(Radius.circular(10)),
      child: CachedNetworkImage(
        imageUrl: url,
        fit: BoxFit.cover,
      ),
    );
  }
}
