import 'package:flutter/material.dart';
import 'package:foundation/Components/ArticleList.dart';
import 'ArticlePresenter.dart';
import '../../Components/Markdown.dart';
import '../../Models/Db/DbHelper.dart';
import '../../generated/l10n.dart';

class ArticleView extends StatelessWidget {
  final Article article;

  const ArticleView(this.article, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticlePresenter ap = ArticlePresenter();
    return Scaffold(
        appBar: AppBar(
          title: Text(article.title),

        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: MMarkdown(article.content)),
              FutureBuilder<List<Article>>(
                  future: ap.getArticleList(article),
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
