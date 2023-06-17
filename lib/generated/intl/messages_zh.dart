// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a zh locale. All the
// messages from the main program should be duplicated here with the same
// function name.

// Ignore issues from commonly used lints in this file.
// ignore_for_file:unnecessary_brace_in_string_interps, unnecessary_new
// ignore_for_file:prefer_single_quotes,comment_references, directives_ordering
// ignore_for_file:annotate_overrides,prefer_generic_function_type_aliases
// ignore_for_file:unused_import, file_names, avoid_escaping_inner_quotes
// ignore_for_file:unnecessary_string_interpolations, unnecessary_string_escapes

import 'package:intl/intl.dart';
import 'package:intl/message_lookup_by_library.dart';

final messages = new MessageLookup();

typedef String MessageIfAbsent(String messageStr, List<dynamic> args);

class MessageLookup extends MessageLookupByLibrary {
  String get localeName => 'zh';

  static String m0(link) =>
      "> 扫描二维码导入记录\n> 或通过访问 [链接](${link}) 下载记录\n> 有效期一周，扫描一次后过期\n> 使用公共服务file.io";

  static String m1(version) => "当前版本 v${version}";

  static String m2(version) => "v${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_title": MessageLookupByLibrary.simpleMessage("关于"),
        "already_newest_version_toast":
            MessageLookupByLibrary.simpleMessage("已经是最新版本了呦～"),
        "app_name": MessageLookupByLibrary.simpleMessage("Caritas"),
        "cancel": MessageLookupByLibrary.simpleMessage("取消"),
        "change_theme_mode_subtitle":
            MessageLookupByLibrary.simpleMessage("是否跟随系统切换模式"),
        "change_theme_mode_title":
            MessageLookupByLibrary.simpleMessage("浅色/深色模式切换"),
        "check_privacy_button": MessageLookupByLibrary.simpleMessage("隐私政策"),
        "check_update_button": MessageLookupByLibrary.simpleMessage("检查更新"),
        "copied": MessageLookupByLibrary.simpleMessage("已复制到剪贴板"),
        "db_downloading": MessageLookupByLibrary.simpleMessage("下载中..."),
        "db_update_fail_toast": MessageLookupByLibrary.simpleMessage("数据更新失败！"),
        "db_update_success_toast":
            MessageLookupByLibrary.simpleMessage("数据更新完成！～"),
        "developer": MessageLookupByLibrary.simpleMessage("开发者 idealclover"),
        "device_push_id": MessageLookupByLibrary.simpleMessage("当前设备推送 id"),
        "donate_subtitle": MessageLookupByLibrary.simpleMessage("给傻翠买支棒棒糖吧！"),
        "donate_title": MessageLookupByLibrary.simpleMessage("投喂"),
        "easter_egg": MessageLookupByLibrary.simpleMessage(
            "感谢 @大卫 提供的 1.0 版本、图标等关键信息\n感谢 @nell nell @g9qad 的内容授权\n感谢 @阿寜寜 @流水浮灯 提供的笔记文件\n感谢每一位读到这里的人\n以此APP送给每一位努力活下去的朋友\n\n\n"),
        "export_content": m0,
        "export_title": MessageLookupByLibrary.simpleMessage("导出"),
        "export_to_file_subtitle":
            MessageLookupByLibrary.simpleMessage("导出阅读与收藏记录到文件"),
        "export_to_file_title":
            MessageLookupByLibrary.simpleMessage("导出记录到文件/二维码"),
        "fav_add_toast": MessageLookupByLibrary.simpleMessage("已收藏"),
        "fav_button": MessageLookupByLibrary.simpleMessage("是否收藏"),
        "fav_del_toast": MessageLookupByLibrary.simpleMessage("已取消收藏"),
        "fav_title": MessageLookupByLibrary.simpleMessage("收藏"),
        "github_open_source": MessageLookupByLibrary.simpleMessage("GitHub 开源"),
        "his_title": MessageLookupByLibrary.simpleMessage("历史"),
        "home_title": MessageLookupByLibrary.simpleMessage("文集"),
        "import_from_file_subtitle":
            MessageLookupByLibrary.simpleMessage("从文件中导入阅读与收藏记录"),
        "import_from_file_title":
            MessageLookupByLibrary.simpleMessage("从文件导入记录"),
        "import_from_qrcode_subtitle":
            MessageLookupByLibrary.simpleMessage("通过二维码扫描导入阅读与收藏记录"),
        "import_from_qrcode_title":
            MessageLookupByLibrary.simpleMessage("从二维码导入记录"),
        "import_qr_title": MessageLookupByLibrary.simpleMessage("二维码导入"),
        "import_success_toast": MessageLookupByLibrary.simpleMessage("数据导入成功"),
        "introduction": MessageLookupByLibrary.simpleMessage(
            "博客：https://idealclover.top\nEmail：idealclover@163.com"),
        "network_error_toast": MessageLookupByLibrary.simpleMessage("网络错误，请重试"),
        "next_article": MessageLookupByLibrary.simpleMessage("下一篇"),
        "now_version": m1,
        "ok": MessageLookupByLibrary.simpleMessage("确认"),
        "open_in_browser_button":
            MessageLookupByLibrary.simpleMessage("浏览器内打开"),
        "open_source_library_content": MessageLookupByLibrary.simpleMessage(
            "cloud_kit: ^1.1.0 (modified)\ndio: ^4.0.6\nfile_picker: ^5.0.0\nflutter_markdown: ^0.6.10+2\nfluttertoast: ^8.0.9\nflutter_html: ^3.0.0-alpha.5\nflutter_native_splash: ^2.2.3+1\nflutter_search_bar: ^3.0.0 (modified)\nget: ^4.6.5\nget_storage: ^2.0.3\nhive: ^2.2.3\nhive_flutter: ^1.1.0\npackage_info_plus: ^1.4.2\nqr_code_scanner: ^1.0.0\nqr_flutter: ^4.0.0\nshare_plus: ^4.0.10\numeng_common_sdk: ^1.2.4 (modified)\nuniversal_io: ^2.0.4\nurl_launcher: ^6.1.4"),
        "open_source_library_title":
            MessageLookupByLibrary.simpleMessage("所使用到的开源库"),
        "pre_article": MessageLookupByLibrary.simpleMessage("上一篇"),
        "qrcode_url_error_toast":
            MessageLookupByLibrary.simpleMessage("二维码无效，可能为链接过期"),
        "random_article": MessageLookupByLibrary.simpleMessage("随机文章"),
        "random_title": MessageLookupByLibrary.simpleMessage("随机"),
        "read_hide_toast": MessageLookupByLibrary.simpleMessage("已读文章藏起来啦～"),
        "read_show_toast": MessageLookupByLibrary.simpleMessage("已读文章又显示啦～"),
        "related_article": MessageLookupByLibrary.simpleMessage("相关阅读"),
        "report_copy_message":
            MessageLookupByLibrary.simpleMessage("已复制QQ号到剪贴板"),
        "report_subtitle":
            MessageLookupByLibrary.simpleMessage("轻触打开QQ反馈，长按复制号码"),
        "report_title": MessageLookupByLibrary.simpleMessage("反馈"),
        "settings_title": MessageLookupByLibrary.simpleMessage("设置"),
        "share_data_subtitle":
            MessageLookupByLibrary.simpleMessage("帮助我们提升产品体验"),
        "share_data_title": MessageLookupByLibrary.simpleMessage("共享阅读数据"),
        "share_message": MessageLookupByLibrary.simpleMessage(
            "Caritas APP 一个关于「爱」的 APP https://github.com/idealclover/Caritas-APP"),
        "share_subtitle": MessageLookupByLibrary.simpleMessage("把应用分享给更多小伙伴吧！"),
        "share_title": MessageLookupByLibrary.simpleMessage("分享"),
        "stat_articles": MessageLookupByLibrary.simpleMessage("文章"),
        "stat_byAuthor": MessageLookupByLibrary.simpleMessage("按作者"),
        "stat_byCatagory": MessageLookupByLibrary.simpleMessage("按分类"),
        "stat_sumArticles": MessageLookupByLibrary.simpleMessage("统计文章数"),
        "stat_sumWords": MessageLookupByLibrary.simpleMessage("统计字数"),
        "stat_title": MessageLookupByLibrary.simpleMessage("统计"),
        "stat_words": MessageLookupByLibrary.simpleMessage("字数"),
        "sync_button_subtitle":
            MessageLookupByLibrary.simpleMessage("导入/导出阅读与收藏数据"),
        "sync_button_title": MessageLookupByLibrary.simpleMessage("数据同步"),
        "sync_from_icloud_subtitle":
            MessageLookupByLibrary.simpleMessage("从 iCloud 同步阅读记录（测试中，不稳定）"),
        "sync_from_icloud_title":
            MessageLookupByLibrary.simpleMessage("从 iCloud 同步(beta)"),
        "sync_icloud_subtitle":
            MessageLookupByLibrary.simpleMessage("同步阅读记录到 iCloud （测试中，不稳定）"),
        "sync_icloud_title":
            MessageLookupByLibrary.simpleMessage("同步到 iCloud (beta)"),
        "sync_title": MessageLookupByLibrary.simpleMessage("数据同步"),
        "theme_mode_always_dark": MessageLookupByLibrary.simpleMessage("深色模式"),
        "theme_mode_always_light": MessageLookupByLibrary.simpleMessage("浅色模式"),
        "theme_mode_customize": MessageLookupByLibrary.simpleMessage("自定义"),
        "theme_mode_follow_system":
            MessageLookupByLibrary.simpleMessage("跟随系统"),
        "update_database_subtitle":
            MessageLookupByLibrary.simpleMessage("获取最新数据"),
        "update_database_title": MessageLookupByLibrary.simpleMessage("更新数据库"),
        "version": m2
      };
}
