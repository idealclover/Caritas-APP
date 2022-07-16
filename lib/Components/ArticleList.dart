import 'package:flutter/material.dart';

import '../Pages/Settings/SettingsProvider.dart';
import 'ArticleListItem.dart';
import '../Models/Db/DbHelper.dart';

class ArticleList extends StatelessWidget {
  late final List<Article> articleList;
  final bool showFavIcon;
  final bool greyRead;
  final bool hideRead;
  final Function? notifyState;

  ArticleList(articleSourceList,
      {Key? key,
      this.showFavIcon = true,
      this.greyRead = true,
      this.hideRead = false,
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
    return Column(
        children:
            ListTile.divideTiles(context: context, tiles: getList()).toList()
              ..add(const Divider(height: 1)));
  }
}
