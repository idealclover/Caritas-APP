import 'dart:math';
import 'package:hive_flutter/hive_flutter.dart';

import '../../Pages/Settings/SettingsProvider.dart';
import '../../Models/Db/DbHelper.dart';

class ArticlePresenter {
  Future<List<Article>> getArticleList(Article article) async {
    Box aBox = Hive.box("articles");
    List<Article> rst = [];

    for (String link in article.links) {
      List<Article> a =
          aBox.values.where((article) => article.id == link).toList().cast();
      // print(a);
      if (a.isNotEmpty) {
        rst.add(a.first);
      }
    }
    return rst;
  }

  Future<List<Article>> getRandomArticleList(int num) async {
    Box aBox = Hive.box("articles");
    List<String> histories = SettingsProvider().getHistories();
    List<Article> rst = [];

    List<Article> a = aBox.values
        .where((article) => !histories.contains(article.id))
        .toList()
        .cast();
    // 如果所有都已读了，则选取全部文章
    if (a.isEmpty) {
      a = aBox.values
          .toList()
          .cast();
    }
    for(int i = 0; i < num; i++) {
      int rand = Random().nextInt(a.length);
      rst.add(a[rand]);
    }

    return rst;
  }

  setAsRead(Article article) {
    SettingsProvider().setHistories(article.id);
  }
}
