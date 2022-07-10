import './Db/DbHelper.dart';

class HomeCategory {
  int id;
  String title;
  List<HomeCategoryItem> itemList;

  HomeCategory(this.id, this.title, this.itemList);
}

class HomeCategoryItem {
  int id;
  String title;
  String intro;
  String? zhihuId;
  String updateTime;

  HomeCategoryItem(this.id, this.title, this.intro, this.updateTime,
      {this.zhihuId});
}

class HCategory {
  String title;
  List<Article> articles;

  HCategory(this.title, this.articles);
}
