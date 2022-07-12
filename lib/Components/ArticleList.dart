import 'package:flutter/material.dart';

import 'ArticleListItem.dart';
import '../Models/Db/DbHelper.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articleList;
  final bool showFavIcon;

  const ArticleList(this.articleList, {Key? key, this.showFavIcon = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        children: ListTile.divideTiles(context: context, tiles: [
      for (var item in articleList)
        ArticleListItemView(
          item,
          showFavIcon: showFavIcon,
        )
    ]).toList()
          ..add(const Divider(height: 1)));
  }
}
