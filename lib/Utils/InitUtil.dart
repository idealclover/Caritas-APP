import 'dart:io';
import 'dart:convert';
import 'dart:collection';
import 'package:caritas/Pages/Settings/SettingsProvider.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get_storage/get_storage.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:cloud_kit/cloud_kit.dart';

import '../Components/Toast.dart';
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
    if (Platform.isIOS) {
      iCloudSync(false);
    }
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
    /// 接住一切异常，不能让 icloud 同步影响 APP 正常启动
    try {
      const _key_histories = "histories";

      // final iCloudStorage =
      //     await ICloudStorage.getInstance('iCloud.top.idealclover.caritas');
      CloudKit cloudKit = CloudKit('iCloud.top.idealclover.caritas');

      String? cloudHistoryStr = await cloudKit.get(_key_histories);
      // print('cloud history');
      // print(cloudHistoryStr);
      List<String> localHistory = SettingsProvider().getHistories();
      // print('local history');
      // print(localHistory);
      List<String> resultHistory = localHistory;

      /// 先获取到整合后的列表
      if (cloudHistoryStr != null) {
        List<String> cloudHistory =
        List<String>.from(json.decode(cloudHistoryStr));
        List<String> combine;
        if (localFirst) {
          combine = localHistory + cloudHistory;
        } else {
          combine = cloudHistory + localHistory;
        }
        resultHistory = LinkedHashSet<String>.from(combine).toList();
      }
      String resultHistoryStr = json.encode(resultHistory);
      // print('combined history');
      // print(resultHistoryStr);

      /// 再将整合后的结果保存在本地与iCloud
      await SettingsProvider().replaceHistories(resultHistory);
      cloudKit.save(_key_histories, resultHistoryStr).then((value) {
        if (value) {
          Fluttertoast.showToast(msg: '同步 iCloud 成功');
          print('History sync to icloud');
        } else {
          Fluttertoast.showToast(msg: '同步 iCloud 失败');
          print('History fail sync to icloud');
        }
      }).onError((error, stackTrace) {
        print(error);
      });
      // bool isHisSuccess = await cloudKit.save(_key_histories, resultHistoryStr);
      // if (isHisSuccess) {
      //   print('History sync to icloud');
      // } else {
      //   print('History fail sync to icloud');
      // }
    } catch (e) {
      print(e);
    }

    /// favorites 这种情况 还不能光靠合并来解决 得想想其他办法
    // const _key_favorites = "favorites";
    // String? cloudFavoriteStr = await cloudKit.get(_key_favorites);
    // print(cloudFavoriteStr);
    // List<String> localFavorite = SettingsProvider().getFavorites();
    // List<String> resultFavorite = localFavorite;
    //
    // /// 先获取到整合后的列表
    // if (cloudFavoriteStr != null) {
    //   List<String> cloudFavorite =
    //       List<String>.from(json.decode(cloudFavoriteStr));
    //   List<String> combine = cloudFavorite + localFavorite;
    //   resultFavorite = LinkedHashSet<String>.from(combine).toList();
    // }
    // String resultFavoriteStr = json.encode(resultFavorite);
    // print(resultFavoriteStr);
    //
    // /// 再将整合后的结果保存在本地与iCloud
    // await SettingsProvider().replaceFavorites(resultFavorite);
    // bool isFavSuccess = await cloudKit.save(_key_favorites, resultFavoriteStr);
    // if (isFavSuccess) {
    //   print('Favorite sync to icloud');
    // } else {
    //   print('Favorite fail sync to icloud');
    // }
  }
}
