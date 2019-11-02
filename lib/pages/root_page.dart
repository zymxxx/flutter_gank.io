import 'package:flutter/material.dart';
import 'package:flutter_gank/pages/beauty_page.dart';
import 'package:flutter_gank/pages/gank_page.dart';

class RootPage extends StatefulWidget {
  @override
  RootPageState createState() => RootPageState();
}

class RootPageState extends State<RootPage> {
  int _selectedIndex = 0;
  List<Widget> pages = [];

  @override
  void initState() {
    super.initState();
    pages..add(GankPage())..add(BeautyPage());
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.new_releases),
            title: Text('Gank'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.next_week),
            title: Text('最新'),
          ),
        ],
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
      ),
    );
  }
}
