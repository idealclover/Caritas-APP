import 'package:flutter/material.dart';
import 'package:foundation/Pages/Article/ArticleView.dart';
import 'package:get/get.dart';

import '../../Components/Drawer.dart';
import '../../Models/HomeCategoryModel.dart';
import 'HomeCategoryProvider.dart';
import '../../Utils/InitUtil.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
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
    HomeCategoryProvider hp = HomeCategoryProvider();
    List<HomeCategory> dataList = hp.getHomeCategory();
    return DefaultTabController(
        length: dataList.length,
        child: Scaffold(
          appBar: AppBar(
            bottom: TabBar(tabs: [
              for (var category in dataList) Tab(text: category.title),
            ]),
            title: Text(widget.title),
          ),
          drawer: const MDrawer(),
          body: TabBarView(
            children: [
              for (var category in dataList)
                SingleChildScrollView(
                  child: Column(
                      children: ListTile.divideTiles(context: context, tiles: [
                    for (var item in category.itemList)
                      ListTile(
                        title: Text(item.title),
                        subtitle: Text(item.intro),
                        trailing: Text(item.updateTime),
                        onTap: () {
                          Get.to(() => ArticleView(item.id));
                        },
                      )
                  ]).toList()),
                )
              // Tab(text: item.title),
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
