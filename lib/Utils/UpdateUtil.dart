import 'package:universal_io/io.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart' hide Response;
import 'package:hive/hive.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../Components/SnackBar.dart';
import '../Models/Db/DbHelper.dart';
import '../generated/l10n.dart';

import '../Pages/Settings/SettingsProvider.dart';
import '../Pages/HomePage/HomePageView.dart';
import '../Components/Dialog.dart';
import '../Components/DownloadDialog.dart';
// import '../Components/Toast.dart';
import '../Components/TransBgTextButton.dart';
import '../Resources/Config.dart';

class UpdateUtil {
  checkUpdate(BuildContext context, bool isForce) async {
    int lastCheckUpdateTime = SettingsProvider().getLastCheckUpdateTime();
    int coolDownTime = SettingsProvider().getCooldownTime();

    DateTime now = DateTime.now();
    DateTime last = DateTime.fromMillisecondsSinceEpoch(lastCheckUpdateTime);
    var difference = now.difference(last);
//    print(difference.inSeconds);
//    print(now.millisecondsSinceEpoch);
    SettingsProvider().setLastCheckUpdateTime(now.millisecondsSinceEpoch);
    if (!isForce && difference.inSeconds < coolDownTime) return;

    Dio dio = Dio();
    String url;
    if (Platform.isIOS) {
      url = '${Config.apiBase}/ios.json';
    } else if (Platform.isAndroid) {
      url = '${Config.apiBase}/android.json';
    } else {
      return;
    }
    // print(url);
    PackageInfo packageInfo;
    Map data;
    try {
      packageInfo = await PackageInfo.fromPlatform();
      Response response = await dio.get(url);
      if (response.statusCode != HttpStatus.ok) throw (Error());
      data = response.data;
    } catch (e) {
      // print(e);
      return;
    }
    if (data['coolDownTime'] != null) {
      SettingsProvider().setCooldownTime(coolDownTime);
    }
    if (data['version'] > int.parse(packageInfo.buildNumber)) {
      await showUpdateDialog(data, context);
    } else if (isForce) {
      MSnackBar.showSnackBar(S.of(context).already_newest_version_toast, "");
      // Toast.showToast(S.of(context).already_newest_version_toast, context);
    }
  }

  showUpdateDialog(Map info, BuildContext context, {callback}) async {
    // UmengCommonSdk.onEvent("update_dialog", {"action": "show"});
    List<Widget> widgets;
    if (info['isForce']) {
      widgets = <Widget>[
        TransBgTextButton(
            color: Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).primaryColor
                : Colors.white,
            onPressed: () async {
              // UmengCommonSdk.onEvent(
              //     "update_dialog", {"action": "forceAccept"});
              if (callback != null) {
                callback(info['url']);
              } else {
                if (info['url'] != '') await launchUrlString(info['url']);
              }
            },
            child: Text(info['confirm_text'])),
      ];
    } else {
      widgets = <Widget>[
        TransBgTextButton(
          color: Colors.grey,
          onPressed: () {
            // UmengCommonSdk.onEvent("update_dialog", {"action": "cancel"});
            Navigator.of(context).pop();
          },
          child: Text(info['cancel_text']),
        ),
        TransBgTextButton(
            color: Theme.of(context).brightness == Brightness.light
                ? Theme.of(context).primaryColor
                : Colors.white,
            onPressed: () async {
              // UmengCommonSdk.onEvent("update_dialog", {"action": "accept"});
              if (callback != null) {
                callback(info['url']);
              } else {
                if (info['url'] != '') await launchUrlString(info['url']);
              }
            },
            child: Text(info['confirm_text'])),
      ];
    }
    await showDialog(
        context: context,
        barrierDismissible: !info['isForce'],
        builder: (context) => MDialog(
              info['title'],
              Text(info['content']),
              overrideActions: widgets,
            ));
  }

  checkDbUpdate(BuildContext context, bool isForce) async {
    // TODO: need to be improved

    int lastCheckUpdateTime = SettingsProvider().getDbLastCheckUpdateTime();
    int coolDownTime = SettingsProvider().getDbCooldownTime();

    DateTime now = DateTime.now();
    DateTime last = DateTime.fromMillisecondsSinceEpoch(lastCheckUpdateTime);
    var difference = now.difference(last);
//    print(difference.inSeconds);
//    print(now.millisecondsSinceEpoch);
    SettingsProvider().setLastCheckUpdateTime(now.millisecondsSinceEpoch);
    if (!isForce && difference.inSeconds < coolDownTime) return;

    Dio dio = Dio();
    String url;
    url = '${Config.apiBase}/database.json';
    // print(url);

    int localDbVersion = SettingsProvider().getDbVersion();

    Map data;
    try {
      Response response = await dio.get(url);
      if (response.statusCode != HttpStatus.ok) throw (Error());
      data = response.data;
    } catch (e) {
      // print(e);
      return;
    }
    if (data['coolDownTime'] != null) {
      SettingsProvider().setDbCooldownTime(coolDownTime);
    }
    if (data['version'] > localDbVersion) {
      await showUpdateDialog(data, context, callback: (url) async {
        Navigator.of(context).pop();
        DownloadDialog downloadDialog = DownloadDialog();
        showDialog(
            context: context,
            builder: (context) {
              return downloadDialog;
            });
        try {
          Response response = await dio.get(
            url,
            onReceiveProgress: showDownloadProgress,
          );
          // print(response.data);

          var cBox = await Hive.openBox('categories');
          var aBox = await Hive.openBox('articles');
          // print(response.data["categories"][0]);
          final totalData = response.data;
          // print(totalData);

          await cBox.clear();
          await aBox.clear();
          for (Map data in totalData['categories']) {
            Category category = Category(title: data['title']);
            cBox.add(category);
          }
          for (Map data in totalData['articles']) {
            Article article = Article.fromJson(data.cast());
            aBox.add(article);
          }
          SettingsProvider().setDbVersion(totalData['version']);
          Navigator.of(context).pop();
          MSnackBar.showSnackBar(S.of(context).db_update_success_toast, "");
          // Toast.showToast(S.of(context).db_update_success_toast, context);
          Get.offAll(() => const MyHomePage(title: 'Caritas'));
        } catch (e) {
          Navigator.of(context).pop();
          MSnackBar.showSnackBar(S.of(context).db_update_fail_toast, "");
          // Toast.showToast(S.of(context).db_update_fail_toast, context);
        }
      });
    } else if (isForce) {
      MSnackBar.showSnackBar(S.of(context).already_newest_version_toast, "");
      // Toast.showToast(S.of(context).already_newest_version_toast, context);
    }
  }

  void showDownloadProgress(received, total) {
    if (total != -1) {
      // print((received / total * 100).toStringAsFixed(0) + "%");
    }
  }
}
