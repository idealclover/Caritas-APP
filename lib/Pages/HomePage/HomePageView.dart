import 'package:flutter/material.dart';
import '../../Components/Drawer.dart';
import '../../Utils/InitUtil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List data = [
    {
      "id": 0,
      "title": "致读者",
      "contents": [
        {
          "id": 0,
          "title": "致读者-0",
          "intro": "关于 Caritas APP",
          "update_time": "4个月前"
        },
        {
          "id": 1,
          "title": "致读者-1",
          "intro": "你有哪些话想对知乎上关注的人说？",
          "update_time": "4个月前"
        }
      ]
    },
    {
      "id": 1,
      "title": "家族答集",
      "contents": [
        {"id": 2, "title": "门当户对", "intro": "什么才是门当户对", "update_time": "4个月前"}
      ]
    }
  ];

  @override
  void initState() {
    super.initState();

    /// This is needed for index StatefulWidget
    Future.delayed(Duration.zero, () {
      InitUtil.initAfterStart(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        length: data.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              for (var item in data)
                Tab(
                  text: item['title'],
                ),
            ]),
            title: Text(widget.title),
          ),
          drawer: const MDrawer(),
          body: TabBarView(
            children: [
              for (var item in data)
                Tab(
                  text: item['title'],
                ),
            ],
          ),
          // Center(
          //   child: Column(
          //     mainAxisAlignment: MainAxisAlignment.center,
          //     children: <Widget>[],
          //   ),
          // ),
        ));
  }
}
