import 'package:flutter/material.dart';

import 'ArticleListItem.dart';
import '../Models/Db/DbHelper.dart';

class ArticleList extends StatelessWidget {
  final List<Article> articleList;
  final bool showFavIcon;

  const ArticleList(this.articleList, {Key? key, this.showFavIcon = true})
      : super(key: key);

  Article? getPre(Article article) {
    int i = articleList.indexOf(article);
    if (i == -1 || i == 0) {
      return null;
    } else {
      return articleList[i - 1];
    }
  }

  Article? getNext(Article article) {
    int i = articleList.indexOf(article);
    if (i == -1 || i == (articleList.length - 1)) {
      return null;
    } else {
      return articleList[i + 1];
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        children: ListTile.divideTiles(context: context, tiles: [
      for (int i = 0; i < articleList.length; i++)
        ArticleListItemView(
          articleList[i],
          showFavIcon: showFavIcon,
          getPre: getPre,
          getNext: getNext,
        )
    ]).toList()
          ..add(const Divider(height: 1)));
  }
}
