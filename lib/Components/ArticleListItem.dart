import 'package:flutter/material.dart';

import '../Pages/Article/ArticleView.dart';
import '../Pages/Settings/SettingsProvider.dart';
import '../../Components/Toast.dart';
import '../../Models/Db/DbHelper.dart';
import '../generated/l10n.dart';


class ArticleListItemView extends StatefulWidget {
  final Article article;
  final bool showFavIcon;
  final bool greyRead;
  final Function? getPre;
  final Function? getNext;
  final Function? notifyState;

  const ArticleListItemView(this.article,
      {Key? key,
      this.showFavIcon = true,
      this.greyRead = true,
      this.getPre,
      this.getNext,
      this.notifyState})
      : super(key: key);

  @override
  State<ArticleListItemView> createState() => _ArticleListItemViewState();
}

class _ArticleListItemViewState extends State<ArticleListItemView> {
  late bool isFavorite;
  late bool isRead;

  @override
  void initState() {
    // init();
    super.initState();
  }

  void init() {
    List<String> favList = SettingsProvider().getFavorites();
    isFavorite = favList.contains(widget.article.id);
    List<String> hisList = SettingsProvider().getHistories();
    isRead = hisList.contains(widget.article.id);
  }

  @override
  Widget build(BuildContext context) {
    init();
    return ListTile(
      /// 只有 greyRead 模式开启时，已读才显示为灰色
      title: Text(
        widget.article.title,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(color: (widget.greyRead && isRead) ? Colors.grey : null),
      ),
      subtitle: Text(
        widget.article.question,
        overflow: TextOverflow.ellipsis,
        style:
            TextStyle(color: (widget.greyRead && isRead) ? Colors.grey : null),
      ),
      trailing: widget.showFavIcon
          ? IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                semanticLabel: S.of(context).fav_button,
                color: isFavorite ? Colors.red : null,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  SettingsProvider().setFavorites(widget.article.id);
                  if (isFavorite) {
                    Toast.showToast(S.of(context).fav_add_toast, context);
                  } else {
                    Toast.showToast(S.of(context).fav_del_toast, context);
                  }
                });
              })
          : null,
      onTap: () async {
        await Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ArticleView(
                  widget.article,
                  getPre: widget.getPre,
                  getNext: widget.getNext,
                )));
        if(widget.notifyState != null) widget.notifyState!();
        // setState(() => {});
      },
    );
  }
}
