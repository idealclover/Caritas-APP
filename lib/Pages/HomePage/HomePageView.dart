import 'package:flutter/material.dart';
import 'package:flutter_search_bar/flutter_search_bar.dart';

import '../../Components/ArticleList.dart';
import '../../Components/Drawer.dart';
import '../../Models/Db/DbHelper.dart';
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
  late SearchBar searchBar;
  late HomeCategoryProvider hp;
  late List<HomeCategory> data;
  late List<Article> searchArticleList;

  AppBar buildAppBar(BuildContext context) {
    return AppBar(
        bottom: TabBar(
          tabs: [
            for (var category in data) Tab(text: category.title),
          ],
          isScrollable: true,
        ),
        title: Text(widget.title),
        actions: [searchBar.getSearchAction(context)]);
  }

  searchChanged(String value) {
    setState(() {
      searchArticleList = hp.getArticleSearchList(value);
    });
  }

  @override
  void initState() {
    hp = HomeCategoryProvider();
    data = hp.getCategorieList();
    searchBar = SearchBar(
        inBar: true,
        setState: setState,
        onSubmitted: print,
        buildDefaultAppBar: buildAppBar,
        closeOnSubmit: false,
        onChanged: searchChanged,
        hintText: "在文集中搜索...");
    searchArticleList = data.first.articles;

    super.initState();

    /// This is needed for index StatefulWidget
    Future.delayed(Duration.zero, () {
      InitUtil.initAfterStart(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    // HomeCategoryProvider hp = HomeCategoryProvider();
    // var categoryList = hp.getCategorieList();
    // List<HomeCategory> dataList = hp.getHomeCategory();

    return ValueListenableBuilder<bool>(
        valueListenable: searchBar.isSearching,
        builder: (BuildContext context, bool value, Widget? child) {
          return DefaultTabController(
              length: data.length,
              child: Scaffold(
                appBar: searchBar.build(context),
                drawer: const MDrawer(),
                body: value

                    /// 搜索场景下展示样式
                    ? SingleChildScrollView(
                        child: ArticleList(searchArticleList),
                      )

                    /// 非搜索下展示样式
                    : TabBarView(
                        children: [
                          for (var category in data)
                            SingleChildScrollView(
                              child: ArticleList(category.articles),
                            )
                          // Tab(text: item.title),
                        ],
                      ),
              ));
        });

    // return FutureBuilder<List<HomeCategory>>(
    //     future: hp.getCategorieList(),
    //     builder:
    //         (BuildContext context, AsyncSnapshot<List<HomeCategory>> snapshot) {
    //       return snapshot.hasData
    //           ? DefaultTabController(
    //               length: snapshot.data!.length,
    //               child: Scaffold(
    //                 appBar: AppBar(
    //                   bottom: TabBar(tabs: [
    //                     for (var category in snapshot.data!)
    //                       Tab(text: category.title),
    //                   ]),
    //                   title: Text(widget.title),
    //                 ),
    //                 drawer: const MDrawer(),
    //                 body: TabBarView(
    //                   children: [
    //                     for (var category in snapshot.data!)
    //                       SingleChildScrollView(
    //                         child: ArticleList(category.articles),
    //                       )
    //                     // Tab(text: item.title),
    //                   ],
    //                 ),
    //                 // Center(
    //                 //   child: Column(
    //                 //     mainAxisAlignment: MainAxisAlignment.center,
    //                 //     children: <Widget>[],
    //                 //   ),
    //                 // ),
    //               ))
    //           : Container();
    //     });
  }
}
