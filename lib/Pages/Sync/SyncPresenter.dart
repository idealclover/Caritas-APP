import 'dart:convert';
import 'package:flutter/material.dart';

import 'package:get/get.dart' hide Response;
import 'package:dio/dio.dart';

import '../../Components/SnackBar.dart';
import '../../Utils/DataSyncUtil.dart';
import '../../generated/l10n.dart';
import 'QRShareView.dart';

class SyncPresenter {

  static exportToFile(BuildContext context) async {
    Map rst = await DataSyncUtil.getLocalData();
    print(json.encode(rst));

    try {
      Dio dio = Dio();
      Response response = await dio.post("https://file.io/?expires=1w",
          data: {"name": "data.json", "text": json.encode(rst)},
          options: Options(
            contentType: Headers.formUrlEncodedContentType,
          ));
      print(response.data['link']);
      Get.to(() => QRShareView(response.data['link']));
    } catch (e) {
      MSnackBar.showSnackBar(S.of(context).read_hide_toast, "");
      // Toast.showToast(S.of(context).network_error_toast, context);
    }
  }

  static importFromString(String str, BuildContext context) async {
    Map data = json.decode(str);
    await DataSyncUtil.importFromJson(data, false);
    MSnackBar.showSnackBar(S.of(context).import_success_toast, "");
  }

  static importFromUrl(String url, BuildContext context) async {
    try {
      Dio dio = Dio();
      Response response = await dio.get(url);
      print(response.data.toString());
      Map data = json.decode(response.data.toString());
      await DataSyncUtil.importFromJson(data, false);
      MSnackBar.showSnackBar(S.of(context).import_success_toast, "");
    } catch (e) {
      MSnackBar.showSnackBar(S.of(context).qrcode_url_error_toast, "");
      return;
    }
  }
}
