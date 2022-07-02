import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class URLUtil {
  static openUrl(String url, BuildContext context,
      {String? appUrlScheme}) async {
    // 无 scheme 情况
    if (appUrlScheme == null || appUrlScheme == "") {
      // Navigator.pushNamed(context, DunWebView.routeName, arguments: url);
      await launchUrlString(url);
      return;
    }
    // 有 scheme 情况
    if (await canLaunchUrlString(appUrlScheme)) {
      // DunToast.showSuccess("正在唤起APP");
      await launchUrlString(appUrlScheme);
    } else {
      // DunToast.showError("没有检测到APP，正在打开网页");
      // Navigator.pushNamed(context, DunWebView.routeName, arguments: url);
      await launchUrlString(url);
    }
  }

  static openAppUrlScheme(String appUrlScheme, BuildContext context) async {
    if (await canLaunchUrlString(appUrlScheme)) {
      // DunToast.showSuccess("正在唤起APP");
      await launchUrlString(appUrlScheme);
    } else {
      // DunToast.showError("没有检测到对应app");
    }
  }
}
