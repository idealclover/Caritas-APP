import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../generated/l10n.dart';

import '../../Models/Db/DbHelper.dart';
import '../../Components/ArticleList.dart';
import '../Settings/SettingsProvider.dart';

class FavoriteView extends StatelessWidget {
  const FavoriteView({Key? key}) : super(key: key);

  List<Article> getFavArticleList() {
    List<String> favList = SettingsProvider().getFavorites();
    Box aBox = Hive.box("articles");
    return aBox.values
        .where((article) => (favList.contains(article.id)))
        .toList()
        .cast();
  }

  @override
  Widget build(BuildContext context) {
    List<Article> articleList = getFavArticleList();

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).fav_title),
        ),
        body: ArticleList(
          articleList,
          showFavIcon: false,
        ));
  }
}
