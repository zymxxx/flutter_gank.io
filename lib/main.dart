import 'package:flutter/material.dart';
import 'package:flutter_gank/pages/root_page.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return RefreshConfiguration(
      hideFooterWhenNotFull: true,
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData.light(),
        home: RootPage(),
      ),
    );
  }
}
