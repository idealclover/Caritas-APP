// GENERATED CODE - DO NOT MODIFY BY HAND
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'intl/messages_all.dart';

// **************************************************************************
// Generator: Flutter Intl IDE plugin
// Made by Localizely
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, lines_longer_than_80_chars
// ignore_for_file: join_return_with_assignment, prefer_final_in_for_each
// ignore_for_file: avoid_redundant_argument_values, avoid_escaping_inner_quotes

class S {
  S();

  static S? _current;

  static S get current {
    assert(_current != null,
        'No instance of S was loaded. Try to initialize the S delegate before accessing S.current.');
    return _current!;
  }

  static const AppLocalizationDelegate delegate = AppLocalizationDelegate();

  static Future<S> load(Locale locale) {
    final name = (locale.countryCode?.isEmpty ?? false)
        ? locale.languageCode
        : locale.toString();
    final localeName = Intl.canonicalizedLocale(name);
    return initializeMessages(localeName).then((_) {
      Intl.defaultLocale = localeName;
      final instance = S();
      S._current = instance;

      return instance;
    });
  }

  static S of(BuildContext context) {
    final instance = S.maybeOf(context);
    assert(instance != null,
        'No instance of S present in the widget tree. Did you add S.delegate in localizationsDelegates?');
    return instance!;
  }

  static S? maybeOf(BuildContext context) {
    return Localizations.of<S>(context, S);
  }

  /// `Foundation`
  String get app_name {
    return Intl.message(
      'Foundation',
      name: 'app_name',
      desc: '',
      args: [],
    );
  }

  /// `OK`
  String get ok {
    return Intl.message(
      'OK',
      name: 'ok',
      desc: '',
      args: [],
    );
  }

  /// `Cancel`
  String get cancel {
    return Intl.message(
      'Cancel',
      name: 'cancel',
      desc: '',
      args: [],
    );
  }

  /// `首页`
  String get home_title {
    return Intl.message(
      '首页',
      name: 'home_title',
      desc: '',
      args: [],
    );
  }

  /// `Settings`
  String get settings_title {
    return Intl.message(
      'Settings',
      name: 'settings_title',
      desc: '',
      args: [],
    );
  }

  /// `Mode Change`
  String get change_theme_mode_title {
    return Intl.message(
      'Mode Change',
      name: 'change_theme_mode_title',
      desc: '',
      args: [],
    );
  }

  /// `Follow system theme?`
  String get change_theme_mode_subtitle {
    return Intl.message(
      'Follow system theme?',
      name: 'change_theme_mode_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `Follow System`
  String get theme_mode_follow_system {
    return Intl.message(
      'Follow System',
      name: 'theme_mode_follow_system',
      desc: '',
      args: [],
    );
  }

  /// `Always Light`
  String get theme_mode_always_light {
    return Intl.message(
      'Always Light',
      name: 'theme_mode_always_light',
      desc: '',
      args: [],
    );
  }

  /// `Always Dark`
  String get theme_mode_always_dark {
    return Intl.message(
      'Always Dark',
      name: 'theme_mode_always_dark',
      desc: '',
      args: [],
    );
  }

  /// `Customize`
  String get theme_mode_customize {
    return Intl.message(
      'Customize',
      name: 'theme_mode_customize',
      desc: '',
      args: [],
    );
  }

  /// `Share`
  String get share_title {
    return Intl.message(
      'Share',
      name: 'share_title',
      desc: '',
      args: [],
    );
  }

  /// `Share this app to more friends!`
  String get share_subtitle {
    return Intl.message(
      'Share this app to more friends!',
      name: 'share_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `This is share message.`
  String get share_message {
    return Intl.message(
      'This is share message.',
      name: 'share_message',
      desc: '',
      args: [],
    );
  }

  /// `Report`
  String get report_title {
    return Intl.message(
      'Report',
      name: 'report_title',
      desc: '',
      args: [],
    );
  }

  /// `Any bugs? Talk to us on Tencent QQ!\nTap to open QQ，long press to copy number.`
  String get report_subtitle {
    return Intl.message(
      'Any bugs? Talk to us on Tencent QQ!\nTap to open QQ，long press to copy number.',
      name: 'report_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `QQ number copied!`
  String get report_copy_message {
    return Intl.message(
      'QQ number copied!',
      name: 'report_copy_message',
      desc: '',
      args: [],
    );
  }

  /// `Donate`
  String get donate_title {
    return Intl.message(
      'Donate',
      name: 'donate_title',
      desc: '',
      args: [],
    );
  }

  /// `Buy me a cup of coffee!`
  String get donate_subtitle {
    return Intl.message(
      'Buy me a cup of coffee!',
      name: 'donate_subtitle',
      desc: '',
      args: [],
    );
  }

  /// `About`
  String get about_title {
    return Intl.message(
      'About',
      name: 'about_title',
      desc: '',
      args: [],
    );
  }

  /// `v{version}`
  String version(Object version) {
    return Intl.message(
      'v$version',
      name: 'version',
      desc: '',
      args: [version],
    );
  }

  /// `Check update`
  String get check_update_button {
    return Intl.message(
      'Check update',
      name: 'check_update_button',
      desc: '',
      args: [],
    );
  }

  /// `Already newest version~`
  String get already_newest_version_toast {
    return Intl.message(
      'Already newest version~',
      name: 'already_newest_version_toast',
      desc: '',
      args: [],
    );
  }

  /// `Privacy Policy`
  String get check_privacy_button {
    return Intl.message(
      'Privacy Policy',
      name: 'check_privacy_button',
      desc: '',
      args: [],
    );
  }

  /// `Now version v{version}`
  String now_version(Object version) {
    return Intl.message(
      'Now version v$version',
      name: 'now_version',
      desc: '',
      args: [version],
    );
  }

  /// `GitHub OpenSource`
  String get github_open_source {
    return Intl.message(
      'GitHub OpenSource',
      name: 'github_open_source',
      desc: '',
      args: [],
    );
  }

  /// `Developer: idealclover`
  String get developer {
    return Intl.message(
      'Developer: idealclover',
      name: 'developer',
      desc: '',
      args: [],
    );
  }

  /// `Blog:：https://idealclover.top\nEmail：idealclover@163.com`
  String get introduction {
    return Intl.message(
      'Blog:：https://idealclover.top\nEmail：idealclover@163.com',
      name: 'introduction',
      desc: '',
      args: [],
    );
  }

  /// `OpenSource Libraries`
  String get open_source_library_title {
    return Intl.message(
      'OpenSource Libraries',
      name: 'open_source_library_title',
      desc: '',
      args: [],
    );
  }

  /// `fluttertoast: ^8.0.9\nflutter_native_splash: ^2.2.3+1\nget: ^4.6.5\nget_storage: ^2.0.3\npackage_info_plus: ^1.4.2\nshare_plus: ^4.0.10\nurl_launcher: ^6.1.4`
  String get open_source_library_content {
    return Intl.message(
      'fluttertoast: ^8.0.9\nflutter_native_splash: ^2.2.3+1\nget: ^4.6.5\nget_storage: ^2.0.3\npackage_info_plus: ^1.4.2\nshare_plus: ^4.0.10\nurl_launcher: ^6.1.4',
      name: 'open_source_library_content',
      desc: '',
      args: [],
    );
  }

  /// `This is easter egg.`
  String get easter_egg {
    return Intl.message(
      'This is easter egg.',
      name: 'easter_egg',
      desc: '',
      args: [],
    );
  }
}

class AppLocalizationDelegate extends LocalizationsDelegate<S> {
  const AppLocalizationDelegate();

  List<Locale> get supportedLocales {
    return const <Locale>[
      Locale.fromSubtags(languageCode: 'en'),
      Locale.fromSubtags(languageCode: 'zh'),
    ];
  }

  @override
  bool isSupported(Locale locale) => _isSupported(locale);
  @override
  Future<S> load(Locale locale) => S.load(locale);
  @override
  bool shouldReload(AppLocalizationDelegate old) => false;

  bool _isSupported(Locale locale) {
    for (var supportedLocale in supportedLocales) {
      if (supportedLocale.languageCode == locale.languageCode) {
        return true;
      }
    }
    return false;
  }
}
