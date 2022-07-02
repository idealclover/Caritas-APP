import 'package:flutter/material.dart';
import '../../../generated/l10n.dart';

import '../../../Providers/SettingsProvider.dart';
import '../../../Resources/Themes.dart';
import '../../../Utils/UmengUtil.dart';
import './ThemeCustomDialog.dart';

class ThemeChanger extends StatelessWidget {
  const ThemeChanger({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        scrollDirection: Axis.horizontal,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: List<Widget>.generate(
                Themes.themeList.length,
                (int i) => Container(
                    width: 30,
                    height: 30,
                    margin:
                        const EdgeInsets.only(left: 15, top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      color: Themes.themeList[i]['light']?.primaryColor,
                      shape: BoxShape.circle,
                    ),
                    child: InkResponse(onTap: () {
                      UmengUtil.onEvent("theme_change", {"type": i});
                      SettingsProvider().setThemeIndex(i);
                    })))
              ..add(Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
                child: InkWell(
                    child: Text(S.of(context).theme_mode_customize),
                    onTap: () {
                      showDialog<String>(
                        context: context,
                        builder: (BuildContext context) {
                          return const ThemeCustomDialog();
                        },
                      );
                    }),
              ))));
  }
}
