import 'package:get_storage/get_storage.dart';

import '../Utils/PrivacyUtil.dart';
import '../Utils/UmengUtil.dart';
import 'UpdateUtil.dart';

class InitUtil {
  static initBeforeStart() async {
    await GetStorage.init();
    UmengUtil.init();
  }

  static initAfterStart(context) async {
    await PrivacyUtil().checkPrivacy(context, false);
    await UpdateUtil().checkUpdate(context, false);
  }
}
