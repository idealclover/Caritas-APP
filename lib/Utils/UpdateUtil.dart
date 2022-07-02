import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher_string.dart';
import '../generated/l10n.dart';

import '../Providers/SettingsProvider.dart';
import '../Components/Dialog.dart';
import '../Components/Toast.dart';
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
    print(url);
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    Response response = await dio.get(url);
    if (response.statusCode == HttpStatus.ok) {
      if (response.data['coolDownTime'] != null) {
        SettingsProvider().setCooldownTime(coolDownTime);
      }
      if (response.data['version'] > int.parse(packageInfo.buildNumber)) {
        await showUpdateDialog(response.data, context);
      } else if (isForce) {
        Toast.showToast(S.of(context).already_newest_version_toast, context);
      }
    }
  }

  showUpdateDialog(Map info, BuildContext context) async {
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
              if (info['url'] != '') await launchUrlString(info['url']);
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
              if (info['url'] != '') await launchUrlString(info['url']);
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
}
