import 'package:flutter/material.dart';

class GankItemTitle extends StatefulWidget {
  final String category;

  GankItemTitle(this.category);

  @override
  _GankItemTitleState createState() => _GankItemTitleState();
}

class _GankItemTitleState extends State<GankItemTitle> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xfffbfbfb),
        border: Border(
          bottom: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
        ),
      ),
      child: Row(
        children: <Widget>[
          Container(
            margin: EdgeInsets.symmetric(vertical: 22),
            width: 4,
            height: 20,
            color: Theme.of(context).primaryColor,
          ),
          SizedBox(width: 12),
          Text(
            widget.category,
            style: Theme.of(context).textTheme.title,
          ),
        ],
      ),
    );
  }
}
