import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../Models/Db/DbHelper.dart';
import '../Utils/PrivacyUtil.dart';
import '../Utils/UmengUtil.dart';
import 'UpdateUtil.dart';

class InitUtil {
  static initBeforeStart() async {
    await GetStorage.init();
    Hive.registerAdapter(ArticleAdapter());
    Hive.registerAdapter(CategoryAdapter());
    await Hive.initFlutter();
    await initBox();
    UmengUtil.init();
  }

  static initAfterStart(context) async {
    await PrivacyUtil().checkPrivacy(context, false);
    await UpdateUtil().checkUpdate(context, false);
  }

  static initBox() async {

    bool exists = await Hive.boxExists('articles');
    var cBox = await Hive.openBox('categories');
    var aBox = await Hive.openBox('articles');
    // print(exists);
    if (exists) return;

    final String response = await rootBundle.loadString('res/data.json');
    final totalData = await json.decode(response);
    // print(totalData);

    for (Map data in totalData['categories']) {
      Category category = Category(title: data['title']);
      cBox.add(category);
    }
    for (Map data in totalData['articles']) {
      Article article = Article.fromJson(data.cast());
      aBox.add(article);
    }
  }
}
