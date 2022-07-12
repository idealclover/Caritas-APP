import 'package:flutter/material.dart';
import 'ArticlePresenter.dart';
import '../Settings/SettingsProvider.dart';
import '../../Components/ArticleList.dart';
import '../../Components/Toast.dart';
import '../../Components/Markdown.dart';
import '../../Models/Db/DbHelper.dart';

class ArticleView extends StatefulWidget {
  final Article article;

  const ArticleView(this.article, {Key? key}) : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late bool isFavorite;

  @override
  void initState() {
    List<String> favList = SettingsProvider().getFavorites();
    isFavorite = favList.contains(widget.article.title);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ArticlePresenter ap = ArticlePresenter();
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.article.title),
          actions: [
            IconButton(
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
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MMarkdown(
                      '# ${widget.article.title}\n${widget.article.content}')),
              FutureBuilder<List<Article>>(
                  future: ap.getArticleList(widget.article),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {
                    return snapshot.hasData && snapshot.data!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.all(32.0)),
                              const ListTile(title: Text('相关阅读')),
                              const Divider(height: 1),
                              ArticleList(snapshot.data!),
                              const Padding(padding: EdgeInsets.all(32.0)),
                            ],
                          )
                        : Container();
                  })
            ],
          ),
        ));
  }
}
