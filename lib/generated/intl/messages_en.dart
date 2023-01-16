// DO NOT EDIT. This is code generated via package:intl/generate_localized.dart
// This is a library that provides messages for a en locale. All the
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
  String get localeName => 'en';

  static String m0(link) =>
      "> Scan QR Code to import.\n> Or visit [link](${link}) to download histories.\n> Expired 1 week later.\n> Supported by file.io";

  static String m1(version) => "Now version v${version}";

  static String m2(version) => "v${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_title": MessageLookupByLibrary.simpleMessage("About"),
        "already_newest_version_toast":
            MessageLookupByLibrary.simpleMessage("Already newest version~"),
        "app_name": MessageLookupByLibrary.simpleMessage("Caritas"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "change_theme_mode_subtitle":
            MessageLookupByLibrary.simpleMessage("Follow system theme?"),
        "change_theme_mode_title":
            MessageLookupByLibrary.simpleMessage("Mode Change"),
        "check_privacy_button":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "check_update_button":
            MessageLookupByLibrary.simpleMessage("Check update"),
        "copied": MessageLookupByLibrary.simpleMessage("Copied to clipboard."),
        "db_downloading":
            MessageLookupByLibrary.simpleMessage("Downloading..."),
        "db_update_fail_toast":
            MessageLookupByLibrary.simpleMessage("Database update fail!"),
        "db_update_success_toast":
            MessageLookupByLibrary.simpleMessage("Database updated!~"),
        "developer":
            MessageLookupByLibrary.simpleMessage("Developer: idealclover"),
        "device_push_id":
            MessageLookupByLibrary.simpleMessage("Device push id"),
        "donate_subtitle":
            MessageLookupByLibrary.simpleMessage("Buy me a cup of coffee!"),
        "donate_title": MessageLookupByLibrary.simpleMessage("Donate"),
        "easter_egg": MessageLookupByLibrary.simpleMessage(
            "感谢 @大卫 提供的 1.0 版本、图标等关键信息\n感谢 @nell nell @g9qad 的内容授权\n感谢 @阿寜寜 @流水浮灯 提供的笔记文件\n感谢每一位读到这里的人\n以此APP送给每一位努力活下去的朋友\n\n\n"),
        "export_content": m0,
        "export_title": MessageLookupByLibrary.simpleMessage("Export"),
        "export_to_file_subtitle": MessageLookupByLibrary.simpleMessage(
            "Export history to file/qrcode."),
        "export_to_file_title":
            MessageLookupByLibrary.simpleMessage("Export history"),
        "fav_add_toast":
            MessageLookupByLibrary.simpleMessage("Added to favorites."),
        "fav_button": MessageLookupByLibrary.simpleMessage("is favorite"),
        "fav_del_toast":
            MessageLookupByLibrary.simpleMessage("Removed from favorites."),
        "fav_title": MessageLookupByLibrary.simpleMessage("Favorites"),
        "github_open_source":
            MessageLookupByLibrary.simpleMessage("GitHub OpenSource"),
        "his_title": MessageLookupByLibrary.simpleMessage("Histories"),
        "home_title": MessageLookupByLibrary.simpleMessage("Articles"),
        "import_from_file_subtitle":
            MessageLookupByLibrary.simpleMessage("Import history from file."),
        "import_from_file_title":
            MessageLookupByLibrary.simpleMessage("Import from file"),
        "import_from_qrcode_subtitle":
            MessageLookupByLibrary.simpleMessage("Import history from QRCode."),
        "import_from_qrcode_title":
            MessageLookupByLibrary.simpleMessage("Import from QRCode"),
        "import_qr_title":
            MessageLookupByLibrary.simpleMessage("QR Code Import"),
        "import_success_toast":
            MessageLookupByLibrary.simpleMessage("Data imported successfully."),
        "introduction": MessageLookupByLibrary.simpleMessage(
            "Blog:：https://idealclover.top\nEmail：idealclover@163.com"),
        "network_error_toast":
            MessageLookupByLibrary.simpleMessage("Network error."),
        "next_article": MessageLookupByLibrary.simpleMessage("Next"),
        "now_version": m1,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "open_in_browser_button":
            MessageLookupByLibrary.simpleMessage("Open in browser."),
        "open_source_library_content": MessageLookupByLibrary.simpleMessage(
            "cloud_kit: ^1.1.0 (modefied)\ndio: ^4.0.6\nfile_picker: ^5.0.0\nflutter_markdown: ^0.6.10+2\nfluttertoast: ^8.0.9\nflutter_html: ^3.0.0-alpha.5\nflutter_native_splash: ^2.2.3+1\nflutter_search_bar: ^3.0.0 (modefied)\nget: ^4.6.5\nget_storage: ^2.0.3\nhive: ^2.2.3\nhive_flutter: ^1.1.0\npackage_info_plus: ^1.4.2\nqr_code_scanner: ^1.0.0\nqr_flutter: ^4.0.0\nshare_plus: ^4.0.10\numeng_common_sdk: ^1.2.4 (modefied)\nuniversal_io: ^2.0.4\nurl_launcher: ^6.1.4"),
        "open_source_library_title":
            MessageLookupByLibrary.simpleMessage("OpenSource Libraries"),
        "pre_article": MessageLookupByLibrary.simpleMessage("Previous"),
        "qrcode_url_error_toast": MessageLookupByLibrary.simpleMessage(
            "QR code is invalid, maybe expired."),
        "random_article": MessageLookupByLibrary.simpleMessage("Random"),
        "random_title": MessageLookupByLibrary.simpleMessage("Random"),
        "read_hide_toast":
            MessageLookupByLibrary.simpleMessage("Read articles hid."),
        "read_show_toast":
            MessageLookupByLibrary.simpleMessage("Read articles showed."),
        "related_article": MessageLookupByLibrary.simpleMessage("Related"),
        "report_copy_message":
            MessageLookupByLibrary.simpleMessage("QQ number copied!"),
        "report_subtitle": MessageLookupByLibrary.simpleMessage(
            "Tap to open QQ，long press to copy number."),
        "report_title": MessageLookupByLibrary.simpleMessage("Report"),
        "settings_title": MessageLookupByLibrary.simpleMessage("Settings"),
        "share_data_subtitle": MessageLookupByLibrary.simpleMessage(
            "Help us improve our products."),
        "share_data_title":
            MessageLookupByLibrary.simpleMessage("Share Usage Data"),
        "share_message": MessageLookupByLibrary.simpleMessage(
            "Caritas APP - an APP about Love. https://github.com/idealclover/Caritas-APP"),
        "share_subtitle": MessageLookupByLibrary.simpleMessage(
            "Share this app to more friends!"),
        "share_title": MessageLookupByLibrary.simpleMessage("Share"),
        "stat_articles": MessageLookupByLibrary.simpleMessage("Articles"),
        "stat_byAuthor": MessageLookupByLibrary.simpleMessage("By Author"),
        "stat_byCatagory": MessageLookupByLibrary.simpleMessage("By Catagory"),
        "stat_sumArticles":
            MessageLookupByLibrary.simpleMessage("Sum Articles"),
        "stat_sumWords": MessageLookupByLibrary.simpleMessage("Sum Words"),
        "stat_title": MessageLookupByLibrary.simpleMessage("Statistics"),
        "stat_words": MessageLookupByLibrary.simpleMessage("Words"),
        "sync_button_subtitle": MessageLookupByLibrary.simpleMessage(
            "Import/export reading and favorite articles."),
        "sync_button_title": MessageLookupByLibrary.simpleMessage("Data Sync"),
        "sync_from_icloud_subtitle": MessageLookupByLibrary.simpleMessage(
            "Import history from iCloud (testing)."),
        "sync_from_icloud_title":
            MessageLookupByLibrary.simpleMessage("Import from iCloud (beta)"),
        "sync_icloud_subtitle": MessageLookupByLibrary.simpleMessage(
            "Sync history to iCloud (testing)"),
        "sync_icloud_title":
            MessageLookupByLibrary.simpleMessage("Sync to iCloud (beta)"),
        "sync_title": MessageLookupByLibrary.simpleMessage("Data Sync"),
        "theme_mode_always_dark":
            MessageLookupByLibrary.simpleMessage("Always Dark"),
        "theme_mode_always_light":
            MessageLookupByLibrary.simpleMessage("Always Light"),
        "theme_mode_customize":
            MessageLookupByLibrary.simpleMessage("Customize"),
        "theme_mode_follow_system":
            MessageLookupByLibrary.simpleMessage("Follow System"),
        "update_database_subtitle":
            MessageLookupByLibrary.simpleMessage("Get newest database"),
        "update_database_title":
            MessageLookupByLibrary.simpleMessage("Get database"),
        "version": m2
      };
}
