import 'package:flutter/material.dart';
import 'package:flutter_gank/model/gank_item.dart';
import 'package:flutter_webview_plugin/flutter_webview_plugin.dart';

class WebViewPage extends StatefulWidget {
  final GankItem gankItem;
  WebViewPage(this.gankItem);

  @override
  WebViewPageState createState() => WebViewPageState();
}

class WebViewPageState extends State<WebViewPage> {
  @override
  void initState() {
    super.initState();
    print(widget.gankItem.url);
  }

  @override
  Widget build(BuildContext context) {
    return WebviewScaffold(
      appBar: AppBar(
        title: Text(widget.gankItem.desc),
      ),
      url: widget.gankItem.url,
      withLocalStorage: true,
      hidden: true,
      initialChild: Column(
        children: <Widget>[
          SizedBox(
            height: 4,
            child: LinearProgressIndicator(),
          ),
        ],
      ),
    );
  }
}
