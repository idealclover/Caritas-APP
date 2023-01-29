import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../generated/l10n.dart';

import '../../Models/Db/DbHelper.dart';
import '../../Components/ArticleList.dart';
import '../Settings/SettingsProvider.dart';

class HistoryView extends StatelessWidget {
  const HistoryView({Key? key}) : super(key: key);

  List<Article> getHisArticleList() {
    List<String> hisList = SettingsProvider().getHistories();
    Box aBox = Hive.box("articles");
    List<Article> result = aBox.values
        .where((article) => (hisList.contains(article.id)))
        .toList()
        .cast();
    result.sort((a, b) => hisList.indexOf(a.id) - hisList.indexOf(b.id));
    return result;
  }

  @override
  Widget build(BuildContext context) {
    List<Article> articleList = getHisArticleList();

    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).his_title),
        ),
        body: ArticleList(
          articleList,
          showFavIcon: false,
          greyRead: false,
          useListView: true,
        ));
  }
}
