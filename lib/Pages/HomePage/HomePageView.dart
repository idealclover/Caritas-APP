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
    // var categoryList = hp.getCategorieList();
    // List<HomeCategory> dataList = hp.getHomeCategory();
    return FutureBuilder<List<HomeCategory>>(
        future: hp.getCategorieList(),
        builder:
            (BuildContext context, AsyncSnapshot<List<HomeCategory>> snapshot) {
          return snapshot.hasData
              ? DefaultTabController(
                  length: snapshot.data!.length,
                  child: Scaffold(
                    appBar: AppBar(
                      bottom: TabBar(tabs: [
                        for (var category in snapshot.data!)
                          Tab(text: category.title),
                      ]),
                      title: Text(widget.title),
                    ),
                    drawer: const MDrawer(),
                    body: TabBarView(
                      children: [
                        for (var category in snapshot.data!)
                          SingleChildScrollView(
                            child: Column(
                                children: ListTile.divideTiles(
                                    context: context,
                                    tiles: [
                                  for (var item in category.articles)
                                    ListTile(
                                      title: Text(item.title),
                                      subtitle: Text(item.question,
                                          overflow: TextOverflow.ellipsis),
                                      // trailing: Text(item.lastUpdate),
                                      onTap: () {
                                        Get.to(() => ArticleView(item));
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
                  ))
              : Container();
        });
  }
}
