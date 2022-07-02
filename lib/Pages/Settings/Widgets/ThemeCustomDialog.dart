import 'package:flutter/services.dart';
import 'package:get/get.dart';

// import '../../../generated/l10n.dart';
import 'package:flutter/material.dart';
import '../../../Components/Dialog.dart';
import '../../../Providers/SettingsProvider.dart';
import '../../../Utils/ThemeUtil.dart';
import '../../../Utils/UmengUtil.dart';

const String defaultColor = '#0095F9';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    return TextEditingValue(
      text: newValue.text.toUpperCase(),
      selection: newValue.selection,
    );
  }
}

class ThemeCustomDialog extends StatefulWidget {
  const ThemeCustomDialog({Key? key}) : super(key: key);

  @override
  State<ThemeCustomDialog> createState() => _ThemeCustomDialogState();
}

class _ThemeCustomDialogState extends State<ThemeCustomDialog> {
  final TextEditingController _controller = TextEditingController();
  String color = defaultColor;

  @override
  Widget build(BuildContext context) {
    return MDialog(
      '自定义主题颜色',
      Column(mainAxisSize: MainAxisSize.min, children: [
        const Text('请输入对应十六位颜色代码\n系统将会根据该颜色计算适合主题'),
        const Padding(padding: EdgeInsets.symmetric(vertical: 10)),
        Row(
          children: <Widget>[
            const Text('#'),
            Expanded(
                child: TextField(
              autofocus: true,
              decoration: const InputDecoration.collapsed(
                  // hintText: defaultColor.substring(1)
                  hintText: '十六进制颜色代码'),
              inputFormatters: [
                FilteringTextInputFormatter.allow(RegExp('[a-fA-F0-9]')),
                LengthLimitingTextInputFormatter(6),
                UpperCaseTextFormatter(),
              ],
              controller: _controller,
              onChanged: (text) {
                setState(() {
                  color = '#${_controller.text}';
                  if (_controller.text == '') {
                    color = defaultColor;
                  }
                });
              },
            )),
            Container(
                width: 30,
                height: 30,
                margin: const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                decoration: BoxDecoration(
                  color: ThemeUtil.getColorFromHex(color),
                  shape: BoxShape.circle,
                )),
          ],
        )
      ]),
      widgetCancelAction: () {
        UmengUtil.onEvent(
            "theme_change", {"type": "theme_change", "action": "cancel"});
        Navigator.of(context).pop('');
      },
      widgetOKAction: () {
        String color = '#${_controller.text}';
        if (color == '#') {
          color = defaultColor;
        }
        UmengUtil.onEvent(
            "theme_change", {"type": "theme_change", "color": color});
        SettingsProvider().setThemeCustomColor(color);
        Get.back(result: _controller.text);
      },
    );
  }
}
