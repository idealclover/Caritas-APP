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

  static String m0(version) => "Now version v${version}";

  static String m1(version) => "v${version}";

  final messages = _notInlinedMessages(_notInlinedMessages);
  static Map<String, Function> _notInlinedMessages(_) => <String, Function>{
        "about_title": MessageLookupByLibrary.simpleMessage("About"),
        "already_newest_version_toast":
            MessageLookupByLibrary.simpleMessage("Already newest version~"),
        "app_name": MessageLookupByLibrary.simpleMessage("Foundation"),
        "cancel": MessageLookupByLibrary.simpleMessage("Cancel"),
        "change_theme_mode_subtitle":
            MessageLookupByLibrary.simpleMessage("Follow system theme?"),
        "change_theme_mode_title":
            MessageLookupByLibrary.simpleMessage("Mode Change"),
        "check_privacy_button":
            MessageLookupByLibrary.simpleMessage("Privacy Policy"),
        "check_update_button":
            MessageLookupByLibrary.simpleMessage("Check update"),
        "developer":
            MessageLookupByLibrary.simpleMessage("Developer: idealclover"),
        "donate_subtitle":
            MessageLookupByLibrary.simpleMessage("Buy me a cup of coffee!"),
        "donate_title": MessageLookupByLibrary.simpleMessage("Donate"),
        "easter_egg":
            MessageLookupByLibrary.simpleMessage("This is easter egg."),
        "github_open_source":
            MessageLookupByLibrary.simpleMessage("GitHub OpenSource"),
        "home_title": MessageLookupByLibrary.simpleMessage("首页"),
        "introduction": MessageLookupByLibrary.simpleMessage(
            "Blog:：https://idealclover.top\nEmail：idealclover@163.com"),
        "now_version": m0,
        "ok": MessageLookupByLibrary.simpleMessage("OK"),
        "open_source_library_content": MessageLookupByLibrary.simpleMessage(
            "fluttertoast: ^8.0.9\nflutter_native_splash: ^2.2.3+1\nget: ^4.6.5\nget_storage: ^2.0.3\npackage_info_plus: ^1.4.2\nshare_plus: ^4.0.10\nurl_launcher: ^6.1.4"),
        "open_source_library_title":
            MessageLookupByLibrary.simpleMessage("OpenSource Libraries"),
        "report_copy_message":
            MessageLookupByLibrary.simpleMessage("QQ number copied!"),
        "report_subtitle": MessageLookupByLibrary.simpleMessage(
            "Any bugs? Talk to us on Tencent QQ!\nTap to open QQ，long press to copy number."),
        "report_title": MessageLookupByLibrary.simpleMessage("Report"),
        "settings_title": MessageLookupByLibrary.simpleMessage("Settings"),
        "share_message":
            MessageLookupByLibrary.simpleMessage("This is share message."),
        "share_subtitle": MessageLookupByLibrary.simpleMessage(
            "Share this app to more friends!"),
        "share_title": MessageLookupByLibrary.simpleMessage("Share"),
        "theme_mode_always_dark":
            MessageLookupByLibrary.simpleMessage("Always Dark"),
        "theme_mode_always_light":
            MessageLookupByLibrary.simpleMessage("Always Light"),
        "theme_mode_customize":
            MessageLookupByLibrary.simpleMessage("Customize"),
        "theme_mode_follow_system":
            MessageLookupByLibrary.simpleMessage("Follow System"),
        "version": m1
      };
}
