import 'package:caritas/Pages/Article/ArticleView.dart';
import 'package:caritas/Utils/ArticleUtil.dart';
import 'package:flutter/cupertino.dart';
import 'package:universal_io/io.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';

class URLUtil {
  static openUrl(String url, BuildContext context,
      {String? appUrlScheme, bool openLocalArtical = false}) async {
    // 如果链接匹配本地文章, 则跳转到本地文章页面, 而不是知乎页面
    if (openLocalArtical) {
      var article = ArticleUtil.findArticleByUrl(url);
      if (article != null) {
        await Navigator.of(context).push(CupertinoPageRoute(
            builder: (BuildContext context) => ArticleView(
                  article,
                )));
        return;
      }
    }

    /// 试了下，安卓并不能成功调起 schema，只能通过在其他应用中打开链接的方式
    /// 因此只有 iOS 进行自动 schema 识别
    /// 同时由于安卓需要调起知乎 app，因此默认使用外部应用形式打开
    /// 只有 iOS 使用系统内置 webView
    LaunchMode mode = LaunchMode.externalApplication;
    if (Platform.isIOS) {
      appUrlScheme ??= _getZhihuScheme(url);
      mode = LaunchMode.platformDefault;
    }

    /// 无 scheme 情况
    if (appUrlScheme == null || appUrlScheme == "") {
      // Navigator.pushNamed(context, DunWebView.routeName, arguments: url);
      await launchUrlString(url, mode: mode);
      return;
    }
    /// 有 scheme 情况
    if (await canLaunchUrlString(appUrlScheme)) {
      // DunToast.showSuccess("正在唤起APP");
      await launchUrlString(appUrlScheme, mode: mode);
    } else {
      // DunToast.showError("没有检测到APP，正在打开网页");
      // Navigator.pushNamed(context, DunWebView.routeName, arguments: url);
      await launchUrlString(url, mode: mode);
    }
  }

  static openAppUrlScheme(String appUrlScheme, BuildContext context) async {
    if (await canLaunchUrlString(appUrlScheme)) {
      // DunToast.showSuccess("正在唤起APP");
      await launchUrlString(appUrlScheme, mode: LaunchMode.externalApplication);
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
