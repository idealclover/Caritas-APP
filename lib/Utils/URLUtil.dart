import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class URLUtil {
  static openUrl(String url, BuildContext context,
      {String? appUrlScheme}) async {
    appUrlScheme ??= _getZhihuScheme(url);
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

  static _getZhihuScheme(String url) {
    /// 识别知乎 URL
    /// 专栏 example: https://zhuanlan.zhihu.com/p/498759256
    /// 预期 output: zhihu://articles/498759256
    /// oia output: https://oia.zhihu.com/articles/498759256
    /// 问题 example: https://www.zhihu.com/question/485657993/answer/2158420471
    /// 预期 output: zhihu://answers/2158420471
    /// oia output: https://oia.zhihu.com/answers/2158420471
    // print(url);
    RegExp articleExp = RegExp(r"zhuanlan\.zhihu\.com\/p\/([0-9]*)");
    final matchArticle = articleExp.firstMatch(url);
    if (matchArticle != null) {
      final matchedArticleText = matchArticle.group(1);
      if (matchedArticleText != null) {
        // print('zhihu://articles/$matchedArticleText');
        return 'zhihu://articles/$matchedArticleText';
        // return 'https://oia.zhihu.com/articles/$matchedArticleText';
      }
    }
    RegExp answerExp =
        RegExp(r"www\.zhihu\.com\/question\/([0-9]*)\/answer\/([0-9]*)");
    final matchAnswer = answerExp.firstMatch(url);
    if (matchAnswer != null) {
      final matchedAnswerText = matchAnswer.group(2);
      if (matchedAnswerText != null) {
        // print('zhihu://answers/$matchedAnswerText');
        return 'zhihu://answers/$matchedAnswerText';
        // return 'https://oia.zhihu.com/answers/$matchedAnswerText';
      }
    }
    return null;
  }
}
