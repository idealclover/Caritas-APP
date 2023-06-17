import 'package:flutter/material.dart';

import '../Pages/Settings/SettingsProvider.dart';
import 'ArticleListItem.dart';
import '../Models/Db/DbHelper.dart';

class ArticleList extends StatelessWidget {
  late final List<Article> articleList;
  final bool showFavIcon;
  final bool greyRead;
  final bool hideRead;
  // 是否使用 ListView.builder, 文章详情页的相关阅读使用ListView.builder会导致白屏
  // 因此仅列表页面使用使用此开关显式开启性能优化
  final bool useListView;
  final Function? notifyState;

  ArticleList(articleSourceList,
      {Key? key,
      this.showFavIcon = true,
      this.greyRead = true,
      this.hideRead = false,
      this.useListView = false,
      this.notifyState})
      : super(key: key) {
    /// 复制一份 list 进行修改和渲染，避免影响原 list
    articleList = List.from(articleSourceList);
  }

  Article? getPre(Article article) {
    int i = articleList.indexOf(article);
    if (i == -1 || i == 0) {
      return null;
    } else {
      return articleList[i - 1];
    }
  }

  Article? getNext(Article article) {
    int i = articleList.indexOf(article);
    if (i == -1 || i == (articleList.length - 1)) {
      return null;
    } else {
      return articleList[i + 1];
    }
  }

  List<Widget> getList() {
    List<Widget> result = [];
    List<String> hisList = SettingsProvider().getHistories();
    if (hideRead) {
      articleList.removeWhere((element) => hisList.contains(element.id));
    }
    for (int i = 0; i < articleList.length; i++) {
      result.add(ArticleListItemView(
        articleList[i],
        showFavIcon: showFavIcon,
        greyRead: greyRead,
        getPre: getPre,
        getNext: getNext,
        notifyState: notifyState,
      ));
    }
    return result;
  }

  @override
  Widget build(BuildContext context) {
    var items = getList();
    if (useListView) {
      // 使用 ListView.builder 优化列表性能，参考 https://docs.flutter.dev/cookbook/lists/long-lists
      // 代码来自 ListTile.divideTiles
      itemBuilder(index) {
        return DecoratedBox(
          position: DecorationPosition.foreground,
          decoration: BoxDecoration(
            border: Border(
              bottom: Divider.createBorderSide(context),
            ),
          ),
          child: items[index],
        );
      }

      return Scrollbar(
          child: ListView.builder(
        itemCount: items.length,
        prototypeItem: items.isEmpty ? null : itemBuilder(0),
        itemBuilder: (context, index) {
          return itemBuilder(index);
        },
      ));
    } else {
      return Column(
          children:
              ListTile.divideTiles(context: context, tiles: items).toList()
                ..add(const Divider(height: 1)));
    }
  }
}
