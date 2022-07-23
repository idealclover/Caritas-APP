import 'package:flutter/material.dart';

import '../generated/l10n.dart';
import './Dialog.dart';

class DownloadDialog extends StatefulWidget {
  const DownloadDialog({Key? key}) : super(key: key);

  @override
  State<DownloadDialog> createState() => _DownloadDialogState();
}

class _DownloadDialogState extends State<DownloadDialog> {
  double progress = 0;

  changeProgress(double value) {
    setState(() {
      progress = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MDialog(
      S.of(context).db_downloading,
      const LinearProgressIndicator(
          // value: progress
          ),
      widgetOK: Container(),
    );
  }
}
