import 'package:foundation/Resources/Config.dart';
import 'package:umeng_common_sdk/umeng_common_sdk.dart';
import 'package:get/get.dart';

import '../Resources/Config.dart';

class UmengUtil {
  static final bool _isMobile = GetPlatform.isAndroid || GetPlatform.isIOS;

  static init() {
    if (!_isMobile) return;
    UmengCommonSdk.initCommon(
        Config.umengAndroidKey, Config.umengiOSKey, Config.umengChannel);
    UmengCommonSdk.setPageCollectionModeAuto();
  }

  static onEvent(String event, Map<String, dynamic> properties) {
    if (!_isMobile) return;
    UmengCommonSdk.onEvent(event, properties);
  }
}
