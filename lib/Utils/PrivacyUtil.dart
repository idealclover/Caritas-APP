import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:get/get.dart' hide Response;
import 'package:universal_io/io.dart';

import '../Components/Dialog.dart';
import '../Components/TransBgTextButton.dart';
import '../Pages/Settings/SettingsProvider.dart';
import '../Resources/Config.dart';
import '../Utils/UmengUtil.dart';
import '../generated/l10n.dart';

class PrivacyUtil {
  Future<bool> checkPrivacy(BuildContext context, bool isForce) async {
    Map data = {};
    try {
      Dio dio = Dio();
      String url = '${Config.apiBase}/privacy.json';
      Response response = await dio.get(url);
      if (response.statusCode != HttpStatus.ok) throw Error();
      data = response.data;
    } catch (e) {
      data = {
        "version": 1,
        "title": "用户协议与隐私政策",
        "content":
            "<p>版本生效日期：2021-10-01</p><p>感谢使用Caritas APP！本应用由<b>idealclover</b>开发与发布。我们非常重视用户的隐私保护，绝不会在未经允许的情况下手机您的任何隐私内容。本文尽可能简短，强烈建议您认真阅读。</p><p><b>我们收集的数据</b><br>应用崩溃时产生的日志信息，以便于我们定位bug和改善应用健壮性；</p><p><b>集成的第三方 SDK</b><br>集成友盟+SDK，友盟+SDK需要收集您的设备Mac地址、唯一设备识别码（IMEI/android ID/IDFA/OPENUDID/GUID、SIM 卡 IMSI 信息）以提供统计分析服务，并通过地理位置校准报表数据准确性，提供基础反作弊能力。</p>",
        "isForce": false,
        "confirm_text_first_install": "同意协议，开始使用",
        "confirm_text_for_upgrade": "同意协议，开始使用",
        "cancel_text": "不同意并退出"
      };
    }
    int privacyVersion = SettingsProvider().getPrivacyVersion();
    int targetVersion = data['version'] ?? 0;
    isForce = isForce || (data['isForce'] ?? false);
    if (isForce || targetVersion > privacyVersion) {
      return await showPrivacyDialog(
          data, targetVersion, isForce, privacyVersion == -1, context);
    } else {
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
    // TODO: Notice: this is trick code and need to be rewrite!
    // check for this: https://github.com/Sub6Resources/flutter_html/issues/1165
    RenderObject.debugCheckingIntrinsics = true;
    return await showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => MDialog(
              info['title'],
              SingleChildScrollView(
                child: Html(data: info['content']),
              ),
              overrideActions: widgets,
            ));
  }
}
