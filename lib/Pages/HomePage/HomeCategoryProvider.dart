import 'package:hive_flutter/hive_flutter.dart';

import '../../Models/HomeCategoryModel.dart';
import '../../Models/Db/DbHelper.dart';

class HomeCategoryProvider {
  Future<List<HCategory>> getCategorieList() async {
    Box cbox = Hive.box('categories');
    var values = cbox.values;
    // print(values);
    List<HCategory> result = [];
    Box aBox = Hive.box("articles");
    print(aBox.values);
    for (Category category in values) {
      result.add(HCategory(
          category.title,
          aBox.values
              .where((article) => article.tags.contains(category.title))
              .toList()
              .cast()));
    }
    print(result);
    return result;
    // return [Category(title: 'qwq')];
  }

  Future<List<HomeCategory>> getHomeCategory() async {
    // TODO: to be implemented 获取文章分类
    List data = [
      {
        "id": 0,
        "title": "致读者",
        "contents": [
          {
            "id": 0,
            "title": "致读者-0",
            "intro": "关于 Caritas APP",
            "update_time": "4个月前"
          },
          {
            "id": 1,
            "title": "致读者-1",
            "intro": "你有哪些话想对知乎上关注的人说？",
            "update_time": "4个月前"
          }
        ]
      },
      {
        "id": 1,
        "title": "家族答集",
        "contents": [
          {"id": 2, "title": "门当户对", "intro": "什么才是门当户对", "update_time": "4个月前"}
        ]
      }
    ];
    List<HomeCategory> result = [];
    for (var category in data) {
      List<HomeCategoryItem> articles = [];
      for (var item in category['contents']) {
        articles.add(HomeCategoryItem(
            item['id'], item['title'], item['intro'], item['update_time']));
      }
      result.add(HomeCategory(category['id'], category['title'], articles));
    }
    return result;
  }
}
