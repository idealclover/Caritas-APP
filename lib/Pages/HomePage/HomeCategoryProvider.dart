import 'package:hive_flutter/hive_flutter.dart';

import '../../Models/HomeCategoryModel.dart';
import '../../Models/Db/DbHelper.dart';

class HomeCategoryProvider {
  // Future<List<HomeCategory>> getCategorieList() async {
  List<HomeCategory> getCategorieList() {
    Box cbox = Hive.box('categories');
    var values = cbox.values;
    // print(values);
    List<HomeCategory> result = [];
    Box aBox = Hive.box("articles");
    // print(aBox.values);
    for (Category category in values) {
      result.add(HomeCategory(
          category.title,
          aBox.values
              .where((article) => article.tags.contains(category.title))
              .toList()
              .cast()));
    }
    // print(result);
    return result;
  }

  List<Article> getArticleSearchList(String value) {
    Box aBox = Hive.box("articles");
    List<Article> result = aBox.values
        .where((article) => (article.title.contains(value) ||
            article.content.contains(value)))
        .toList()
        .cast();
    return result;
  }
}
