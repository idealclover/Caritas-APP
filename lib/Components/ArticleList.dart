import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Models/Db/DbHelper.dart';
import '../Pages/Article/ArticleView.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articleList;

  const ArticleList(this.articleList, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: ListTile.divideTiles(context: context, tiles: [
      for (var item in articleList)
        ListTile(
          title: Text(item.title),
          subtitle: Text(item.question, overflow: TextOverflow.ellipsis),
          // trailing: Text(item.lastUpdate),
          onTap: () {
            Navigator.of(context).push(MaterialPageRoute(
                builder: (BuildContext context) => ArticleView(item)));
          },
        )
    ]).toList()
          ..add(const Divider(height: 1)));
  }
}
