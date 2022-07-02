import 'package:flutter/material.dart';
import '../../generated/l10n.dart';
import 'package:get/get.dart';

import './Widgets/ThemeChanger.dart';
import '../About/AboutView.dart';
import '../../Providers/SettingsProvider.dart';
import '../../Utils/SettingsUtil.dart';
import '../../Utils/VersionUtil.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key}) : super(key: key);

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  late int themeMode;

  @override
  void initState() {
    super.initState();
    themeMode = _getThemeIndex();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings_title),
      ),
      body: Center(
        child: Column(
            children: ListTile.divideTiles(context: context, tiles: [
          ListTile(
              title: Text(S.of(context).change_theme_mode_title),
              subtitle: Text(S.of(context).change_theme_mode_subtitle),
              trailing: DropdownButton<int>(
                  value: themeMode,
                  items: [
                    DropdownMenuItem(
                        value: 0,
                        child: Row(children: [
                          const Icon(Icons.settings),
                          Text(S.of(context).theme_mode_follow_system)
                        ])),
                    DropdownMenuItem(
                        value: 1,
                        child: Row(children: [
                          const Icon(Icons.wb_sunny),
                          Text(S.of(context).theme_mode_always_light)
                        ])),
                    DropdownMenuItem(
                        value: 2,
                        child: Row(children: [
                          const Icon(Icons.shield_moon),
                          Text(S.of(context).theme_mode_always_dark)
                        ]))
                  ],
                  onChanged: (value) {
                    if (value == null) return;
                    SettingsProvider().setThemeMode(value);
                    setState(() {
                      themeMode = value;
                    });
                  })),
          Get.isDarkMode ? Container() : const ThemeChanger(),
          ListTile(
            title: Text(S.of(context).share_title),
            subtitle: Text(S.of(context).share_subtitle),
            onTap: () async => await SettingsUtil.shareUtil(context),
          ),
          ListTile(
              title: Text(S.of(context).report_title),
              subtitle: Text(S.of(context).report_subtitle),
              onTap: () async => await SettingsUtil.qqTapUtil(context),
              onLongPress: () async =>
                  await SettingsUtil.qqLongPressUtil(context)),
          ListTile(
            title: Text(S.of(context).donate_title),
            subtitle: Text(S.of(context).donate_subtitle),
            onTap: () async => await SettingsUtil.donateUtil(context),
          ),
          ListTile(
            title: Text(S.of(context).about_title),
            subtitle: FutureBuilder<String>(
                future: VersionUtil.getVersion(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Text(S.of(context).now_version(snapshot.data!));
                  }
                }),
            onTap: () {
              Get.to(() => const AboutView());
            },
          ),
        ]).toList()),
      ),
    );
  }

  int _getThemeIndex() {
    themeMode = SettingsProvider().getThemeMode();
    return themeMode;
  }
}
