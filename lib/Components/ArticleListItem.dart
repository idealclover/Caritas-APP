import 'package:flutter/material.dart';

import '../Pages/Article/ArticleView.dart';
import '../Pages/Settings/SettingsProvider.dart';
import '../../Components/Toast.dart';
import '../../Models/Db/DbHelper.dart';

class ArticleListItemView extends StatefulWidget {
  final Article article;
  final bool showFavIcon;

  const ArticleListItemView(this.article, {Key? key, this.showFavIcon = true})
      : super(key: key);

  @override
  State<ArticleListItemView> createState() => _ArticleListItemViewState();
}

class _ArticleListItemViewState extends State<ArticleListItemView> {
  late bool isFavorite;

  @override
  void initState() {
    List<String> favList = SettingsProvider().getFavorites();
    isFavorite = favList.contains(widget.article.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(widget.article.title),
      subtitle: Text(widget.article.question, overflow: TextOverflow.ellipsis),
      trailing: widget.showFavIcon
          ? IconButton(
              icon: Icon(
                isFavorite ? Icons.favorite : Icons.favorite_border,
                semanticLabel: "is favorited",
                color: isFavorite ? Colors.red : Colors.white,
              ),
              onPressed: () {
                setState(() {
                  isFavorite = !isFavorite;
                  SettingsProvider().setFavorites(widget.article.id);
                  if (isFavorite) {
                    Toast.showToast('已收藏', context);
                  } else {
                    Toast.showToast('已取消收藏', context);
                  }
                });
              })
          : null,
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (BuildContext context) => ArticleView(widget.article)));
      },
    );
  }
}
