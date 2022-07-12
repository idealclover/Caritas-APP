import 'package:hive_flutter/hive_flutter.dart';

import '../../Models/Db/DbHelper.dart';

class ArticlePresenter {
  Future<List<Article>> getArticleList(article) async {
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
}
