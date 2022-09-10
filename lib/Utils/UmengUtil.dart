import '../Pages/Settings/SettingsProvider.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';
import 'package:umeng_push_sdk/umeng_push_sdk.dart';
import 'package:get/get.dart';

import '../Resources/Config.dart';

class UmengUtil {
  static final bool _isMobile = GetPlatform.isAndroid || GetPlatform.isIOS;

  static init() {
    if (!_isMobile) return;
    UmengCommonSdk.initCommon(
        Config.umengAndroidKey, Config.umengiOSKey, Config.umengChannel);
    UmengCommonSdk.setPageCollectionModeAuto();
    UmengPushSdk.register();
  }

  static onEvent(String event, Map<String, dynamic> properties) {
    if (!_isMobile) return;
    UmengCommonSdk.onEvent(event, properties);
  }

  static onArticleEvent(String event, Map<String, dynamic> properties) {
    if (!_isMobile) return;
    if (!SettingsProvider().getShareData()) return;
    UmengCommonSdk.onEvent(event, properties);
  }
}
