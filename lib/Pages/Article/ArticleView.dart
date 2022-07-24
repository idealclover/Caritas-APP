import 'package:flutter/material.dart';
import '../../Components/SnackBar.dart';
import '../../Utils/UmengUtil.dart';
import '../../generated/l10n.dart';
import 'ArticlePresenter.dart';
import '../Settings/SettingsProvider.dart';
import '../../Components/ArticleList.dart';

// import '../../Components/Toast.dart';
import '../../Components/Markdown.dart';
import '../../Models/Db/DbHelper.dart';
import '../../Utils/URLUtil.dart';

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
    article = widget.article;
    super.initState();
  }

  /// 打开上一篇/下一篇通过直接刷新当前页面的形式，而不是新建页面
  /// 原因是担心顺序浏览的时候同时开启的页面过多，不好进行回退
  Widget getArticleWidget(String title, Article? targetArticle) {
    if (targetArticle == null) return Container();
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(5.0)),
        ListTile(title: Text(title)),
        const Divider(height: 1),
        ListTile(
            title: Text(targetArticle.title),
            subtitle:
                Text(targetArticle.question, overflow: TextOverflow.ellipsis),
            onTap: (() {
              setState(() => {article = targetArticle});
              // ArticlePresenter ap = ArticlePresenter();
              // ap.setAsRead(targetArticle);
              sc.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
            })),
        const Divider(height: 1),
        const Padding(padding: EdgeInsets.all(5.0)),
      ],
    );
  }

  Article? getPreArticle() {
    if (widget.getPre == null || widget.getPre!(article) == null) {
      return null;
    }
    return widget.getPre!(article);
  }

  Article? getNextArticle() {
    if (widget.getNext == null || widget.getNext!(article) == null) {
      return null;
    }
    return widget.getNext!(article);
  }

  @override
  Widget build(BuildContext context) {
    List<String> favList = SettingsProvider().getFavorites();
    isFavorite = favList.contains(article.id);
    ArticlePresenter ap = ArticlePresenter();
    ap.setAsRead(article);
    UmengUtil.onEvent("open_article", {"aid": article.id});
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),
          actions: [
            IconButton(
                icon: Icon(
                  isFavorite ? Icons.favorite : Icons.favorite_border,
                  semanticLabel: S.of(context).fav_button,
                  color: isFavorite ? Colors.red : Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    isFavorite = !isFavorite;
                    SettingsProvider().setFavorites(article.id);
                    if (isFavorite) {
                      MSnackBar.showSnackBar(S.of(context).fav_add_toast, "");
                      // Toast.showToast(S.of(context).fav_add_toast, context);
                    } else {
                      MSnackBar.showSnackBar(S.of(context).fav_del_toast, "");
                      // Toast.showToast(S.of(context).fav_del_toast, context);
                    }
                  });
                }),
            article.zhihuLink != ''
                ? IconButton(
                    icon: Icon(
                      Icons.explore,
                      semanticLabel: S.of(context).open_in_browser_button,
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
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MMarkdown(
                      '# ${article.title}\n`最近更新: ${article.lastUpdate}`\n\n${article.question == "" ? "" : ">${article.question}\n\n"}${article.content}')),
              // '# ${article.title}\n${article.zhihuLink == "" ? article.question : "[${article.question}](${article.zhihuLink})"}\n\n> 最后更新: ${article.lastUpdate}\n\n${article.content}')),
              // child: MMarkdown(article.content)),
              getArticleWidget(S.of(context).pre_article, getPreArticle()),
              getArticleWidget(S.of(context).next_article, getNextArticle()),
              FutureBuilder<List<Article>>(
                  future: ap.getArticleList(article),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {
                    return snapshot.hasData && snapshot.data!.isNotEmpty
                        ? Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Padding(padding: EdgeInsets.all(5.0)),
                              ListTile(
                                  title: Text(S.of(context).related_article)),
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
