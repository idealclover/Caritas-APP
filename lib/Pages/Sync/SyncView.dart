import 'dart:typed_data';
import 'dart:convert';
import 'package:universal_io/io.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../generated/l10n.dart';

import 'QRScanView.dart';
import 'SyncPresenter.dart';
import '../../Utils/InitUtil.dart';

class SyncView extends StatelessWidget {
  const SyncView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).sync_title),
        ),
        body: SingleChildScrollView(
            child: Column(
                children: ListTile.divideTiles(context: context, tiles: [
          Platform.isIOS
              ? ListTile(
                  title: Text(S.of(context).sync_icloud_title),
                  subtitle: Text(S.of(context).sync_icloud_subtitle),
                  onTap: () async => await InitUtil.iCloudSync(true),
                )
              : Container(),
          Platform.isIOS
              ? ListTile(
                  title: Text(S.of(context).sync_from_icloud_title),
                  subtitle: Text(S.of(context).sync_from_icloud_subtitle),
                  onTap: () async => await InitUtil.iCloudSync(false),
                )
              : Container(),
          ListTile(
              title: Text(S.of(context).export_to_file_title),
              subtitle: Text(S.of(context).export_to_file_subtitle),
              onTap: () async => SyncPresenter.exportToFile(context)),
          ListTile(
            title: Text(S.of(context).import_from_file_title),
            subtitle: Text(S.of(context).import_from_file_subtitle),
            onTap: () async {
              FilePickerResult? result = await FilePicker.platform.pickFiles(
                  type: FileType.custom, allowedExtensions: ['json']);
              if (result != null) {
                /// web场景没有path参数 只能通过bytes读取
                if (kIsWeb) {
                  Uint8List fileBytes = result.files.first.bytes!;
                  String contents = utf8.decode(fileBytes);
                  print(contents);
                  await SyncPresenter.importFromString(contents, context);
                } else if (result.files.single.path != null) {
                  File file = File(result.files.single.path!);
                  final String contents = await file.readAsString();
                  print(contents);
                  await SyncPresenter.importFromString(contents, context);
                }
              }
            },
          ),
          (Platform.isIOS || Platform.isAndroid)
              ? ListTile(
                  title: Text(S.of(context).import_from_qrcode_title),
                  subtitle: Text(S.of(context).import_from_qrcode_subtitle),
                  onTap: () async {
                    String? str = await Get.to(() => const QRScanView());
                    if (str == null || str == "") return;
                    await SyncPresenter.importFromUrl(str, context);
                  },
                )
              : Container(),
        ]).toList())));
  }
}
