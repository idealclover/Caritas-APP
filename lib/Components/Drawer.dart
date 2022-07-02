import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Pages/About/AboutView.dart';
import '../Pages/Settings/SettingsView.dart';
import '../Resources/Config.dart';
import '../Utils/SettingsUtil.dart';
import '../Utils/VersionUtil.dart';
import '../generated/l10n.dart';

class MDrawer extends StatelessWidget {
  const MDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            accountName: const Text(Config.drawerTitle,
                style: TextStyle(fontWeight: FontWeight.bold)),
            accountEmail: const Text(Config.drawerLink),
            currentAccountPicture: const CircleAvatar(
              backgroundImage: AssetImage("res/icon.jpg"),
            ),
            decoration: BoxDecoration(
                color: Theme.of(context).primaryColor),
          ),
          ListTile(
            title: Text(S.of(context).home_title),
            trailing: const Icon(Icons.home),
            onTap: () => Get.back(),
          ),
          ListTile(
            title: Text(S.of(context).settings_title),
            trailing: const Icon(Icons.settings),
            onTap: () => Get.to(() => const SettingsView()),
          ),
          ListTile(
            title: Text(S.of(context).share_title),
            trailing: const Icon(Icons.share),
            onTap: () async => await SettingsUtil.shareUtil(context),
          ),
          ListTile(
              title: Text(S.of(context).report_title),
              trailing: const Icon(Icons.message),
              onTap: () async => await SettingsUtil.qqTapUtil(context),
              onLongPress: () async =>
                  await SettingsUtil.qqLongPressUtil(context)),
          ListTile(
            title: Text(S.of(context).donate_title),
            trailing: const Icon(Icons.attach_money),
            onTap: () async => await SettingsUtil.donateUtil(context),
          ),
          ListTile(
            title: Text(S.of(context).about_title),
            trailing: FutureBuilder<String>(
                future: VersionUtil.getVersion(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) {
                    return Container(width: 0);
                  } else {
                    return Text(S.of(context).version(snapshot.data!));
                  }
                }),
            onTap: () => Get.to(() => const AboutView()),
          ),
        ],
      ),
    );
  }
}
