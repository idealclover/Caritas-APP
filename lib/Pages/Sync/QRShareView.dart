import '../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:qr_flutter/qr_flutter.dart';

import '../../Components/Markdown.dart';

class QRShareView extends StatelessWidget {
  final String url;

  const QRShareView(this.url, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(S.of(context).export_title),
        ),
        body: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            QrImage(
              data: url,
              backgroundColor: Colors.white,
              version: QrVersions.auto,
              size: 200.0,
            ),
            const Padding(padding: EdgeInsets.all(10)),
            MMarkdown(S.of(context).export_content(url))
          ],
        )));
  }
}
