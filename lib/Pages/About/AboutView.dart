import 'package:foundation/Utils/URLUtil.dart';
import '../../Resources/Config.dart';
import '../../Utils/PrivacyUtil.dart';
import '../../Utils/UpdateUtil.dart';
import '../../generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'Widgets/RainDropWidget.dart';

class AboutView extends StatefulWidget {
  const AboutView({Key? key}) : super(key: key);

  @override
  State<AboutView> createState() => _AboutViewState();
}

class _AboutViewState extends State<AboutView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // backgroundColor: Theme.of(context).hoverColor,
        appBar: AppBar(
          title: Text(S.of(context).about_title),
        ),
        body: Stack(children: [
          RainDropWidget(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height),
          SingleChildScrollView(
              child: Column(children: <Widget>[
            Container(
              padding: const EdgeInsets.all(10.0),
              alignment: Alignment.center,
              width: 150,
              child: Image.asset("res/icon.jpg"),
            ),
            Text(S.of(context).app_name),
            FutureBuilder<String>(
                future: _getVersion(),
                builder:
                    (BuildContext context, AsyncSnapshot<String> snapshot) {
                  if (!snapshot.hasData) {
                    return Container();
                  } else {
                    return Text(S.of(context).version(snapshot.data!));
                  }
                }),
            TextButton(
              style: TextButton.styleFrom(
                  primary: Colors.white,
                  backgroundColor: Theme.of(context).primaryColor),
              child: Text(S.of(context).check_update_button),
              onPressed: () {
                UpdateUtil().checkUpdate(context, true);
              },
            ),
            TextButton(
              style: TextButton.styleFrom(
                  primary: Theme.of(context).brightness == Brightness.light
                      ? Theme.of(context).primaryColor
                      : Colors.white,
                  backgroundColor: Colors.transparent),
              child: Text(S.of(context).check_privacy_button),
              onPressed: () {
                PrivacyUtil().checkPrivacy(context, true);
              },
            ),
            _generateTitle(S.of(context).github_open_source),
            _generateContent(Config.openSourceUrl,
                onTap: () => URLUtil.openUrl(Config.openSourceUrl, context)),
            _generateTitle(S.of(context).developer),
            _generateContent(S.of(context).introduction,
                onTap: () => URLUtil.openUrl(Config.blogUrl, context)),
            _generateTitle(S.of(context).open_source_library_title),
            _generateContent(S.of(context).open_source_library_content),
            _generateTitle(S.of(context).easter_egg),
          ]))
        ]));
  }

  Future<String> _getVersion() async {
    PackageInfo packageInfo = await PackageInfo.fromPlatform();
    return packageInfo.version;
  }

  Widget _generateTitle(String text) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 0, horizontal: 15),
      alignment: Alignment.centerLeft,
      child: Text(text),
    );
  }

  Widget _generateContent(String text, {onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(15.0),
        padding: const EdgeInsets.all(10.0),
        color: Theme.of(context).secondaryHeaderColor,
        alignment: Alignment.centerLeft,
        child: Text(text),
      ),
    );
  }
}
