import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../Components/Toast.dart';
import '../Resources/Config.dart';
import '../generated/l10n.dart';
import 'URLUtil.dart';

class SettingsUtil {
  static shareUtil(context) async {
    Share.share(S.of(context).share_message);
  }

  static qqTapUtil(context) async {
    await URLUtil.openUrl(Config.qqUrl, context);
  }

  static qqLongPressUtil(context) async {
    await Clipboard.setData(const ClipboardData(text: Config.qqNumber));
    Toast.showToast(S.of(context).report_copy_message, context);
  }

  static donateUtil(context) async {
    await URLUtil.openUrl(Config.donateUrl, context);
  }
}
