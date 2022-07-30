import 'dart:convert';
import 'package:flutter/services.dart';

import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_kit/cloud_kit.dart';

import '../Components/SnackBar.dart';
import '../Models/Db/DbHelper.dart';
import '../Utils/DataSyncUtil.dart';
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
    await UpdateUtil().checkDbUpdate(context, false);
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

  static iCloudSync(bool localFirst) async {
    try {
      const _key_histories = "histories";
      const _key_favorites = "favorites";

      CloudKit cloudKit = CloudKit('iCloud.top.idealclover.caritas');

      String? cloudHistoryStr = await cloudKit.get(_key_histories);
      // print('cloud history');
      // print(cloudHistoryStr);

      String? cloudFavoriteStr = await cloudKit.get(_key_favorites);
      // print('cloud favorite');
      // print(cloudFavoriteStr);

      Map cloud = {"histories": [], "favorites": []};

      if (cloudHistoryStr != null) {
        cloud["histories"] = List<String>.from(json.decode(cloudHistoryStr));
      }

      if (cloudFavoriteStr != null) {
        cloud["favorites"] = List<String>.from(json.decode(cloudFavoriteStr));
      }

      Map combineRst = await DataSyncUtil.importFromJson(cloud, localFirst);

      bool rst_1 = await cloudKit.save(
          _key_histories, json.encode(combineRst['histories']));
      print(rst_1);
      bool rst_2 = await cloudKit.save(
          _key_favorites, json.encode(combineRst['favorites']));
      print(rst_2);
      if (rst_1 && rst_2) {
        MSnackBar.showSnackBar('同步 iCloud 成功', "");
        print('History sync to icloud');
      }
    } catch (e) {
      print(e);
      MSnackBar.showSnackBar('同步遇到错误', "");
    }
  }
}
