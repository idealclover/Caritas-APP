import 'package:flutter/material.dart';
import '../../generated/l10n.dart';

// import 'package:audioplayers/audioplayers.dart';
import 'package:just_audio/just_audio.dart';
import 'ArticlePresenter.dart';
import '../Settings/SettingsProvider.dart';
import '../../Components/ArticleList.dart';
import '../../Components/SnackBar.dart';
import '../../Components/Markdown.dart';
import '../../Models/Db/DbHelper.dart';
import '../../Utils/UmengUtil.dart';
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
  /// 解释下为什么要有 actualArticle:
  /// 这个是随机文章场景引入的 因为随机文章会打乱原来列表中的上下文顺序
  /// 所以需要有一个实际的文章，表示当前列表里的文章
  /// 这样即使表层的文章展示成了其他文章，上下文的锚点也能定位到
  late Article article;
  late Article actualArticle;

  late bool isFavorite;
  bool isPlaying = false;
  final player = AudioPlayer();

  @override
  void initState() {
    actualArticle = article = widget.article;
    super.initState();
  }

  @override
  void dispose() {
    player.stop();
    super.dispose();
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
            onTap: (() async {
              setState(() => {actualArticle = article = targetArticle});
              // ArticlePresenter ap = ArticlePresenter();
              // ap.setAsRead(targetArticle);
              ScrollController? sc = PrimaryScrollController.of(context);
              if (sc == null) return;
              sc.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
              await player.stop();
              setState(() {
                isPlaying = false;
              });
            })),
        const Divider(height: 1),
        const Padding(padding: EdgeInsets.all(5.0)),
      ],
    );
  }

  /// 打开随机文章通过直接刷新当前页面的形式，而不是新建页面
  /// 原因是担心顺序浏览的时候同时开启的页面过多，不好进行回退
  /// 单独写成函数的原因是特殊逻辑比较多
  Widget getRandomArticleWidget(List<Article> articles) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(padding: EdgeInsets.all(5.0)),
        ListTile(title: Text(S.of(context).random_article)),
        const Divider(height: 1),

        /// TODO: 懒了 先这么实现着吧 反正也没两行代码
        /// 注意：对于随机文章，只变更 article，不变更 actualArticle
        ListTile(
            title: Text(articles[0].title),
            subtitle:
                Text(articles[0].question, overflow: TextOverflow.ellipsis),
            onTap: (() async {
              setState(() => {article = articles[0]});
              // ArticlePresenter ap = ArticlePresenter();
              // ap.setAsRead(targetArticle);
              ScrollController? sc = PrimaryScrollController.of(context);
              if (sc == null) return;
              sc.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
              await player.stop();
              setState(() {
                isPlaying = false;
              });
            })),
        const Divider(height: 1),
        ListTile(
            title: Text(articles[1].title),
            subtitle:
                Text(articles[1].question, overflow: TextOverflow.ellipsis),
            onTap: (() async {
              setState(() => {article = articles[1]});
              // ArticlePresenter ap = ArticlePresenter();
              // ap.setAsRead(targetArticle);
              ScrollController? sc = PrimaryScrollController.of(context);
              if (sc == null) return;
              sc.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
              await player.stop();
              setState(() {
                isPlaying = false;
              });
            })),
        const Divider(height: 1),
        ListTile(
            title: Text("随机文章"),
            subtitle: Text("不打开不知道是什么的随机文章", overflow: TextOverflow.ellipsis),
            onTap: (() async {
              setState(() => {article = articles[2]});
              // ArticlePresenter ap = ArticlePresenter();
              // ap.setAsRead(targetArticle);
              ScrollController? sc = PrimaryScrollController.of(context);
              if (sc == null) return;
              sc.animateTo(0,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.ease);
              await player.stop();
              setState(() {
                isPlaying = false;
              });
            })),
        const Divider(height: 1),
        const Padding(padding: EdgeInsets.all(5.0)),
      ],
    );
  }

  Article? getPreArticle() {
    if (widget.getPre == null || widget.getPre!(actualArticle) == null) {
      return null;
    }
    return widget.getPre!(actualArticle);
  }

  Article? getNextArticle() {
    if (widget.getNext == null || widget.getNext!(actualArticle) == null) {
      return null;
    }
    return widget.getNext!(actualArticle);
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
            isPlaying
                ? IconButton(
                    icon: const Icon(Icons.stop_circle_outlined),
                    onPressed: () async {
                      await player.stop();
                      setState(() {
                        isPlaying = false;
                      });
                    })
                : IconButton(
                    icon: const Icon(Icons.headphones),
                    onPressed: () async {
                      const baseUrl =
                          "https://cdn.idealclover.cn/Projects/caritas/audio/";
                      String audioUrl = Uri.encodeFull(
                          "$baseUrl${article.tags.last}/${article.title}.mp3");
                      // print(audioUrl);
                      try {
                        await player.setUrl(audioUrl);
                        player.play();
                        setState(() {
                          isPlaying = true;
                        });
                        UmengUtil.onEvent("play_audio",
                            {"aid": article.id, "type": "manual"});
                      } catch (e) {
                        setState(() {
                          isPlaying = false;
                        });
                        MSnackBar.showSnackBar('无网络或无当前文章声音资源 TvT', "");
                      }

                      player.playerStateStream.listen((playerState) async {
                        if (playerState.processingState ==
                            ProcessingState.completed) {
                          Article? targetArticle = getNextArticle();
                          if (targetArticle == null) {
                            return;
                          }
                          setState(() => {
                                article = targetArticle,
                                actualArticle = targetArticle
                              });
                          // ArticlePresenter ap = ArticlePresenter();
                          // ap.setAsRead(targetArticle);
                          ScrollController? sc =
                              PrimaryScrollController.of(context);
                          if (sc == null) return;
                          sc.animateTo(0,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease);
                          audioUrl = Uri.encodeFull(
                              "$baseUrl${article.tags.last}/${targetArticle.title}.mp3");
                          try {
                            await player.setUrl(audioUrl);
                            player.play();
                            UmengUtil.onEvent("play_audio",
                                {"aid": article.id, "type": "auto"});
                          } catch (e) {
                            setState(() {
                              isPlaying = false;
                            });
                            MSnackBar.showSnackBar('无网络或无当前文章声音资源 TvT', "");
                          }
                        }
                      });
                    },
                  ),
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
        body: Scrollbar(
            child: SingleChildScrollView(
          primary: true,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MMarkdown(
                      '# ${article.title}\n    作者: ${article.author} 最近更新: ${article.lastUpdate}\n\n${article.question == "" ? "" : ">${article.question}\n\n"}${article.content}')),
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
                  }),
              FutureBuilder<List<Article>>(
                  future: ap.getRandomArticleList(3),
                  builder: (BuildContext context,
                      AsyncSnapshot<List<Article>> snapshot) {
                    return snapshot.hasData && snapshot.data!.isNotEmpty
                        ? getRandomArticleWidget(snapshot.data!)
                        : Container();
                  }),
              const Padding(padding: EdgeInsets.all(5.0)),
            ],
          ),
        )));
  }
}
