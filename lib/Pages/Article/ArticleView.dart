import 'package:flutter/material.dart';
import '../../Components/Markdown.dart';
import '../../Models/Db/DbHelper.dart';
import 'ArticleProvider.dart';
import '../../generated/l10n.dart';

class ArticleView extends StatelessWidget {
  final int id;

  const ArticleView(this.id, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ArticleProvider ap = ArticleProvider();
    return FutureBuilder<Article>(
        future: ap.getArticle(id),
        builder: (BuildContext context, AsyncSnapshot<Article> snapshot) {
          return Scaffold(
              appBar: AppBar(
                title: Text(snapshot.hasData ? snapshot.data!.title : '加载中'),
              ),
              body:
                  MMarkdown(snapshot.hasData ? snapshot.data!.content : '加载中'));
        });
  }
}
