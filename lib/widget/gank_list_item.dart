import 'package:flutter/material.dart';
import 'package:flutter_gank/model/gank_item.dart';
import 'package:flutter_gank/utils/time_utils.dart';

class GankListItem extends StatefulWidget {
  final GankItem gankItem;
  GankListItem(this.gankItem);

  @override
  GankListItemState createState() => GankListItemState();
}

class GankListItemState extends State<GankListItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).canvasColor,
        border: Border(
          bottom: BorderSide(width: 0.0, color: Theme.of(context).dividerColor),
        ),
      ),
      child: _buildGankListItem(context),
    );
  }

  _buildGankListItem(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          Container(
            padding: EdgeInsets.only(top: 16, bottom: 16, left: 16, right: 10),
            width: MediaQuery.of(context).size.width - 80,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(bottom: 16),
                  child: Text(
                    widget.gankItem.desc,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.subhead,
                  ),
                ),
                Container(
                  child: Row(
                    children: <Widget>[
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.person_outline,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 5),
                            SizedBox(
                              child: Text(
                                widget.gankItem.who,
                                style: Theme.of(context).textTheme.caption,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(width: 10),
                      Container(
                        child: Row(
                          children: <Widget>[
                            Icon(
                              Icons.access_time,
                              color: Theme.of(context).primaryColor,
                            ),
                            SizedBox(width: 5),
                            Text(
                              formatDateStr(widget.gankItem.publishedAt),
                              style: Theme.of(context).textTheme.caption,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Container(
            width: 80,
            color: Colors.black,
          ),
        ],
      ),
    );
  }
}
