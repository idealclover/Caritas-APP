import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../generated/l10n.dart';
import 'package:get/get.dart' hide Response;

import 'package:flutter_html/flutter_html.dart';
import 'package:foundation/Providers/SettingsProvider.dart';
import '../Components/Dialog.dart';
import '../Components/TransBgTextButton.dart';
import '../Resources/Config.dart';
import '../Utils/UmengUtil.dart';

class PrivacyUtil {
  Future<bool> checkPrivacy(BuildContext context, bool isForce) async {
    try {
      Dio dio = Dio();
      String url = '${Config.apiBase}/privacy.json';
      Response response = await dio.get(url);
      if (response.statusCode != HttpStatus.ok) return false;
      int privacyVersion = SettingsProvider().getPrivacyVersion();
      int targetVersion = response.data['version'] ?? 0;
      isForce = isForce || (response.data['isForce'] ?? false);
      if (isForce || targetVersion > privacyVersion) {
        return await showPrivacyDialog(response.data, targetVersion, isForce,
            privacyVersion == -1, context);
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<bool> showPrivacyDialog(Map info, int version, bool isForce,
      bool firstInstall, BuildContext context) async {
    List<Widget> widgets;
    UmengUtil.onEvent("privacy_dialog", {"action": "show"});
    widgets = isForce

        ///强制同意场景
        ? <Widget>[
            TransBgTextButton(
                color: Theme.of(context).brightness == Brightness.light
                    ? Theme.of(context).primaryColor
                    : Colors.white,
                child: Text(S.of(context).ok),
                onPressed: () {
                  UmengUtil.onEvent(
                      "privacy_dialog", {"action": "forceAccept"});
                  Get.back(result: false);
                })
          ]
        : <Widget>[
            ///非强制同意场景
            TransBgTextButton(
                color: Colors.grey,
                child: Text(info['cancel_text']),
                onPressed: () {
                  UmengUtil.onEvent("privacy_dialog", {"action": "cancel"});
                  SystemChannels.platform
                      .invokeMethod<void>('SystemNavigator.pop', true);
                }),
            firstInstall

                /// 首次安装
                ? TransBgTextButton(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    child: Text(info['confirm_text_first_install']),
                    onPressed: () async {
                      SettingsProvider().setPrivacyVersion(version);
                      UmengUtil.onEvent("privacy_dialog", {"action": "accept"});
                      Get.back(result: true);
                    })

                /// 非首次安装
                : TransBgTextButton(
                    color: Theme.of(context).brightness == Brightness.light
                        ? Theme.of(context).primaryColor
                        : Colors.white,
                    child: Text(info['confirm_text_for_upgrade']),
                    onPressed: () async {
                      SettingsProvider().setPrivacyVersion(version);
                      UmengUtil.onEvent(
                          "privacy_dialog", {"action": "acceptUpgrade"});
                      Get.back(result: false);
                    }),
          ];
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MDialog(
              info['title'],
              SingleChildScrollView(child: Html(data: info['content'])),
              overrideActions: widgets,
            ));
  }
}
