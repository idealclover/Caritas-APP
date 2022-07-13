import 'package:flutter/material.dart';
import '../../Utils/URLUtil.dart';
import 'ArticlePresenter.dart';
import '../Settings/SettingsProvider.dart';
import '../../Components/ArticleList.dart';
import '../../Components/Toast.dart';
import '../../Components/Markdown.dart';
import '../../Models/Db/DbHelper.dart';

class ArticleView extends StatefulWidget {
  final Article article;
  final Function? getPre;
  final Function? getNext;

  const ArticleView(this.article, {this.getPre, this.getNext, Key? key})
      : super(key: key);

  @override
  State<ArticleView> createState() => _ArticleViewState();
}

class _ArticleViewState extends State<ArticleView> {
  late Article article;
  late bool isFavorite;
  ScrollController sc = ScrollController();

  @override
  void initState() {
    List<String> favList = SettingsProvider().getFavorites();
    isFavorite = favList.contains(widget.article.title);
    article = widget.article;
    super.initState();
  }

  /// 打开上一篇/下一篇通过直接刷新当前页面的形式，而不是新建页面
  /// 原因是担心顺序浏览的时候同时开启的页面过多，不好进行回退
  Widget getArticleWidget(String title, List<Article>? articleList) {
    if (articleList == null || articleList.isEmpty) {
      return Container();
    }
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(5.0)),
        ListTile(title: Text(title)),
        const Divider(height: 1),
        ListTile(
            title: Text(articleList.first.title),
            subtitle: Text(articleList.first.question,
                overflow: TextOverflow.ellipsis),
            onTap: (() {
              setState(() => {article = articleList.first});
              sc.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            })),
        const Divider(height: 1),
        const Padding(padding: EdgeInsets.all(5.0)),
      ],
    );
  }

  List<Article>? getPreArticle() {
    if (widget.getPre == null || widget.getPre!(article) == null) {
      return null;
    }
    return [widget.getPre!(article)];
  }

  List<Article>? getNextArticle() {
    if (widget.getNext == null || widget.getNext!(article) == null) {
      return null;
    }
    return [widget.getNext!(article)];
  }

  @override
  Widget build(BuildContext context) {
    ArticlePresenter ap = ArticlePresenter();
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
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
                    SettingsProvider().setFavorites(article.id);
                    if (isFavorite) {
                      Toast.showToast('已收藏', context);
                    } else {
                      Toast.showToast('已取消收藏', context);
                    }
                  });
                }),
            article.zhihuLink != ''
                ? IconButton(
                    icon: const Icon(
                      Icons.explore,
                      semanticLabel: "open in browser",
                    ),
                    onPressed: () async {
                      await URLUtil.openUrl(article.zhihuLink, context);
                    })
                : Container()
          ],
        ),
        body: SingleChildScrollView(
          controller: sc,
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MMarkdown('# ${article.title}\n${article.content}')),
              getArticleWidget('上一篇', getPreArticle()),
              getArticleWidget('下一篇', getNextArticle()),
              FutureBuilder<List<Article>>(
                  future: ap.getArticleList(article),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {
                    return snapshot.hasData && snapshot.data!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.all(5.0)),
                              const ListTile(title: Text('相关阅读')),
                              const Divider(height: 1),
                              ArticleList(snapshot.data!),
                              const Padding(padding: EdgeInsets.all(5.0)),
                            ],
                          )
                        : Container();
                  })
            ],
          ),
        ));
  }
}
